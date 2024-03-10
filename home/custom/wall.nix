{ inputs, ... }:

{
  xdg.configFile."wallpaper.png".source = "${inputs.walls}/10.png";
}
