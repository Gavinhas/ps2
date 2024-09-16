#!/bin/env/usr bash

# Insert Pendrive
echo "insert the "ARCH" pendrive and type 'C' to continue"
read -r resposta

if [[ "$resposta" =~ ^[Cc]$ ]]; then
    echo "Continuing..."
    # Coloque o restante do código aqui
else
    echo "Exiting..."
    exit 1
fi

# Configure Git

git config --global user.name "gavinha"
git config --global user.email "gui.mgava@gmail.com"

# Configure SSH Key
cp -r /run/media/gavinha/ARCH/.ssh ~
chmod 700 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Clone Memory-Card
git clone "git@github.com:Gavinhas/memory-card.git"

# Install ZSH
sudo pacman -S zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/amuse/g' ~/.zshrc
exit
