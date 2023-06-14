# Standard OGN Receiver image

This project builds a RVSS standard OGN Receiver image based on Sébastien Chaumontet contribution to the OGN project. http://wiki.glidernet.org/downloads

Receivers build from this image can

 1. Be reached remotely via mail.rvss.ca (if you have an account on that server). (optional)
 1. Keep OGN logs on SD card. 1.5 GB of reserved space.
 1. Upload OGN logs to mail.rvss.ca for safekeeping (optional)


## Requires.

4 GB SD card, minimum. Additional space will be ignored.


## Known OGN Receiver names.

These receiver names are recognized. Fixed ports are used for autossh.

OGN-receiver.conf.cpl3  OGN-receiver.conf.GlebeON  OGN-receiver.conf.WinghamON

---------------------------------------------


Download the image from mail.rvss.ca:/data/img/ognstation.img.zip
Unzip.
Burn the img to your SD card.
Update OGN-receiver.conf  




- 4 GB card minimum
- Recognizes common station names and uses assigned ports
- OGN logging is permanent
- logging to SD card partition
- logs are pushed to mail.rvss.ca (optional)
- autossh to mail.rvss.ca (optional)
- logging is automatic

- 1.5 GB of space for log files.






OGN-receiver.conf.cpl3  OGN-receiver.conf.GlebeON  OGN-receiver.conf.WinghamON

