let
  theme = (import ../../modules/colorscheme).theme;
in {
  xdg.configFile."nvim" = {
    source = ../../modules/nvim;
    recursive = true;
  };

  xdg.configFile."nvim/lua/utils/nix_colorscheme.lua".text = ''
    return "${theme.nvim-colorscheme}"
  '';

  xdg.configFile."nvim/lua/utils/nix_lazylock.lua".text = ''
    return vim.fn.expand("$HOME/.dotfiles/modules/nvim") .. "/lazy-lock.json"
  '';
}