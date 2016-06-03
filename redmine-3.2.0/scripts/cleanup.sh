
#yum -y erase gtk2 libX11 hicolor-icon-theme avahi bitstream-vera-fonts
sudo -S yum -y clean all
sudo -S rm -rf VBoxGuestAdditions_*.iso
sudo -S rm -rf /tmp/rubygems-*
sudo -S rm -rf /tmp/*
