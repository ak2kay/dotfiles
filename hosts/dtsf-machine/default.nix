{ config, lib, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ]
    ++ (import ../../modules/desktops/virtualisation);

  boot = {
    kernelPackages = pkgs.linuxPackages_6_6;

    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        efiSupport = true;
        devices = ["nodev"];
        useOSProber = true;
      };

      timeout = 4;
    };

    # wifi adapter driver
    initrd.kernelModules = [ "8821cu" ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  networking = {
    hostName = "dtsf-machine";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [ { from = 0; to = 65535; } ];
    };
    extraHosts = ''
      127.0.0.1 host.docker.internal
    '';
  };

  # disable networkmanager-wait-online
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
    };

    inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-gtk
            fcitx5-rime
        ];
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs = {
    nix-ld.enable = true;
  };
}
