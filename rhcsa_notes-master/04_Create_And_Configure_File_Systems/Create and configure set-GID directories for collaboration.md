Create and configure set-GID directories for collaboration

List information for directory:
# ls -l | grep /test

Assign group to directory:
# chgrp -R new_group /test   

Set GID on directory:

# chmod g+s /test