## Required Dependencies
* systemd
* bash
* make
* coreutils

## Display Managers (CHOOSE ONLY ONE)
* gdm
* sddm
* lightdm
* lxdm

## Installation
### Arch Linux
Using yay:
```sh
yay -S gui-cli-toggle
```

Using paru:
```sh
paru -S gui-cli-toggle
```

Manual installation: (Requires git)
```sh
git clone https://aur.archlinux.org/gui-cli-toggle.git gui-cli-toggle.AUR
cd gui-cli-toggle.AUR
makepkg -si
cd ..
rm -rf gui-cli-toggle.AUR
```

### Installing from Source for Other Distributions (With Systemd)
First grab a Release Tarball and then run these commands:
```sh
tar -xvf gui-cli-toggle-<x>.<y>.<z>.tar.xz
cd gui-cli-toggle-<x>.<y>.<z>
```

Run this command as the root user:
```sh
make install
```

Run the rest as the previous user:
```sh
cd ..
rm -rf gui-cli-toggle-<x>.<y>.<z>
```

## TODOLIST
- [X] Make an option to switch on Reboot: [-r --reboot].
- [ ] Add support for other Init Systems such as OpenRC and SysVInit (Primarily with LFS-Bootscripts).
