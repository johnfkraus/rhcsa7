# RHELAB
A script or set of scripts that create a virtual lab to study for the RHCSA test. Based on objectives stated at RHEL certifications pages.
I have diff'd the ldap.conf, sssd.conf, and one of slapd.d config files and hopefully patched up my errors that caused the script to fail on the first test on a new Centos 7 machine.
Please feel free to use this for your own studies. If you decide to use the script on a production machine, be forwarned that I have taken NO steps to validate the security of the installation as the primary use for me will be a lab situation. 
I am in no way asserting what will or will not be included in any examination by Red Hat or any other certification body. I am creating this script to help me study for the Red Hat CSA test based on objectives stated by Red Hat Enterprise Linux for their exams.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I've verified the script runs on a CentOS 7 Minimal install and installs a working LDAP server and 
client with SSSD. The script creates users ldapuser1 through ldapuser10. All users have the 
password "Z0mgbee!"

I am sure the script will not work on CentOS 6.x or earlier and don't care to do that. It has not 
been tested on any Fedora, RHEL, or Scientific Linux release.

To install;

1. Clone the repository to your server's / directory (not /root!)
2. chmod +x clean_ldap_sssd_installer.sh
3. ./clean_ldap_sssd_installer.sh


Note - This is my first "real" script, so I would love to have feedback on things I could 
do better. 

