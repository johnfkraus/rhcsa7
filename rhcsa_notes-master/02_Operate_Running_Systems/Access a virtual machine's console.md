### Access a virtual machine's console
---
##### KVM
Access graphical KVM manager: `virt-manager`

##### Without X Windows
In the `/boot/grub2/grub.cfg` file:
```
grubby --update-kernel=ALL --args="console=ttyS0"
```