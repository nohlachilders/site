{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.templ.url = "github:a-h/templ";

  outputs = {nixpkgs, flake-utils, templ, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
      nixpkgs.overlays = [
        templ.overlays.default
      ];
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.go
            pkgs.air
            pkgs.templ
            ];
        };
      });
}
