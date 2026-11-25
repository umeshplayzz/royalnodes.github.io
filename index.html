#!/bin/bash
# ==================================================
#  UMESHPLAYZZ - PROFESSIONAL INSTALLER v3.2 FINAL
#  Panel + Wings + Cloudflare + Blueprint + Nebula
#  + Extensions + Backup + SSHX + Update + Uninstall
#  Made by UMESHPLAYZZ | royalnodes.bond
#  Discord: discord.gg/Royalnodes | YouTube: @twumeshyt
# ==================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'
WHITE='\033[1;37m'
exec < /dev/tty
FULL_MODE=0

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Please run as root: sudo bash install.sh${NC}"
   exit 1
fi

show_banner() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  ██╗   ██╗███╗   ███╗███████╗███████╗██╗  ██╗${NC}"
echo -e "${CYAN}  ██║   ██║████╗ ████║██╔════╝██╔════╝██║  ██║${NC}"
echo -e "${CYAN}  ██║   ██║██╔████╔██║█████╗  ███████╗███████║${NC}"
echo -e "${CYAN}  ██║   ██║██║╚██╔╝██║██╔══╝  ╚════██║██╔══██║${NC}"
echo -e "${CYAN}  ╚██████╔╝██║ ╚═╝ ██║███████╗███████║██║  ██║${NC}"
echo -e "${CYAN}   ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}"
echo -e "${PURPLE}============================================================${NC}"
echo -e "${YELLOW}  🔥 UMESHPLAYZZ - PROFESSIONAL INSTALLER v3.2 🔥${NC}"
echo -e "${GREEN}  Panel | Wings | Cloudflare | Blueprint | Nebula | SSHX${NC}"
echo -e "${CYAN}  Discord: discord.gg/Royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${PURPLE}============================================================${NC}"
}

pause() {
  if [ "$FULL_MODE" = "1" ]; then return; fi
  echo ""
  read -p "Press Enter to continue... " _
}

install_deps() {
  echo -e "${CYAN}[*] Updating System + Installing Dependencies...${NC}"
  export DEBIAN_FRONTEND=noninteractive
  apt update && apt upgrade -y
  apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release mariadb-client
  echo -e "${GREEN}[+] System Ready!${NC}"
}

install_panel() {
  echo -e "${CYAN}[*] Installing Pterodactyl Panel...${NC}"
  echo -e "${YELLOW}The official Pterodactyl Installer will now ask for Domain / Email / Admin.${NC}"
  sleep 2
  curl -s -o /tmp/ptero-installer.sh https://pterodactyl-installer.se
  bash /tmp/ptero-installer.sh
  if [ $? -ne 0 ]; then
    echo -e "${YELLOW}Retrying with GitHub installer...${NC}"
    curl -s -o /tmp/ptero-installer2.sh https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh
    bash /tmp/ptero-installer2.sh
  fi
  echo -e "${GREEN}[+] Panel Installed!${NC}"
  pause
}

install_docker() {
  if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}[*] Docker not found. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o /tmp/docker.sh
    sh /tmp/docker.sh
    systemctl enable --now docker
  else
    echo -e "${GREEN}[+] Docker already installed.${NC}"
  fi
}

install_wings() {
  echo -e "${CYAN}[*] Installing Wings...${NC}"
  install_docker
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
  systemctl daemon-reload
  systemctl enable wings
  echo -e "${GREEN}[+] Wings Installed!${NC}"
  echo -e "${YELLOW}Next Steps:${NC}"
  echo -e "${WHITE}1. Panel -> Admin -> Nodes -> Create Node${NC}"
  echo -e "${WHITE}2. Copy Wings config to /etc/pterodactyl/config.yml${NC}"
  echo -e "${WHITE}3. Run: systemctl restart wings${NC}"
  pause
}

install_blueprint() {
  echo -e "${CYAN}[*] Installing Blueprint Framework...${NC}"
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}Please install Panel first!${NC}"; pause; return; fi
  cd /var/www/pterodactyl
  curl -s -o /tmp/blueprint.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh
  bash /tmp/blueprint.sh
  if ! command -v blueprint &> /dev/null; then
    ln -sf /var/www/pterodactyl/blueprint.sh /usr/local/bin/blueprint 2>/dev/null || true
    export PATH="$PATH:/var/www/pterodactyl"
  fi
  echo -e "${GREEN}[+] Blueprint Installed! Check Blueprint menu in Panel.${NC}"
  pause
}

