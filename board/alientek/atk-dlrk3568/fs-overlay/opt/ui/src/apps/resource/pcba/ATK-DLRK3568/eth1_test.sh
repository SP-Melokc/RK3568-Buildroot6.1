#!/bin/bash
ip_address=$(ip addr show dev eth1 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
if [ -z "$ip_address" ]; then
    exit 1
else
    exit 0
fi
