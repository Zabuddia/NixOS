{ config, pkgs, lib, ... }:

# Fix VSCodium so that the Continue extension works by injecting the missing libstdc++
let
  ldFix = "LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib";
in {
  home.packages = [ pkgs.vscodium ];

  home.file.".local/share/applications/codium.desktop".text = ''
    [Desktop Entry]
    Name=VSCodium
    Comment=Visual Studio Code without telemetry
    GenericName=Code Editor
    Exec=env ${ldFix} codium %F
    Icon=vscodium
    Type=Application
    StartupNotify=false
    StartupWMClass=VSCodium
    Categories=Utility;TextEditor;Development;IDE;
    MimeType=text/plain;
  '';

  # Completely nuke the URL handler registration
  home.file.".local/share/applications/codium-url-handler.desktop".text = ''
    [Desktop Entry]
    NoDisplay=true
    Hidden=true
    Name=Ignore This
    Exec=true
    Type=Application
  '';

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

  install_extension_if_missing continue.continue
  install_extension_if_missing tabbyml.vscode-tabby
  install_extension_if_missing ms-python.python
  install_extension_if_missing rust-lang.rust-analyzer
  install_extension_if_missing bbenoist.nix
  install_extension_if_missing esbenp.prettier-vscode
  install_extension_if_missing zaaack.markdown-editor
  '';
}
