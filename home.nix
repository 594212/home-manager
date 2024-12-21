{ nixgl, config, pkgs, lib, ... }:

{
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "ngrok" "vscode" ];

  fonts.fontconfig.enable = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";

  home.packages = with pkgs; [
    vim
    vscode
    ngrok

    #c lang
    meson
    ninja
    pkg-config
    cmake

    go
    php
    ruby_3_4
    python39
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
    nixfmt-classic
    ripgrep
    skim
    lazydocker
    bat
    # ventoy
    imagemagick
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono

    #lsp
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    taplo
    nil
    ccls

    #docs
    asciidoctor-with-extensions

    #browser
    firefox
    brave
    lynx
    w3m
    urlencode
    (writeShellScriptBin "duck" ''
      #!/bin/sh
      url="https://lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$(urlencode "$*")" # 🦆
      #chat "🦆 searching: $* $url"
      exec lynx "$url"
    '')
    (writeShellScriptBin "prg" ''
      #!/usr/bin/env bash
      format='{1}:{2}:{3}'
      if [ "$EDITOR" == 'nvim' ];then
        format="+'call cursor({2},{3})' {1}"
      fi

      rg_prefix="rg --column --line-number --no-heading --color=always --smart-case $*"
      fzf --bind 'start:reload:'"$rg_prefix" \
        --bind "change:reload:$rg_prefix {q} || true" \
        --ansi --disabled \
        --delimiter : \
        --bind "enter:become($EDITOR $format)" \
        --preview 'bat --color=always --style=numbers,changes --highlight-line {2} {1}' \
        --preview-window 'right:65%' \
        --bind "shift-up:preview-page-up,shift-down:preview-page-down" \
        --bind "alt-up:preview-up,alt-down:preview-down"
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

  programs.nixvim = import ./nixvim.nix { inherit pkgs; };

  home.file = { };
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.local/bin" ];
  home.file = {
    ".config/lynx" = {
      source = ./lynx;
      recursive = true;
    };
  };
  home.sessionVariables = {
    LYNX_CFG = "$HOME/.config/lynx/lynx.cfg";
    LYNX_LSS = "$HOME/.config/lynx/lynx.lss";
    EDITOR = "hx";
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
      theme = "autumn";
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

  programs.lazygit = { enable = true; };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.gh-dash = { enable = true; };
}
