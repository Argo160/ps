#!/bin/bash

# Read the first SSH port number from the sshd_config file
first_port=$(grep ^Port /etc/ssh/sshd_config | head -n 1 | awk '{print $2}')

# Define the number of ports to update
num_ports=8

# Loop through the number of ports to update and replace them in the sshd_config file
for (( i=0; i<$num_ports; i++ ));
do
    old_port=$((first_port+i))
    new_port=$((old_port+8))
    sed -i "s/Port $old_port/Port $new_port/g" /etc/ssh/sshd_config
done

# Increment the first port number for the next time the script runs
first_port=$((first_port+8))

# Restart the SSH service to apply the changes
systemctl restart sshd
