#!/bin/bash
set -x

IPATH=/usr/local/share/dutchradar

systemctl disable --now dutchradar-mlat
systemctl disable --now dutchradar-mlat2 &>/dev/null
systemctl disable --now dutchradar-feed

if [[ -d /usr/local/share/tar1090/html-dutchradar ]]; then
    bash /usr/local/share/tar1090/uninstall.sh dutchradar
fi

rm -f /lib/systemd/system/dutchradar-mlat.service
rm -f /lib/systemd/system/dutchradar-mlat2.service
rm -f /lib/systemd/system/dutchradar-feed.service

cp -f "$IPATH/dutchradar-uuid" /tmp/dutchradar-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/dutchradar-uuid "$IPATH/dutchradar-uuid"

set +x

echo -----
echo "adsb.lol feed scripts have been uninstalled!"
