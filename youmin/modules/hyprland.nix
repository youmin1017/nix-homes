{ lib, pkgs, ... }:
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    services.swayosd.enable = true;
    services.swww.enable = true;

    services.dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 1;
          follow = "keyboard";
        };
      };
    };
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   plugins = [
  #     inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
  #   ];
  # };
}
