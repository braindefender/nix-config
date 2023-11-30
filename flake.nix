{
  description = "A very basic flake";

  inputs = {
    # NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixPkgs Unstable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixPkgs Stable
    stable.url = "github:nixos/nixpkgs/release-23.05";

    # Snowfall Lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS User Repository
    nur.url = "github:nix-community/NUR";

    # Discord Replugged
    replugged = {
      url = "github:LunNova/replugged-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Discord Tweaks for Replugged
    discord-tweaks = {
      url = "github:NurMarvin/discord-tweaks";
      flake = false; # repo is not a flake
    };

    ### My Own Packages

    # neovim with bundled config
    nix-neovim = {
      url = "github:braindefender/nix-neovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };

    nix-apple-fonts = {
      url = "github:braindefender/nix-apple-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.unstable.follows = "unstable";
    };

  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "plusultra";
            title = "Plus Ultra";
          };

          namespace = "plusultra";
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        nix-neovim.overlays.default
        nix-apple-fonts.overlays.default
        nur.overlay
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
      ];
    };
}
