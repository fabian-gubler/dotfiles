# -----------------------------------------------------------------------------
# Install Script
# -----------------------------------------------------------------------------
# TODO: Automatic Updates | https://fedoraproject.org/wiki/AutoUpdates
# TODO: Adding Swap Space for hibernation (~10GB)

# TODO: Status Bar DWM
	# - nm-applet
	# - protonvpn

# -----------------------------------------------------------------------------
# Post Install Script
# -----------------------------------------------------------------------------
# NOTE: A normal symlink would be even easier
# NOTE: Dotbot with Nextcloud could solve all these

# TODO: Networking: Transfer Passwords 

# -----------------------------------------------------------------------------
# Low Priority, Do after Installed
# -----------------------------------------------------------------------------
# TODO: TLP Configuration
# TODO: Printing Dependencies

# -----------------------------------------------------------------------------
# RPM Fusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# -----------------------------------------------------------------------------
# FEDORA PACKAGES
# -----------------------------------------------------------------------------

GROUPS=(
	'networkmanager-submodules'
	'virtualization'
	'sound-and-video'
)

# Install
for PKG in "${GROUPS[@]}"; do
    echo "INSTALLING: $PKG"
    sudo dnf group install -y "$PKG"
done

# GROUPS
# sudo dnf group install -y networkmanager-submodules virtualization sound-and-video

PACKAGES=(

	# SYSTEM ------------------------------------------------------------------
	'fzf'						# Fuzzy finder
	'redshift'					# Night filter
	'adwaita-qt5'				# Adwaita dark
	'xsetroot'					# Solid background
	'qt5ct'						# Qt theming
	'xclip'						# Clipboard
	'xbacklight'				# Screen Brightness
	'wget'						# Internet Downloads
	'tar'						# File Extraction
	'acpi'						# Battery info
	'tlp'						# Battery optimization
	'picom'						# Compositor
	'arandr'					# Xrandr frontend
	'gnome-keyring'				# Keyring Daemon
	'network-manager-applet'	# Network Interface
	'seahorse'					# Keyring Gui
	'nextcloud-client'			# Cloud

	# PROGRAMMING LANGUAGES  --------------------------------------------------
	'nodejs'					# Node
	'lua'						# Lua
	'rust'						# Rust
	'golang'					# Go
	'python3-pip'				# Python Package Manager
	'cargo'						# Rust Package Manager

	# COMMAND LINE  -----------------------------------------------------------
	'neovim'					# Tex editor
	'zsh'						# Shell
	'kitty'						# Terminal
	'alacritty'					# Fallback Terminal
	'tmux'                      # Terminal Multiplexer
	'exa'                       # Better ls
	'ranger'                    # File explorer
	'texlive'					# Latex Packages
	'ncdu'						# Disk space
	'newsboat'					# RSS Reader
	'mpd'						# Music Player Daemon
	'ncmpcpp'					# Music Player Interface
	'playerctl'					# Music Player Controller
	'mpdris2'					# Music Player Media Keys

	# APPLICATIONS ------------------------------------------------------------
	'qbittorrent'               # Torrent client
	'xournalpp'					# Stylus Application
	'xsane'                     # Scanning
	'unclutter-xfixes'          # Mouse timeout
	'timeshift'                 # Backup snapshots
	'firefox'					# Web browser
	'anki'						# Flashcard spaced repetition
	'chromium'					# Web browser (Backup)
	'zathura'                   # PDF viewer
	'sxiv'                      # Image viewer
	'mpv'                       # Media player
)

# Install
for PKG in "${PACKAGES[@]}"; do
    echo "INSTALLING: $PKG"
    sudo dnf install -y "$PKG" 
done
