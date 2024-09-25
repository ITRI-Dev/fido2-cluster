#!/bin/bash

# Copy the script and configuration file
cp -f check_haproxy2.sh check_haproxy.sh
cp -f keepalived_backup.conf keepalived.conf

# Make all shell scripts in the directory executable
chmod +x *.sh

# Remove any existing Docker container named 'keepalived2'
docker rm -f keepalived2

# Run the keepalived Docker container with the specified configuration
docker run \
  -d \
  --name keepalived2 \
  --network host \
  --restart unless-stopped \
  --cap-add=NET_ADMIN \
  --cap-add=NET_BROADCAST \
  --cap-add=NET_RAW \
  -v /home/k3d/keepalived/keepalived.conf:/usr/local/etc/keepalived/keepalived.conf \
  -v /home/k3d/keepalived/check_haproxy.sh:/usr/local/etc/keepalived/check_haproxy.sh \
  osixia/keepalived:latest

# Pause for 3.5 seconds to allow the container to start
sleep 3.5

# Show the network interfaces and IP addresses for 'enp0s8'
echo "Current local IP address of keepalived2 + haproxy2 node:"
ip addr show enp0s8
echo "Wait to get Virtual IP address..."
sleep 3.5
ip addr show enp0s8
