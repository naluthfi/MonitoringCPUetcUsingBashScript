#!/bin/bash
while [ true ]
do
	waktu=`date +"%F %r"`
	cpuload=`cat /proc/loadavg | awk '{print $2}'`
	parcpu=0.8;
	if [ $cpuload '>' $parcpu ]
		then
			echo -e "Your CPU load is greater than 80%. Please check the running task on your PC.\n\n\nRegards,\n\nAdmin" | mail -s "High CPU Load Notification" "naluthfi@gmail.com"
	fi
	memused=`free -mh | grep Mem | awk '{print $3}'`
	memtotal=`free -mh | grep Mem | awk '{print $2}'`
	mempercent=`free -m | grep Mem | awk '{printf "%.2f", $3/$2*100}'`
	parmem=80;
	if [ $mempercent '>' $parmem ]
		then
			echo -e "Your Memory is greater than 80%. Please check it on your PC.\n\n\nRegards,\n\nAdmin" | mail -s "High Memory Used Notification" "naluthfi@gmail.com"
	fi	
	totalkoneksi=`netstat -i | grep -v "Kernel" | grep -v "Iface" | wc -l`
	echo -n "| Date : $waktu | CPU Load : $cpuload | Memory Used : $memused/$memtotal ($mempercent%) | Bandwidth (Iface RX TX) : " >> filemonitoring
	while [ $totalkoneksi -gt 0 ];
	do
		NewBandwidth=`netstat -i | grep -v "Kernel" | grep -v "Iface" | awk -v var=$totalkoneksi 'NR==var' | awk '{print $1 " " $4 " " $8}'`;
		echo -n "$NewBandwidth" >> filemonitoring
		if [ $totalkoneksi -gt 1 ];
		then
			echo -n ", " >> filemonitoring
		fi
		totalkoneksi=`expr $totalkoneksi - 1`;
	done;
	IOspeed=`sudo iotop -q | head -2 | awk 'NR==2' | awk '{print}'`;
	echo " | $IOspeed |" >> filemonitoring;
	sleep 5;
done;