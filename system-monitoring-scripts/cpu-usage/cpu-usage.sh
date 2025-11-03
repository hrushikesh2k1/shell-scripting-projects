#!/bin/bash
# cpu_usage.sh — Display CPU usage percentage

echo "====== CPU Usage ======"

top -bn1 | grep "Cpu(s)" | \
awk '{print "CPU Usage: " 100 - $8 "%"}'
