I made this fork for gui-cli-toggle now because I've switched from Glitt3ring to Zheralix.

TODOLIST:
1. Make an option to switch on Reboot: "-r --switch-on-reboot".
2. Make an option for help: "-h --help".
3. Make an option to switch without disabling the Display Manager: "-d --do-not-disable-the-display-manager".
4. Make it use the font from /etc/vconsole.conf if present.
5. Turn this into a source that compiles with a compiler.
6. Make a configure script for selecting PREFIX.
7. Add colors and an option to disable colors: "--no-color".
8. Make the script run all commands with polkit (But it only asks for password once) instead of sudo...
9. Make an Initial Release.
...

Required Dependencies:
1. sudo (Or polkit, If you modify the gui-cli-toggle bash script)
2. systemd
3. bash
4. make
5. coreutils

Display Managers (CHOOSE ONLY ONE):
1. gdm
2. sddm
3. lightdm
4. lxdm
5. xdm
6. ly

Installing the Script:
1. The default PREFIX is /usr/local, If you want to use something like /usr or /opt/gui-cli-toggle, Then run 'sed -i "s|/usr/local|/usr|g" Makefile', Or 'sed -i "s|/usr/local|/opt/gui-cli-toggle|g" Makefile'.
2. Make sure you have the Required Dependencies.
3. Run "make install" as the root user. (The output will be verbose so you know exactly what this does)
4. If you are not using /usr or /usr/local and/or the PREFIX is not in your PATH, Then you will have to run PREFIX/bin/gui-cli-toggle, For example: "/opt/gui-cli-toggle/bin/gui-cli-toggle".

If you don't know what these variables mean, Then:
1. PATH: The PATH variable is exported to the path of binaries, For Example PATH=/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin
2. PREFIX: The PREFIX variable is usually /usr/local, For example: if you make the PREFIX /foo/bar, Then the binary will be in /foo/bar/bin/gui-cli-toggle.
