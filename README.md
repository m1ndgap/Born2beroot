### 1) What is a Virtual Machine (VM)?

Answer:
A VM is software that simulates the operation of a physical computer in a safe and controlled way.
It allows operating systems and applications to run in an isolated virtual environment, as if it were a physical computer, simulating real resources such as CPU, memory, storage, etc. In reality, everything is running on the hardware of another physical system (the host).

It is a software-based simulation of a physical computer system.
A VM is an isolated environment, separate from your main system. In it, we can run different operating systems, software, applications, and tests without affecting the main computer.

Notes:

⇒ When we create a VM in VirtualBox and install Debian on it, we are creating a virtual computer inside our real computer. Inside this VM, we create users, configure permissions, and manage the system just as if it were a real physical server, but with the advantage of being able to easily restart if something goes wrong.

⇒ VMs offer flexibility, allowing multiple operating systems to run simultaneously on a single physical computer. This makes development and application execution across different platforms easier, without requiring additional hardware. In addition, VMs can be easily created, copied, moved, and deleted.

### 2) How does a Virtual Machine (VM) work?

Answer:
A Virtual Machine works like a computer simulated by software inside another computer.
The hypervisor (VirtualBox) creates virtual resources (CPU, memory, disk, network) that are used by a guest operating system (Debian).
This system runs in an isolated and independent way, as if it were on real hardware, but all its operation is controlled by the hypervisor, which manages access to the physical computer’s resources (host) without directly interfering with it.

A VM works by virtually reproducing the hardware components of a physical computer: CPU, RAM, storage, and network interfaces, creating a virtualized environment that behaves like a physical computer.

Notes:
Main components of a VM:
Hypervisor (or virtual machine monitor):

Software responsible for creating, managing, controlling, and running virtual machines.

Allows VMs to use real hardware resources (CPU, memory, disk, etc.) safely and in a controlled way.

Hosted type:
Runs on top of an existing operating system, like a normal application (e.g., VirtualBox).

In the Born2beroot project, we use VirtualBox (a hosted-type hypervisor) to create a VM with Debian and simulate a real server in a controlled environment.

Virtualized Hardware:

Simulation of physical computer components inside the VM.

Although resources are provided by the host’s real hardware, the hypervisor creates virtual versions of these resources for the guest OS to use as if they were real.

Examples of virtualized resources:

Virtual CPU: The VM thinks it has one or more dedicated processors, but they are actually shared with the host.

Virtual RAM: The hypervisor allocates a portion of physical RAM to the VM.

Virtual hard disk (VHD/VDI): A file on the host simulates a physical hard disk inside the VM.

Virtual network card: Allows the VM to access the internet and communicate with other machines (including the host), as if it had its own network interface.

These resources are simulated and shared with the physical host.
The VM’s isolated environment ensures that operations inside it do not affect the host system and vice versa, preventing the VM from using more resources than allocated.

Guest Operating System (Guest OS):

The operating system that runs inside the VM, as if installed on a real physical computer.

It behaves exactly as if it were running directly on physical hardware.

Guest OS responsibilities:

Manages users, files, and permissions inside the VM.

Communicates with virtual hardware (managed by the hypervisor).

In the Born2beroot project, Debian is the guest OS installed in the VM, where we configure users, groups, sudo, UFW, SSH, cron jobs, and other system administration features.

⇒ “Isolated environment” means that everything happening inside the VM is confined to it and does not affect the host system.

The VM has its own OS.

It has its own users, files, permissions, firewall, and services.

If the VM is compromised (e.g., virus or misconfiguration), the host is not affected.

The VM communicates only with virtual hardware simulated by the hypervisor.

### 3) Choice of Operating System (Rocky vs Debian)
### 3.1) Differences between Rocky and Debian

Answer:
Debian is an independent, community-driven Linux distribution known for stability, flexibility, and freedom of configuration. It supports many architectures and can be used for servers and desktops. It uses .deb packages and the APT package manager.

