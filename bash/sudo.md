

- **The problem:** while being logged as a normal user, I need to run a command that needs privilege access
- Options
    - Switch to the root account (using *su* command) and run the command
    - Use *setuid* / *setgid* - the program starts using the normal user UID/GID (thus having some normal access rights) but changes its effective UID/GID to some other value (which usually gives more priviledge access rights)
        - Example: *passwd* command that allows a regular user to change the password is using *setuid* to update files in /etc/
