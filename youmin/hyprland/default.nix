{
  inputs,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
    ];
  };
}
