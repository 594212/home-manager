{ config, pkgs, lib, ... }:

{
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "ngrok" "vscode" ];

  fonts.fontconfig.enable = true;

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
    nodejs_22
    typescript
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
    imagemagick
    (nerdfonts.override {
      fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ];
    })

    #lsp
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    taplo
    nil
    ccls

    #browser
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
  ];

  programs.git = {
    enable = true;
    userName = "sul";
    userEmail = "su1im69n@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "hx";
    };
  };

  programs.nixvim = import ./nixvim.nix;

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
}
