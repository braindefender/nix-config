{ channels, ... }:

final: prev: {
  superfile = prev.superfile.override {
    buildGoModule = args: prev.buildGoModule (args // {
      version = "1.1.5-fix-flickering";

      src = prev.fetchFromGitHub {
        owner = "yorukot";
        repo = "superfile";
        rev = "19ca445454cf2ade955b6cfb874a4f86c7c3f53b";
        hash = "sha256-/bEmGfnoG0s/Rs1uHycWtfu/dlIB6hD/ThE2o+rVBiE=";
      };

      vendorHash = "sha256-qqKC6OSGTaoAjkLIAwuBXfpM/KlDXqleHfHuSjI3DSw=";
    });
  };
}
