# Boot, reboot, and shut down a system normally
## 6.4. SHUTTING DOWN, SUSPENDING, AND HIBERNATING THE SYSTEM
**Table 6.8. Comparison of Power Management Commands with systemctl**

| Old Command       	| New Command            	| Description                         	|
|-------------------	|------------------------	|-------------------------------------	|
| halt              	| systemctl halt         	| Halts the system.                   	|
| poweroff          	| systemctl poweroff     	| Powers off the system.              	|
| reboot            	| systemctl reboot       	| Restarts the system.                	|
| pm-suspend        	| systemctl suspend      	| Suspends the system.                	|
| pm-hibernate      	| systemctl hibernate    	| Hibernates the system.              	|
| pm-suspend-hybrid 	| systemctl hybrid-sleep 	| Hibernates and suspends the system. 	|
