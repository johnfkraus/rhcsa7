!/bin/bash
# Script to create Mozilla NSS certificates for openLDAP
# Install packages needed and configure server
# If installing client and server on a separate machine migrationtools,openldap-servers and migrationtools are not
# needed on the client machine and openldap-clients, sssd, authconfig are not needed on server
# Lots of things I could probably do better, rewrite in python maybe
# Todo - add this to a kickstart file, include the changes.ldif and base.ldif creation in the script

yum -y install openldap openldap-servers openldap-clients migrationtools nss-utils sssd authconfig authconfig-gtk expect


#enable logging

echo "local4.* /var/log/ldap.log" >> /etc/rsyslog.conf
systemctl restart rsyslog

setenforce 0
hostnamectl set-hostname instructor.example.com

# Functions to create the changes.ldif and base.ldif files we will need for LDAP

create_changes.ldif(){ cat >> /etc/openldap/changes.ldif << EOF

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=example,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: redhat

dn: cn=config
changetype: modify
replace: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/openldap/certs/cacert.pem

dn: cn=config
changetype: modify
replace: olcTLSCACertificatePath
olcTLSCACertificatePath: /etc/openldap/certs

dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: "OpenLDAP-Server"

dn: cn=config
changetype: modify
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/certs/password

dn: cn=config
changetype: modify
replace: olcTLSVerifyClient
olcTLSVerifyClient: never

dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: -1
EOF
}

create_base.ldif(){ cat >> /etc/openldap/base.ldif << EOF
dn: dc=example,dc=com
dc: example
objectClass: top
objectClass: domain

dn: ou=People,dc=example,dc=com
ou: People
objectClass: top
objectClass: organizationalUnit

dn: ou=Group,dc=example,dc=com
ou: Group
objectClass: top
objectClass: organizationalUnit
EOF
}

#Check netowrking - could use some improvement, specifically, what are we doing with all these other interfaces?

echo "Determining host networking...."
for netw in $(ip addr show | grep ^[0-9] | cut -d' ' -f2)
do
case $netw in
	lo:)
		ping -c 1 127.0.0.1 > /dev/null
		[ $? -eq 0 ] && echo "localhost ok" || { echo "localhost not ok"; exit 1; } 
		;;
	eth[0-9]:)
		ipadrss=$(ip addr show $netw | awk '/inet/{ print $2;exit; }' | cut -d"/" -f1)
		ethdev=$(cut -d':' -f1 $netw)
		ping -c 1 $ipadrss > /dev/null
		[ $? -eq 0 ] && echo "ethernet ok" || { echo "ethernet not ok"; exit 1; }
		echo "IP Address of host stored as $ipadrss"
		echo "127.0.0.1 instructor.example.com" >> /etc/hosts
		echo "$ipadrss instructor.example.com" >> /etc/hosts
		;;
	br[0-9][0-9]:)
		echo "Bridged ethernet present"
		brdev=$netw
		bripadrss=$(ip addr show $netw | awk '/inet/{ print $2;exit; }' | cut -d'/' -f1)
		ping -c 1 $bripadrss > /dev/null
		[ $? -eq 0 ] && echo "bridged ethernet ok" || { echo "bridged ethernet not ok"; exit 1; }
		echo "Ethernet Bridge IP address stored as $bripadrss"
		;;
	virbr[0-9][0-9]:)
		echo "Virtual Bridge ethernet present"
		virdev=$netw
		vbripadrss=$(ip addr show $netw | awk '/inet/{ print $2;exit; }' | cut -d'/' -f1)
		ping -c 1 $vbripadrss > /dev/null
		[ $? -eq 0 ] && echo "Virtual bridged ethernet ok" || { echo "Virtual bridged ethernet not ok"; exit 1; }
		echo "Virtual ethernet bridge IP address stored as $vbripadrss"
		;;
	*)
		echo "Additional interface device $netw also detected. " 
		;;
esac
done

#establish variables

