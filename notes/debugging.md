# Debugging
A list of quick fixes for some problems I encountered.

## Fix Brave-Browser right click popup
Open brave://flags/
Search for "Preferred Ozone platform" and explicitly set it to "Wayland"

Some more things to try out:
- Shared pinned tab

## Fix firefox performance
On some devices hardware acceleration leads to worse performance.
Try to disable it by disabling recommended performance settings and disabling hardware acceleration.

## Disable startup sound on mac
Command to disable macos startup sound:
```
sudo nvram StartupMute=%01
```
And to enable:
```
sudo nvram StartupMute=%00
```
https://apple.stackexchange.com/questions/431910/how-to-permanently-disable-the-mac-startup-sound

## Sleeping issues
This might be a problem when booting from an external media on a MacBook.

Some grub args may have to be modified.
edit with:
```
sudo vim /etc/default/grub
```

Here is a working list of args, most of which are probably not needed or useful:
```
GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet pcie_aspm=force nohibernate=1 acpi=copy_dsdt security=apparmor amd_iommu=off mitigations=auto acpi_osi=Linux"
```

Then update grub with:
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

This might be needed if the error is related to brcmf:
Run:
```
sudo nano /etc/modprobe.d/blacklist-brcmf.conf
```

And add:
```
blacklist brcmf
```

## Youtube lagging in dark mode
1. enter youtube video
2. click on the video settings
3. disable ambient mode
