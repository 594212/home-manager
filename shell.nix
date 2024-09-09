{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
    };

    bashrcExtra = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.alacritty = {
    enable = false;
    settings = {
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "-l" ];
      };
    };
  };
}
