{ config, pkgs, lib, ... }: {

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      vi = "nvim";
      yy = "yazi";
      "?" = "duck";
      pf =
        "fzf --delimiter :  --preview-window 'right:65%' --preview 'bat --color=always --style=numbers,changes {1}' --bind shift-up:preview-up,shift-down:preview-down --bind 'enter:become($EDITOR {1})'";
    };

    autosuggestion.enable = true;
    prezto.enable = true;
    enableCompletion = true;

    initExtraFirst = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
  };

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
      pf =
        "fzf --delimiter :  --preview-window 'right:65%' --preview 'bat --color=always --style=numbers,changes {1}' --bind shift-up:preview-up,shift-down:preview-down --bind 'enter:become($EDITOR {1})'";
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

  programs.direnv = {
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    enable = true;
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
  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    defaultCommand = "fd --type f --strip-cwd-prefix";
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
    prefix = "C-w";
    disableConfirmationPrompt = true;
    terminal = "xterm-256color";
    escapeTime = 0;
    mouse = true;
    extraConfig = ''
      set-option -g status-position top
      set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      setw -g mode-keys vi
    '';
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