Rocky Linux is based on Red Hat Enterprise Linux (RHEL) and aimed at enterprise environments.
It focuses on long-term stability, security, and enterprise compatibility.
It uses .rpm packages and DNF/YUM package managers.

Unlike Debian, Rocky follows a more standardized and controlled structure, ideal for companies but with less customization freedom for regular users.

### 3.2) Why I chose Debian for the Born2beroot project

Answer:
I chose Debian because it is stable, secure, and highly customizable, making it ideal for learning Linux system administration fundamentals such as permission management, services, users, and security policies.

Additionally, it is lightweight, supports a wide range of free packages, and makes it easy to build a Linux server from scratch, which is exactly what Born2beroot requires.

### 4) What is the purpose of a VM?

Answer:
The purpose of a VM is to simulate a complete system inside another one, allowing an operating system to run in an isolated, secure, and independent way from the host system.

In the Born2beroot project, we use the VM to create a Linux server (Debian) where we configure and manage users, permissions, and services without affecting the real computer.

VMs allow us to test configurations, develop and administer systems, and run multiple environments on the same physical hardware without impacting the host.

### 5) Difference between aptitude and apt, and what is AppArmor
### 5.1) Difference between aptitude and apt

Answer:
Both use the APT (Advanced Package Tool) system to manage packages on Debian, but with different approaches:

apt: Lower-level package manager, ideal for quick commands and scripts. It has simple dependency resolution and limited conflict-handling suggestions.

aptitude: Higher-level package manager with an interactive interface and more advanced conflict resolution, offering multiple possible solutions automatically.

Notes:
Both manage .deb packages and rely on APT internally. APT does the real work; apt and aptitude are tools built on top of it.

### 5.2) What is AppArmor?

Answer:
AppArmor is a Linux kernel security module that restricts what each application can do, even with root permissions.
It works through security profiles that limit access to files and system resources to only what is explicitly allowed.

It adds an extra layer of protection, containing damage if an application is compromised and reducing the impact of vulnerabilities or unexpected behavior.

### 6. What is LVM and why did you use it?

Answer:
LVM (Logical Volume Manager) is a storage management system that allows flexible management of disk space.

Instead of fixed partitions, LVM introduces:

Physical Volumes (PV) → actual disks or partitions

Volume Groups (VG) → pools of storage made from PVs

Logical Volumes (LV) → virtual partitions created from a VG

I used LVM because it allows:

Resizing partitions without reinstalling the OS

Easier disk management

Better flexibility if disk space needs change in the future

### 7. What partitions did you create and why?

Answer:
I created separate partitions for critical directories to improve security and stability:

/ → root filesystem
/boot → bootloader and kernel
/home → user files
/var → logs and variable data
/tmp → temporary files
/srv → service data (if used)
/var/log → system logs
/var/tmp → persistent temporary files

Separating these partitions limits damage if one fills up and improves security isolation.

### 8. Why is /boot not under LVM?

Answer:
The bootloader (GRUB) must access the kernel before LVM is fully initialized.
Keeping /boot outside LVM ensures the system can boot correctly without dependency issues.

### 9. What is SSH and why is it important?

Answer:
SSH (Secure Shell) is a protocol that allows secure remote access to a machine.

It provides:

Encrypted communication

Secure authentication

Protection against eavesdropping

It is important because it allows administrators to manage servers remotely in a secure way.

### 10. What SSH configurations did you change?

Answer:
I modified the SSH configuration to improve security:

Changed the default port from 22 to another port

Disabled root login via SSH

Allowed only specific users to connect

These changes reduce exposure to brute-force attacks.

### 11. What is sudo and why do we use it?

Answer:
sudo allows a permitted user to execute commands as another user (usually root).

It is used to:

Avoid logging in as root

Track administrative actions

Limit privileges per user

This improves system security and accountability.

### 12. What sudo rules did you configure?

Answer:
I configured sudo to:

Require authentication

Limit commands to authorized users

Log sudo actions

Prevent running sudo without a password

