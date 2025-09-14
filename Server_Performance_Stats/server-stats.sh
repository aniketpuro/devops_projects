#!/bin/bash

# server-stats.sh
# A script to display basic server performance statistics.
# This script is designed for Linux systems and provides a quick overview
# of CPU, memory, disk usage, and top processes.

# --- Configuration ---
# Set colors for the output for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Helper Functions ---

# Prints a formatted section header.
# Argument 1: Header title text.
print_header() {
    printf "\n${YELLOW}========== %s ==========${NC}\n" "$1"
}

# --- Main Script Logic ---

# Clear the screen for a clean report
clear

echo "========================================================================"
echo "               Server Performance & System Information"
echo "========================================================================"
echo "Report generated on: $(date)"

# --- System Information (Stretch Goals) ---
print_header "System Information"

# OS Version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo -e "Operating System : ${GREEN}$PRETTY_NAME${NC}"
else
    echo -e "Operating System : ${RED}Could not determine OS version.${NC}"
fi

# Uptime and Load Average
echo -e "System Uptime    : ${GREEN}$(uptime -p)${NC}"
echo -e "Load Average     : ${GREEN}$(uptime | awk -F'load average: ' '{print $2}')${NC}"

# Currently Logged-in Users
echo -e "Logged-in Users  : ${GREEN}$(who | wc -l)${NC}"

# --- CPU Usage ---
print_header "CPU Usage Statistics"
# Calculate total CPU usage. It gets the idle percentage from 'top' and subtracts it from 100.
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo -e "Total CPU Usage  : ${GREEN}${CPU_USAGE}%%${NC}"

# --- Memory Usage ---
print_header "Memory Usage (RAM)"
# Use 'free -m' for calculations and 'free -h' for display
MEM_INFO_MB=$(free -m | grep Mem)
TOTAL_MEM_MB=$(echo "$MEM_INFO_MB" | awk '{print $2}')
USED_MEM_MB=$(echo "$MEM_INFO_MB" | awk '{print $3}')
PERCENT_USED=$(echo "scale=2; $USED_MEM_MB * 100 / $TOTAL_MEM_MB" | bc)

# Get human-readable output
MEM_INFO_H=$(free -h | grep Mem)
TOTAL_MEM_H=$(echo "$MEM_INFO_H" | awk '{print $2}')
USED_MEM_H=$(echo "$MEM_INFO_H" | awk '{print $3}')
FREE_MEM_H=$(echo "$MEM_INFO_H" | awk '{print $4}')

echo -e "Total Memory     : ${GREEN}${TOTAL_MEM_H}${NC}"
echo -e "Used Memory      : ${GREEN}${USED_MEM_H} (${RED}${PERCENT_USED}%%${NC})"
echo -e "Free Memory      : ${GREEN}${FREE_MEM_H}${NC}"


# --- Disk Usage ---
print_header "Disk Usage (Mounted Filesystems)"
# Display disk usage in a table format, ignoring temp and loop devices
df -h | grep -vE '^Filesystem|tmpfs|cdrom|loop' | awk '
{
    usage_color = ($5+0 > 85) ? "\033[0;31m" : "\033[0;32m"; # Red if usage > 85%, else Green
    no_color = "\033[0m";
    printf "%-25s | Total: %-8s | Used: %-8s | Free: %-8s | Usage: %s%s%s\n", $1, $2, $3, $4, usage_color, $5, no_color;
}'


# --- Top 5 Processes by CPU ---
print_header "Top 5 Processes by CPU Usage"
# Use ps to list processes sorted by CPU usage, then take the top 5.
ps -eo pid,user,%cpu,cmd --sort=-%cpu | head -n 6


# --- Top 5 Processes by Memory ---
print_header "Top 5 Processes by Memory Usage"
# Use ps to list processes sorted by memory usage, then take the top 5.
ps -eo pid,user,%mem,cmd --sort=-%mem | head -n 6


# --- Failed Login Attempts (Stretch Goal) ---
print_header "Security Information"
# Check common log file locations for failed login attempts.
AUTH_LOG="/var/log/auth.log" # Debian/Ubuntu
SECURE_LOG="/var/log/secure" # RHEL/CentOS/Fedora

if [ -f "$AUTH_LOG" ]; then
    FAILED_COUNT=$(grep -c "Failed password" "$AUTH_LOG")
    echo "Failed login attempts (from $AUTH_LOG): ${RED}${FAILED_COUNT}${NC}"
elif [ -f "$SECURE_LOG" ]; then
    FAILED_COUNT=$(grep -c "Failed password" "$SECURE_LOG")
    echo "Failed login attempts (from $SECURE_LOG): ${RED}${FAILED_COUNT}${NC}"
else
    echo "Could not find auth log files to check for failed logins."
fi

echo
echo "========================================================================"
echo "                         Report Finished"
echo "========================================================================"
echo

