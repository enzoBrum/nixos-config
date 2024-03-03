{ pkgs, ... }: {
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
        hide_cursor = false
    }

    background {
        path = /home/erb/.current_image.png
    }

    input-field {
        monitor =
        size = 200, 50
        outline_thickness = 3
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false
        outer_color = rgb(151515)
        inner_color = rgb(200, 200, 200)
        font_color = rgb(10, 10, 10)
        fade_on_empty = true
        placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
        hide_input = false

        position = 0, -20
        halign = center
        valign = center
    }

  '';
}
