if [[ "$(pidof dnsmasq)" != "" ]]
then
    kill -9 $(pidof dnsmasq)
fi

if [[ "$(pidof hostapd)" != "" ]]
then
    kill -9 $(pidof hostapd)
fi
rfkill unblock all
ifconfig p2p0 down
sleep 1
ifconfig p2p0 up
sleep 1
dnsmasq -C dnsmasq.conf
ifconfig p2p0 192.168.4.1
hostapd hostapd.conf -B

