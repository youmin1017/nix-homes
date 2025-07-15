{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    terminal = "xterm-ghostty";

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_host 'on' # Enables hostname in the status bar
          set -g @rose_pine_user 'on' # Turn on the username component in the statusbar
          set -g @rose_pine_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators
          # If @rose_pine_bar_bg_disable is set to 'on', uses the provided value to set the background color
          # It can be any of the on tmux (named colors, 256-color set, `default` or hex colors)
          # See more on http://man.openbsd.org/OpenBSD-current/man1/tmux.1#STYLES
          set -g @rose_pine_bar_bg_disabled_color_option 'default'

          set -g @rose_pine_default_window_behavior 'on' # Forces tmux default window list behaviour
          set -g @rose_pine_show_current_program 'on' # Forces tmux to show the current running program as window name
          set -g @rose_pine_show_pane_directory 'on' # Forces tmux to show the current directory as window name
        '';
      }
    ];

    extraConfig = ''
      set -g mouse on 
    '';
  };
}
