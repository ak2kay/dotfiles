{ config, lib, vars, pkgs, ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "${vars.user}" ];
  };
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        chromium
        firefox
      '';
      mode = "0755";
    };
  };
}
