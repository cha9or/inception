# USER_DOC.md

## Overview: What Services Are Provided?

This stack provides a secure, multi-service web hosting environment using Docker Compose. The following services are included:

- **Nginx**: Web server and reverse proxy (HTTPS on port 443)
- **WordPress**: Content management system (served via Nginx)
- **MariaDB**: Database for WordPress
- **Adminer**: Database management UI (port 8080)
- **Redis**: In-memory data store for caching
- **FTP**: File transfer service (ports 20, 21, 21000-21010)
- **Portainer**: Docker management UI (port 9000)
- **Static Site**: Simple static website (port 80)

---

## How to Start and Stop the Project

1. **Start all services:**
   ```sh
   make up
   ```

2. **Stop and remove all containers:**
   ```sh
   make down
   ```

3. **Rebuild everything from scratch:**
   ```sh
   make re
   ```

---

## How to Access the Website and Admin Panels

- **Main Website (WordPress):**
  Open https://moboulan.42.fr/ in your browser.

- **WordPress Admin Panel:**
  Go to https://moboulan.42.fr/wp-admin/
  Use the credentials from `wp_admin_password.txt` and `wp_password.txt`.

- **Adminer (Database UI):**
  Visit http://moboulan.42.fr:8080/

- **Portainer (Docker UI):**
  Visit http://moboulan.42.fr:9000/

- **Static Site:**
  Visit http://moboulan.42.fr:81/

- **FTP:**
  Connect to localhost on port 21 using an FTP client. Credentials are in `ftp_password.txt`.

---

## Where to Find and Manage Credentials

All passwords and sensitive information are stored in the `secrets` directory:

- `db_root_password.txt` – MariaDB root password
- `db_password.txt` – MariaDB user password
- `wp_password.txt` – WordPress user password
- `wp_admin_password.txt` – WordPress admin password
- `ftp_password.txt` – FTP user password

To change a password:
Edit the corresponding file in the secrets directory and restart the affected service(s).

---

## How to Check That Services Are Running Correctly

1. **List running containers:**
   ```sh
   docker-compose ps
   ```

2. **View logs for a service:**
   ```sh
   docker-compose logs <service>
   ```
   Replace `<service>` with one of: nginx, wordpress, mariadb, adminer, redis, ftp, portainer, static-site.

3. **Access a container shell:**
   ```sh
   docker-compose exec <service> sh
   ```
   Replace `<service>` with the desired service name.

4. **Check websites and UIs:**
   Open the URLs listed above in your browser. If you see the expected interface, the service is running.

For more details, see the `README.md`.