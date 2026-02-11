#!/bin/bash
set -e

FTP_USER="${FTP_USER:-ftpuser}"
FTP_PASS="${FTP_PASS:-ftppass}"

# Create virtual user database
echo -e "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.txt
db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db

# Create user home directory
mkdir -p "/home/vsftpd/${FTP_USER}"
chown -R ftp:ftp /home/vsftpd

echo "==> FTP server starting"
echo "    User: ${FTP_USER}"
echo "    Home: /home/vsftpd/${FTP_USER}"

# Start vsftpd
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
