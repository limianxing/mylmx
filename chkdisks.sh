#!/bin/sh
echo disk$1ModelFamily$1DeviceModel$1SerialNumber$1FirmwareVersion$1UserCapacity$1SectorSize
for i in `grep sd /proc/partitions|awk '{print$4}'|tr -d [0-9]`;
do
	ModelFamily=`smartctl -i /dev/$i|grep -E "Model Family" |cut -d':' -f 2 `;
	[[ "$ModelFamily" == "" ]] && ModelFamily='No Model Family'	
	DeviceModel=`smartctl -i /dev/$i|grep -E "Device Model" |cut -d':' -f 2 `;
	SerialNumber=`smartctl -i /dev/$i|grep -E "Serial Number" |cut -d':' -f 2 `;	
	FirmwareVersion=`smartctl -i /dev/$i|grep -E "Firmware Version" |cut -d':' -f 2 `;
	UserCapacity=`smartctl -i /dev/$i|grep -E "User Capacity" |cut -d':' -f 2 `;
	SectorSize=`smartctl -i /dev/$i|grep -E "Sector Size" |cut -d':' -f 2 `;
	echo -n $i$1$ModelFamily$1$DeviceModel$1$SerialNumber$1$FirmwareVersion$1$UserCapacity$1$SectorSize |grep -v "InnoDisk"|grep -v "SM611GX4";
done

