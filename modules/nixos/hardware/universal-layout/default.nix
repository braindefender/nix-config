{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.universal-layout;

  layouts = {
    universalLayoutNormal = {
      description = "Universal Layout Normal";
      symbolsFile = ./universalLayoutNormal;
      languages = [ "eng" ];
    };
    universalLayoutOrtho = {
      description = "Universal Layout Ortho";
      symbolsFile = ./universalLayoutOrtho;
      languages = [ "eng" ];
    };
  };

in
{
  options.plusultra.hardware.universal-layout = with types; {
    enable = mkBoolOpt false "Whether to enable Universal Layout.";

    defaultLayout = mkOption {
      type = types.enum [ "universalLayoutNormal" "universalLayoutOrtho" ];
      default = "universalLayoutNormal";
      example = "universalLayoutOrtho";
      description = mkDoc "Which layout version to use.";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.extraLayouts = layouts;

    environment.systemPackages = with pkgs; [ numlockx ];
    # services.udev.packages = [
    #   (pkgs.callPackage
    #     ./universal-layout-udev.nix
    #     {
    #       inherit pkgs options config lib;
    #       layout = cfg.defaultLayout;
    #     })
    # ];
  };
}
