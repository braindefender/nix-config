{ ... }:

let
  link = "https://teams.microsoft.com/v2";
  name = "Microsoft Teams Web Client";
in

final: prev: {
  plusultra = (prev.plusultra or { }) // {
    microsoft-teams-vivaldi = prev.makeDesktopItem {
      name = "microsoft-teams";
      desktopName = "${name} (Vivaldi)";
      genericName = "Microsoft Teams integration for Chromium-based browsers";
      exec = "${final.vivaldi}/bin/vivaldi --app=${link}";
      icon = ./icon-microsoft-teams.svg;
      type = "Application";
      categories = [ "Network" "InstantMessaging" "Chat" ];
      terminal = false;
      mimeTypes = [ "x-scheme-handler/msteams" ];
    };
  };
}
