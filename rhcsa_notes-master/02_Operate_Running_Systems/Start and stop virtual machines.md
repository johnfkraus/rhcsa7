### Start and stop virtual machines
---

##### VM Management
`virsh start vm.random-host.com`: Starts VM

`virsh shutdown vm.example.com`: Stops VM nicely

`virsh destroy vm.example.com`: Stops VM immediately

`virsh undefine vm.example.com`: Deletes VM

`virsh reboot vm.example.com`: Reboots VM

`virsh dominfo vm.example.com`: Displays configuration information of VM

##### VM Reporting
`virsh list --all`: List all VMs

`virt-top`: See activity of all running VMs