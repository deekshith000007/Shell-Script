<h3>Step 1: Update System<h3></h3>
'''sudo apt update && sudo apt upgrade -y'''<br>
<h3></h3>Step 2: Install Docker</h3>
'''sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io'''<br>
<h3>Step 3: Start and Enable Docker</h3>
'''sudo systemctl enable docker
sudo systemctl start docker'''<br>
<h3>Step 4: Add Current User to Docker Group (optional but recommended)</h3>
'''sudo usermod -aG docker $USER
# Then log out and log back in or run:
newgrp docker'''<br>
<h3>Step 5: Install Docker Compose (v2.x)</h3>
'''sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Test
docker-compose --version'''<br>
<h3>Step 6: (Optional) Configure UFW Firewall</h3>
Allow basic traffic:

'''sudo apt install ufw -y
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable'''
If this is MySQL Server (Server B):
'''sudo ufw allow from <Server-A-IP> to any port 3306'''<br>

<h3>Installation Summary:</h3>
''' Application	Command/Status
Docker	docker --version
Docker Compose	docker-compose --version
UFW (Firewall)	sudo ufw status ''' <br>
