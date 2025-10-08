#!/bin/bash
# Cron Job Setup Example

echo "=== Cron Job Setup Examples ==="
echo "Common automated task examples:"
echo "1. Daily user backup at 2 AM:"
echo "   0 2 * * * /home/$(whoami)/BRG-ISEA-Project/scripts/user_management_auto.sh backup"

echo "2. Hourly system resource check:"
echo "   0 * * * * /home/$(whoami)/BRG-ISEA-Project/scripts/user_management_auto.sh check"

echo "3. Weekly cleanup every Sunday at 3 AM:"
echo "   0 3 * * 0 /home/$(whoami)/BRG-ISEA-Project/scripts/user_management_auto.sh cleanup"

echo ""
echo "To add cron jobs, use: crontab -e"
echo "Then add one of the lines above"
