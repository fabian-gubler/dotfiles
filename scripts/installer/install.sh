#!/bin/sh

aurhelper="yay"

# ------------------------------------------------------
# --- PART 1: INTRODUCTION------------------------------
# ------------------------------------------------------

echo
echo 'Some things need to be done first before running...'
echo

echo 'Synchronizing database and updating packages'
sudo pacman -Syu --noconfirm --needed

# Git
sudo pacman -S git --noconfirm --needed

# ------------------------------------------------------
# --- PART 2: INSTALLATION------------------------------
# ------------------------------------------------------

echo
echo "INSTALLING AUR HELPER"
echo

# Base-devel
sudo pacman -S base-devel --noconfirm --needed

# Build
if ! command -v $aurhelper &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git "$HOME/downloads/yay"
    cd $HOME/downloads/yay
    makepkg -si --noconfirm
    rm -rf $HOME/downloads/yay
else
    echo "$aurhelper already Exists, skipping..."
fi

# ----------------------------------------------------

echo
echo "INSTALLING SOFTWARE"
echo

PRGS=(

    # LANGUAGES ---------------------------------------------------------------
    'python-pip'                  # Python packages
    'rust'                        # Programming language

    # DEVELOPMENT -------------------------------------------------------------
    'neovim'                      # Text editor
    'typora'                      # Markdown editor

    # COMMAND LINE TOOLS ------------------------------------------------------
    'zsh'                         # Shell
    'tmux'                        # Terminal Multiplexer
    'git'                         # Version control
    'lazygit'                     # Git management
    'zsa-wally-cli'               # Keyboard Layout
    'gotop'                       # System monitoring
    'exa'                         # Better ls
    'wget'                        # Download web content
    'ranger'                      # File explorer
    'dragon-drag-and-drop-git'    # Drag and drop
	'todotxt'					  # Todo

    # SYSTEM ------------------------------------------------------------------
    'alacritty'                   # Terminal
    'lxappearance'                # GTK theme switcher
    'qt5ct'                       # Qt theming
    'adwaita-qt'                  # Adwaita dark
    'tlp'                         # Battery optimization

    # UTILITIES ---------------------------------------------------------------
    'ueberzug'                    # Image preview
    'xsane'                       # Scanning
    'qbittorrent'                 # Torrent client
    'unclutter'                   # Mouse timeout
    'flameshot'                   # Screenshot tool
    'timeshift'                   # Backup snapshots
    'insync'                      # Cloud sync
    'networkmanager-dmenu-git'    # Network manager
    'devour'                      # Swallow programs
    'baobab'                      # Disk space
    'unzip'                       # Unzip directories

    # WEB TOOLS ---------------------------------------------------------------
    'firefox'                     # Web browser
    'firefox-developer-edition'   # Web browser
    'firefox-tridactyl-native'    # Vim integration
    'ferdi'                       # Website Platform

    # MEDIA -------------------------------------------------------------------
    'alsa-utils'                  # For setting volume
    'bluez-utils'                 # Bluetooth support
    'bluez'                       # Bluetooth protocol
    'pipewire'                    # Audio
    'pipewire-pulse'              # Audio
    'gst-plugin-pipewire'         # Required, no idea
    'sxiv'                        # Image viewer
    'mpv'                         # Media player
    'ncpamixer'                   # Cli Pavucontrol

    # PRODUCTIVITY ------------------------------------------------------------
    'mailspring'                  # Email Client 
    'anki'                        # Flashcard app
    'pcmanfm-gtk3'                # GTK file manager
    'zoom'                        # Virtual Classroom
    'teams'                       # Video Communication
    'masterpdfeditor'             # PDF editor (advanded)
    'okular'                      # PDF editor (light)
    'zathura'                     # PDF viewer
    'xournal'                     # PDF markup

    # VIRTUALIZATION ----------------------------------------------------------
    'virtualbox'                  # OS virtualization
    'virtualbox-host-dkms'        # Kernel modules
    'virtualbox-guest-utils'      # Guest utilities
)

# Compare list with already installed packages
packages=$(comm -13 <(pacman -Qqe | sort) <(printf "%s\n" "${PRGS[@]}" | sort))

# Installation loop
for PKG in $packages; do
    echo "INSTALLING: $PKG"
    sudo sudo -u $USER $aurhelper -S "$PKG" --noconfirm --needed
done

# ------------------------------------------------------

echo
echo "Done!"
echo "All packages have been installed"
echo

# ------------------------------------------------------
# --- PART 3: FINAL SETUP ------------------------------
# ------------------------------------------------------
echo
echo "FINAL SETUP AND CONFIGURATION"

# Systemd
sudo systemctl enable cups
sudo systemctl enable pipewire
sudo systemctl enable pipewire-pulse
sudo systemctl enable bluetooth
sudo systemctl enable tlp

# Keyboard
localectl set-x11-keymap us "" altgr-intl

# Wifi connect automatically
nmcli radio wifi on

ssh-keygen
cat $HOME/.ssh/id_rsa.pub

# User confirmation dialog
while true; do
    read -p "Add your ssh key to github settings [y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Optional: git clone command

# FINISH -----------------------------------------------

# Reboot prompt
while true; do
    read -p "Do you wish to reboot your system? [y/n]" yn
    case $yn in
        [Yy]* ) reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
