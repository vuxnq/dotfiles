#!/bin/bash
EDID_FOLDER="/usr/lib/firmware/edid"
EDID_FILE="samsung-q800t-hdmi2.1"

echo "> creating ${EDID_FOLDER} folder"
sudo mkdir -p ${EDID_FOLDER}

echo "> downloading ${EDID_FILE} file into ${EDID_FOLDER}"
sudo wget -O ${EDID_FOLDER}/${EDID_FILE} https://git.linuxtv.org/v4l-utils.git/plain/utils/edid-decode/data/${EDID_FILE}

for p in /sys/class/drm/*/status; do con=${p%/status}; echo -n "${con#*/card?-}: "; cat $p; done
read -p "> select free GPU output (DP-3): " output
output="${output:-DP-3}"
parameters="drm.edid_firmware=${output}:edid/${EDID_FILE} video=${output}:e"

echo "> adding kernel parameters (${parameters})"
sudo grubby --update-kernel=ALL --args="${parameters}"

echo "> adding edid file to dracut (/etc/dracut.conf.d/99-edid.conf)"
echo "install_items+=' ${EDID_FOLDER}/${EDID_FILE} '" | sudo tee /etc/dracut.conf.d/99-edid.conf

echo "> regenerating initramfs"
sudo dracut -f --regenerate-all

echo "> done, reboot to apply the changes"
