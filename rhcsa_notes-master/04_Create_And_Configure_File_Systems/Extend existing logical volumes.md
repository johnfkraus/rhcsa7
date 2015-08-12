Extend existing logical volumes

Display information about configured logical volumes
# lvdisplay

Extend logical volume:
# lvextend -L +100M /dev/my_volgrp/my_logvol

# lvextend -L 500M /dev/my_volgrp/my_logvol