#!/bin/bash
while [ true ]
do
	waktu=`date +"%F %H:%M:%S"`
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
	rx=`netstat -i | grep -v "Kernel" | grep -v "Iface" | awk 'NR==3' | awk '{printf "%.2f", $4/1024}'`
	tx=`netstat -i | grep -v "Kernel" | grep -v "Iface" | awk 'NR==3' | awk '{printf "%.2f", $8/1024}'`
	DRead=`sudo iotop -q | head -2 | awk 'NR==2' | awk '{printf "%.2f", $4/1024}'`
	DWrite=`sudo iotop -q | head -2 | awk 'NR==2' | awk '{printf "%.2f", $10/1024}'`
	echo "|$waktu|CPU Load: $cpuload|MemUsed: $memused/$memtotal|TX: $tx Kb/s|RX: $rx Kb/s|DRead: $DRead KB/s|DWrite: $DWrite KB/s|" >> filemonitoring
	sleep 5
done