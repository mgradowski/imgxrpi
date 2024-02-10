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
      modules = [
        {
          # imports =
          #   [
          #     ./hardware-configuration.nix
          #   ];

          networking.hostName = "imgxrpi0";

          # boot.loader.systemd-boot.enable = true;
          # boot.loader.efi.canTouchEfiVariables = true;

          time.timeZone = "Europe/Warsaw";

          i18n.defaultLocale = "en_US.UTF-8";

          users.users.mgradowski = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            packages = with nixpkgs.legacyPackages.aarch64-linux; [ ];
            shell = nixpkgs.legacyPackages.aarch64-linux.fish;
            initialHashedPassword = "$y$j9T$9SkHp/L/8vdP8d7cLghUI0$iXArK6PaT4f/sn/xQITVduUuApczpAqRWD.DgXHL358";
          };

          programs.fish.enable = true;

          environment.systemPackages = with nixpkgs.legacyPackages.aarch64-linux; [
            cowsay
          ];

          # nix.settings.experimental-features = [ "nix-command" "flakes" ];

          services.openssh.enable = true;

          networking.firewall.enable = false;

          system.stateVersion = "23.11"; # DO NOT EDIT
        }
      ];
    };
  };
}
