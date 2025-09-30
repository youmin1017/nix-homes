{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    # lsp
    helm-ls
    lua-language-server
    marksman
    nil

    # formatter
    kdlfmt
    nixfmt-rfc-style
    stylua

    # linter
    hadolint # Dockerfile linter

    # misc
    unzip # for mason.nvim
    tree-sitter
  ];
}
