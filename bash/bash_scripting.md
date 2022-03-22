

## Passing argumets
- Argumets are received in the script as $1, $2, etc
- $0 is the name of the script
- $# is the number of the arguments
- $* is the complete list of arguments as a string
- $@ is the complete list of arguments as a array
- **NOTE:** $#, $* and $@ contain only the arguments themselves (the name of the script is excluded)
- *shift* command is shifting the list of arguments to the left we we process them
    - This way, the script will only have to work with $1 as *shift* will put there the next argument that needs to be processed.
- *getops* allows you to process arguments in the script
    - *getops ab* -> this means that we can pass "-a" and "-b" as options
    - *getops a:b* -> the ":" after "a" means that we can pass an argument after "-a" option
        - $OPTARG contains the argument after an option
        - Put a ":" at the begining of the options list (e.g. *:ab*) to signal that you accepts options other than "a" or "b" - this is useful to support a custom help.
    - *--* -> this signals the end of options list. From this moment on everything will be considered as arguments for the script.

## Running scripts
- Run a script and logout
    - This is supported by modern shell - just start your script in background mode
    - After you logout, the parent of the script is systemd (PID 1)
    - NOTE: The TTY will no longer be available if you logout!!!
        - If you are interested in logs, use "nohup" - output data will be available in nohup.out file
- "at" command to run a job at a certain moment in time (e.g.*at noon* )
    - *atq* - to see the jobs in the queue
    - *at -c JobID* - to see the details / configurations of a job
    - *atrm jobID* - to remove a job from the queue
- crontab: runs the scheduled jobs at a very specific interval, but only if the system is running at that moment.
    - "-e" - to edit the crontab schedule
    - "-l" - to list the crontab schedule
- anacron: runs the scheduled job even if the computer is off at that moment
    - [Cron vs Anacron](https://www.putorius.net/cron-vs-anacron.html)
- Systemd - starting the script as a service usinng systemd
    - Service Unit sections
        - Unit
            - Description - description of the service
            - After - specifies after which service the current service should start
        - Service
            - Type - type of the service (e.g. "simple")
            - ExecStart - the command to start the service
            - ExecStop - the command to stop the service
            - KillMode - specifies how processes of this unit shall be killed. One of control-group, mixed, process, none.
        - Install - needed if we want to enable the service to start on system boot
            - WantedBy - specifies the system boot target (run level ) where the service should be started on
    - Systemd maintains the PID of the service in $MAINPID
    - System configuration files are stored in */etc/systemd/system*
    - Re-reading the services available (used when you add a new service config file): *systemctl daemon-reload*
    - Enable and start a service: *systemctl enable --now myservice.service*
    - Check status: *systemctl status myservice.service*