install_nebula() {
  echo -e "${CYAN}[*] Installing Nebula Theme + Branding + Extensions...${NC}"
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}Please install Panel + Blueprint first!${NC}"; pause; return; fi
  if ! command -v blueprint &> /dev/null; then echo -e "${RED}Blueprint not found! Install Blueprint first (Option 3).${NC}"; pause; return; fi
  cd /var/www/pterodactyl
  mkdir -p /tmp/nebula && cd /tmp/nebula
  rm -f nebula.blueprint nebula.zip
  echo -e "${YELLOW}Downloading Nebula...${NC}"
  wget -O nebula.blueprint "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.blueprint "https://github.com/NebulaThemes/Nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.zip "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.zip" 2>/dev/null || true
  if [ -f nebula.blueprint ] && [ -s nebula.blueprint ]; then
    cp nebula.blueprint /var/www/pterodactyl/nebula.blueprint
    cd /var/www/pterodactyl
    blueprint -install nebula || blueprint -i nebula || echo -e "${YELLOW}Install via Panel -> Blueprint -> Extensions${NC}"
  elif [ -f nebula.zip ] && [ -s nebula.zip ]; then
    unzip -o nebula.zip -d /var/www/pterodactyl/
    cd /var/www/pterodactyl
    blueprint -install nebula || blueprint -i nebula
  else
    echo -e "${RED}[!] Nebula auto download failed.${NC}"
    echo -e "${WHITE}Manual: Download nebula.blueprint and upload in Panel -> Blueprint -> Extensions${NC}"
    pause; return
  fi
  echo -e "${CYAN}[*] Applying UMESHPLAYZZ Branding + Extensions...${NC}"
  find /var/www/pterodactyl/resources -type f -name "*.blade.php" -exec sed -i 's/Pterodactyl/UMESHPLAYZZ/g' {} \; 2>/dev/null || true
  mkdir -p /var/www/pterodactyl/public/themes/ /var/www/pterodactyl/public/extensions/umeshplayzz
  cat > /var/www/pterodactyl/public/themes/umeshplayzz-custom.css << 'EOF'
