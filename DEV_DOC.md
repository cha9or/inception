# DEV_DOC.md

## Developer Documentation

This guide explains how to set up, build, and manage the Inception project as a developer.

---


# DEV_DOC.md

## Developer Documentation

This guide explains how to set up, build, and manage the Inception project as a developer.

---


## 0. Project Structure

The project is organized as follows:

```text
Inception/
├── .gitignore
├── DEV_DOC.md
├── Makefile
├── README.md
├── USER_DOC.md
├── secrets
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── ftp_password.txt
│   ├── wp_admin_password.txt
│   └── wp_password.txt
└── srcs
    ├── .env
    ├── docker-compose.yml
    └── requirements
        ├── bonus
        │   ├── adminer
        │   │   └── Dockerfile
        │   ├── ftp
        │   │   ├── Dockerfile
        │   │   ├── conf
        │   │   │   └── ftp.conf
        │   │   └── tools
        │   │       └── ftp.sh
        │   ├── portainer
        │   │   ├── Dockerfile
        │   │   ├── conf
        │   │   │   └── .gitkeep
        │   │   └── tools
        │   │       └── .gitkeep
        │   ├── redis
        │   │   ├── Dockerfile
        │   │   ├── conf
        │   │   │   └── .gitkeep
        │   │   └── tools
        │   │       └── redis.sh
        │   └── static-site
        │       ├── Dockerfile
        │       ├── conf
        │       │   └── index.html
        │       └── tools
        │           └── .gitkeep
        ├── mariadb
        │   ├── .dockerignore
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── mariadb.cnf
        │   └── tools
        │       └── mariadb.sh
        ├── nginx
        │   ├── .dockerignore
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── nginx.conf
        │   └── tools
        │       └── nginx.sh
        └── wordpress
            ├── .dockerignore
            ├── Dockerfile
            └── tools
                └── wordpress.sh

```

---

## 1. Environment Setup

### Prerequisites

- Docker
- Docker Compose
- GNU Make


### Configuration Files & Secrets

- All service configurations are in `srcs/requirements/<service>/conf/`.
- Secrets (passwords, etc.) are in the `secrets/` directory. Example files are provided; update them as needed.
- The main environment file is `srcs/.env`.

#### Copying .env and Secrets

Before building, ensure you have copied the required `.env` and secrets files:

```sh
cp /path/to/your/.env srcs/.env
cp /path/to/your/secrets/* secrets/
```
Replace `/path/to/your/` with the actual location of your files. Example secrets are provided; update them as needed for your deployment.

### Data Directories

Before starting, you must create the following directories on your host to persist data:

```sh
mkdir -p /home/moboulan/data/wordpress
mkdir -p /home/moboulan/data/mariadb
```

These directories are used as bind mounts for Docker volumes to ensure data persists even if containers are removed.

### /etc/hosts Configuration

To access your services via a custom domain, add the following line to your `/etc/hosts` file:

```
127.0.0.1 moboulan.42.fr
```

---

## 2. Building and Launching

- **Build and start all services:**
	```sh
	make
	```
- **Stop and remove all containers:**
	```sh
	make down
	```
- **Rebuild everything from scratch:**
	```sh
	make re
	```

---

## 3. Managing Containers and Volumes

- **List running containers:**
	```sh
	docker-compose ps
	```
- **View logs for a service:**
	```sh
	docker-compose logs <service>
	```
- **Access a container shell:**
	```sh
	docker exec -it <container> /bin/sh
	```
- **List Docker volumes:**
	```sh
	docker volume ls
	```
- **Remove unused volumes:**
	```sh
	docker volume prune
	```

---

## 4. Data Persistence

- Persistent data is stored in Docker volumes defined in `docker-compose.yml`.
- Volumes are mapped to `/home/moboulan/data/wordpress`, `/home/moboulan/data/mariadb`, and `/home/moboulan/data/portainer` on the host.
- These directories ensure that your database, WordPress files, and Portainer data are not lost when containers are stopped or removed.

---

For further details, refer to the README.md and service-specific documentation in `srcs/requirements/`.