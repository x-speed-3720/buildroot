#!/bin/sh

destdir=/mnt

my_umount()
{
	if grep -qs "^/dev/$1 " /proc/mounts ; then
		case "$1" in 
	mmcblk0p1)
		umount "${destdir}/boot";
		devtyp=boot	
		;;
	mmcblk0p2)
		umount "${destdir}/config";
		devtyp=config		
		;;
	mmcblk0p3)
		umount "${destdir}/log";
		devtyp=log		
		;;
	mmcblk1p1)
		umount "${destdir}/sd";
		devtyp=sd
		;;
	sda1|sdb1|sdc1)
		umount "${destdir}/usb";
		devtyp=usb
		;;
		esac
	fi
#	[ -d "${destdir}/${devtyp}" ] && rmdir "${destdir}/${devtyp}"
}

my_mount()
{
	case "$1" in  
        mmcblk0p1)
                devtype=boot;    
                ;;  
        mmcblk0p2)
                devtype=config;    
                ;;  
        mmcblk0p3)
                devtype=log; 
		;;   
        mmcblk1p1)
		devtype=sd;
                ;;  
        sda1|sdb1|sdc1)
		devtype=usb;
                ;;  
	esac		
	mkdir -p "${destdir}/${devtype}" || exit 1
	if ! mount -t auto -o sync "/dev/$1" "${destdir}/${devtype}"; then
		echo "${devtype} mount failure !"		
		exit 1
	fi
}

case "${ACTION}" in
add|"")
	my_umount ${MDEV}
	my_mount ${MDEV}
	;;
remove)
	my_umount ${MDEV}
	;;
esac
