{ config, pkgs, lib, ... }:

{
  home.activation.installCodiumExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    CODIUM_BIN="$HOME/.nix-profile/bin/codium"

    install_extension_if_missing() {
      EXT=$1
      if "$CODIUM_BIN" --list-extensions | grep -q "$EXT"; then
        echo "Extension $EXT already installed, skipping."
      else
        echo "Installing extension: $EXT"
        "$CODIUM_BIN" --install-extension "$EXT"
      fi
    } 

    install_extension_if_missing tabbyml.vscode-tabby
    install_extension_if_missing ms-python.python
    install_extension_if_missing rust-lang.rust-analyzer
    install_extension_if_missing bbenoist.nix
    install_extension_if_missing esbenp.prettier-vscode
    '';
}
