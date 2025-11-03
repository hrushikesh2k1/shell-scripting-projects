# 🧠 Linux Commands for DevOps Engineers

A comprehensive guide to essential Linux commands every DevOps Engineer and SysAdmin uses daily.  
Includes real examples, sample outputs, and practical notes for day-to-day operations.

---

## 🧩 1️⃣ System Information Commands

### 🧠 `uname`
**Usage:**
```bash
uname -a
```
Description:
Shows system information like kernel name, version, and architecture.

Example Output:

Linux ubuntu-server 5.15.0-107-generic #118-Ubuntu SMP x86_64 GNU/Linux

---
🧠 hostnamectl
Usage:

```bash
hostnamectl
```
Description:
Displays system’s hostname, OS version, and kernel info.

Example Output:

Static hostname: devops-node
Operating System: Ubuntu 22.04.3 LTS
Kernel: Linux 5.15.0-107-generic
Architecture: x86-64

---
🧠 uptime
Usage:

bash
Copy code
uptime
Description:
Shows system uptime, logged-in users, and load averages.

Example Output:

bash
Copy code
14:32:21 up 3 days, 5:44, 2 users, load average: 0.32, 0.47, 0.51
🧠 lsb_release
Usage:

bash
Copy code
lsb_release -a
Description:
Displays Linux distribution details.

Example Output:

yaml
Copy code
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
🧠 whoami
Usage:

bash
Copy code
whoami
Description:
Shows the current logged-in user.

🧠 date
Usage:

bash
Copy code
date "+%Y-%m-%d %H:%M:%S"
Description:
Displays current date and time.

Pro Tip:
Use inside scripts for logging:
echo "Backup completed at $(date)" >> backup.log

🧩 2️⃣ System Monitoring & Resource Commands
🧠 top
Usage:

bash
Copy code
top
Description:
Shows real-time processes, CPU, and memory usage.

Pro Tip:
Press q to quit, k to kill a process, M to sort by memory.

🧠 htop
Usage:

bash
Copy code
htop
Description:
An improved version of top with colors and interactive navigation.

Pro Tip:
Use arrow keys to scroll, F9 to kill a process.

🧠 free
Usage:

bash
Copy code
free -h
Description:
Displays total, used, and free memory.

Example Output:

makefile
Copy code
              total        used        free
Mem:            15G         6.2G        8.1G
Swap:           2.0G        0.0G        2.0G
🧠 df
Usage:

bash
Copy code
df -h
Description:
Shows disk space usage in human-readable format.

🧠 du
Usage:

bash
Copy code
du -sh /var/log
Description:
Displays total size of a directory or file.

🧠 vmstat
Usage:

bash
Copy code
vmstat 1 5
Description:
Displays system performance (CPU, memory, I/O) every 1 second for 5 times.

🧠 iostat
Usage:

bash
Copy code
iostat -xz 1
Description:
Shows CPU and I/O statistics for performance troubleshooting.

🧩 3️⃣ File & Directory Management
🧠 ls
Usage:

bash
Copy code
ls -lh
Description:
Lists files with details in human-readable format.

🧠 pwd
Usage:

bash
Copy code
pwd
Description:
Prints the current working directory.

🧠 cd
Usage:

bash
Copy code
cd /etc
Description:
Changes directory.

🧠 mkdir / rmdir
Usage:

bash
Copy code
mkdir new_folder
rmdir old_folder
🧠 cp / mv / rm
Usage:

bash
Copy code
cp file1 /backup/
mv file1 /tmp/
rm file1
Pro Tip:
Use rm -rf folder/ carefully — it deletes everything recursively.

🧠 find
Usage:

bash
Copy code
find /var/log -name "*.log"
Description:
Search for files by name or pattern.

🧩 4️⃣ User & Permission Management
🧠 adduser / userdel
Usage:

bash
Copy code
sudo adduser devops
sudo userdel devops
🧠 passwd
Usage:

bash
Copy code
sudo passwd devops
Description:
Change or set user password.

