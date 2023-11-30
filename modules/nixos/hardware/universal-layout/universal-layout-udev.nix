{ options, config, lib, pkgs, layout ? "universalLayoutNormal" }:

let
  home = config.users.users.${config.plusultra.user.name}.home;
in

pkgs.stdenv.mkDerivation {
  name = "universal-layout-udev-rule";

  src = ./.;

  dontBuild = true;
  dontConfigure = true;

  rule = pkgs.writeText "00-universal-layout.rules" ''
    SUBSYSTEM=="usb", ACTION=="add", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="${home}/.Xauthority" RUN+="${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout ${layout}"
  '';

  # SUBSYSTEM=="usb", ACTION=="add", RUN+="${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout ${layout}"

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp $rule $out/lib/udev/rules.d
  '';
  # cp $rule $out/lib/udev/rules.d
}
