## Creating the image file

git clone or git pull this repo to a Linux host where you have superuser (root) access.

```
TODO : put example command here.
```

```
$ pwd
/home/tf/git/ogn-receiver
```

Move a copy of Sebastien's image (the unzipped, ~2 GB version) into the img/ directory. The zipped image is [here](https://drive.google.com/file/d/1pncyWeEAkNTGjUBEetyMWp8FSkfy--Oe/view).

```
$ ls img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img
img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img
```

Create the OGN image. You need to be root to do this.

```
$ sudo ./create-ogn-image
[sudo] password for tf: 
Password:
```

A file named img/ognreceiver.img is written. This file is under 4 GB in size.

```
$ ls -lh img/ognreceiver.img 
-rw-r--r-- 1 root root 3.5G Jun 17 16:13 img/ognreceiver.img
```

## Creating the SD card.

Insert your SD card into the computer. Linux will detect the card and give it a device name. Depending on your distro, Linux might mount the SD card or partitions from the card. You need to know the device name *and* you need to ensure that the card is not mounted.


Write the image to your SD card. Note that the device name assigned for your SD card by your Linux host will be different than this example. Your Linux host might automatically mount the partitions on your SD card when you insert it. In that case, unmount the partitions first. The command will be something like this:

When you insert the SD card your computer may mount its partitions automatically. You must unmount those partitions before the card can be overwritten with the OGN Receiver image.

Look for the name of the device and the mountpoint with this command. You will need to note both.  

```
$ df -h

$ umount /media/yourname/*
```

Burn the OGN Receiver image to your card.

** WARNING ** This step has the potential to ruin your day. If you identify the wrong device (e.g. your main computer drive), it will be overwritten without confirmation!

The dd command will take about five minutes to run.

```
$ dd if=img/ognreceiver.img of=/dev/sda bs=1M
3584+0 records in
3584+0 records out
3758096384 bytes (3.8 GB, 3.5 GiB) copied, 575.475 s, 6.5 MB/s
```

Eject the SD card from your computer. It is ready to insert into the Raspberry Pi.


