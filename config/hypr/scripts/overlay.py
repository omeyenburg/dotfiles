import sys
import os
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

try:
    print(sys.argv)
    percentage = int(sys.argv[1])
except ValueError or IndexError:
    raise Exception("Expected one numeric argument: percentage")


win = Gtk.Window()

win.set_title("info-overlay")
win.set_opacity(0.8)
win.set_size_request(200, 200)
win.connect("destroy", Gtk.main_quit)

vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
vbox.set_homogeneous(True)
win.add(vbox)

# Add a label
label = Gtk.Label(label="Volume")
vbox.pack_start(label, False, False, 0)

# Add an image
image_path = os.path.join(os.getenv("HOME"), ".config/hypr/icons/audio-volume-high-symbolic.png")
image = Gtk.Image.new_from_file(image_path)
vbox.pack_start(image, False, False, 0)

# Add a progress bar
progress_bar = Gtk.ProgressBar()
progress_bar.set_fraction(percentage / 100)
progress_bar.set_margin_start(30)
progress_bar.set_margin_end(30)
vbox.pack_start(progress_bar, False, False, 0)

# Function to close the window after 1 second
def close_window():
    win.close()
    return False  # Returning False removes the timeout callback after it runs once

# Set a timeout to close the window after 1 second
GLib.timeout_add(1000, close_window)

style_provider = Gtk.CssProvider()
css = """
label {
    color: #D3D3D3;
    font-size: 25px;
    font-weight: bold;
}

progressbar > trough {
    background-color: #D3D3D3;
    min-height: 10px;
}

progressbar > trough > progress {
    background-color: #808080;
    border: none;
    min-height: 10px;
}
"""
style_provider.load_from_data(css.encode('utf-8'))
Gtk.StyleContext.add_provider_for_screen(
    Gtk.Window.get_screen(win),
    style_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)


win.show_all()

Gtk.main()
