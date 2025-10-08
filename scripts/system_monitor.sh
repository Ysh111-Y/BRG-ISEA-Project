#!/bin/bash
# BRG-ISEA System Monitor Script
# Author: Student
echo "=== System Health Report ==="
echo "Generated on: $(date)"
echo ""
# System information
echo "--- System Info ---"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Kernel: $(uname -r)"
echo ""
# Memory usage
echo "--- Memory Usage ---"
free -h
echo ""
# Disk usage
echo "--- Disk Usage ---"
df -h | grep -E '(/dev/sd|/dev/vd|Filesystem)'
echo ""
# Top processes by CPU
echo "--- Top Processes by CPU ---"
ps aux --sort=-%cpu | head -6
echo ""
# Network connections
echo "--- Active Network Connections ---"
ss -tuln | head -10
echo ""
# Log analysis using regex
echo "--- Recent Errors in Logs ---"
find /var/log -name "*.log" -type f -exec grep -E "(Error|ERROR|error|Failed|FAILED)" {} \; 2>/dev/null | head -5
echo "=== Report Complete ==="
