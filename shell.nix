{ config, pkgs, lib, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      "?" = "duck";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
    };

    bashrcExtra = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      "?" = "duck";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
    };

    configFile.text = ''
        $env.config = {
          show_banner: false
        }
        
       let $config = {
        filesize_metric: false
        table_mode: rounded
        use_ls_colors: true
      }
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
      "?" = "duck";
    };
    autosuggestion.enable = true;
    prezto.enable = true;
    enableCompletion = true;

    initExtraFirst = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      verbs = [
        {
          # invocation = "edit";
          # key = "F2";
          # shortcut = "e";
          # execution = "${pkgs.helix}/bin/hx {file}";
        }
      ];
    };
  };

  programs.carapace = {
    enable = true;
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

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      dialect = "us";
      ignored_commands = [ "cd" "ls" "vi" ];
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
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

  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    terminal = "xterm-256color";
    escapeTime = 0;
    mouse = true;
    extraConfig = "set-option -g status-position top";
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_disable_active_window_menu 'on'
        '';
      }
      {
        plugin = tmuxPlugins.mode-indicator;
        extraConfig = ''
          set -g status-right '%Y-%m-%d %H:%M #{tmux_mode_indicator}'
        '';
      }
    ];
  };

  ########################################

  programs.zellij = {
    enable = false;
    enableZshIntegration = true;
  };

  programs.alacritty = {
    enable = false;
    settings = {
      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [ "-l" ];
      };
      window = {
        decorations = "None";
        padding = {
          x = 5;
          y = 2;
        };
        dynamic_padding = true;
      };
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };

}

