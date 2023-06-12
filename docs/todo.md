

## add a partition that can be used to keep station OGN records.
PARTUUID=833fe3cf-03  /extlogs        ext4    rw,noexec,nofail,noatime  0       0

## rsync OGN station log records to external host for safekeeping.

## disable services that DV has identified to reduce Internet data.

Disable automated eeprom and other update services
systemctl disable rpi-eeprom-update.service
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily.timer



# add Pi Witty software for scheduled shutdown and boot.

# write a script to automate the process described in "howto-extend-original-image.md"

- might want to leave out the final zip production and do it manually.

