import os
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib


css = """
label {
    color: #D3D3D3;
    font-size: 18px;
    font-weight: bold;
}

progressbar {
    color: #D3D3D3;
}

progressbar > trough {
    border: none;
    background-color: #808080;
    min-height: 10px;
}

progressbar > trough > progress {
    background-color: #D3D3D3;
    border: none;
    min-height: 10px;
}
"""

images = {
    "empty": ".config/hypr/icons/empty.png",
    "audio-low": ".config/hypr/icons/audio-volume-low-symbolic.png",
    "audio-medium": ".config/hypr/icons/audio-volume-medium-symbolic.png",
    "audio-high": ".config/hypr/icons/audio-volume-high-symbolic.png",
    "audio-muted": ".config/hypr/icons/audio-volume-muted-symbolic.png",
    "audio-overamplified": ".config/hypr/icons/audio-volume-overamplified-symbolic.png",
    "display-brightness": ".config/hypr/icons/display-brightness-symbolic.png",
    "keyboard-brightness": ".config/hypr/icons/keyboard-brightness-symbolic.png"
}


class Window(Gtk.Window):
    def __init__(self):
        super().__init__()
        self.widgets()
        self.connect("destroy", Gtk.main_quit)
        self.set_title("media-overlay")
        self.set_opacity(0.8)
        self.set_size_request(200, 200)

        # Apply custom css
        style_provider = Gtk.CssProvider()
        style_provider.load_from_data(css.encode('utf-8'))
        Gtk.StyleContext.add_provider_for_screen(
            Gtk.Window.get_screen(self),
            style_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )

        timeout_id = GLib.timeout_add(1000, self.quit)
        GLib.idle_add(self.update, timeout_id)
        self.show_all()
        Gtk.main()

    def widgets(self):
        # Widget container
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        vbox.set_homogeneous(True)
        self.add(vbox)

        # Title label
        self.title_widget = Gtk.Label(label="")
        vbox.pack_start(self.title_widget, False, False, 0)

        # Media icon
        icon_path = os.path.join(os.getenv("HOME"), images["empty"])
        self.icon_widget = Gtk.Image.new_from_file(icon_path)
        vbox.pack_start(self.icon_widget, False, False, 0)

        # Bar
        self.bar_widget = Gtk.ProgressBar()
        self.bar_widget.set_margin_start(23)
        self.bar_widget.set_margin_end(23)
        self.bar_widget.set_show_text(True)
        vbox.pack_start(self.bar_widget, False, False, 0)

    def update(self, timeout_id):
        with open("/tmp/hyprland-media-overlay", "r+") as pipe:
            line = pipe.read().strip().split()
            if len(line) >= 2:
                try:
                    percent = int(line[0])
                except ValueError:
                    print("Could not convert to int:", line[0])

                if "muted" in line:
                    title = " ".join(line[1:-2])
                    muted = True
                else:
                    title = " ".join(line[1:])
                    muted = False

                self.title_widget.set_text(title)
                self.bar_widget.set_fraction(percent / 100)
                self.bar_widget.set_text(str(percent) + "%")

                if title == "Volume":
                    if muted:
                        icon = images["audio-muted"]
                    elif percent < 33:
                        icon = images["audio-low"]
                    elif percent < 66:
                        icon = images["audio-medium"]
                    elif percent < 100:
                        icon = images["audio-high"]
                    else:
                        icon = images["audio-overamplified"]
                elif title == "Display Brightness":
                    icon = images["display-brightness"]
                else:
                    icon = images["keyboard-brightness"]

                icon_path = os.path.join(os.getenv("HOME"), icon)
                self.icon_widget.set_from_file(icon_path)

                GLib.source_remove(timeout_id)
                timeout_id = GLib.timeout_add(800, self.quit)
                pipe.truncate(0)

        GLib.timeout_add(50, self.update, timeout_id)
        return False

    def quit(self):
        self.close()
        return False


if __name__ == "__main__":
    Window()
