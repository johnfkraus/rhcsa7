### sed
Stream editor. Search for and change words or text streams in a file.
```
sed 's/abc/xyz' infile > outfile
sed -i 's/abc/xyz/g' infile > outfile
```

### grep & egrep
Search through a file / stream.
egrep allows simpler special char searching + ? | ( )
```
grep 'Username' /etc/passwd
ps aux | grep process
```

### awk
Run actions on lines which match a given pattern
```
awk '/User/ {print $1}' /etc/passwd
```

### sort
Sort the contents of a file
```
sort file.txt
```

### find
Searches through directories and subdirectories for a desired file.
```
find / -name file.txt

# Case insensitive
find / -iname file.txt
find . -maxdepth 1 -name *.txt

# Pipe errors away if searching entire filesys as non-su
find / -name foo 2>/dev/null

# Search many locations
find /tmp /var/tmp . $HOME -name foo
```

### which
shows the full path of (shell) commands.
```
which git
```

### ln
make links between files
```
# Hard link
ln /file/to/link /link

# Symbolic / soft link
ln -s /file/to/link /link
```

### cd
Change dir
```
cd dir
```

### mv
move a file
```
mv file.txt newname.txt
mv -r dir newdir
```

### head
output the first part of a file
```
head file.txt

# choose the number of lines to output
head -n20 file.txt
head -n15 file.txt
```

### tail
output the last part of a file
```
tail file.txt

# choose the number of lines to output
tail -n20 file.txt
tail -n15 file.txt
```

### ls
cat
locate
pwd

### less and more
Scroll through larger files / streams
more - scrolls through the file one screen at a time
less - bi-directional scrolling
```
more file.txt
less file.txt
```

### wc
Returns the wordcount of a given file
```
wc file.txt
wc -w file.txt
```

ps
who
w

### whatis
display one-line manual page descriptions
```
whatis git
```

### whereis
locate the binary, source, and manual page files for a command
```
whereis git
```
