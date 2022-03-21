

# Repeat the last commands
# Repeat last executed command (CTRL-P / CTRL-O)
!!
# Repeat last executed command as root
sudo !!
# Repeat last executed command that starts with specific word/char
!un                         # unset command may execute this way
# Repeat the last n-th executed command
!-5                         # this will execute the last 5-th command


# Getting the current PID -> $$
ps -f $$
echo $$
# List current runnning jobs
> psx aux
# A tree of jobs (with PID)
> pstree -p


# Identifies all the types of "pwd" commands available - that could be run 
# (shell built in, external, aliases, functions etc)
> type -a pwd
# Same like "type" but this isonly looking in PATH!
> which -a pwd


# Unset a variable
unset VAR1
# check that the variable does not exist
declare -p VAR1


# Getting the length of a variable
VAR1=mihai
echo ${#VAR1}               # this will echo 5


# Reading data into a variable ($PASSWD in this case)
#   - if a variable is not specified, the value is read in $REPLY variable
# -p: A prompt will ask for a password
# -n5: only 5 characters will be read
# -s: silent mode
read -p -n5 -s "Enter password: " PASSWD


# Using a default value for a variable
# If VAR1 is NULL or unset then "default_value_1" will be used
echo ${VAR1:-default_value_1}
# If VAR1 is unset then "default_value_2" will be used
# - if VAR1 is NULL, the default value is not used
echo ${VAR1-default_value2_}


# String replacement
VAR1=replacement
# First occurance replacement
echo ${VAR1/e/E}                # this will display "rEplacement"
# Global occurance replacement
echo ${VAR1//e/E}                # this will display "rEplacEmEnt"

# Run long-running scripts that will allow you to logout
#    & - run in background mode
#    nohup - will allow logs to be available in nohup.out file
#    my_script parent after logging out will be systemd (PID = 1) 
nohup my_script &