🧠 id
Usage:

bash
Copy code
id devops
Description:
Displays UID, GID, and group info.

🧠 chmod
Usage:

bash
Copy code
chmod 755 script.sh
Description:
Change file permissions.

🧠 chown
Usage:

bash
Copy code
chown user:group file.txt
Description:
Change file ownership.

🧩 5️⃣ Process Management
🧠 ps
Usage:

bash
Copy code
ps -ef | grep nginx
Description:
Lists processes with details.

🧠 kill
Usage:

bash
Copy code
kill -9 <pid>
Description:
Forcefully stops a process.

🧠 systemctl
Usage:

bash
Copy code
sudo systemctl start nginx
sudo systemctl status nginx
sudo systemctl stop nginx
🧠 journalctl
Usage:

bash
Copy code
sudo journalctl -u nginx --since "2 hours ago"
Description:
Shows logs for a specific service.

🧩 6️⃣ Networking Commands
🧠 ip
Usage:

bash
Copy code
ip addr show
Description:
Displays network interfaces and IPs.

🧠 ping
Usage:

bash
Copy code
ping -c 4 google.com
🧠 curl
Usage:

bash
Copy code
curl -I https://example.com
Description:
Check HTTP response headers or API endpoints.

🧠 netstat
Usage:

bash
Copy code
netstat -tulnp
Description:
Lists open ports and listening services.

🧠 ss
Usage:

bash
Copy code
ss -tuln
Description:
Modern replacement for netstat.

🧠 traceroute
Usage:

bash
Copy code
traceroute google.com
Description:
Displays the network path packets take to a destination.

🧩 7️⃣ Disk & Storage Management
🧠 lsblk
Usage:

bash
Copy code
lsblk
Description:
Lists all block devices and mount points.

🧠 fdisk
Usage:

bash
Copy code
sudo fdisk -l
Description:
Displays disk partition details.

🧠 mount / umount
Usage:

bash
Copy code
sudo mount /dev/sdb1 /mnt/data
sudo umount /mnt/data
🧠 blkid
Usage:

bash
Copy code
sudo blkid
Description:
Shows UUIDs of disks (useful for /etc/fstab).

🧩 8️⃣ Log Management
🧠 tail
Usage:

bash
Copy code
tail -f /var/log/syslog
Description:
Monitors log files in real time.

🧠 grep
Usage:

bash
Copy code
grep "error" /var/log/syslog
Description:
Searches for keywords in files.

🧠 awk / sed
Usage:

bash
Copy code
awk '{print $1, $2}' /etc/passwd
sed 's/error/ERROR/g' logfile.log
Description:
Used for text processing and file manipulation.

🧩 9️⃣ Package Management
🧠 Debian / Ubuntu
bash
Copy code
sudo apt update
sudo apt install nginx
sudo apt remove nginx
🧠 CentOS / RHEL
bash
Copy code
sudo yum install nginx
sudo yum remove nginx
🧩 🔟 SSH, SCP & Rsync
🧠 ssh
bash
Copy code
ssh user@server_ip
🧠 scp
bash
Copy code
scp file.txt user@server_ip:/tmp/
🧠 rsync
bash
Copy code
rsync -avz /data/ user@server_ip:/backup/
🧩 11️⃣ Shell Scripting Basics
🧠 Variables
bash
Copy code
name="Hrushi"
echo "Hello $name"
🧠 If Condition
bash
Copy code
if [ $USER == "root" ]; then
  echo "You are root!"
else
  echo "You are not root!"
fi
🧠 For Loop
bash
Copy code
for i in {1..5}; do
  echo "Count: $i"
done
🧩 12️⃣ Useful Shortcuts & Tricks
Shortcut	Description
Ctrl + C	Stop current command
Ctrl + D	Logout/exit terminal
!!	Run previous command
!ssh	Run last command that started with “ssh”
history	Show recent commands
clear	Clear terminal
df -hT	Show disk type and usage

🧾 Author
Hrushi
DevOps Engineer & Cloud Enthusiast
