{
  description = "Ruby on Rails development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];

          buildInputs = with pkgs; [
            ruby_3_4
            bundler

            # Database libraries
            sqlite
            postgresql_17

            # Node for asset compilation
            nodejs_24
            yarn

            # Common gem dependencies
            libyaml
            zlib
            openssl
            libxml2
            libxslt
            readline
          ];

          shellHook = ''
            export GEM_HOME=$PWD/.gem
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH

            echo "Ruby on Rails environment loaded!"
            ruby --version
          '';
        };
      }
    );
}
