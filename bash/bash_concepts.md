
- [Types of Shell](#types-of-shell)
- [Basic workflows / concepts](#basic-workflows--concepts)
- [My Links](#my-links)

## Types of Shell
- Interactive vs Non-Interactove
    - Interactive: attached to the terminal (TTY) and allows you to send commands and see the results
    - Non-Interactive: not attached to the TTY and cannot receive commands
        - Used to run scripts
- Login vs Non-Login
    - Login: a login shell is started when a shell is required as part of the login process (e.g. ssh into a server)
        - Will execute any commands or set any confguration required as part of starting the session
    - Non-Login: a non-login shell will set any configuration specific to setting up the sell itself (rather than the session)
        - Example: the shell you get from graphical session when you start the Terminal (you are already logged in the machine by the graph interface)
- Bash config files order
    - For interactive login shell
        - If system admin has configured this file: /etc/profile
        - Then will read from the first of the following files (if exist)
            - ~/.bash_profile
            - ~/.bash_login
            - ~/.profile
        - When the shell ends:
            - ~/.bash_logout
    - For interactive non-login shell
        - Will first read /etc/bash.bashrc
        - Then will read ~/.bashrc
- Z-Shell config files order
    - For interactive login the following files are executed in order:
        - /etc/zshenv      -> to set global env variables
        - ~/.zshenv        -> to set local env variables
        - /etc/zprofile    -> if exists
        - ~/.zprofile
        - /etc/zshrc       -> if exists
        - ~/.zshrc         -> to set up local aliases, options and custom prompt
        - /etc/zlogin      -> if exists
        - ~/.zlogin        -> to finish local setting up the interactive logging shell
        - When the shell ends:
            - ~/.zlogout
    - For interactive non-login the following files are executed in order:
        - /etc/zshenv      -> to set global env variables
        - ~/.zshenv        -> to set local env variables
        - /etc/zshrc       -> if exists
        - ~/.zshrc         -> to set up local aliases, options and custom prompt

## Basic workflows / concepts
- Customizing prompt
    - bash: set the PS1 env variable
    - zshell: set the PROMPT env variable
- Shell options
    - Shopt for bash and Setopt for zsh
        - Or Set for both bash and zsh
            - Use *set -o* to see the current configurations
    - Options examples
        - autocd: change dir without specifying *cd* command
        - noclobber: used to prevent accidetal file overwrites when using output redirection (*>*)
            - In this mode, if you really want to overwrite the file, use *>|*
        - noglob: perform / suppress filename generation (e.g. using * to get all the log files: */home/\*.log*)
        - restricted_shell: switch shell to a restricted mode (e.g. cd to other dirs is denied)
            - On bash you enable it with *bash -r* or *rbash*
- Calculating values
    ```
    # Let command: shell built-in
    > let VAR1=2+3

    # Expr command: external command - more portable
    # Spaces are important between 2 and 3!!
    > VAR2=$(expr 2 + 3)

    # (())  -> double paranteses
    > VAR3=$((2+3))
    ```
- Arrays
    ```
    # Declare an array variable
    > declare -a ARR1=([0]=elem0 [1]=elem1 [2]=elem2)
    > echo ${ARR1[0]}

    # Declare an associative array variable - available from BASH 4 and above
    > declare -A ARR2=([key0]=val0 [key1]=val1)
    > echo ${ARR2[key0]}
    ```
- $VAR1 vs "$VAR1"
    - You should use the quoted version to handle cases where the VAR1 value contains spaces.
- I/O
    - Redirecting STDIN(0), STDOUT(1), STDERR(2)
    ```
    # Redirect STDOUT
    > 1>file1
    > >file1

    # Redirect STDERR
    > 2>file2

    # Redirect STDOUT and STDERR
    > &>file3               # file3 is open once
    > >&file3               # Same as before
    > 1>file3 2>file3       # file3 is open twice
    > 2>&1                  # redirects stderr (fd 2) to the current value of stdout (fd 1)

    ```
    - *>* redirects STDOUT and *2>* redirects STDERR
    - *&>* redirects both STDOUT and STDERR to the same file
- Running jobs in foreground / background
    - CTRL-Z will suspend a job
        - With *jobs* command you will get the list of suspended jobs
    - Run a comamnd with *&* at the end to run the job in background
        - With *jobs* command you will get the list of jobs running in background
    - Use *fg %JobID* to resume a suspended job in foreground or to bring a background job in the foreground
        - If JobID will not be provided then the last job that was suspended will be resumed
    - Use *bg %JobID* to resume a suspended job in background
- Variables
    - Initialize by *variable=value*
    - Resolve the variable using the $ sign: *$variable*
    - Make them global by using *export*
    - **Command substitution:** You can assign the output of a command to a variable by using *$(command)*
- Nice: use it to set the priority of a process
    - Values from -20 (highest prio) to 19 (lowest prio)
        - Default prio is 0 (zero)
    - Once set, to increase the prio you need root capabilities!
- Signals
    - HUP: Hang Up signal  (ID = 1)
        - Sent to a backgrounnd job when the spawning foreground job is ended
            - *nohup* utility is used to stop backgrounnd jobs from terminating when their parent ends
    - INT: Interrupt signal (ID = 2)
        - Sent to the foreground job when CRTL-C is pressed
        - Used to stop jobs
    - QUIT: Quit signal (ID = 3)
        - Used for terminating a process while dumpinng its memory (to be used for debugging)
    - KILL: Kill signal (ID = 9)
        - This signal cannot be ignorred!
        - Used to forcefuly terminate a process (the process will not have the opportunity to run anny cleanup operations)
    - TERM: Terminate signal (ID = 15)
        - A signal send by other process to terminate a process
    - STOP: Stop signal (ID = 19)
        - This signal cannot be ignorred!
        - Used to suspend a running process
    - STP: Stop signal (ID = 20)
        - Similar with STOP but this signal can be ignored
        - Sent to the foreground job when CRTL-Z is pressed
    - CONT: Continue signal  (ID = 18)
        - Sent to a suspended process to signal the resume of execution
    - Kill command
        - You can send a signal to a process id (PID)
            - Specify *-s* flag to specify the signal name
        - If no signal is specified, TERM will be sent
- Job performace: top, htop
- See running jobs
    ```
    > psx aux

    # A tree of jobs (with PID)
    > pstree -p

    # The PID of the current process
    > echo $$
    ```
- exec
    - Whenever we run any command in a Bash shell, a subshell is created by default, and a new child process is spawned (forked) to execute the command. When using exec, however, the command following exec replaces the current shell. 
        - This means no subshell is created and the current process is replaced with this new command.
        - When the new command exits the process that initially started the shell also exits.
    - exec can also be used to manipulate file descriptors
    ```
    # The output is now written in the log file instead of STDOUT
    > exec 1>>file1.log
    # We are writing STDERR to STDOUT which was already redirected to file1.log
    > exec 2>&1

    # Changing STDIN to read from a file 
    > exec < input.txt

    # Open input.txt file on file-descriptor 4
    > exec 4< input.txt
    # Read a line from file-descriptor 4 (which means read from input.txt)
    > read -u 4 line
    # Close file-descriptor 4
    > exec 4<&-

    # Create file-descriptor 5 and redirect it to the same location as 
    # the current STDOUT (1)
    > exec 5>&1
    # Redirect STDOUT to file.log
    > exec > file.log
    # Reset the STDOUT to the previous channel (saved in file-descriptor 5) 
    # and reset file-descriptor 5
    > exec 1>&5 5>&-
    ```
    - exec can also be executed on the files found by the found command
    ```
    # Here we specified the option -type f  to find only the regular files. 
    # Thereafter, we used the -exec option to execute the grep command on the 
    # list of files returned by the find command. Note the semi-colon at the 
    # end causes the grep command to be executed for each file, one at a time, 
    # as the {} is replaced by the current file name. Note also a backslash is 
    # required to escape the semi-colon from being interpreted by the shell.
    > find src -name "*.java" -type f -exec grep -l interface {} \;
    ```
- HEREDOC
    - The string *END* can be any text that we like - but it has to match with the string at the end of the heredoc.
    ```
    > cat > file1.txt <<END
    Line 1
    Line2
    END
    ```
  

## My Links
- https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
- 