### Identify CPU/memory intensive processes, adjust process priority with renice, and kill processes
---

##### System Activity
Commands to identify running processes:
```
top
ps -ef
ps -waux
```

Kill process: `kill <PID>`

Forcefully kill process: `kill -9 <PID>`

##### Process Priority

Alter priority of running process: `renice <priority> <PID>`

Alter multiple priorities at once: `renice <priority> <PID> -u <username> -p <another_PID`

#####System Reporting

To display details about IO activities, type: `iostat`

To show network card activities, type: `netstat -i`

To display socket activities, type: `netstat -a`

To get details about virtual memory activities (memory, swap, run queue, cpu usage, etc) every 5 second, type: `vmstat 5`

To get a full report of a server activity, type: `sar -A`