#!/bin/bash

TLS=1

if [ ! -z "$TLS" ]; then
cp /usr/local/etc/opensips/opensips_tls.cfg /usr/local/etc/opensips/opensips.cfg
fi

HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)

sed -i "s/listen=udp.*/listen=udp:${HOST_IP}:5060/g" /etc/opensips/opensips.cfg
sed -i "s/listen=tls.*/listen=tls:${HOST_IP}:5061/g" /etc/opensips/opensips.cfg

service rsyslog start

opensipsctl start

tail -f /var/log/opensips.log
