sudo -S VBOX_VERSION=$(cat /home/admin/.vbox_version)
cd /tmp
sudo -S mount -o loop /home/admin/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sudo -S sh /mnt/VBoxLinuxAdditions.run
sudo -S umount /mnt
sudo -S rm -rf /home/admin/VBoxGuestAdditions_*.iso
