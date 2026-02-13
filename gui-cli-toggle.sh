#!/bin/bash

gui_cli_toggle_variable_VERSION="2.1.0"
gui_cli_toggle_variable_TARGET="$(systemctl get-default)"

gui_cli_toggle_function_confirm() {
        read -r -p "$1 [y/N]: " gui_cli_toggle_confirm_response
        case "${gui_cli_toggle_confirm_response}" in
                [yY][eE][sS]|[yY])    return 0 ;;
                *) echo "Cancelled."; exit   0 ;;
        esac
}

gui_cli_toggle_function_dm() {
        local gui_cli_toggle_variable_DMS=("gdm" "sddm" "lightdm" "lxdm")
        for gui_cli_toggle_variable_DM in "${gui_cli_toggle_variable_DMS[@]}"; do
                if systemctl list-unit-files | grep -q "^${gui_cli_toggle_variable_DM}.service"; then
                        echo "${gui_cli_toggle_variable_DM}"
                        return 0
                fi
        done
        return 1
}

gui_cli_toggle_function_root() {
        if   [ $EUID = 0 ];          then          ${*}
        elif [ -x /usr/bin/sudo ];   then sudo     ${*}
        elif [ -x /usr/bin/doas ];   then doas     ${*}
        elif [ -x /usr/bin/pkexec ]; then pkexec   ${*}
        else                              su -c \\"${*}\\"
        fi
}

case "${1}" in
        -v|--version)
                echo "gui-cli-toggle version ${gui_cli_toggle_variable_VERSION}"
                echo ""
                echo "(C) Glitt3ring (2025-2025)"
                echo "(C) Zheralix   (2026-Present)"
                echo ""
                echo -e "You may \e[1;31mNOT\e[0m distribute this package without Zheralix's permission."
                echo -e "You may \e[1;31mNOT\e[0m distribute this package if you will not credit Zheralix."
                echo -e "You \e[1;32mMAY\e[0m support additional display managers to this script."
                echo -e "You \e[1;32mMAY\e[0m create patches for this package that will fix problems."
        ;;
        "")
                echo "gui-cli-toggle version ${gui_cli_toggle_variable_VERSION}"
                echo ""
                echo -e "\e[1;33mWARNING\e[0m: If this script uses 'pkexec' or 'su',"
                echo "         Then you must enter the correct password for every iteration of the script."
                echo ""
                echo -e "\e[1;31mCAUTION\e[0m: Make sure to save your work before running this script."
                echo ""
                echo "Current default target: ${gui_cli_toggle_variable_TARGET}"
                if [[ "${gui_cli_toggle_variable_TARGET}" == "graphical.target" ]]; then
                        echo "This will switch to text mode (multi-user.target) and close your GUI session."
                        gui_cli_toggle_function_confirm "Are you sure you want to continue?"

                        gui_cli_toggle_variable_DM="$(gui_cli_toggle_function_dm)"
                        if [[ -n "${gui_cli_toggle_variable_DM}" ]]; then
                                echo "Disabling display manager: ${gui_cli_toggle_variable_DM}"
                                gui_cli_toggle_function_root systemctl disable "${gui_cli_toggle_variable_DM}.service"
                        fi

                        gui_cli_toggle_function_root systemctl set-default multi-user.target
                        echo "Switching to multi-user.target..."
                        gui_cli_toggle_function_root systemctl isolate multi-user.target
                elif [[ "${gui_cli_toggle_variable_TARGET}" == "multi-user.target" ]]; then
                        gui_cli_toggle_variable_DM="$(gui_cli_toggle_function_dm)"
                        if [[ -z "${gui_cli_toggle_variable_DM}" ]]; then
                                echo -e "\e[1;31mERROR\e[0m: No display manager service found on the system."
                                echo "Install either: (gdm, sddm, lightdm, or lxdm) to use graphical.target."
                                exit 1
                        fi

                        echo "This will switch to GUI mode (graphical.target)."
                        gui_cli_toggle_function_confirm "Are you sure you want to continue?"

                        echo "Enabling display manager: ${gui_cli_toggle_variable_DM}"
                        gui_cli_toggle_function_root systemctl enable "${gui_cli_toggle_variable_DM}.service"

                        gui_cli_toggle_function_root systemctl set-default graphical.target
                        echo "Switching to graphical.target..."
                        gui_cli_toggle_function_root systemctl isolate graphical.target
                else
                        echo "Unknown default target: ${gui_cli_toggle_variable_TARGET}"
                        exit 1
                fi
        ;;
        -r|--reboot)
                echo "gui-cli-toggle version ${gui_cli_toggle_variable_VERSION}"
                echo ""
                echo -e "\e[1;33mWARNING\e[0m: If this script uses 'pkexec' or 'su',"
                echo "         Then you must enter the correct password for every iteration of the script."
                echo ""
                echo -e "\e[1;31mCAUTION\e[0m: Make sure to save your work before running this script."
                echo ""
                echo "Current default target: ${gui_cli_toggle_variable_TARGET}"
                if [[ "${gui_cli_toggle_variable_TARGET}" == "graphical.target" ]]; then
                        echo "This will switch to text mode (multi-user.target) and close your GUI session."
                        gui_cli_toggle_function_confirm "Are you sure you want to continue?"

                        gui_cli_toggle_variable_DM="$(gui_cli_toggle_function_dm)"
                        if [[ -n "${gui_cli_toggle_variable_DM}" ]]; then
                                echo "Disabling display manager: ${gui_cli_toggle_variable_DM}"
                                gui_cli_toggle_function_root systemctl disable "${gui_cli_toggle_variable_DM}.service"
                        fi

                        gui_cli_toggle_function_root systemctl set-default multi-user.target
                        echo "Switching to multi-user.target..."
                        gui_cli_toggle_function_root reboot
                elif [[ "${gui_cli_toggle_variable_TARGET}" == "multi-user.target" ]]; then
                        gui_cli_toggle_variable_DM="$(gui_cli_toggle_function_dm)"
                        if [[ -z "${gui_cli_toggle_variable_DM}" ]]; then
                                echo -e "\e[1;31mERROR\e[0m: No display manager service found on the system."
                                echo "Install either: (gdm, sddm, lightdm, or lxdm) to use graphical.target."
                                exit 1
                        fi

                        echo "This will switch to GUI mode (graphical.target)."
                        gui_cli_toggle_function_confirm "Are you sure you want to continue?"

                        echo "Enabling display manager: ${gui_cli_toggle_variable_DM}"
                        gui_cli_toggle_function_root systemctl enable "${gui_cli_toggle_variable_DM}.service"

                        gui_cli_toggle_function_root systemctl set-default graphical.target
                        echo "Switching to graphical.target..."
                        gui_cli_toggle_function_root reboot
                else
                        echo "Unknown default target: ${gui_cli_toggle_variable_TARGET}"
                        exit 1
                fi
        ;;
        -h|--help)
                echo "gui-cli-toggle version ${gui_cli_toggle_variable_VERSION}"
                echo ""
                echo "gui-cli-toggle [-h --help] [-r --reboot] [-v --version]"
                echo "Type 'gui-cli-toggle' alone to switch between GUI/CLI."
                exit 1
        ;;
        *)
                echo "gui-cli-toggle version ${gui_cli_toggle_variable_VERSION}"
                echo ""
                echo "Unknown option: ${1}"
                echo "gui-cli-toggle [-h --help] [-r --reboot] [-v --version]"
                echo "Type 'gui-cli-toggle' alone to switch between GUI/CLI."
                exit 1
        ;;
esac
