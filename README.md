# How to install NixOS
- Put NixOS on a USB drive and go thorugh installation
## Connect to the internet
## Install Git
```bash
sudo nano /etc/nixos/configuration.nix
# Put git in the environment.systemPackages = with pkajs; [ git ]; block
sudo nixos-rebuild switch
```
## Set Up GitHub
```bash
ssh-keygen -t ed25519 -C "fife.alan@protonmail.com"
cat ~/.ssh/id_ed25519.pub 
# Paste this into GitHub
mkdir ~/.nixos
git clone git@github.com:Zabuddia/NixOS.git ~/.nixos
```
## Set Up Home Manager
```bash
# https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
## Set Up NixOS
```bash
cd ~/.nixos
rm ~/.nixos/hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix ~/.nixos
sudo nixos-rebuild switch --flake .#alan-laptop-nixos
home-manager switch --flake .
```
