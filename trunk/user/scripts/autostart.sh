#!/bin/sh
#nvram set ntp_ready=0

logger -t "autostart" "checking if the router is connected to the internet..."
count=0
while :
do
	ping -c 1 -W 1 -q 1.1.1.1 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 5
	ping -c 1 -W 1 -q one.one.one.one 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 5
	count=$((count+1))
	if [ $count -gt 18 ]; then
		break
	fi
done

if [ $(nvram get bafa_enable) = 1 ] ; then
logger -t "自动启动" "正在启动巴法云物联网"
/usr/bin/bafa.sh start &
fi
if [ $(nvram get hxcli_enable) = 1 ] ; then
logger -t "自动启动" "正在启动异地组网"
/usr/bin/hx.sh start &
fi

if [ $(nvram get nelink_enable) = 1 ] ; then
logger -t "自动启动" "正在启动NE异地组网"
/usr/bin/ne.sh start &
fi

if [ $(nvram get ntwon_enable) = 1 ] ; then
logger -t "自动启动" "正在启N2V2组网"
/usr/bin/ntwon.sh start &
fi

if [ $(nvram get etink_enable) = 1 ] ; then
logger -t "自动启动" "正在启动ET异地组网"
/usr/bin/etink.sh start &
fi

if [ $(nvram get etweb_enable) = 1 ] ; then
logger -t "自动启动" "正在启动ETWEB异地组网"
/usr/bin/etink.sh start &
fi
