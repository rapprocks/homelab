{
  description = "NixOS server configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {

        test-lxc-dev-1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/test-lxc-dev-1 ./modules/common.nix ];
        };

        test-lxc-dev-2 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/test-lxc-dev-2 ./modules/common.nix ];
        };

      };
    };
}
