{
  programs = {
    sesh = {
      enable = true;
      enableAlias = true;
      enableTmuxIntegration = true;
    };

    # sesh required settings
    fzf.tmux.enableShellIntegration = true;
  };
}
