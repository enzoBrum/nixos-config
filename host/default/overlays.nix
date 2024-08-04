{ pkgs, ... }:
{
   nixpkgs = {
     overlays = [
       (self: super: {
        python3Packages = super.python3Packages // {pykeepass = super.python3Packages.pykeepass.overrideAttrs (_: rec {
            version = "4.1.0.post1";
            src = pkgs.fetchFromGitHub {
              owner = "libkeepass";
              repo = "pykeepass";
              rev = "refs/tags/v${version}";
              hash = "sha256-64is/XoRF/kojqd4jQIAQi1od8TRhiv9uR+WNIGvP2A=";
            };
          }
        );}; 
      })
     ];
   };
}
