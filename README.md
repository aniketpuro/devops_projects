Of course\! The reason your "edit" and "preview" sections look the same is that you're missing some key **Markdown formatting**, especially for your section titles and code snippets.

The preview renderer doesn't have any special instructions to format your text differently from how you typed it.

-----

## The Problem

1.  **Headings:** You've correctly used `###` for the first title, but subsequent section titles like `Features`, `Prerequisites`, `Usage`, and `Sample Output` are just plain text. They need to be formatted as headings (e.g., using `##`).
2.  **Code Blocks:** The commands you listed under `Usage` are not wrapped in backticks (\`\`\`). Without them, Markdown treats them as regular text. The `Sample Output` section is correctly wrapped, but the commands before it are not.
3.  **Lists:** The `Features` section is a block of text. Turning it into a bulleted list would make it much more readable.

-----

## The Corrected Version

Here is the corrected version of your `README.md` file. Copy and paste this into your editor, and you will see a significant difference between the "edit" and "preview" views.

````markdown
# Welcome to the Server Performance Analysis Script!

This is a simple yet powerful Bash script for analyzing basic performance statistics on any Linux server. It provides a quick, color-coded overview of the most important system metrics, making it easy to get a snapshot of a server's health and performance.

This is a personal project to demonstrate shell scripting for DevOps tasks.

## Features

* **System Information:** OS version, uptime, and load average.
* **Resource Monitoring:** CPU, Memory, and Disk Usage with percentages and color-coding.
* **Top Process Analysis:** Instantly see the top 5 processes by CPU and Memory consumption.
* **Security Overview:** Check logged-in users and scan for failed login attempts.
* **Clean & Readable:** A beautifully formatted, easy-to-understand report.

## Prerequisites

* A Linux-based operating system.
* `bash` shell.
* Standard Linux command-line utilities (`top`, `free`, `df`, `ps`, etc.).

## Usage

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/aniketpuro/devops_projects.git](https://github.com/aniketpuro/devops_projects.git)
    ```

2.  **Navigate to the directory:**
    ```bash
    cd devops_projects
    ```

3.  **Make the script executable:**
    ```bash
    chmod +x server-stats.sh
    ```

4.  **Run the script:**
    ```bash
    sudo ./server-stats.sh
    ```

## Sample Output

Running the script will produce a clean, easy-to-read report directly in your terminal:

````

# \======================================================================== Server Performance & System Information

Report generated on: Sun Sep 14 18:05:00 IST 2025

\========== System Information ==========
Operating System : Ubuntu 22.04.5 LTS
System Uptime    : up 2 days, 4 hours, 15 minutes
Load Average     : 0.05, 0.15, 0.25
Logged-in Users  : 1

\========== CPU Usage Statistics ==========
Total CPU Usage  : 12.5%

\========== Memory Usage (RAM) ==========
Total Memory     : 7.8Gi
Used Memory      : 3.2Gi (41.00%)
Free Memory      : 4.6Gi

\========== Disk Usage (Mounted Filesystems) ==========
/dev/sda1                | Total: 98G     | Used: 45G      | Free: 53G      | Usage: 46%
/dev/sdb1                | Total: 1.8T    | Used: 1.7T     | Free: 100G     | Usage: 95%

\========== Top 5 Processes by CPU Usage ==========
PID USER      %CPU CMD
12345 www-data   5.2 /usr/sbin/apache2 -k start
1234 mysql      2.1 /usr/sbin/mysqld
9876 root       1.5 /usr/bin/python3 ./app.py
...

\========== Top 5 Processes by Memory Usage ==========
PID USER      %MEM CMD
1234 mysql     15.8 /usr/sbin/mysqld
12345 www-data   8.3 /usr/sbin/apache2 -k start
9876 root       4.1 /usr/bin/python3 ./app.py
...

\========== Security Information ==========
Failed login attempts (from /var/log/auth.log): 142

# \======================================================================== Report Finished

```
```
