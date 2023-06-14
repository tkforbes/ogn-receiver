# Standard OGN Receiver image

This project builds a RVSS standard OGN Receiver image based on Sébastien Chaumontet contribution to the OGN project. http://wiki.glidernet.org/downloads

Receivers build from this image can

 1. Be reached remotely via mail.rvss.ca (if you have an account on that server). (optional)
 1. Keep OGN logs on SD card. 1.5 GB of reserved space.
 1. Upload OGN logs to mail.rvss.ca for safekeeping (optional)

## Known OGN Receiver names.

These receiver names are recognized. Fixed ports are used for autossh.

OGN-receiver.conf.cpl3  OGN-receiver.conf.GlebeON  OGN-receiver.conf.WinghamON

## Instructions.

4 GB SD card, minimum. Additional space will be ignored.

 1. Download zip file from mail.rvss.ca:/data/img/ognreceiver.img.zip
 1. Unzip
 1. Burn img to your SD card.
 1. Update OGN-receiver.conf. You can overwrite with one of these templates for convenience.

OGN-receiver.conf.cpl3  OGN-receiver.conf.GlebeON  OGN-receiver.conf.WinghamON

You will have to provide wifiName, wifiPassword and piUserPassword.


If you want ssh access from mail.rvss.ca, define _EnableCoreOGNTeamRemoteAdmin="true"_.

If you want logs to be copied to mail.rvss.ca, define _sendLogs="true"_.

## Stuff.

### Logs.

There is 1.5 GB of space for OGN log files. ATM, this is unmanaged; it could theoretically fill to capacity. If you are concerned about approaching the limit, login to your receiver and delete some files from /data/ogn/log/

OGN log file names are constructed from the name of your receiver and the GMT time at the start of logging.

### Access to your receiver.

 1. Login to mail.rvss.ca
 1. ssh pi@localhost -p PORT
 1. provide the password you specified for piUserPassword in OGN-receiver.conf.

You should know the port of your receiver.

### Timezone.

The receiver is set to use the Montreal timezone.

### Daily reboot.

The receiver will reboot at 5am daily. This will cause a new OGN log to be started. The reboot may resolve a remote connection issue.

### Pi Witty

If you want to install software for the Pi Witty hat, 

 1. pi@ogn-receiver:~ $ overlayctl disable
 1. pi@ogn-receiver:~ $ sudo reboot
 1. login again
 1. pi@ogn-receiver:~ $ cd ~
 1. pi@ogn-receiver:~ $ ./installWittyPi4

Remember to enable overlayctl once your software is setup.
