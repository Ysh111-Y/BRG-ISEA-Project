#!/bin/bash
# Automated User Management Script
# Author: Shaohuiyang
# Function: Batch user management and system maintenance

LOG_FILE="/home/$(whoami)/BRG-ISEA-Project/logs/user_management.log"
BACKUP_DIR="/home/$(whoami)/BRG-ISEA-Project/backups"

# Create log directory
mkdir -p $(dirname "$LOG_FILE")
mkdir -p "$BACKUP_DIR"

# Logging function
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}
# Backup user information
backup_user_info() {
    log_message "Starting user information backup"
    
    local backup_file="$BACKUP_DIR/user_backup_$(date +%Y%m%d_%H%M%S).txt"
    
    echo "=== System User Backup Report ===" > "$backup_file"
    echo "Generated: $(date)" >> "$backup_file"
    echo "=================================" >> "$backup_file"
# Backup user list
    echo "System Users:" >> "$backup_file"
    cut -d: -f1 /etc/passwd | sort >> "$backup_file"
    
    # Backup group information
    echo -e "\nSystem Groups:" >> "$backup_file"
    cut -d: -f1 /etc/group | sort >> "$backup_file"
    
    log_message "User information backed up to: $backup_file"
    echo "Backup completed: $backup_file"
}
# System resource check
check_system_resources() {
    log_message "Performing system resource check"
    
    echo "=== System Resource Status ==="
    echo "Memory Usage:"
    free -h | awk 'NR==1 || NR==2'
    
    echo -e "\nDisk Space:"
    df -h | awk 'NR==1 || /\/$/'
    
    echo -e "\nCPU Load:"
    uptime | awk -F'load average:' '{print $2}'
# Check critical services
    echo -e "\nService Status:"
    local services=("apache2" "ssh")
    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "✅ $service: Running"
        else
            echo "❌ $service: Not running"
        fi
    done
}
# File cleanup function
cleanup_old_files() {
    log_message "Starting temporary file cleanup"
    
    echo "Cleaning temporary files older than 7 days..."
    find /tmp -type f -mtime +7 -delete 2>/dev/null | wc -l | \
        xargs echo "Files cleaned:"
    
    echo "Cleaning log files..."
    find /var/log -name "*.log.?" -type f -mtime +30 -delete 2>/dev/null | wc -l | \
        xargs echo "Log files cleaned:"
}
# Main menu
main() {
    echo "=========================================="
    echo "    Linux Server Automation Script"
    echo "=========================================="
    
    case "$1" in
        "backup")
            backup_user_info
            ;;
        "check")
            check_system_resources
            ;;
        "cleanup")
            cleanup_old_files
            ;;
        "all")
            backup_user_info
            check_system_resources
            cleanup_old_files
            ;;
        *)
echo "Usage: $0 [backup|check|cleanup|all]"
            echo "  backup  - Backup user information"
            echo "  check   - Check system resources"
            echo "  cleanup - Clean temporary files"
            echo "  all     - Perform all operations"
            ;;
    esac
    
    log_message "Script execution completed"
}

# Execute main function
main "$@"
