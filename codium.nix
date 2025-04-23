{ config, pkgs, lib, ... }:

{
  # Install Extensions
  home.activation.installCodiumExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    CODIUM_BIN="$HOME/.nix-profile/bin/codium"

    install_extension_if_missing() {
      EXT=$1
      echo "Installing extension: $EXT"
      "$CODIUM_BIN" --install-extension "$EXT" --force
    }

    install_extension_if_missing TabbyML.vscode-tabby
    install_extension_if_missing ms-python.python
    install_extension_if_missing rust-lang.rust-analyzer
    install_extension_if_missing bbenoist.nix
  '';
}
