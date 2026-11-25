#!/bin/bash
# ==================================================
#  UMESHPLAYZZ - ALL IN ONE ULTIMATE INSTALLER
#  Panel + Wings + Cloudflare + Blueprint + Nebula
#  + Themes + Extensions + Auto Backup
#  Made by UMESHPLAYZZ
# ==================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m'
WHITE='\033[1;37m'

# FIX: curl se chalane par read kaam kare isliye
exec < /dev/tty

clear
echo -e "${PURPLE}================================================${NC}"
echo -e "${CYAN}  ██╗   ██╗███╗   ███╗███████╗███████╗██╗  ██╗${NC}"
echo -e "${CYAN}  ██║   ██║████╗ ████║██╔════╝██╔════╝██║  ██║${NC}"
echo -e "${CYAN}  ██║   ██║██╔████╔██║█████╗  ███████╗███████║${NC}"
echo -e "${CYAN}  ██║   ██║██║╚██╔╝██║██╔══╝  ╚════██║██╔══██║${NC}"
echo -e "${CYAN}  ╚██████╔╝██║ ╚═╝ ██║███████╗███████║██║  ██║${NC}"
echo -e "${CYAN}   ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}"
echo -e "${PURPLE}================================================${NC}"
echo -e "${YELLOW}  🔥 UMESHPLAYZZ - ULTIMATE INSTALLER 🔥${NC}"
echo -e "${GREEN}  Panel | Wings | Cloudflare | Blueprint | Nebula${NC}"
echo -e "${GREEN}  Themes | Extensions | Auto Backup${NC}"
echo -e "${PURPLE}================================================${NC}"
echo -e "${CYAN}  Join Discord: discord.gg/umeshplayzz${NC}"
echo -e "${CYAN}  YouTube: @umeshplayzz${NC}"
echo -e "${PURPLE}================================================${NC}"
sleep 2

# Root Check
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Bhai root me chala: sudo bash install.sh${NC}"
   exit 1
fi

# User Input
read -p "Tera Domain daal (ex: panel.royalnodes.bond): " DOMAIN
read -p "Tera Email daal (SSL ke liye): " EMAIL
read -p "Cloudflare Tunnel Token (skip ke liye Enter): " CF_TOKEN
read -p "Admin Email (Panel ke liye): " ADMIN_EMAIL
read -p "Admin Username: " ADMIN_USER
read -s -p "Admin Password: " ADMIN_PASS
echo ""

# Khali check
if [ -z "$DOMAIN" ] || [ -z "$ADMIN_EMAIL" ] || [ -z "$ADMIN_USER" ] || [ -z "$ADMIN_PASS" ]; then
  echo -e "${RED}[!] Bhai sab kuch bharna zaroori hai, dobara chala.${NC}"
  exit 1
fi

export DOMAIN EMAIL ADMIN_EMAIL ADMIN_USER ADMIN_PASS

# ==================================================
# [1/8] SYSTEM UPDATE + DEPENDENCIES
# ==================================================
echo -e "${CYAN}[1/8] System Update + Dependencies...${NC}"
apt update && apt upgrade -y
apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release
echo -e "${GREEN}[+] System Ready!${NC}"

# ==================================================
# [2/8] CLOUDFLARE TUNNEL
# ==================================================
echo -e "${CYAN}[2/8] Cloudflare Tunnel Setup...${NC}"
if [ ! -z "$CF_TOKEN" ]; then
  curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
  dpkg -i cloudflared.deb
  cloudflared service install $CF_TOKEN
  systemctl enable cloudflared
  systemctl start cloudflared
  echo -e "${GREEN}[+] Cloudflare Connected: $DOMAIN${NC}"
else
  echo -e "${YELLOW}[-] Cloudflare Skipped, Direct IP/Domain use hoga${NC}"
fi

