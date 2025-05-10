# How to install NixOS
- Put NixOS on a USB drive and go thorugh installation
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
## Set Up NixOS
```bash
cd ~/.nixos
# If on different hardware do
rm ~/.nixos/hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix ~/.nixos
# Otherwise just skip to this
sudo nixos-rebuild switch --flake .#alan-laptop-nixos
```
