{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."regexpattern" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [./home.nix];

      extraSpecialArgs = {
        inherit (inputs) neovim-nightly-overlay;
      };
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        lua-language-server
        stylua
      ];
    };
  };
}
