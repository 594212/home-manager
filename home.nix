{ config, pkgs, lib, ... }:

{
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vim
    ngrok

    gcc
    meson
    ninja
    pkg-config
    cmake

    xh
    helix
    jq
    fd
    xsel
    tldr
    nixfmt-classic
    ripgrep
    skim
    zoxide
    lazydocker
    lazygit
    starship
    bat
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
    };

    bashrcExtra = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
      eval "$(starship init bash)"
      eval "$(zoxide init --cmd cd bash)"
    '';
  };

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

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  # The critical missing piece for me
  xdg.systemDirs.data =
    [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
}
