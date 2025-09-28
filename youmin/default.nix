{ isDarwin, ... }:
let
  isLinux = !isDarwin;
in
{
  imports = [
    ./home.nix
    ./dotfiles
    ./pkgs

    # Linux specific
    ./modules/dconf.nix
    ./modules/hyprland.nix
  ];
}