Disable dangerous environment inheritance

This ensures controlled privilege escalation.

### 13. What is UFW and why did you use it?

Answer:
UFW (Uncomplicated Firewall) is a firewall management tool.

I used it to:

Allow only necessary ports (SSH)

Block all other incoming connections by default

This reduces the attack surface of the system.

### 14. How did you verify the firewall is working?

Answer:
I checked firewall status using:

sudo ufw status


I also confirmed that only the SSH port is allowed.

### 15. What are the password policy rules you implemented?

Answer:
I configured strong password policies using PAM:

Minimum password length

Uppercase and lowercase characters required

Numbers and special characters required

Password expiration

Password reuse prevention

This protects against brute-force and weak-password attacks.

### 16. What is a cron job?

Answer:
A cron job is a scheduled task that runs automatically at specific intervals.

It is managed by the cron daemon and configured using crontab.

### 17. What monitoring script did you create and what does it do?

Answer:
I created a monitoring script that displays system information such as:

CPU usage

Memory usage

Disk usage

Number of logged-in users

Network information

Last boot time

The script runs automatically every 10 minutes using cron.

### 18. How did you ensure the script runs periodically?

Answer:
I added a cron entry:

crontab -e


Configured it to run every 10 minutes.

### 19. Why is this project important?

Answer:
This project teaches:

Linux system administration

Security best practices

Disk and user management

Automation with scripts

Server hardening fundamentals

These are essential skills for real-world system administration.

### 20. What is PAM and why is it important?

Answer:
PAM (Pluggable Authentication Modules) is a framework that manages authentication on Linux systems.

It controls:

User authentication

Password policies

Account restrictions

PAM allows system administrators to enforce security rules without changing application code.

### 21. What PAM modules did you configure?

Answer:
I configured:

pam_pwquality.so → password strength enforcement

pam_unix.so → standard UNIX authentication

These modules enforce strong password rules and prevent weak credentials.

### 22. What is the difference between authentication and authorization?

Answer:

Authentication verifies who the user is (password, key).

Authorization determines what the user is allowed to do.

Authentication happens first; authorization follows.

### 23. What is SELinux or AppArmor? Which one did you use?

Answer:
SELinux and AppArmor are Mandatory Access Control (MAC) systems.

SELinux uses security contexts

AppArmor uses profile-based rules

In Debian, AppArmor is enabled by default and restricts program capabilities to reduce damage from compromised services.

### 24. How can you check if AppArmor is running?

Answer:

sudo aa-status


This command shows loaded profiles and their enforcement status.

### 25. What is a daemon?

Answer:
A daemon is a background process that runs without user interaction.

Examples include:

sshd

cron

ufw

Daemons usually start at boot and provide system services.

### 26. What is systemd?

Answer:
systemd is the init system used by Debian.

It:

Starts system services

Manages daemons

Handles logging and boot order

It replaces older init systems like SysVinit.

### 27. How do you check running services?

Answer:

systemctl status
systemctl list-units --type=service


These commands show active and inactive services.

### 28. What is journald?

Answer:
journald is the logging component of systemd.

It collects:

Kernel logs

Service logs

Authentication logs

Logs can be viewed using:

journalctl

### 29. Why is time synchronization important?

Answer:
Time synchronization ensures:

Correct log timestamps

Reliable cron jobs

Proper certificate validation

Without it, logs and security checks may be unreliable.

### 30. What service handles time synchronization?

Answer:
systemd-timesyncd synchronizes system time with NTP servers.

Check status with:

timedatectl status

### 31. What is a kernel?

Answer:
The kernel is the core of the operating system.

It manages:

Hardware communication

Memory

CPU scheduling

Process management

All programs interact with hardware through the kernel.

### 32. What is the difference between user space and kernel space?

Answer:

Kernel space: where the kernel runs with full hardware access

User space: where applications run with restricted access

This separation improves system stability and security.

### 33. What is a file descriptor?

Answer:
A file descriptor is an integer that represents an open file or I/O stream.

