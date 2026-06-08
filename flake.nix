{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";

    nixvim.url = "github:nix-community/nixvim";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs: {
    nixosConfigurations.legolas = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.nixvim.nixosModules.nixvim
        inputs.mangowm.nixosModules.mango
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.user = ./home-manager/home.nix;
        }
        ./configuration.nix
        ./global.nix
        ./disko.nix
        ./preservation.nix
        ./hosts/legolas
      ];
    };
    nixosConfigurations.nvidia = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.nixvim.nixosModules.nixvim
        inputs.mangowm.nixosModules.mango
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.user = ./home-manager/home.nix;
        }
        ./configuration.nix
        ./global.nix
        ./disko.nix
        ./preservation.nix
        ./hosts/nvidia
      ];
    };
    nixosConfigurations.vps = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.user = ./home-manager/home.nix;
        }
        inputs.nixvim.nixosModules.nixvim
        ./configuration.nix
        ./disko-min.nix
        ./hosts/vps
      ];
    };
    nixosConfigurations.work = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        inputs.nixvim.nixosModules.nixvim
        inputs.mangowm.nixosModules.mango
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.user = ./home-manager/home.nix;
        }
        ./configuration.nix
        ./disko.nix
        ./preservation.nix
        ./hosts/work
      ];
    };
  };
}
