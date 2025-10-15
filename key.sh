#!/usr/bin/env bash

# Insert Pendrive
echo -e "\n>>> Insert the 'ARCH' pendrive and type 'C' to continue <<<\n"
read -r RESPOSTA

if [[ "$RESPOSTA" != "C" && "$RESPOSTA" != "c" ]]; then
    echo "Exiting..."
    exit 1    
fi

echo "Continuing..."

# Configure Git

git config --global user.name "gavinha"
git config --global user.email "gui.mgava@gmail.com"

# Configure SSH Key

echo "Configure SSH? | [Y] Yes, [N] No"
read -r CONFIGURESSH

if [[ "$CONFIGURESSH" =~ ^[Yy]$ ]]; then

    PENDRIVE_PATH="/run/media/$USER/Ventoy/.ssh"

    if [[ -f "$PENDRIVE_PATH/id_ed25519" && -f "$PENDRIVE_PATH/id_ed25519.pub" ]]; then

        mkdir -p ~/.ssh

        cp "$PENDRIVE_PATH/id_ed25519" ~/.ssh/
        cp "$PENDRIVE_PATH/id_ed25519.pub" ~/.ssh/

        chmod 600 ~/.ssh/id_ed25519
        chmod 644 ~/.ssh/id_ed25519.pub

        echo "SSH keys copied and permissions set."
    else
        echo "Error: SSH Not found on the Pendrive"
        exit 1
    fi

fi



# Install ZSH

echo "Install ZSH? | [Y] Yes, [N] No"
read -r CONFIGUREZSH

if [[ "$CONFIGUREZSH" =~ ^[Yy]$ ]]; then
    sudo pacman -S zsh --needed --noconfirm
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Clone Memory-Card

echo "Clone Memory-Card? | [Y] Yes, [N] No"
read -r CMEMORYCARD

if [[ "$CMEMORYCARD" =~ ^[Yy]$ ]]; then
    git clone "git@github.com:Gavinhas/memory-card.git"
fi

# Run Memory-Card

echo "Run Memory-Card? | [Y] Yes, [N] No"
read -r RMEMORYCARD

if [[ "$RMEMORYCARD" =~ ^[Yy]$ ]]; then
    chmod +x memory-card/script/arch.sh
    sudo bash memory-card/script/arch.sh
fi