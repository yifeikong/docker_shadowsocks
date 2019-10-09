#!/bin/bash

REMOTE_IP=`host hkdev.yifei.me | cut -f4 -d' '` # 或者直接是 IP
REMOTE_PORT=10087 # 上面配置的端口
LOCAL_IP=47.92.94.73 # 阿里云的 IP
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport $REMOTE_PORT -j DNAT --to-destination $REMOTE_IP:$REMOTE_PORT
iptables -t nat -A POSTROUTING -p tcp -d $REMOTE_IP --dport $REMOTE_PORT -j SNAT --to-source $LOCAL_IP
iptables -t nat -A PREROUTING -p udp --dport $REMOTE_PORT -j DNAT --to-destination $REMOTE_IP:$REMOTE_PORT
iptables -t nat -A POSTROUTING -p udp -d $REMOTE_IP --dport $REMOTE_PORT -j SNAT --to-source $LOCAL_IP
echo relay to $REMOTE_IP:$REMOTE_PORT via $LOCAL_IP is enabled
