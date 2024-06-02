# SSH and Samba for Anbernic RG35XXSP Stock OS

**Why would you want this?**

Constantly having to take your device's MicroSD card out and inserting in into your computer just to move and copy files over can get pretty tedious after a while. With these features, you can now manage your MicroSD card while inside your RG35SXSP wirelessly.

Samba allows the MicroSD card to be accessible as a network share on computers. If you use something like SyncThing to sync your saves and save states across devices, you should be able to more easily set up your sync paths to and from the network shares of your RG35XXSP.

**How it works**

There are four files:

* ssh_disable.sh
* ssh_enable.sh
* samba_disable.sh
* samba_enable.sh

The RG35XXSP stock OS has the packages needed for SSH. But to my knowledge, Anbernic doesn't provide any built-in settings for users to enable it. _ssh_enable.sh_ basically flips on a preexisting flag that will run additional lines to start up SSH on the next reboot. _ssh_enable.sh_ will also start SSH services immediately after running without needing to reboot. From there, go to your computer, open WinSCP or an SFTP app of your choice, point it to your device's IP, use root and root for credentials, and you should be good to go with root level access. You can also connect to the device through SSH and run bash commands, by opening a terminal on your computer and typing in: ssh root@<Your RG35XXSP's IP>

Samba unfortunately does not seem to be packaged with the stock OS, so _samba_enable.sh_ will do an apt-get command to pull the necessary packages off the Internet in order to install it. Depending on your Internet speeds, that may take a few minutes. The script also initiates Samba services without having to reboot, and configures itself to automatically turn on after a reboot. Once the script finishes, you should be able to start accessing it through Windows by opening your start menu and typing in \\<Your RG35XXSP's IP>\ during which point you should be prompted for credentials, which are once again root and root. 

I've set up two network shares: 
1. __sdcard - the same location as when you access your MicroSD card's partition
2. __root - the top level (/) directory.

**Installation**

1. Connect your MicroSD card to your computer.
2. Access the card's partition.
3. Drop the .sh files into Roms\APPS.
4. Put the MicroSD card into your RG35XXSP.
5. Boot it up and select the App Center.
6. Select APPS.
7. Run _ssh_enable.sh_ and/or _samba_enable.sh_ in either order.
8. Access your RG35XXSP by SFTP with WinSCP, SSH with a terminal, or with Samba by connecting to it as a network drive. Use credentials root and root if prompted.

**Disclaimer**

For network security reasons, I highly recommend you keep these features disabled when you're not at home. Simply run _ssh_disable.sh_ and _samba_disable.sh_ to turn them off. Also, the scripts are provided as-is. If you don't feel comfortable about what the scripts do, either back up your saves first or just don't risk it.
