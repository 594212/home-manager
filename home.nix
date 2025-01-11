{ nixgl, config, pkgs, lib, ... }:

{
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" ];

  fonts.fontconfig.enable = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";

  home.packages = with pkgs; [
    vim
    vscode
    elvish

    #c lang
    ninja
    xmake
    cmake
    pkg-config

    #zig
    zig
    zls

    go
    php
    # ruby_3_4
    # python39
    nodejs_22
    typescript
    dart-sass
    bun

    #rust
    rustup
    openssl
    openssl.dev
    perl
    emscripten

    #utils
    xh
    jq
    fd
    xsel
    tldr
    ripgrep
    skim
    lazydocker
    bat
    plantuml-c4
    # ventoy
    mangohud
    imagemagick
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack

    #lsp
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    lua-language-server
    taplo
    nil
    ccls
    #fmt
    nixfmt-classic

    #docs
    asciidoctor-with-extensions

    #browser
    firefox
    brave
    w3m
    urlencode

    mermaid-cli
    (writeShellScriptBin "plt" ''
      if [ -z "$1" ]; then
        echo "Usage: plt <path_to_puml_file>"
        exit 1
      fi
      puml_path="$1"

      # Check if the file exists
      if [ ! -f "$puml_path" ]; then
        echo "Error: File '$puml_path' not found."
        exit 1
      fi
      filename="$(basename $puml_path)"
      title="''${filename%.puml}"
      error=$(zk new -n diagram --title "$title" 2>&1) 
      if [ $? -ne 0 ]; then
        path=$(echo $error | cut -d':' -f4)
        rm -f $path
      fi

      cat $puml_path | plantuml -utxt -p | zk new --interactive diagram --title $title
    '')
  ];

  programs.git = {
    enable = true;
    userName = "sul";
    userEmail = "su1im69n@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      diff.tool = "nvimdiff";
    };
  };

  home.file = { };
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.local/bin" ];
  home.file = {
    ".config/zk" = {
      source = ./zk;
      recursive = true;
    };
    ".config/elvish" = {
      source = ./elvish;
      recursive = true;
    };
  };
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
    OPENSSL_DEV = "openssl.dev";
    SUDO_EDITOR = "${pkgs.helix}/bin/hx";
  };

  programs.home-manager.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  # The critical missing piece for me
  xdg.systemDirs.data =
    [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      theme = "rasmus";
    };
    languages = {
      language-server.rust-analyzer = with pkgs; {
        command = "${rust-analyzer}/bin/rust-analyzer";
      };
      language = [{
        auto-format = true;
        formatter = { command = "nixfmt"; };
        name = "nix";
      }];
    };
  };

  programs.lazygit = {
    enable = true;
    settings.promptToReturnFromSubprocess = false;
  };

  # programs.gh = {
  #   enable = true;
  #   settings.git_protocol = "ssh";
  # };

  # programs.gh-dash = { enable = true; };
}
