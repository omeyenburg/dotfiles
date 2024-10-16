if the error is related to brcmf:

Run:
sudo nano /etc/modprobe.d/blacklist-brcmf.conf
And add:
blacklist brcmf


here is the old grub conf:
edit with:
sudo vim /etc/default/grub

old line:
GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet pcie_aspm=force nohibernate=1 acpi=copy_dsdt security=apparmor amd_iommu=off mitigations=auto acpi_osi=Linux"

and update grub with:
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
