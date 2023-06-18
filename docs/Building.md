

git clone or git pull this project (repo) to a Linux host where you have superuser (root) access.

$ pwd
/home/tf/git/ogn-receiver

Move a copy of Sebastien's image (the unzipped, ~2 GB version) into the img/ directory. You can download the zipped image from https://drive.google.com/file/d/1pncyWeEAkNTGjUBEetyMWp8FSkfy--Oe/view

$ ls img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img
img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img

Become root.

$ sudo su
[sudo] password for tf: 
Password:
$ whoami
root

$ ./create-ogn-image

A file named img/ognreceiver.img is written. This file is under 4 GB in size.

$ ls -lh img/ognreceiver.img 
-rw-r--r-- 1 root root 3.5G Jun 17 16:13 img/ognreceiver.img

Write the image to your SD card. Note that the device name assigned for your SD card by your Linux host will be different than this example. Your Linux host might automatically mount the partitions on your SD card when you insert it. In that case, unmount the partitions first. The command will be something like this:

When you insert the SD card to your computer, its partitions may be mounted automatically. You must unmount before the card can be overwritten with the OGN Receiver image 

Look for the name of the device and the mountpoint with this command. You will need to note both.  

$ df -h

$ umount /media/yourname/*

Burn the OGN Receiver image to your card.

** WARNING ** This step has the potential to ruin your day. If you identify the wrong device (e.g. your main computer drive), it will be overwritten without confirmation!

The dd command will take about five minutes to run.

$ dd if=img/ognreceiver.img of=/dev/sda bs=1M
3584+0 records in
3584+0 records out
3758096384 bytes (3.8 GB, 3.5 GiB) copied, 575.475 s, 6.5 MB/s





