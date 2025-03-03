{ config, pkgs, lib, inputs, ... }: {

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      vi = "nvim";
      yy = "yazi";
      pf = "fzf --preview 'bat --color=always --style=numbers,changes {1}'";
    };

    autosuggestion.enable = true;
    prezto.enable = true;
    enableCompletion = true;

    initExtraFirst = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
      export VISUAL=$EDITOR

      bindkey '^H' backward-kill-word
      unsetopt alwaystoend


      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
      yy = "yazi";
      pf = "fzf --preview 'bat --color=always --style=numbers,changes {1}'";
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
    enableBashIntegration = false;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      directory.style = "white";
      character = {
        success_symbol = "~>";
        error_symbol = "~>(red)";
      };
    };

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
    enableBashIntegration = false;
    enableZshIntegration = true;
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
    defaultOptions = [
      "--bind 'shift-up:preview-page-up,shift-down:preview-page-down'"
      "--bind 'ctrl-e:become($EDITOR {1})'"
      "--bind 'alt-up:preview-up,alt-down:preview-down'"
      "--preview-window 'right:65%'"
      "--delimiter ':'"
    ];
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
        ratio = [ 2 2 6 ];
        show_hidden = false;
        sort_by = "mtime";
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
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @minimal-tmux-bg "#da9969"
          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-right-arrow "|"
          set -g @minimal-tmux-left-arrow "|"
          set -g @minimal-tmux-justify "left"
        '';
      }
      tmuxPlugins.cpu
      # {
      #   plugin = tmuxPlugins.rose-pine;
      #   extraConfig = ''
      #     set -g @rose_pine_variant 'main'
      #     set -g @rose_pine_disable_active_window_menu 'on'
      #   '';
      # }
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
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.alacritty);
    settings = {
      keyboard.bindings = [
        {
          key = "Backspace";
          mods = "Control";
          chars = "\\b";
        }
        {
          key = "N";
          mods = "Control|Shift";
          action = "CreateNewWindow";
        }
      ];

      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "-l" ];
      };
      window = {
        decorations = "Full";
        padding = {
          x = 5;
          y = 2;
        };
        dynamic_padding = true;
      };
      font = {
        size = 14;
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Hack Nerd Font Mono";
          style = "Italic";
        };
      };
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
      general = {
        import = [ "${pkgs.alacritty-theme}/gruvbox_material_hard_dark.toml" ];
      };
    };
  };
  programs.zk = {
    enable = true;
    settings = {
      notebook.dir = "~/journal";

      note = {
        language = "en";
        default-title = "Untitled";
        filename = "{{id}}-{{slug title}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 4;
        id-case = "lower";
      };

      format.markdown = {
        # Format used to generate links between notes.
        # Either "wiki", "markdown" or a custom template. Default is "markdown".
        link-format = "wiki";
        # Indicates whether a link's path will be percent-encoded.
        # Defaults to true for "markdown" format and false for "wiki" format.
        #link-encode-path = true
        # Indicates whether a link's path file extension will be removed.
        # Defaults to true.
        #link-drop-extension = true

        # Enable support for #hashtags.
        hashtags = true;
        # Enable support for :colon:separated:tags:.
        colon-tags = true;
        # Enable support for Bear's #multi-word tags#
        # Hashtags must be enabled for multi-word tags to work.
        multiword-tags = false;
      };

      # EXTERNAL TOOLS
      tool = {
        # Default shell used by aliases and commands.
        shell = "${pkgs.zsh}/bin/zsh";
        # Pager used to scroll through long output.
        pager = "less -FIRX";
        # Command used to preview a note during interactive fzf mode.
        fzf-preview = "bat -p --color always {-1}";
      };
      # NAMED FILTERS
      filter.recents = "--sort created- --created-after 'last two weeks'";

      group.daily = {
        # Directories listed here will automatically use this group when creating notes.
        paths = [ "journal/daily" ];

        note = {
          # %Y-%m-%d is actually the default format, so you could use {{format-date now}} instead.
          filename = "{{format-date now '%Y-%m-%d'}}";
          extension = "md";
          template = "daily.md";
        };
      };

      group.diagram = {
        note = {
          extension = "md";
          filename = "{{title}}";
          template = "diagram.md";
        };
      };
      # COMMAND ALIASES
      alias = {
        # Edit the last modified note.
        edlast = "zk edit --limit 1 --sort modified- $@";
        # Edit the notes selected interactively among the notes created the last two weeks.
        recent =
          "zk edit --sort created- --created-after 'last two weeks' --interactive";
        # Show a random note.
        lucky = "zk list --quiet --format full --sort random --limit 1";
        # daily = ''zk new --no-input "$ZK_NOTEBOOK_DIR/journal/daily"'';
      };
      extra.author = "Suleiman";
    };
  };

  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