Common descriptors:

0 → stdin

1 → stdout

2 → stderr

### 34. What does /etc/passwd contain?

Answer:
/etc/passwd contains user account information:

Username

User ID (UID)

Home directory

Default shell

Passwords are stored securely elsewhere.

### 35. What does /etc/shadow contain?

Answer:
/etc/shadow stores encrypted passwords and password policies.

It is readable only by root for security reasons.

### 36. What is a symbolic link?

Answer:
A symbolic link is a pointer to another file or directory.

Unlike hard links, it can point to different filesystems and directories.

### 37. What is the difference between hard and soft links?

Answer:

Hard link: points directly to inode data

Soft (symbolic) link: points to a file path

Soft links break if the target is removed; hard links do not.

### 38. What happens when you reboot the system?

Answer:

BIOS/UEFI initializes hardware

Bootloader (GRUB) loads the kernel

Kernel initializes devices

systemd starts services

Login prompt appears

### 39. How do you check disk usage?

Answer:

df -h
du -sh


These commands show filesystem and directory usage.

### 40. How do you safely shut down the system?

Answer:

sudo shutdown now
sudo poweroff


These commands ensure services stop correctly before powering off.

### 41. What is GRUB?

Answer:
GRUB (GRand Unified Bootloader) is the bootloader used to load the Linux kernel into memory.

It allows:

Selecting which OS to boot

Passing parameters to the kernel

Recovering the system if boot fails

### 42. Why is GRUB important?

Answer:
Without GRUB, the system cannot start the operating system.
It bridges firmware (BIOS/UEFI) and the Linux kernel.

### 43. What is the purpose of swap?

Answer:
Swap is disk space used as overflow memory when RAM is full.

It helps:

Prevent system crashes

Allow more processes to run

Handle memory spikes

Swap is slower than RAM but improves stability.

### 44. Did you create a swap partition or swap file?

Answer:
I created a swap (partition / file) to extend available memory and prevent out-of-memory situations.

(Evaluator accepts either — answer according to your setup.)

### 45. What is a filesystem?

Answer:
A filesystem organizes how data is stored and retrieved on a disk.

It defines:

File structure

Permissions

Metadata

### 46. Which filesystem did you use and why?

Answer:
I used ext4 because it is:

Stable

Widely supported

Efficient for Linux systems

Reliable for journaling

### 47. What is journaling in a filesystem?

Answer:
Journaling records changes before applying them.

If the system crashes, the filesystem can recover quickly and avoid corruption.

### 48. What is /proc?

Answer:
/proc is a virtual filesystem that provides real-time information about:

Processes

Kernel state

Hardware

Files here do not exist on disk.

### 49. What is /sys?

Answer:
/sys exposes kernel objects and hardware information.

It allows interaction between user space and kernel space.

### 50. What is /dev?

Answer:
/dev contains device files representing hardware components such as:

Disks

Terminals

USB devices

### 51. What is a process?

Answer:
A process is a running instance of a program.

Each process has:

A PID

Memory allocation

Execution state

### 52. What is a PID?

Answer:
A PID (Process ID) is a unique number assigned to each running process.

### 53. How do you view running processes?

Answer:

ps aux
top
htop


These commands display process activity.

### 54. What is a signal?

Answer:
A signal is a notification sent to a process to control its behavior.

Examples:

SIGTERM → request termination

SIGKILL → force termination

### 55. How do you kill a process?

Answer:

kill PID
kill -9 PID


-9 forces termination if the process does not respond.

### 56. What is networking in Linux?

Answer:
Linux networking manages communication between systems using protocols such as TCP/IP.

### 57. What is an IP address?

Answer:
An IP address uniquely identifies a device on a network.

It can be:

IPv4

IPv6

### 58. How do you check network configuration?

Answer:

ip a
ip route

### 59. What is localhost?

Answer:
localhost refers to the local machine itself, usually mapped to 127.0.0.1.

### 60. What is a port?

