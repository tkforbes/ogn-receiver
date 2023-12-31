# Standard OGN Receiver image

This project builds a RVSS standard OGN Receiver image for a Raspberry Pi. The image extends [Sébastien Chaumontet's contribution to the OGN project](http://wiki.glidernet.org/downloads) with custom content and behaviour.

Receivers running the RVSS standard OGN Receiver image:

 1. can be administered remotely (optional) by ssh via ogn.rvss.ca provided you have a shell account on that server.
 1. keep OGN logs on the SD card in 1.5 GB of reserved space.
 1. optionally send the OGN logs to ogn.rvss.ca for safekeeping and central access.

## Known OGN Receiver names.

These receiver names are recognized. Fixed ports are used for autossh.

 * CPL3		6000
 * FALLFLD	6020
 * Fallfld3	6040
 * GlebeON	6060
 * PerthON	6080
 * TglwoodON	6100
 * WinghamON	6120

## Instructions.

4 GB SD card, minimum. Additional space will be ignored.

 1. Download zip file from ogn.rvss.ca:/data/img/ognreceiver.img.zip
 1. Unzip
 1. Burn img to your SD card.
 1. Update OGN-receiver.conf. You can overwrite with one of these templates for convenience.

[OGN-receiver.conf.CPL3](../p1/OGN-receiver.conf.CPL3) [OGN-receiver.conf.GlebeON](../p1/OGN-receiver.conf.GlebeON) [OGN-receiver.conf.WinghamON](../p1/OGN-receiver.conf.WinghamON)


The template files are in the same directory as OGN-receiver.conf.

OGN-receiver.conf must have _wifiName, wifiPassword_ and _piUserPassword_ defined.

If you want ssh access from ogn.rvss.ca, define _EnableCoreOGNTeamRemoteAdmin="true"_.

If you want logs to be copied to ogn.rvss.ca, define _sendLogs="true"_.

## Stuff.

### Logs.

There is 1.5 GB of space for OGN log files. ATM, this is unmanaged; it could theoretically fill to capacity. If you are concerned about approaching the limit, login to your receiver and delete some files from /data/ogn/log/

OGN log file names are constructed from the name of your receiver and the UTC time at the start of logging.

### Access to your remote receiver.

If your receiver is at a remote location, you can access it if
 - you defined _EnableCoreOGNTeamRemoteAdmin="true"_
 - you have a shell account on ogn.rvss.ca



 1. Login to ogn.rvss.ca
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
