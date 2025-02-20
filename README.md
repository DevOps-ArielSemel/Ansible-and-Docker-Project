# Ansible Automation: Configuring ComA and ComB with Docker & NFS

## Overview
This project automates the configuration of two Ubuntu-based virtual machines (ComA and ComB)
using **Ansible**. It sets up NFS for file sharing, configures system settings,
and deploys an **NGINX** container using **Docker** on ComB.


## Project Structure
```
project-folder/
│── Vagrantfile
│── inventory.yml
│── playbook.yml
│── ansible.cfg
│── roles/
│   ├── ComA/ (NFS Server)
│   │   ├── tasks/main.yml
│   │   ├── handlers/main.yml
│   ├── ComB/ (NFS Client)
│   │   ├── tasks/main.yml
│   │   ├── handlers/main.yml
│   ├── docker/ (NGINX Container)
│   │   ├── tasks/main.yml
│   │   ├── handlers/main.yml
│── scripts/
│   ├── setups.sh
│── README.md



## Installation & Execution
### 1.ZIP File

```sh
unzip project-folder.zip
cd project-folder
```

### 2. Start Virtual Machines
Run the following to provision and start the virtual machines:
```sh
vagrant up
```

If you need to restart and re-provision:
```sh
vagrant reload --provision
```

### 3. SSH into the Control Machine
```sh
vagrant ssh control
```

### 4. Run the Setup Script for ssh key and copies to secure locations
```sh
cd /vagrant
bash scripts/setups.sh
```

### 5. Run the Ansible Playbook
```sh
ansible-playbook -i inventory.yml playbook.yml
```

## Verification
### Check NFS Mount
On **ComB**, ensure that the NFS mount is available:
```sh
ls -lah /tmp/letsplay2
```

### Check Nginx Container Status
On **ComB**, verify that the Nginx container is running:
```sh
docker ps -a
```
Expected output:
```sh
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                  NAMES
abcdef123456   nginx     "/docker-entrypoint.…"   X minutes ago   Up X minutes   0.0.0.0:8080->80/tcp   nginx_container
```

### Check Web Server
Run the following to check if Nginx is responding:
```sh
curl http://localhost:8080
```
Expected output:
```html
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.27.4</center>
</body>
</html>
```

If you see **403 Forbidden**, it means that **NGINX is working but missing an index.html file**.
To fix:
```sh
echo "<h1>Hello from Nginx!</h1>" | sudo tee /tmp/letsplay2/index.html
```
Then, restart the container:
```sh
docker restart nginx_container
```
Now, re-run:
```sh
curl http://localhost:8080
```
Expected output:
```html
<h1>Hello from Nginx!</h1>
```

## Cleanup
To **destroy** the virtual machines:
```sh
vagrant destroy -f
```
To **remove Docker containers** and images:
```sh
docker rm -f nginx_container
docker rmi nginx
```

## Troubleshooting
### NFS Mount Issues
- Check if the NFS server is running on **ComA**:
  ```sh
  sudo systemctl status nfs-server
  ```
- Verify **NFS exports** on ComA:
  ```sh
  sudo exportfs -v
  ```

### Docker Issues
- Restart Docker on ComB:
  ```sh
  sudo systemctl restart docker
  ```
- Check Docker logs:
  ```sh
  docker logs nginx_container
  ```

## Notes
- If using **Windows**, ensure that `Vagrant` and `VirtualBox` are installed.
- If using **Linux/Mac**, you may need to run certain commands with `sudo`.
- This setup assumes Ubuntu 20.04/22.04 images for **ComA** and **ComB**.

## Author
[Ariel Semel]

## License
This project is **open-source** and free to use for educational purposes.