Answer:
A port identifies a specific service or application on a system.

Example:

SSH → port 22 (or custom)

### 61. What is DNS?

Answer:
DNS (Domain Name System) translates domain names into IP addresses.

### 62. What happens when you type a command in the terminal?

Answer:

Shell parses the command

Searches PATH for executable

Forks a process

Kernel executes the program

Output is returned to terminal

### 63. What is a shell?

Answer:
A shell is a command-line interpreter that allows users to interact with the operating system.

Example: bash

### 64. What is the difference between bash and sh?

Answer:

sh is a basic shell

bash adds scripting features, history, and completion

### 65. What did you personally learn from Born2beroot?

Answer:
I learned:

Linux system administration

Disk and user management

Security hardening

Automation with scripts

How an OS boots and runs internally

This project built a strong foundation for working with real servers.


Open a terminal and run the command:

# lsblk

What is lsblk?
The lsblk command displays information about all available block devices (disks), such as their size and 
mount points, in a tree format.

1) Boot - Enter Encrypted Disk Password

When you start the virtual machine, it will prompt you to enter the encrypted disk password.
This is the password you set during the installation of Debian. Enter the password to unlock the disk and boot
into the system.

2) Boot -Enter User Credentials

After entering the encrypted disk password, you will be prompted to enter your user credentials.
Enter your username and password to log in to the system.
You will be logged in as the user you created during the installation of Debian.
You will see a bash prompt indicating that you are logged in.
You can now start configuring your system.

In my case the user is rmedeiro 

3) Installing Sudo

Switch to Root User and Install Sudo: Begin by switching to the root user to install sudo. 
Enter su - in the bash prompt and provide the root password. Additionally, install VIM to configure some files. 

2.1) Installing sudo

2.1.1) Switch to root and its environment via su -.

# su -

Password:

*----------------------------------------------------------------------*
| su - : Switch/Log in to root user.                                   |
| su : Switch/Log in to root user without loading the root environment.|
*----------------------------------------------------------------------*

2.1.2) Getting system updates 

# apt-get update -y
# apt-get upgrade -y

*----------------------------------------------------------------------------------------*
| apt-get update -y: Fetching system updates, -y to automate all permission acceptances. |
| apt-get upgrade -y: Upgrading all packages, -y to automate all permission acceptances. |
*----------------------------------------------------------------------------------------*

2.1.3) Install sudo. 

# apt-get install sudo

*-------------------------------------------------------------------------------------------*
| apt-get install sudo: Installing the sudo package to allow users to run commands as root. |
*-------------------------------------------------------------------------------------------*

2.1.4) Rebbot the machine to apply changes:

# sudo reboot

2.1.5) Verify whether sudo was successfully installed

After the reboot, log in as the root user again:

# su-

and check if sudo was installed:

# dpkg -l | grep sudo

*-------------------------------------------------------------------------------------------*
| dpkg -l | grep sudo: Checking if the sudo package is installed.                           |
| dpkg -l: List all installed packages, grep sudo: Filter the list to show only sudo.       |
*-------------------------------------------------------------------------------------------*

2.1.6) CHeck sudo version: 

# sudo -V


2.2) Configuring User and Groups

2.2.1) Adding User to sudo Group 

Create a new user named <youruser> [rmedeiro]

# sudo adduser <youruser>

If already exists, this might give an error if the user was alerady created during Debian installation.

2.2.2) Add the user to the sudo group:

# sudo adduser <youruser> sudo

Alternatively, add user to sudo group via:

# usermod -aG sudo <youruser>

*-------------------------------------------------------------------------------------------------*                   |
| usermod -aG sudo <youruser>: Adds the user <youruser> to the "sudo" group while keeping their   |
|                              existing group memberships intact.                                 | 
|                              Instead of granting individual permissions to each user, groups    | 
|                              act as containers, categorizing users based on their roles,        |  
|                              responsibilities, or access levels. usermod modifies user accounts.|
|																								  |
| 								-a: Append the user to the group.								  |
| 								-G: Specify the group to which the user should be added.          |
*-------------------------------------------------------------------------------------------------*

