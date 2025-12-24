PREFIX = /usr/local

all:
        @echo Run \'make install\' to install GUI-CLI-Toggle.
        @echo Dependencies\: \'sudo systemd bash make coreutils \<display-manager\: Choose either gdm sddm lightdm lxdm xdm ly\>\'

install:
        @sudo mkdir -pv ${DESTDIR}/${PREFIX}/bin
        @sudo cp -vr gui-cli-toggle ${DESTDIR}/${PREFIX}/bin/
        @sudo chmod -v +x ${DESTDIR}/${PREFIX}/bin/gui-cli-toggle
        @echo Installed GUI-CLI-Toggle

uninstall:
        @sudo rm -rfv ${DESTDIR}/${PREFIX}/bin/gui-cli-toggle*
        @echo Uninstalled GUI-CLI-Toggle
