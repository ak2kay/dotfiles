{ pkgs, vars, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
