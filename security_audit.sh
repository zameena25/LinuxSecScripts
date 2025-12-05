#Linux Security Audit Script
#Purpose : This will scn Linux system for common security risks and generates a report about them.

#Setting report files with date 
REPORT="security_audit_$(date).txt"  #creating a filename with the current dat to store the audit report.
echo "Linux Security Audit Report - $(date)">$REPORT #this coe writes the report header with the current date, overwriting any existing files.
echo "===========================================" >> $REPORT #this will add a seperator line to the report.
echo "Users with empty passowrds: ">> $REPORT #this will print a section header for the users without the passwords.
awk -f: '($2==""){print $1}' /etc/shadow 2>/dev/null >> $REPORT #this will lists usernames with empty passwords from /etc/shadow and appends them to the report.
echo -e "\nWorld-writable files: " >> $REPORT #this will print a section header for files writable by everyone with a newline bfore it.
find / -type f -perm -0002 2 > /dev/null >> $REPORT #this code will help to find all world-writable files on the system and adds them to the report.
echo -e "\nUnused users (nologin): " >> $REPORT #this will print a section header for users who cannot log in.
awk -F: '($7=="/usr/sbin/nologin" || $7=="/bin/false"){print $1}' /etc/passwd >> $REPORT #this will list usernames with shells set to nologin or false and appends them to the report.
echo -e "\nOpen ports and listening services: " >> $REPORT #this will print a section header for network listening ports.
ss -tuln >> $REPORT #will list all open TCP/UDP listening ports and appends them to the report.
echo -e "n\Security audit completed. Review "$REPORT" for details." #will print a message indicating the audit is finished and where to find the report.
