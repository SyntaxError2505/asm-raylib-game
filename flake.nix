{
  description = "flake for a raylib game written in x86 assembly";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          gnumake
          gcc
          raylib
        ];
        shellHook = ''
          echo "Welcome to the dev shell. Have fun writing 0s and 1s!"
        '';
      };
    };
}