/* UMESHPLAYZZ CUSTOM */
:root { --umesh-primary: #8b5cf6; --umesh-secondary: #06b6d4; }
EOF
  echo "UMESHPLAYZZ Extensions - Discord: discord.gg/Royalnodes - YouTube: @twumeshyt" > /var/www/pterodactyl/public/extensions/umeshplayzz/readme.txt
  cd /var/www/pterodactyl
  blueprint -install server-splitting 2>/dev/null || true
  blueprint -install allocation-manager 2>/dev/null || true
  php artisan view:clear 2>/dev/null || true
  php artisan config:clear 2>/dev/null || true
  chown -R www-data:www-data /var/www/pterodactyl/* 2>/dev/null || true
  php artisan queue:restart 2>/dev/null || true
  systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}[+] Nebula + Branding + Extensions Done!${NC}"
  echo -e "${YELLOW}Don't forget to ENABLE Nebula in Panel -> Blueprint -> Extensions${NC}"
  pause
}

setup_cloudflare() {
  echo -e "${CYAN}[*] Cloudflare Tunnel Setup...${NC}"
  read -p "Enter Cloudflare Tunnel Token: " CF_TOKEN
  if [ -z "$CF_TOKEN" ]; then echo -e "${RED}Token is empty!${NC}"; pause; return; fi
  curl -L --output /tmp/cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb"
  dpkg -i /tmp/cloudflared.deb
  cloudflared service install "$CF_TOKEN"
  systemctl enable cloudflared
  systemctl restart cloudflared
  echo -e "${GREEN}[+] Cloudflare Connected!${NC}"
  pause
}

do_backup() {
  mkdir -p /backup/umeshplayzz
  DATE=$(date +%F-%H-%M)
  DB_PASS=""
  if [ -f /var/www/pterodactyl/.env ]; then
    DB_PASS=$(grep "^DB_PASSWORD=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_USER=$(grep "^DB_USERNAME=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_NAME=$(grep "^DB_DATABASE=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_USER=${DB_USER:-pterodactyl}
    DB_NAME=${DB_NAME:-pterodactyl}
  else
    DB_USER="pterodactyl"
    DB_NAME="pterodactyl"
  fi
  if [ -n "$DB_PASS" ]; then
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true
  else
    mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true
  fi
  tar -czf "/backup/umeshplayzz/files-$DATE.tar.gz" /var/www/pterodactyl /etc/pterodactyl 2>/dev/null || true
  echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
  find /backup/umeshplayzz -type f -mtime +7 -delete 2>/dev/null || true
  echo -e "${GREEN}Backup Done: /backup/umeshplayzz/panel-$DATE.sql${NC}"
}

backup_menu() {
  echo -e "${CYAN}=== BACKUP MENU ===${NC}"
  echo -e "${WHITE}1) Create Backup Now${NC}"
  echo -e "${WHITE}2) Enable Auto Backup (Daily 3 AM)${NC}"
  echo -e "${WHITE}3) View Backup List${NC}"
  echo -e "${WHITE}0) Back${NC}"
  read -p "Select Option: " b
  case $b in
    1) do_backup; pause ;;
    2)
      cat > /root/umeshplayzz-backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%F-%H-%M)
mkdir -p /backup/umeshplayzz
DB_PASS=$(grep "^DB_PASSWORD=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_USER=$(grep "^DB_USERNAME=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_NAME=$(grep "^DB_DATABASE=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_USER=${DB_USER:-pterodactyl}
DB_NAME=${DB_NAME:-pterodactyl}
if [ -n "$DB_PASS" ]; then
  mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql 2>/dev/null || mysqldump -u root "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql
else
  mysqldump -u root "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql
fi
tar -czf /backup/umeshplayzz/files-$DATE.tar.gz /var/www/pterodactyl /etc/pterodactyl 2>/dev/null
echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
find /backup/umeshplayzz -type f -mtime +7 -delete
EOF
      chmod +x /root/umeshplayzz-backup.sh
      (crontab -l 2>/dev/null | grep -v umeshplayzz-backup; echo "0 3 * * * /root/umeshplayzz-backup.sh") | crontab -
      ln -sf /root/umeshplayzz-backup.sh /usr/local/bin/umesh-backup
      echo -e "${GREEN}[+] Auto Backup Enabled! Command: umesh-backup${NC}"; pause ;;
    3) ls -lh /backup/umeshplayzz/ 2>/dev/null || echo -e "${YELLOW}No backups found.${NC}"; pause ;;
  esac
}

sshx_system() {
  echo -e "${CYAN}[*] SSHX System...${NC}"
  if ! command -v sshx &> /dev/null; then
    echo -e "${YELLOW}Installing SSHX...${NC}"
    curl -sSf https://sshx.io/get -o /tmp/sshx.sh
    sh /tmp/sshx.sh
  fi
  echo -e "${GREEN}SSHX Ready! Command: sshx${NC}"
  echo -e "${YELLOW}WARNING: Do NOT share the link with strangers, they will get full terminal access!${NC}"
  read -p "Start SSHX now? (y/n): " yn
  if [[ "$yn" == "y" || "$yn" == "Y" ]]; then sshx; fi
  pause
}

update_system() {
  echo -e "${CYAN}[*] Updating Everything - System + Panel + Blueprint + Wings...${NC}"
  echo -e "${YELLOW}[1/4] System Update...${NC}"
  export DEBIAN_FRONTEND=noninteractive
  apt update && apt upgrade -y
  apt autoremove -y
  echo -e "${GREEN}[+] System Updated!${NC}"
  if [ -d "/var/www/pterodactyl" ]; then
    echo -e "${YELLOW}[2/4] Panel Update...${NC}"
    cd /var/www/pterodactyl
    php artisan down 2>/dev/null || true
    php artisan migrate --seed --force 2>/dev/null || true
    php artisan view:clear 2>/dev/null || true
    php artisan config:clear 2>/dev/null || true
    chown -R www-data:www-data /var/www/pterodactyl/* 2>/dev/null || true
    php artisan queue:restart 2>/dev/null || true
    php artisan up 2>/dev/null || true
    echo -e "${GREEN}[+] Panel Updated!${NC}"
    echo -e "${YELLOW}[3/4] Blueprint Update...${NC}"
    blueprint -update 2>/dev/null || blueprint -upgrade 2>/dev/null || { curl -s -o /tmp/blueprint-up.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh; bash /tmp/blueprint-up.sh; } || echo -e "${YELLOW}Blueprint manual update needed.${NC}"
    echo -e "${GREEN}[+] Blueprint Updated!${NC}"
  else
    echo -e "${YELLOW}Panel not installed yet, skipping Panel/Blueprint update.${NC}"
  fi
  echo -e "${YELLOW}[4/4] Wings Update...${NC}"
  if [ -f /usr/local/bin/wings ]; then
    curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64"
    chmod u+x /usr/local/bin/wings
    systemctl restart wings 2>/dev/null || true
    echo -e "${GREEN}[+] Wings Updated!${NC}"
  else
    echo -e "${YELLOW}Wings not installed yet, skipping.${NC}"
  fi
  systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}✅ EVERYTHING UPDATED!${NC}"
  pause
}

uninstall_all() {
  echo -e "${RED}WARNING: This will delete Panel + Wings + Database completely!${NC}"
  read -p "Are you sure? Type YES to confirm: " confirm
  if [ "$confirm" != "YES" ]; then echo -e "${YELLOW}Cancelled.${NC}"; pause; return; fi
  echo -e "${CYAN}Uninstalling...${NC}"
  systemctl stop wings nginx mysql mariadb 2>/dev/null || true
  systemctl disable wings 2>/dev/null || true
  rm -rf /var/www/pterodactyl /etc/pterodactyl /usr/local/bin/wings /etc/systemd/system/wings.service /backup/umeshplayzz
  rm -f /usr/local/bin/umesh-backup /root/umeshplayzz-backup.sh
  mysql -u root -e "DROP DATABASE IF EXISTS pterodactyl;" 2>/dev/null || true
  systemctl daemon-reload
  echo -e "${GREEN}[+] Uninstall Complete! VPS is clean.${NC}"
  pause
}

full_install() {
  FULL_MODE=1
  echo -e "${GREEN}=== FULL INSTALL STARTED ===${NC}"
  install_deps
  install_panel
  install_wings
  install_blueprint
  install_nebula
  do_backup
  FULL_MODE=0
  echo -e "${GREEN}✅ FULL INSTALL COMPLETE!${NC}"
  echo -e "${WHITE}Next: Panel -> Admin -> Nodes -> Create Node${NC}"
  pause
}

while true; do
show_banner
echo -e "${WHITE}  [1] Panel Install Only${NC}"
echo -e "${WHITE}  [2] Wings Install Only${NC}"
echo -e "${WHITE}  [3] Blueprint Install${NC}"
echo -e "${WHITE}  [4] Nebula Theme + Branding + Extensions${NC}"
echo -e "${WHITE}  [5] Cloudflare Tunnel Setup${NC}"
echo -e "${WHITE}  [6] Backup / Restore Menu${NC}"
echo -e "${WHITE}  [7] SSHX System (Terminal Share)${NC}"
echo -e "${WHITE}  [8] Update System (apt + Panel + Blueprint + Wings)${NC}"
echo -e "${WHITE}  [9] Full Install (Panel + Wings + Blueprint + Nebula + Backup)${NC}"
echo -e "${WHITE}  [10] Uninstall (Delete Full Panel)${NC}"
echo -e "${RED}  [0] Exit${NC}"
echo -e "${PURPLE}============================================================${NC}"
read -p "Select Option [0-10]: " opt
case $opt in
  1) install_panel ;;
  2) install_wings ;;
  3) install_blueprint ;;
  4) install_nebula ;;
  5) setup_cloudflare ;;
  6) backup_menu ;;
  7) sshx_system ;;
  8) update_system ;;
  9) full_install ;;
  10) uninstall_all ;;
  0) echo -e "${GREEN}Thanks for using UMESHPLAYZZ ❤️🔥${NC}"; exit 0 ;;
  *) echo -e "${RED}Invalid option! Choose 0-10.${NC}"; sleep 1 ;;
esac
done
