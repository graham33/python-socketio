{
  description = "python-socketio v4";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    python-engineio.url = "/home/graham/git/graham33/python-engineio";
  };

  outputs = { self, nixpkgs, nur, python-engineio }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (self: super: {
          nur = import nur {
            nurpkgs = self;
            pkgs = self;
          };
        })
      ];
    };
    python-engineio_3 = python-engineio.packages.${system}.default;
    python3 = pkgs.python311.withPackages (ps: with ps; [
        bidict
        python-engineio_3
        mock
        pytest
    ]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      inputsFrom = [
      ];
      packages = with pkgs; [
        python3
      ];
    };
  };
}
