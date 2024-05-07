{ pkgs, ... }: {
  # nixpkgs = {
  #   overlays = [
  #     (self: super: {
  #       gnome = super.gnome.overrideScope' (selfg: superg: {
  #         gnome-shell = superg.gnome-shell.overrideAttrs (old: {
  #           patches = (old.patches or [ ]) ++ [
  #             (
  #               let
  #                 bg = pkgs.fetchurl {
  #                   url =
  #                     "https://github.com/enzoBrum/nixos-config/raw/main/assets/wallpaper/blurred";
  #                   sha256 =
  #                     "sha256-U3nJ8AaAltSE3bIVYLwTm+vyV4Susg/5pl73lCTZbAk=";
  #                 };
  #               in
  #               pkgs.writeText "bg.patch" ''
  #                 --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
  #                 +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
  #                 @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
  #                  /* Login Dialog */
  #                  .login-dialog {
  #                    background-color: $_gdm_bg;
  #                 +  background-image: url('file://${bg}');
  #                  }
  #               ''
  #             )
  #           ];
  #         });
  #       });
  #     })
  #   ];
  # };
}
