
- [Preventing root login](#preventing-root-login)

## Preventing root login
- We first create a user that has administrative rights
- Then we disable root loging in ssh
```
    # First ssh using root
    > ssh root@ip_address

    # Add the user you want to use as admin to the group that has admin rights
    > sudo usermod -a -G admingroup adminuser

    # Exit ssh and login again using adminuser
    > ssh adminuser@ip_address
    # Get root access
    > sudo -s
    # Edit /etc/ssh/sshd_config file and set the "PermitRootLogin" to "no"

    # Restart the sshd daemon
    > sudo systemctl restart sshd
    # From this moment on root access to ssh is no longer allowed
```




