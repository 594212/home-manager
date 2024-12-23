{
  programs.nixvim = {
    # Neo-tree is a Neovim plugin to browse the file system
    # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
    plugins.neo-tree = {
      enable = true;

      filesystem = { window = { mappings = { "<M-1>" = "close_window"; }; }; };
    };

    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [{
      key = "<M-1>";
      action = "<cmd>Neotree reveal<cr>";
      options = { desc = "NeoTree reveal"; };
    }];
  };
}
