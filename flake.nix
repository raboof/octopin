{
  description = "Analyses and pins GitHub actions in your workflows.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      perSystem = { pkgs, ... } : {
        packages.default = pkgs.python3.pkgs.buildPythonPackage rec {
          pname = "octopin";
          version = "0.1.3";
        
          src = pkgs.fetchFromGitHub {
            owner = "eclipse-csi";
            repo = "octopin";
            tag = "v${version}";
            hash = "sha256-jpMa4NO78ttmr/VGJHjwOkGecwN4BSMvbCJFKjXd/ko=";
          };
        
          pyproject = true;
        
          dependencies = with pkgs.python3.pkgs; [
            pdm-backend
            typer
            pyyaml
            semver
            aiohttp
            aiohttp-client-cache
            aiosqlite
            platformdirs
          ];
        
          doCheck = true;
        
          nativeCheckInputs = with pkgs.python3.pkgs; [
            pytest
            parameterized
          ];
        
          checkPhase = ''
            runHook preCheck
        
            echo "__version__ = \"${version}\"" > octopin/_version.py
            pytest
        
            runHook postCheck
          '';
        
          meta = {
            description = "Analyses and pins GitHub actions in your workflows.";
            homepage = "https://github.com/eclipse-csi/octopin";
            license = pkgs.lib.licenses.epl20;
            maintainers = with pkgs.lib.maintainers; [ raboof ];
            platforms = pkgs.lib.platforms.all;
          };
        
        };

      };
    };
}
