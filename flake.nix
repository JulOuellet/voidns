{
  description = "voidns: a DNS sinkhole written in Rust";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # Rust toolchain
        cargo
        rustc
        clippy
        rustfmt

        # DNS testing (dig)
        dnsutils
      ];

      # Makes rust-analyzer use this project's std source instead of its own nixpkgs version
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };
}
