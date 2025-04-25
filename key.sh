#!/bin/env/usr bash

# Insert Pendrive
echo "insert the "ARCH" pendrive and type 'C' to continue"
read -r resposta

if [[ "$resposta" != ^[Cc]$ ]]; then
    echo "Exiting..."
    exit 1    
fi

echo "Continuing..."

# Configure Git

git config --global user.name "gavinha"
git config --global user.email "gui.mgava@gmail.com"

# Configure SSH Key

mkdir -p ~/.ssh

cp /run/media/gavinha/Ventoy/.ssh/id_ed25519 ~
cp /run/media/gavinha/Ventoy/.ssh/id_ed25519.pub ~

chmod 700 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

echo "SSH keys copied and permissions set."

# Clone Memory-Card
git clone "git@github.com:Gavinhas/memory-card.git"

# Install ZSH
sudo pacman -S zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Run Memory-Card

chmod +x memory-card/script/arch.sh
bash memory-card/script/arch.sh

exit