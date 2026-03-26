#!/bin/bash
set -e
echo "Installing Arcade Calamares configs..."
cp -r calamares/branding/arcade /usr/share/calamares/branding/
cp calamares/settings.conf /etc/calamares/settings.conf
cp calamares/modules/*.conf /etc/calamares/modules/
echo "Done. Run: sudo calamares -D to test."