certdir='/root/ldapca' #a working directory for creating the signing and authentication certs
cacertpassfile='/root/ldapca/capassword'  #location of the CA signing cert password
certpassfile='/root/ldapca/password'  #location of the certificate password
certnoisefile='/root/ldapca/noise.txt'  #random noise needed to generate certificates
ldapdir='/etc/openldap'	 #configuration directory for openldap
ldapconffile='/etc/openldap/ldap.conf' #editable ldap config file
sssddir='/etc/sssd' #sssd config directory
sssdconffile='/etc/sssd/sssd.conf' #sssd config file

# create cert directory and passwords
mkdir $certdir
echo "redhat" > $cacertpassfile
echo "redhat" > $certpassfile
head -c 100 /dev/urandom >> $certnoisefile

#This section creates the CA cert for self-signing the LDAP server cert and LDAP client cert
#I dont know why you cant do this in the $ldapdir directory? Havent tried it.
#Basic steps are creating the database, the key pair, signing cert, creating the server cert, creating the client
#cert and exporting both to the certificate database
#I specify rsa security here, even though it is the default and has some vulnerabilities
#elliptical curve i think is the recommended, but I just wanted to get a lab working

#create the database. 
certutil -d $certdir -N -f $cacertpassfile 

#create the signing key pair
certutil -d $certdir -G -z $certnoisefile -f $cacertpassfile

#create the CA cert
certutil -d $certdir -S -k rsa -n "CA-certificate" -s "cn=LDAP_CA,dc=example,dc=com" -x -t "PCT,," -m 1000 -z $certnoisefile -f $cacertpassfile 

#create the LDAP server cert 
certutil -d $certdir -S -k rsa -n "OpenLDAP-Server" -s "cn=instructor.example.com" -c "CA-certificate" -t "u,u,u" -m 1001 -z $certnoisefile -f $cacertpassfile

#create the cert for authentication
certutil -d $certdir -S -k rsa -n "Auth-Client" -s "cn=auth,dc=example,dc=com" -c "CA-certificate" -t "u,u,u" -m 1002 -z $certnoisefile -f $cacertpassfile

#Export the CA cert
certutil -d $certdir/ -L -n "CA-certificate" -a > $certdir/cacert.pem -f $cacertpassfile

#Export the LDAP server certificate and key
pk12util -d $certdir/ -o $certdir/ldapserver.p12 -n "OpenLDAP-Server" -k $cacertpassfile -w $certpassfile

#Export the Client Cert and key
pk12util -d $certdir/ -o $certdir/authclient.p12 -n "Auth-Client" -k $cacertpassfile -w $certpassfile

#Begin clean up of old data and LDAP setup
#Run on both machines if installing a separate client