2.2.3) Verify if the user was successfully added to sudo group:

# getent group sudo

2.2.4) Create a new group called user42:

# sudo addgroup user42   or   # sudo groupadd user42

2.2.5) Add <youruser> to the "user42" group:

# sudo adduser <youruser> user42   or   # sudo usermod -aG user42 <youruser>

2.2.6) Check if the group user42 was created correctly:

# getent group user42

2.2.7) Reboot the system to apply changes:

# sudo reboot

2.2.8) Verify sudopowers via: 

# sudo -v

NOTE: To delete a certain group we use:  # sudo delgroup <groupname> 
NOTE: To delete a certain user we use:  # sudo deluser <username>
NOTE: To see which groups the user account belongs to we use: # groups <username>


3) Installing Git and Vim: 

# sudo apt-get install vim -y
# sudo apt-get install git -y


4) Installing and Configuring SSH

SSH stands for "Secure Shell."
The SSH protocol was designed as a secure alternative to unsecured remote shell protocols. 
It utilizes a client-server, in which clients and servers communicate via a secure channel.
This is an important step for remote management and secure communication between computers 
over an unsecured network. SSH provides a secure way to access and control your virtual 
machine remotely.

4.1) Check for available updates:

# sudo apt-get update

3.2) Install OpenSSH Server:

# sudo apt-get install openssh-server

It will install the component (openssh-server) that is responsible for allowing secure remote 
access to your machine.

Press Y to confirm the installation when prompted.

3.3) Verify whether openssh-server was successfully installed via dpkg -l | grep ssh.

# dpkg -l | grep ssh

3.4) Check SSH Service Status - check if the package was successfully installed and the SSH service is running:

# sudo service ssh status   or    # sudo systemctl status ssh

Systemctl status shows detailed information about whether a service is running, its current state, and recent 
log messages related to the service. Here, we are checking the status of the SSH service on the system.

This should return a status showing that the SSH service is active and running.

3.5) Edit SSH Configuration to customize your SSH settings:

You need root privileges to edit the SSH configuration file. Switch to root using -> su. 
Then, open the SSH configuration file using a text editor like vim:

# sudo vim /etc/ssh/sshd_config

Editing the ssh server configuration file. sshd for SSH daemon is a background process or service that runs on
a server to handle incoming SSH connections. It’s responsible for handling incoming SSH connections, and its 
behavior is determined by the settings in this configuration file. Some of the configurations include Port Number,
PermitRootLogin, PasswordAuthentication, PubkeyAuthentication and AllowUsers or AllowGroups.

3.6) Uncomment and Update Configuration Lines

The # symbol indicates that a line is commented out. Uncomment and update the following lines:

-> Change #Port 22 to Port 4242

-> Change #PermitRootLogin prohibit-password to PermitRootLogin no

Save the changes and exit the file.

/* 
3.8) Edit the SSH Client Configuration File:

# sudo vim /etc/ssh/ssh_config

Update the following line:

    Change #Port 22 to Port 4242
*/

3.9) Restart the SSH Service To Apply the Changes:

# sudo systemctl restart ssh    or    # sudo service ssh restart

And then check SSH status again via:

# sudo service ssh status     or      # systemctl status ssh


4) Connecting via SSH:

4.1) To connect via SSH, first shut down the virtual machine and go to its settings.

	Configure Network Settings

    Open VirtualBox and select the virtual machine you want to connect to, in this case, Born2beroot.
    Go to Settings
    Go to Network
    Go to Adapter 1
    Change NAT to Bridged Adapter. 

This will allow the VM to use the same network as the host machine.

4.3) # sudo reboot to reboot the VM

4.4) Get VirtualMachine IP (in the VM)

# hostname -I

4.5) Open a terminal out of VM and connect to the VM:

# ssh <username>@<VirtualMachine_IP> -p 4242

Note: To close the connection:  # exit     or     # logout


