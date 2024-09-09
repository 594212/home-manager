{ config, pkgs, lib, ... }:

{
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "ngrok" ];

  home.packages = with pkgs; [
    vim
    ngrok

    meson
    ninja
    pkg-config
    cmake

    rustup
    openssl
    openssl.dev
    perl
    emscripten

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

    go
    imagemagick
    vscode-langservers-extracted
  ];

  programs.git = {
    enable = true;
    userName = "sul";
    userEmail = "su1im69n@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      dialect = "us";
      ignored_commands = [ "cd" "ls" "vi" ];
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };

  programs.nixvim = import ./nixvim.nix;

  home.file = { };
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/go/bin" ];
  home.sessionVariables = {
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
    };
  };

  programs.lazygit = { enable = true; };
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      log = { enabled = false; };
      manager = {
        ratio = [ 1 1 6 ];
        show_hidden = false;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
    };
  };
}
