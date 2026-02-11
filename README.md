# FTP Docker Example

A lightweight, Dockerized FTP server using **vsftpd** with virtual user authentication.

## Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and Docker Compose installed

### Run the Server

```bash
docker compose up -d --build
```

The FTP server will start on port **21** with passive ports **21100–21110**.

### Default Credentials

| Field    | Value     |
|----------|-----------|
| Username | `dynamic` |
| Password | `yield`   |

You can change these in `docker-compose.yml` via the `FTP_USER` and `FTP_PASS` environment variables.

### Stop the Server

```bash
docker compose down
```

### View Logs

```bash
docker compose logs -f ftp
```

## Connecting with Cyberduck

[Cyberduck](https://cyberduck.io/) is a free FTP/SFTP client available for macOS and Windows.

### Setup

1. Download and install Cyberduck from [cyberduck.io](https://cyberduck.io/)
2. Open Cyberduck and click **Open Connection**
3. Fill in the connection details:

| Field        | Value                          |
|--------------|--------------------------------|
| Protocol     | **FTP (File Transfer Protocol)** |
| Server       | `localhost`                    |
| Port         | `21`                           |
| Username     | `dynamic`                      |
| Password     | `yield`                        |

4. Click **Connect**

### Transfer Mode

Cyberduck uses **passive mode** by default, which matches the server configuration. No additional changes are needed for local connections.

### Uploading Files

Once connected, drag and drop files into the Cyberduck window or use **File → Upload**. Uploaded files will appear in the `data/` directory on your host machine.

## Project Structure

```
├── Dockerfile           # Builds the vsftpd container
├── docker-compose.yml   # Service definition and port mapping
├── entrypoint.sh        # Creates virtual users and starts vsftpd
├── vsftpd.conf          # vsftpd configuration
├── vsftpd_virtual       # PAM config for virtual user auth
└── data/                # Mounted volume — uploaded files appear here
```

## Configuration

### Changing Credentials

Edit the environment variables in `docker-compose.yml`:

```yaml
environment:
  FTP_USER: myuser
  FTP_PASS: mypassword
```

Then rebuild:

```bash
docker compose up -d --build
```

### Remote Access

By default, `pasv_address` in `vsftpd.conf` is set to `127.0.0.1`, which only allows local connections. To allow connections from other machines, change it to your host's IP address:

```
pasv_address=192.168.1.100
```
