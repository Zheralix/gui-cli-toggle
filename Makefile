# Beginning of settings and variables.

DESTDIR =
PREFIX  = /usr/local
BINDIR  = ${PREFIX}/bin

# End of settings and variables.

all:
        @echo Run \'make install\' to install gui-cli-toggle\.
        @echo Dependencies\: \'systemd bash make coreutils \<display-manager\> \(Choose either\: gdm\, sddm\, lightdm\, or lxdm\)\'
        @echo You can also run \'head -n7 Makefile\' for a list of settings and variables\.

install:
        mkdir   -p                      ${DESTDIR}${BINDIR}
        install -m755 gui-cli-toggle.sh ${DESTDIR}${BINDIR}/gui-cli-toggle
        @echo Installed gui-cli-toggle\.
        @echo -n -e "\e[1;31m"
        @echo "+------------------------------------------------------------------------------+"
        @echo "| IF YOU ARE USING A TTY (FRAMEBUFFER CONSOLE OR TEXT MODE CONSOLE),           |"
        @echo "| AND/OR YOU ARE USING SOMETHING LIKE XINIT TO USE GUI,                        |"
        @echo -e "| THEN MAKE SURE TO RUN \"\e[1;37msystemctl set-default multi-user.target\e[1;31m\".             |"
        @echo "+------------------------------------------------------------------------------+"
        @echo -n -e "\e[1;32m"
        @echo "+------------------------------------------------------------------------------+"
        @echo "| IF YOU ARE USING GUI (WITH A SUPPORTED DISPLAY MANAGER BY gui-cli-toggle),   |"
        @echo -e "| THEN MAKE SURE TO RUN \"\e[1;37msystemctl set-default graphical.target\e[1;32m\".              |"
        @echo -e "\e[1;32m+------------------------------------------------------------------------------+\e[0m"

install-without-msg:
        mkdir   -p                      ${DESTDIR}${BINDIR}
        install -m755 gui-cli-toggle.sh ${DESTDIR}${BINDIR}/gui-cli-toggle

uninstall:
        rm ${DESTDIR}${BINDIR}/gui-cli-toggle
        @echo Uninstalled gui-cli-toggle\.

uninstall-without-msg:
        rm ${DESTDIR}${BINDIR}/gui-cli-toggle

.PHONY: all install install-without-msg uninstall uninstall-without-msg
