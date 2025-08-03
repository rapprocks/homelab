{
  description = "NixOS server configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      sharedModules = [ ./modules/common.nix sops-nix.nixosModules.sops ];

    in {
      nixosConfigurations = {

        vps-dev-1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [ ./hosts/vps-dev-1 ];
        };

      };
    };
}
