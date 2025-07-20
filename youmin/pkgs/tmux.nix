{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    terminal = "xterm-ghostty";
    baseIndex = 1; # Start pane and window indices at 1 instead of 0
    reverseSplit = true;

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
      set -sg escape-time 0

      # reload config with prefix + r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # split current window horizontally and vertically
      bind _ split-window -v
      bind - split-window -h

      # pane evenly
      bind | select-layout even-horizontal \; display "Even horizontal split!"

      # pane navigation
      bind -r h select-pane -L  # move left
      bind -r j select-pane -D  # move down
      bind -r k select-pane -U  # move up
      bind -r l select-pane -R  # move right

      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window                             # select previous window
      bind -r C-l next-window                                 # select next window
      bind -r C-S-H swap-window -t -1 \; select-window -t -1  # swap current window with the previous one
      bind -r C-S-L swap-window -t +1 \; select-window -t +1  # swap current window with the next one
      bind Tab last-window                                    # move to last active window

      # sesh integration
      bind-key "s" run-shell "sesh connect \"$(
        sesh list --icons | fzf-tmux -p 80%,70% \
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list --icons -t)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list --icons -c)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list --icons -z)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
          --preview-window 'right:55%' \
          --preview 'sesh preview {}'
      )\""
    '';
  };
}
