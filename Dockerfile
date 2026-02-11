FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        vsftpd \
        db-util \
    && rm -rf /var/lib/apt/lists/*

# Create config directory and ftp user home
RUN mkdir -p /etc/vsftpd /home/vsftpd /var/run/vsftpd/empty

# Copy config files
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY vsftpd_virtual /etc/pam.d/vsftpd
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# FTP command port + passive range
EXPOSE 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
