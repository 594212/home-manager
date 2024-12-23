{ pkgs }: {
  enable = true;

  # extraPlugins = [
  #   (pkgs.vimUtils.buildVimPlugin {
  #     name = "monochrome";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "kdheepak";
  #       repo = "monochrome.nvim";
  #       rev = "2de78d9688ea4a177bcd9be554ab9192337d35ff";
  #       hash = "sha256-TgilR5jnos2YZeaJUuej35bQ9yE825MQk0s6gxwkAbA=";
  #     };
  #   })
  # ];

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
  };

  colorschemes.gruvbox.enable = true;
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  #    extraConfigLua = ''
  #    '';

  keymaps = [
    {
      action = "<cmd>Telescope harpoon marks<CR>";
      key = "<leader>fh";
    }
    {
      action = "<C-w>";
      key = "<M-BS>";
      mode = "i";
    }
    {
      action = "<esc>_<C-q>";
      key = "<C-q>";
      mode = "i";
    }
    {
      action = ''"+yy'';
      key = "<leader>y";
      mode = "n";
    }
    {
      action = "<cmd>Neotree toggle reveal<CR>";
      key = "<M-1>";
      mode = [ "n" "i" "v" ];
    }
  ];

  plugins = {
    zk.enable = true;
    diffview.enable = true;
    web-devicons.enable = true;
    vim-surround.enable = true;
    treesitter.enable = true;
    telescope = {
      enable = true;
      keymaps = {
        "<C-n>" = { action = "git_files"; };
        "<leader>fg" = "live_grep";
        "<leader>ff" = "find_files";
        "<leader>fb" = "buffers";
        "<leader>ds" = { action = "lsp_document_symbols"; };
        "<leader>ws" = "lsp_workspace_symbols";
        "<leader>gr" = "lsp_references";
        "<leader>K" = "keymaps";
      };
    };
    harpoon = {
      enable = true;
      keymaps = {
        addFile = "mm";
        navNext = "mh";
        navPrev = "ml";
        navFile = {
          "1" = "m1";
          "2" = "m2";
          "3" = "m3";
          "4" = "m4";
        };
        toggleQuickMenu = "<leader>hh";
      };
    };
    lsp = {
      enable = true;
      servers = {
        marksman.enable = true;
        zk.enable = true;
        nil_ls.enable = true;
        clangd.enable = true;
        ccls.enable = true;
        taplo.enable = true;
        rust_analyzer = {
          installCargo = false;
          installRustc = false;
          enable = true;
        };
        sqls = {
          enable = false;
          settings.hostname = "localhost:5432";
        };
      };
      keymaps = {
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
      };
    };
    none-ls = {
      enable = true;
      sources.formatting.nixfmt.enable = true;
      sources.formatting.asmfmt.enable = true;
      enableLspFormat = true;
    };
    lsp-format.enable = true;

    nvim-autopairs.enable = true;
    indent-o-matic.enable = true;
    gitsigns.enable = true;
    which-key.enable = true;
    neo-tree.enable = true;
  };
}
