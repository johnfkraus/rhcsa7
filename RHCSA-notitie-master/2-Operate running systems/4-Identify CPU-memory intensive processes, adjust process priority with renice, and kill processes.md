# Identify CPU/memory intensive processes, adjust process priority with renice, and kill processes
## http://www.certdepot.net/sys-identify-cpu-memory-intensive-processes/
To get an instantaneous image of a server activity (use ‘virt-top‘ on a KVM hypervisor), type:
```shell
# top
```
To get details about processes, type:
```shell
# ps -edf
```
To start a process (here script.sh) with a low priority, type:
```shell
# nice -n 10 ./script.sh
```
To change the priority (here +5) of an already running process, get its PID (Process ID) through top or ps (here 789) and type:
```shell
# renice +5 789
```
**Alternatively:**
```shell
# renice +5 `pgrep script.sh`
```
To kill the process, get its PID through top or ps (here 789) and type:
```shell
# kill -9 789
```
**Alternatively:**
```shell
# pkill script.sh
```
To display details about IO activities, type:
```shell
# iostat
```
To show network card activities, type:
```shell
# netstat -i
```
To display socket activities, type:
```shell
# netstat -a
```
To get details about virtual memory activities (memory, swap, run queue, cpu usage, etc) every 5 second, type:
```shell
# vmstat 5
```
To get a full report of a server activity, type:
```shell
# sar -A
```