5) Configuring sudo policies (sudoers file) and log (User privileges)

5.1) Create a directory for the sudo log file:

# su
# cd ~/../
# cd /var/log
# mkdir sudo

NOTE: Till here, its the same as creating ->  sudo mkdir /var/log/sudo

NOTE: cd /var/log - Access the location where log files are stored, providing information 
      about system events, services, processes.

5.2) Create the sudo log file:

NOTE: Each action using sudo has to be archived, both inputs and outputs. To do so, create a 
      folder (name it sudo for clarity), then create a file.log, and save the path to that file: 

# cd sudo
# touch sudo.log
# cd ~/../

5.4) Configuring the Sudoers Group

To open to Sudoers file.

# sudo visudo   or   # sudo vim /etc/sudoers

Access the sudoers file, that is responsible for defining the rules and permissions that determine 
which users or groups are allowed to execute commands with elevated privileges using the sudo command.

5.5) Edit your sudoers file by adding the rest of the defaults so it should read like this:

Defaults  secure_path  (add :/snap/bin in the end of the path)
Defaults  badpass_message="Wrong Password!"
Defaults  passwd_tries=3
Defaults  iolog_dir="/var/log/sudo"
Defaults  logfile="/var/log/sudo/sudo.log"
Defaults  log_input
Defaults  log_output
Defaults  requiretty

go to the line where there is root	ALL=(ALL:ALL) ALL
put bellow it <username>	ALL=(ALL:ALL) ALL

Save and exit the file.


6) Configuring Password Policy - Setting Up A Strong Password Policy

6.1) Password Max and Min Days 

6.1.1) Configure password age policy via:

# sudo vi /etc/login.defs

Go to line 165 or search for PASS_MAX_DAYS and set: 

PASS_MAX_DAYS 99999 to 30
PASS_MIN_DAYS 0 to 2

To update the password policy run the following command: 

# sudo chage -M 30 <username>   (and # chage -M 30 <username> for root)
# sudo chage -m 2 <username>    (and # chage -m 2 <username> for root)

To confirm that the existing users receive the changes, run the following command:

# sudo chage -l <username>  (and # chage -l <username> for root)

NOTE: REMEMBER TO EXECUTE BOTH COMANDS FOR ROOT AS WELL
NOTE: You can use passwd <username> to change the password of a user. 

6.2) Password Quality - Password Strength

6.2.1) Install PAM package for password quality checking

We are gonna install the Pluggable Authentication Module (PAM) package, which is a framework that allows
the system to enforce authentication policies. It offers features to enforce password policies by configuring
the PAM configuration files on your system.

# sudo apt-get install libpam-pwquality

NOTE: We can verify if the pam package was installed via: # dpkg -l | grep libpam-pwquality

6.2.2) Configure and edit the common-password file

# sudo vim /etc/pam.d/common-password

On the per-package modules section after: "25 password    requisite   pam_pwquality.so retry=3" add:

minlen=10 ucredit=-1 dcredit=-1 lcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root

Save and exit the file. 

Then, # sudo reboot, to reboot the VM and apply the changes.

NOTE: To Test the Password Policy

# sudo passwd <username>
# sudo passwd root


7) Installing & Configuring UFW

UFW is a firewall that uses the command line for setting up iptables with a small number of easy commands.

4.1) Install the UFW package by running the following command and typing y when prompted:

# sudo apt-get install ufw

4.2) Enable UFW

Start UFW using the command below. It should display a message indicating that the firewall is active:

# sudo ufw enable

NOTE: in case of turn it off we use: # sudo ufw disable
NOTE: To show status of ufw and allowed ports we use: sudo ufw status numbered
NOTE: To delete a rule we use: # sudo ufw delete <rule number>

4.3) Allow Connections on Port 4242

Configure the firewall to accept connections on port 4242:

# sudo ufw allow 4242

4.4) Check UFW Status

Verify that everything is configured correctly by checking the status of the firewall:

# sudo ufw status
