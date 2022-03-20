

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

