```
# task requires super user privileges
tf@prince:/home/tf/workdir# sudo su            
[sudo] password for tf: 

# make a copy of the original image. we will modify the copy.
root@prince:/home/tf/workdir# cp img/2022-04-29-rpi-lite-ognro-v0.3-stretch.img img/ognstation.img

# extend the file size of the original image
root@prince:/home/tf/workdir# fallocate -l 3.9G img/ognstation.img 

# associate the image file with a loop device
root@prince:/home/tf/workdir# myloop=`losetup --show --find img/ognstation.img`
/dev/loop23

# probe the device for its partitions
root@prince:/home/tf/workdir# partprobe ${myloop}

# optional. just to display info.
root@prince:/home/tf/workdir# lsblk $myloop

NAME       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop23       7:23   0  3.5G  0 loop 
├─loop23p1 259:8    0  256M  0 part 
└─loop23p2 259:9    0  3.2G  0 part 

# resize (grow) the second partition with parted
root@prince:/home/tf/workdir# parted ${myloop} resizepart 2 100%FREE

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

# allocate some additional space on disk.
#  detach
#  falloc

# 
root@ONOTTRA805608XL:/home/forbestim/git/ogn-station# parted ${myloop} p
Model: Loopback device (loopback)
Disk /dev/loop18: 4295MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  273MB   268MB   primary  fat32        lba
 2      273MB   2684MB  2412MB  primary  ext4

root@ONOTTRA805608XL:/home/forbestim/git/ogn-station# parted ${myloop} mkpart primary ext4 2684MB 4295MB

# add ext4 file system to third partition

# make mount directories if necessary
root@prince:/home/tf/workdir# mkdir /mnt/p1
root@prince:/home/tf/workdir# mkdir /mnt/p2
root@prince:/home/tf/workdir# mkdir /mnt/p2

# mount the partitions
root@prince:/home/tf/workdir# mount ${myloop}p1 /mnt/p1
root@prince:/home/tf/workdir# mount ${myloop}p2 /mnt/p2
root@prince:/home/tf/workdir# mount ${myloop}p3 /mnt/p3

# copy p1 files
root@prince:/home/tf/workdir# rsync -av p1/ /mnt/p1/

# copy p2 files
root@prince:/home/tf/workdir# rsync -av p2/ /mnt/p2/

# set ownership of things changed and added
root@prince:/home/tf/workdir# chown -R 1000.1000 /mnt/p2/home/pi
root@prince:/home/tf/workdir# chown -R root.root /mnt/p2/etc
root@prince:/home/tf/workdir# chown -R root.root /mnt/p2/root
root@prince:/home/tf/workdir# chown -R root.root /mnt/p2/var

# the following two steps ensure efficient compression of
# the newly allocated space on p2.

# add a file of zeros to the filesystem until full, then remove it
root@prince:/home/tf/workdir# dd if=/dev/zero of=/mnt/p2/delme; rm /mnt/p2/delme
dd: writing to '/mnt/p2/delme': No space left on device
3601449+0 records in
3601448+0 records out
1843941376 bytes (1.8 GB, 1.7 GiB) copied, 7.04904 s, 262 MB/s

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

