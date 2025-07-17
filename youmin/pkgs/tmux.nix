{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    terminal = "xterm-ghostty";
    baseIndex = 1; # Start pane and window indices at 1 instead of 0

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
      # session
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      set -g mouse on 

      # pane navigation
      bind -r h select-pane -L  # move left
      bind -r j select-pane -D  # move down
      bind -r k select-pane -U  # move up
      bind -r l select-pane -R  # move right

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window                             # select previous window
      bind -r C-l next-window                                 # select next window
      bind -r C-S-H swap-window -t -1 \; select-window -t -1  # swap current window with the previous one
      bind -r C-S-L swap-window -t +1 \; select-window -t +1  # swap current window with the next one
      bind Tab last-window                                    # move to last active window
    '';
  };
}
