Use boolean settings to modify system SELinux settings

Get boolean listing:
# getsebool -a

Locate specific booleans:
# getsebool -a | grep <process>

Turn on|off specific boolean:

# setsebool -P <boolean> on|off