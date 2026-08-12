{
config,
pkgs,
...
}: {
  # programs.neovim = {
  #   enable = false;
  #   # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  #   withNodeJs = false;
  #   withRuby = false;
  #   withPython3 = false;
  #
  #   viAlias = false;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   defaultEditor = true;
  #
  #   # plugins = with pkgs.vimPlugins; [
  #   #   # ... your other plugins
  #   #   (nvim-treesitter.withPlugins (_:
  #   #     nvim-treesitter.allGrammars
  #   #     ++ [
  #   #       # # nix-prefetch-github latex-lsp tree-sitter-latex
  #   #       # (pkgs.tree-sitter.buildGrammar {
  #   #       #   language = "latex";
  #   #       #   version = "temp";
  #   #       #   src = pkgs.fetchFromGitHub {
  #   #       #     owner = "latex-lsp";
  #   #       #     repo = "tree-sitter-latex";
  #   #       #     rev = "7b06f6ed394308e7407a1703d2724128c45fc9d7";
  #   #       #     sha256 = "sha256-HbRjblLBExpBkBBjHyEHfnK0oootjAsqkwjmGH3/UYI=";
  #   #       #   };
  #   #       # })
  #   #     ]))
  #   # ];
  # };
  #
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };
  #
  # home.packages = with pkgs; [
  #   # node
  #   # nodejs
  #   # c/c++
  #   # gcc
  #   pandoc
  #   # nix
  #   deadnix
  #   nil
  #   nixd
  #   alejandra
  #   statix
  #   # typo
  #   typos-lsp
  #   # lua
  #   luajitPackages.luacheck
  #   lua-language-server
  #   codeium
  #   # json
  #   # nodePackages.vscode-json-languageserver
  #   # yaml
  #   yaml-language-server
  #   # latex
  #   texliveFull
  #   # python311Packages.pylatexenc
  #   texlab
  #   # all
  #   ctags-lsp
  #   # go
  #   golangci-lint-langserver
  #   golangci-lint
  #   golines
  #   delve
  #   marksman
  #   markdownlint-cli2
  #   markdown-oxide
  #   # proto
  #   protobuf
  #   buf
  #   protols
  #   # clang-tools
  #   # js/ts
  #   vtsls
  #   vscode-langservers-extracted
  #   angular-language-server
  #   vue-language-server
  #   svelte-language-server
  #   #docker
  #   docker-compose-language-service
  #   docker-ls
  #   dockerfile-language-server
  #   hadolint
  #   #graphql
  #   # nodePackages.graphql-language-service-cli
  #   #sql
  #   sqlfluff
  #   #tools
  #   gnumake
  #   imagemagick
  #   mermaid-cli
  #   #inotify-tools
  #   obsidian
  #   xclip
  #   # ansible
  #   # ansible-language-server
  #   # python
  #   pyright
  #   # bash
  #   bash-language-server
  #   # # cssmodule
  #   # cssmodules-language-server
  #   # rust
  #   # rustup
  #   #java
  #   jdt-language-server
  #   # grammar
  #   harper
  #   # js-debug
  #   # vscode-js-debug
  # ];
}
