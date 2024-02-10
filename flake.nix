{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    gen.url = "github:nix-community/nixos-generators/1.8.0";
  };

  outputs = { self, nixpkgs, gen }: {
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixpkgs-fmt;

    packages.aarch64-linux.default = gen.nixosGenerate {
      format = "sd-aarch64";
      system = "aarch64-linux";
      modules = [ ];
    };
  };
}