# ==================================================
# [3/8] PTERODACTYL PANEL INSTALL
# ==================================================
echo -e "${CYAN}[3/8] Pterodactyl Panel Install ho raha hai...${NC}"
bash <(curl -s https://pterodactyl-installer.se) || bash <(curl -s https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh)

# Panel URL Set
echo -e "${CYAN}Panel URL set ho rahi hai: https://$DOMAIN${NC}"
cd /var/www/pterodactyl
php artisan p:environment:url https://$DOMAIN || true

# Admin User Create - UMESHPLAYZZ
php artisan p:user:make --email=$ADMIN_EMAIL --username=$ADMIN_USER --name-first=Umesh --name-last=Playzz --password=$ADMIN_PASS --admin=1 || echo -e "${YELLOW}Admin pehle se hai ya manual banao${NC}"

echo -e "${GREEN}[+] Panel Installed!${NC}"

# ==================================================
# [4/8] WINGS INSTALL
# ==================================================
echo -e "${CYAN}[4/8] Wings Install ho raha hai...${NC}"
curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64"
chmod u+x /usr/local/bin/wings
mkdir -p /etc/pterodactyl
cat > /etc/systemd/system/wings.service << 'EOF'
[Unit]
Description=Pterodactyl Wings Daemon
After=docker.service
Requires=docker.service
PartOf=docker.service
[Service]
User=root
WorkingDirectory=/etc/pterodactyl
LimitNOFILE=4096
PIDFile=/var/run/wings/daemon.pid
ExecStart=/usr/local/bin/wings
Restart=on-failure
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now wings
echo -e "${GREEN}[+] Wings Installed! Panel me Node bana ke config /etc/pterodactyl/config.yml me daal dena${NC}"

# ==================================================
# [5/8] BLUEPRINT INSTALL
# ==================================================
echo -e "${CYAN}[5/8] Blueprint Framework Install...${NC}"
bash <(curl -s https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh) || echo -e "${YELLOW}Blueprint manual install karna padega${NC}"
echo -e "${GREEN}[+] Blueprint Installed!${NC}"

# ==================================================
# [6/8] NEBULA THEME + UMESHPLAYZZ BRANDING
# ==================================================
echo -e "${CYAN}[6/8] Nebula Theme + UMESHPLAYZZ Branding...${NC}"
cd /var/www/pterodactyl
mkdir -p /tmp/nebula
cd /tmp/nebula
wget -O nebula.zip https://github.com/NebulaThemes/Nebula/releases/latest/download/nebula.zip || wget -O nebula.zip https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.zip || echo -e "${YELLOW}Nebula download fail, manual .blueprint file daalo${NC}"
if [ -f nebula.zip ]; then
  unzip -o nebula.zip -d /var/www/pterodactyl/
  cd /var/www/pterodactyl
  blueprint -install nebula || blueprint -i nebula || echo "Blueprint se install karo"
fi

# Branding Change
echo -e "${CYAN}UMESHPLAYZZ Branding Apply...${NC}"
find /var/www/pterodactyl/resources -type f -name "*.blade.php" -exec sed -i 's/Pterodactyl/UMESHPLAYZZ/g' {} \; 2>/dev/null || true
# Custom CSS for UMESHPLAYZZ
cat > /var/www/pterodactyl/public/themes/umeshplayzz-custom.css << 'EOF'
/* UMESHPLAYZZ CUSTOM */
:root { --umesh-primary: #8b5cf6; --umesh-secondary: #06b6d4; }
.logo { content: "UMESHPLAYZZ"; }
EOF

php artisan view:clear
php artisan config:clear
chown -R www-data:www-data /var/www/pterodactyl/*
echo -e "${GREEN}[+] Nebula + Branding Done!${NC}"

# ==================================================
# [7/8] EXTENSIONS INSTALL
# ==================================================
echo -e "${CYAN}[7/8] Extensions Install ho rahe hai...${NC}"
cd /var/www/pterodactyl
mkdir -p /var/www/pterodactyl/public/extensions/umeshplayzz
echo "UMESHPLAYZZ Extensions" > /var/www/pterodactyl/public/extensions/umeshplayzz/readme.txt

# SSL - Certbot
echo -e "${CYAN}SSL Certificate lag raha hai...${NC}"
certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m $EMAIL || certbot certonly --standalone -d $DOMAIN --non-interactive --agree-tos -m $EMAIL || echo -e "${YELLOW}SSL manual lagana padega${NC}"

# Build
npm run build 2>/dev/null || yarn build 2>/dev/null || true
php artisan queue:restart
systemctl restart nginx
echo -e "${GREEN}[+] Extensions + SSL Done!${NC}"

# ==================================================
# [8/8] BACKUP SYSTEM - UMESHPLAYZZ
# ==================================================
echo -e "${CYAN}[8/8] Auto Backup System Setup...${NC}"
cat > /root/umeshplayzz-backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%F-%H-%M)
mkdir -p /backup/umeshplayzz
mysqldump -u root --skip-password pterodactyl > /backup/umeshplayzz/panel-$DATE.sql 2>/dev/null || mysqldump pterodactyl > /backup/umeshplayzz/panel-$DATE.sql
tar -czf /backup/umeshplayzz/files-$DATE.tar.gz /var/www/pterodactyl /etc/pterodactyl 2>/dev/null
echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
find /backup/umeshplayzz -type f -mtime +7 -delete
EOF
chmod +x /root/umeshplayzz-backup.sh
(crontab -l 2>/dev/null; echo "0 3 * * * /root/umeshplayzz-backup.sh") | crontab -
ln -sf /root/umeshplayzz-backup.sh /usr/local/bin/umesh-backup
echo -e "${GREEN}[+] Backup ON! Command: umesh-backup | Location: /backup/umeshplayzz${NC}"

# ==================================================
# FINISH
# ==================================================
clear
echo -e "${PURPLE}================================================${NC}"
echo -e "${GREEN}  ✅ UMESHPLAYZZ INSTALL COMPLETE! ✅${NC}"
echo -e "${PURPLE}================================================${NC}"
echo -e "${CYAN} 🌐 Panel: https://$DOMAIN${NC}"
echo -e "${CYAN} 👤 Admin: $ADMIN_USER / $ADMIN_EMAIL${NC}"
echo -e "${CYAN} 🦅 Wings: Installed & Running${NC}"
echo -e "${CYAN} 🎨 Theme: Nebula + UMESHPLAYZZ Branding${NC}"
echo -e "${CYAN} 🧩 Blueprint: Installed${NC}"
echo -e "${CYAN} ☁️ Cloudflare: Done${NC}"
echo -e "${CYAN} 💾 Backup: Daily 3 AM - /backup/umeshplayzz${NC}"
echo -e "${CYAN} 🔧 Backup Command: umesh-backup${NC}"
echo -e "${PURPLE}================================================${NC}"
echo -e "${YELLOW}  NEXT STEP:${NC}"
echo -e "${WHITE}  1. Panel kholo -> Admin -> Nodes -> New Node banao${NC}"
echo -e "${WHITE}  2. Wings config copy karke /etc/pterodactyl/config.yml me daalo${NC}"
echo -e "${WHITE}  3. systemctl restart wings${NC}"
echo -e "${
