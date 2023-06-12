```
# task requires super user privileges
tf@prince:/home/tf/workdir# sudo su            
[sudo] password for tf: 

# extend the file size of the original image
root@prince:/home/tf/workdir# fallocate -l 3.5G ./2022-04-29-rpi-lite-ognro-v0.3-stretch.img

# resize the second partition with parted
root@prince:/home/tf/workdir# parted <<'EOT'
> select ./2022-04-29-rpi-lite-ognro-v0.3-stretch.img
> resizepart 2 100%FREE
> quit
> EOT
GNU Parted 3.4
Using /dev/nvme0n1
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) select ./2022-04-29-rpi-lite-ognro-v0.3-stretch.img              
Using /home/tf/workdir/2022-04-29-rpi-lite-ognro-v0.3-stretch.img
(parted) resizepart 2 100%FREE                                            
(parted) quit                                                             

# associate the image file with a loop device
root@prince:/home/tf/workdir# losetup --show --find 2022-04-29-rpi-lite-ognro-v0.3-stretch.img
/dev/loop23

# probe the device for its partitions
root@prince:/home/tf/workdir# partprobe /dev/loop23

# optional. just to display info.
root@prince:/home/tf/workdir# lsblk /dev/loop23

NAME       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop23       7:23   0  3.5G  0 loop 
├─loop23p1 259:8    0  256M  0 part 
└─loop23p2 259:9    0  3.2G  0 part 

# cleanup the file system on the second partition. avoids a problem with the next step.
root@prince:/home/tf/workdir# e2fsck -f /dev/loop23p2
e2fsck 1.46.5 (30-Dec-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
rootfs: 47302/106496 files (0.8% non-contiguous), 389879/408165 blocks

# resize the file system in the second partition.
root@prince:/home/tf/workdir# resize2fs /dev/loop23p2
resize2fs 1.46.5 (30-Dec-2021)
Resizing the filesystem on /dev/loop23p2 to 850944 (4k) blocks.
The filesystem on /dev/loop23p2 is now 850944 (4k) blocks long.

# make a mount directory
root@prince:/home/tf/workdir# mkdir /mnt/tmp/

# mount the second partition
root@prince:/home/tf/workdir# mount /dev/loop23p2 /mnt/tmp/

# set correct timezone
root@prince:/home/tf/workdir# rm /mnt/tmp/etc/localtime
root@prince:/home/tf/workdir# ln -s /usr/share/zoneinfo/America/Montreal /mnt/tmp/etc/localtime

# the following two steps ensure efficient compression.

# add a file of zeros to the filesystem until full
root@prince:/home/tf/workdir# dd if=/dev/zero of=/mnt/tmp/delme
dd: writing to '/mnt/tmp/delme': No space left on device
3601449+0 records in
3601448+0 records out
1843941376 bytes (1.8 GB, 1.7 GiB) copied, 7.04904 s, 262 MB/s

# delete that same file. 
root@prince:/home/tf/workdir# rm /mnt/tmp/delme

# unmount the partition from the mount point
root@prince:/home/tf/workdir# umount /mnt/tmp/

# detach the loop device.
root@prince:/home/tf/workdir# losetup --detach /dev/loop28

# compress the image.
root@prince:/home/tf/workdir# zip 2022-04-29-rpi-lite-ognro-v0.3-stretch--resized.img.zip 2022-04-29-rpi-lite-ognro-v0.3-stretch.img
  adding: 2022-04-29-rpi-lite-ognro-v0.3-stretch.img (deflated 85%)
```

