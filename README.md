*This project has been created as part of the 42 curriculum by moboulan.*

# Inception

## Description
Inception is a project designed to introduce and deepen understanding of Docker and containerization. The goal is to set up a secure, multi-service infrastructure using Docker Compose, simulating a real-world web hosting environment. The project includes services such as Nginx, WordPress, MariaDB, Redis, FTP, Adminer, Portainer, and a static website, each running in its own container.

## Instructions

### Prerequisites
- Docker
- Docker Compose

### Setup & Execution
1. Clone the repository:
   ```sh
   cd Desktop
   git clone <repo_url> Inception
   cd Inception
   ```
2. Copy your secrets to the `secrets/` directory (or use the provided examples).
   ```sh
   cp /home/moboulan/Desktop/to_copy/* .
   ```
3. Build and start the containers:
   ```sh
   make
   ```
4. To stop and remove containers:
   ```sh
   make down
   ```

## Project Description
This project leverages Docker Compose to orchestrate multiple services, each isolated in its own container. The `srcs/requirements` directory contains the Dockerfiles and configuration for each service. The main design choices include:
- Using Docker Compose for service orchestration and network management.
- Separating secrets from code for improved security.
- Using Docker volumes for persistent data.

### Comparison Table
| Topic                        | Option 1                | Option 2                | Comparison |
|------------------------------|-------------------------|-------------------------|------------|
| Virtual Machines vs Docker   | Full OS virtualization  | Lightweight containers  | Docker is more resource-efficient and faster to start/stop than VMs, but VMs offer stronger isolation. |
| Secrets vs Env Variables     | Files outside containers | Env variables in config | Secrets files are more secure and less likely to be leaked in logs or process lists. |
| Docker Network vs Host Net   | Isolated bridge network | Host shares network     | Docker networks provide isolation and flexibility; host network is simpler but less secure. |
| Docker Volumes vs Bind Mounts| Managed by Docker       | Host directory mapped   | Volumes are portable and managed by Docker; bind mounts are simple but less portable and secure. |

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WordPress Docker Guide](https://developer.wordpress.org/apis/cli/commands/docker/)
- [MariaDB Docker Docs](https://hub.docker.com/_/mariadb)
- [Redis Docker Docs](https://hub.docker.com/_/redis)
- [Adminer](https://www.adminer.org/)
- [Portainer](https://www.portainer.io/)

### Use of AI
AI was used to:
- Write and structure this README.

## Additional Information
- For troubleshooting, check logs with `docker-compose logs` or `make logs`.
- For more details on each service, see the respective subdirectories in `srcs/requirements/`.
