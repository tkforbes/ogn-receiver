```
# task requires super user privileges
tf@prince:/home/tf/workdir# sudo su            
[sudo] password for tf: 

# make a copy of the original image. we will work on the copy.
root@prince:/home/tf/workdir# cp img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img img/ognstation.img

# extend the file size of the original image
root@prince:/home/tf/workdir# fallocate -l 3.9G img/ognstation.img 

# resize the second partition with parted
root@prince:/home/tf/workdir# parted <<'EOT'
> select ./2022-04-29-rpi-lite-ognro-v0.3-stretch.img
> resizepart 2 100%FREE
> quit
> EOT
GNU Parted 3.4
Using /dev/nvme0n1
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) select img/ognstation.img        
Using /home/tf/workdir/img/ognstation.img
(parted) resizepart 2 100%FREE                                            
(parted) quit                                                             

# associate the image file with a loop device
root@prince:/home/tf/workdir# myloop=`losetup --show --find img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img`
/dev/loop23

# probe the device for its partitions
root@prince:/home/tf/workdir# partprobe ${myloop}

# optional. just to display info.
root@prince:/home/tf/workdir# lsblk $myloop

NAME       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop23       7:23   0  3.5G  0 loop 
├─loop23p1 259:8    0  256M  0 part 
└─loop23p2 259:9    0  3.2G  0 part 

# cleanup the file system on the second partition. avoids a problem with the next step.
root@prince:/home/tf/workdir# e2fsck -f ${myloop}p2
e2fsck 1.46.5 (30-Dec-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
rootfs: 47302/106496 files (0.8% non-contiguous), 389879/408165 blocks

# resize the file system in the second partition.
root@prince:/home/tf/workdir# resize2fs ${myloop}p2
resize2fs 1.46.5 (30-Dec-2021)
Resizing the filesystem on /dev/loop23p2 to 850944 (4k) blocks.
The filesystem on /dev/loop23p2 is now 850944 (4k) blocks long.

# make mount directories if necessary
root@prince:/home/tf/workdir# mkdir /mnt/p1
root@prince:/home/tf/workdir# mkdir /mnt/p2

# mount the first partition
root@prince:/home/tf/workdir# mount ${myloop}p1 /mnt/p1

# copy template configuration files
root@prince:/home/tf/workdir# cp p1/OGN-receiver.conf.* /mnt/p1/

# mount the second partition
root@prince:/home/tf/workdir# mount ${myloop}p2 /mnt/p2

# update glidernet-autossh with custom version
root@prince:/home/tf/workdir# cp p2/root/root/glidernet-autossh /mnt/p2/root/

# set correct timezone
root@prince:/home/tf/workdir# rm /mnt/p2/etc/localtime
root@prince:/home/tf/workdir# ln -s /usr/share/zoneinfo/America/Montreal /mnt/p2/etc/localtime

# the following two steps ensure efficient compression of
# the newly allocated space on p2.

# add a file of zeros to the filesystem until full
root@prince:/home/tf/workdir# dd if=/dev/zero of=/mnt/tmp/delme
dd: writing to '/mnt/p2/delme': No space left on device
3601449+0 records in
3601448+0 records out
1843941376 bytes (1.8 GB, 1.7 GiB) copied, 7.04904 s, 262 MB/s

# delete that same file. 
root@prince:/home/tf/workdir# rm /mnt/p2/delme

# unmount the partitions from the mount points
root@prince:/home/tf/workdir# umount /mnt/p1/
root@prince:/home/tf/workdir# umount /mnt/p2/

# detach the loop device.
root@prince:/home/tf/workdir# losetup --detach ${myloop}

# compress the image.
root@prince:/home/tf/workdir# cd img && zip ognstation.img.zip ognstation.img && cd ..
  adding: ognstation.img (deflated 85%)



# mount p3 three to /data
PARTUUID=833fe3cf-03  /data   ext4    rw,noexec,nofail,noatime  0       0


# create /ogn/log on p3
mkdir -p /mnt/p3/ogn/log

```