rm -f $ldapdir/certs/*

#Copy the lsapserver.p12 and cacert.pem files to certs directory for ldap
#if configuring a separate client, the password and authclient files will need to be scp'd
#to the client

cp $certdir/ldapserver.p12 $ldapdir/certs/.
cp $certdir/cacert.pem $ldapdir/certs/.
cp $certpassfile $ldapdir/certs/.
cp $certdir/authclient.p12 $ldapdir/certs/.

#Make new database with passowrd then add the server key
#I beleive if you are splitting this between separate host and clients #
#the first certutil command should be run on both machines
#pk12util will need to import the ldapserver.p12 on the server host and
#pk12util will need to import the authclient.p12 on the client

certutil -N -d $ldapdir/certs -f $ldapdir/certs/password
pk12util -i $ldapdir/certs/ldapserver.p12 -k $ldapdir/certs/password -w $ldapdir/certs/password -d $ldapdir/certs
pk12util -i $ldapdir/certs/authclient.p12 -k $ldapdir/certs/password -w $ldapdir/certs/password -d $ldapdir/certs

#Update configuration files for ldap.conf sssd.conf

#ldap.conf - client side config
cat >> $ldapconffile << EOF
URI ldap://instructor.example.com
BASE dc=example,dc=com
TLS_REQUIRE allow
TLS_CACERT /etc/openldap/certs/cacert.pem
TLS_CACERTDIR /etc/openldap/certs
TLS_Cert /etc/openldap/certs/authclient.p12
TLS_KEY /etc/openldap/certs/password
EOF


#sssd.conf - client side config
authconfig \
--enablesssd \
--enablesssdauth \
--enablelocauthorize \
--enableldap \
--enableldapauth \
--ldapserver=ldap://instructor.example.com \
--enableldapstarttls \
--enableldaptls \
--ldapbasedn=dc=example,dc=com \
--enablerfc2307bis \
--enablecachecreds \
--update

cat >> /etc/sssd/sssd.conf << EOF
ldap_tls_cacertdir = /etc/openldap/certs
entry_cache_timeout = 600 
ldap_network_timeout = 3
EOF



#Do I need to make changes to nscd.conf to stop caching?

#Make sure certs are readable and have ldap ownership
chown -R ldap:ldap $ldapdir/certs
chmod 644 $ldapdir/certs/*

#Mark the CA cert as trusted
certutil -d $ldapdir/certs -M -n "CA-certificate" -t "CTu,u,u"


###install and configure ldap for a test lab on CentOS7
##users are ldapuser1 through ldapuser10
##user passwords are all Z0mgbee!


#set slappasswd to "redhat"

slappasswd -s redhat -n > $ldapdir/passwd

#copy sample config

cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

#check to see if slaptest is ok then change ownership to ldap user - enable - start slapd

slaptest 2> /dev/null

if [ $? -eq 1 ] 
then
	chown -R ldap:ldap /var/lib/ldap
	systemctl enable slapd
	systemctl start slapd
	ss -tap | grep ldap
else
	echo "slapd enable failed"
	systemctl status slapd
	exit 1
fi

#configure

cd $ldapdir/schema
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f nis.ldif


#call functions to create changes.ldif and base.ldif

create_changes.ldif
create_base.ldif


#modify ldapd config file !!! THIS IS DIFFERENT FROM ldap.conf !!!
#restart the slapd and sssd daemons 

ldapmodify -Y EXTERNAL -H ldapi:/// -f $ldapdir/changes.ldif 

systemctl restart slapd 
systemctl restart sssd

ldapadd -x -w redhat -D cn=Manager,dc=example,dc=com -f $ldapdir/base.ldif

#create users for testing

mkdir /home/guests

ldappwd='Z0mgbee!'

for u in {1..10}
do
	useradd -d /home/guests/ldapuser$u -p $ldappwd ldapuser$u
done

#migrate user accounts

cd /usr/share/migrationtools

[ -f /usr/share/migrationtools/migrate_common.ph ] && { sed -i 's/"padl.com"/"example.com"/' /usr/share/migrationtools/migrate_common.ph; } && { sed -i 's/"dc=padl,dc=com"/"dc=example,dc=com"/' /usr/share/migrationtools/migrate_common.ph; }

#create users in the directory service

grep ":10[0-9][0-9]" /etc/passwd > passwd
./migrate_passwd.pl passwd users.ldif
ldapadd -x -w redhat -D cn=Manager,dc=example,dc=com -f users.ldif
 
grep ":10[0-9][0-9]" /etc/group > group
./migrate_group.pl group groups.ldif
ldapadd -x -w redhat -D cn=Manager,dc=example,dc=com -f groups.ldif

#setup firewall

firewall-cmd --permanent --add-service=ldap
firewall-cmd --permanent --add-service=ldaps
firewall-cmd --reload

#enable logging

echo "local4.* /var/log/ldap.log" >> /etc/rsyslog.conf
systemctl restart rsyslog

#check to make sure LDAP is working. Finish if ok. Error if not

ldapsearch -ZZ -x '(objectclass=*)'
[ $? -eq 0 ] && { echo "Complete with no errors"; } || { echo "Something went wrong\
	Please report errors to https://github.com/Aikidouke/RHELAB"; exit 1; }
