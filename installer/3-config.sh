# -----------------------------------------------------------------------------
# NODE PACKAGES
# -----------------------------------------------------------------------------

# Nodejs v17 | https://github.com/nodesource/distributions/blob/master/README.md
sudo curl -fsSL https://deb.nodesource.com/setup_17.x | sudo bash -
sudo apt install -y nodejs

# Node Packages
PKG_NODE=(
	'create-react-app'			# React application
	'express-generator'			# Express application
	'tailwindcss'				# Styling
)

# Installation Loop
for PKG in "${PKG_NODE[@]}"; do
    echo "INSTALLING: $PKG"
    sudo sudo npm install -g "$PKG"
done

# -----------------------------------------------------------------------------
# PYTHON PACKAGES
# -----------------------------------------------------------------------------

sudo apt install python3-pip

# Python Packages
PKG_PYTHON=(
	'youtube-dl'				# Download YouTube Videos
	'ueberzug'					# Display Images
	'flake8'					# Python Linter
	'black'						# Python Formatter
)

# Installation Loop
for PKG in "${PKG_PYHON[@]}"; do
    echo "INSTALLING: $PKG"
    sudo sudo pip install "$PKG"
done

# -----------------------------------------------------------------------------
# MISC PACKAGES
# -----------------------------------------------------------------------------


# TODO: ZSA wally cli | https://github.com/zsa/wally/wiki/Linux-install

# TODO: VPN setup | https://protonvpn.com/support/linux-openvpn/
	# 1. network-manager-openvpn-gnome
	# 2. run nm-connection-editor
	# 3. Add according to guide
	# 4. Connect via networkmanager-dmenu

# Golang
wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
sudo tar -zxvf go1.17.linux-amd64.tar.gz -C /usr/local/

# Gotop | https://github.com/cjbassi/gotop
wget https://github.com/xxxserxxx/gotop/releases/download/v4.1.1/gotop_v4.1.1_linux_amd64.tgz
sudo tar -xvzf gotop_v4.1.1_linux_amd64.tgz -C /usr/local/bin

# Typora | https://support.typora.io/Typora-on-Linux/
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt update && sudo apt install typora

# Signal | https://signal.org/download/linux/
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop


# Alacritty | https://github.com/alacritty/alacritty/blob/master/INSTALL.md
cargo install alacritty

# Network manager
git clone https://github.com/firecat53/networkmanager-dmenu $HOME/.local/bin/networkmanager-dmenu

# Dragon
git clone https://github.com/mwh/dragon /tmp/dragon
cd /tmp/dragon
make

# Devour
git clone https://github.com/salman-abedin/devour.git /tmp/devour
cd /tmp/devour
sudo make install

# Nextcloud
sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt install nextcloud-desktop

# Only Office | https://www.onlyoffice.com/de/download-desktop.aspx?from=desktop
wget -O /tmp/onlyoffice.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
sudo apt install /tmp/onlyoffice.deb

# Master PDF Editor | https://code-industry.net/free-pdf-editor/
wget -O /tmp/masterpdf.deb https://code-industry.net/public/master-pdf-editor-5.8.33-qt5.x86_64.deb
sudo apt install /tmp/masterpdf.deb

# TODO: Pipewire | https://wiki.debian.org/PipeWire

# -----------------------------------------------------------------------------
# CUSTOM INSTALL 
# -----------------------------------------------------------------------------

# Anki | https://docs.ankiweb.net/platform/linux/installing.html
