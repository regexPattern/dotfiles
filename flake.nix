{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/6c271ead5b79854a8ac46025d6c05321777b8b6e";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "regexpattern";
    hosts = {
      "carlos-macbook-pro" = "aarch64-darwin";
      "carlos-inspiron" = "x86_64-linux";
      "carlos-raspberry-pi" = "aarch64-linux";
    };
    systems = builtins.attrValues hosts;
    mkHome = host: system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [./home];
        extraSpecialArgs = {
          inherit (inputs) neovim-nightly-overlay;
          inherit username host system;
        };
      };
    homeCfgPairs = builtins.map (
      host: {
        name = "${username}@${host}";
        value = mkHome host hosts.${host};
      }
    ) (builtins.attrNames hosts);
  in {
    homeConfigurations = builtins.listToAttrs homeCfgPairs;

    formatter = nixpkgs.lib.genAttrs systems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );

    devShells = nixpkgs.lib.genAttrs systems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          lua-language-server
          stylua
        ];
      };
    });
  };
}
