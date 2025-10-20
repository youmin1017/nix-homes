{ inputs, pkgs, ... }:
{
  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
    biome
    ruff

    # linter
    hadolint # Dockerfile linter

    # misc
    unzip # for mason.nvim
    tree-sitter
  ];
}
