{
  enable = true;

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
  ];

  plugins = {
    treesitter.enable = true;
    telescope = {
      enable = true;
      keymaps = {
        "<C-n>" = { action = "git_files"; };
        "<leader>fg" = "live_grep";
        "<leader>ff" = "find_files";
        "<leader>fb" = "buffers";
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
        nil-ls.enable = true;
        clangd.enable = true;
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
      enableLspFormat = true;
    };
    lsp-format.enable = true;

    nvim-autopairs.enable = true;
    indent-o-matic.enable = true;
    gitsigns.enable = true;
  };
}
