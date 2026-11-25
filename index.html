#!/bin/bash
# ==================================================
#  UMESHPLAYZZ - PROFESSIONAL INSTALLER v2.1 FINAL
#  Panel + Wings + Cloudflare + Blueprint + Nebula
#  + Backup + SSHX + Uninstall + Menu System
#  Made by UMESHPLAYZZ | royalnodes.bond
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

exec < /dev/tty
FULL_MODE=0

# Root Check
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Bhai root me chala: sudo bash install.sh${NC}"
   exit 1
fi

# ============ FUNCTIONS ============

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
echo -e "${YELLOW}  🔥 UMESHPLAYZZ - PROFESSIONAL INSTALLER v2.1 🔥${NC}"
echo -e "${GREEN}  Panel | Wings | Cloudflare | Blueprint | Nebula | SSHX${NC}"
echo -e "${CYAN}  Discord: discord.gg/umeshplayzz | YouTube: @umeshplayzz${NC}"
echo -e "${PURPLE}============================================================${NC}"
}

pause() {
  if [ "$FULL_MODE" = "1" ]; then return; fi
  echo ""
  read -p "Continue karne ke liye Enter dabao... " _
}

install_deps() {
  echo -e "${CYAN}[*] System Update + Dependencies...${NC}"
  apt update && apt upgrade -y
  apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release
  echo -e "${GREEN}[+] System Ready!${NC}"
}

install_panel() {
  echo -e "${CYAN}[*] Pterodactyl Panel Install ho raha hai...${NC}"
  echo -e "${YELLOW}Ab Pterodactyl Installer khud Domain / Email / Admin puchega...${NC}"
  sleep 2
  bash <(curl -s https://pterodactyl-installer.se) || bash <(curl -s https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh)
  echo -e "${GREEN}[+] Panel Installed!${NC}"
  pause
}

install_wings() {
  echo -e "${CYAN}[*] Wings Install ho raha hai...${NC}"
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
  systemctl enable --now wings
  echo -e "${GREEN}[+] Wings Installed!${NC}"
  echo -e "${YELLOW}Next: Panel -> Admin -> Nodes -> New Node -> Config ko /etc/pterodactyl/config.yml me daalo${NC}"
  pause
}

install_blueprint() {
  echo -e "${CYAN}[*] Blueprint Framework Install...${NC}"
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}Pehle Panel install karo!${NC}"; pause; return; fi
  cd /var/www/pterodactyl
  bash <(curl -s https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh)
  echo -e "${GREEN}[+] Blueprint Installed!${NC}"
  pause
}

install_nebula() {
  echo -e "${CYAN}[*] Nebula Theme Install...${NC}"
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}Pehle Panel + Blueprint install karo!${NC}"; pause; return; fi
  cd /var/www/pterodactyl
  mkdir -p /tmp/nebula && cd /tmp/nebula
  rm -f nebula.blueprint nebula.zip
  wget -O nebula.blueprint https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.blueprint 2>/dev/null || wget -O nebula.zip https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.zip 2>/dev/null || echo -e "${YELLOW}Nebula download fail, manual try kar raha hu...${NC}"
  if [ -f nebula.blueprint ]; then
    cp nebula.blueprint /var/www/pterodactyl/nebula.blueprint
    cd /var/www/pterodactyl
    blueprint -install nebula || blueprint -i nebula
  elif [ -f nebula.zip ]; then
    unzip -o nebula.zip -d /var/www/pterodactyl/
    cd /var/www/pterodactyl
    blueprint -install nebula || blueprint -i nebula
  else
    echo -e "${RED}[!] Nebula auto download fail.${NC}"
    echo -e "${WHITE}Manual: Panel -> Blueprint -> Extensions -> Nebula.blueprint Upload karo${NC}"
    pause; return
  fi
  find /var/www/pterodactyl/resources -type f -name "*.blade.php" -exec sed -i 's/Pterodactyl/UMESHPLAYZZ/g' {} \; 2>/dev/null || true
  mkdir -p /var/www/pterodactyl/public/themes/
  cat > /var/www/pterodactyl/public/themes/umeshplayzz-custom.css << 'EOF'
/* UMESHPLAYZZ CUSTOM */
:root { --umesh-primary: #8b5cf6; --umesh-secondary: #06b6d4; }
EOF
  php artisan view:clear 2>/dev/null || true
  php artisan config:clear 2>/dev/null || true
  chown -R www-data:www-data /var/www/pterodactyl/* 2>/dev/null || true
  php artisan queue:restart 2>/dev/null || true
  systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}[+] Nebula + UMESHPLAYZZ Branding Done!${NC}"
  echo -e "${YELLOW}Panel -> Blueprint -> Extensions me Nebula ON karna mat bhulna!${NC}"
  pause
}

setup_cloudflare() {
  echo -e "${CYAN}[*] Cloudflare Tunnel Setup...${NC}"
  read -p "Cloudflare Tunnel Token daal: " CF_TOKEN
  if [ -z "$CF_TOKEN" ]; then echo -e "${RED}Token khali hai!${NC}"; pause; return; fi
  curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
  dpkg -i cloudflared.deb
  cloudflared service install $CF_TOKEN
  systemctl enable cloudflared
  systemctl start cloudflared
  echo -e "${GREEN}[+] Cloudflare Connected!${NC}"
  pause
}

do_backup() {
  mkdir -p /backup/umeshplayzz
  DATE=$(date +%F-%H-%M)
  mysqldump -u root --skip-password pterodactyl > /backup/umeshplayzz/panel-$DATE.sql 2>/dev/null || mysqldump pterodactyl > /backup/umeshplayzz/panel-$DATE.sql 2>/dev/null || true
  tar -czf /backup/umeshplayzz/files-$DATE.tar.gz /var/www/pterodactyl /etc/pterodactyl 2>/dev/null || true
  echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
  find /backup/umeshplayzz -type f -mtime +7 -delete 2>/dev/null || true
  echo -e "${GREEN}Backup Done: /backup/umeshplayzz/panel-$DATE.sql${NC}"
}

backup_menu() {
  echo -e "${CYAN}=== BACKUP MENU ===${NC}"
  echo -e "${WHITE}1) Backup Abhi Banao${NC}"
  echo -e "${WHITE}2) Auto Backup ON (Daily 3 AM)${NC}"
  echo -e "${WHITE}3) Backup List Dekho${NC}"
  echo -e "${WHITE}0) Back${NC}"
  read -p "Option: " b
  case $b in
    1) do_backup; pause ;;
    2)
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
      (crontab -l 2>/dev/null | grep -v umeshplayzz-backup; echo "0 3 * * * /root/umeshplayzz-backup.sh") | crontab -
      ln -sf /root/umeshplayzz-backup.sh /usr/local/bin/umesh-backup
      echo -e "${GREEN}[+] Auto Backup ON! Command: umesh-backup${NC}"; pause ;;
    3) ls -lh /backup/umeshplayzz/ 2>/dev/null || echo -e "${YELLOW}Koi backup nahi hai${NC}"; pause ;;
  esac
}

sshx_system() {
  echo -e "${CYAN}[*] SSHX System...${NC}"
  if ! command -v sshx &> /dev/null; then
    echo -e "${YELLOW}SSHX install ho raha hai...${NC}"
    curl -sSf https://sshx.io/get | sh
  fi
  echo -e "${GREEN}SSHX Ready! Command: sshx${NC}"
  echo -e "${YELLOW}Link kisi anjaan ko mat dena, full terminal access milega!${NC}"
  read -p "Abhi SSHX start karna hai? (y/n): " yn
  if [[ "$yn" == "y" ]]; then sshx; fi
  pause
}

uninstall_all() {
  echo -e "${RED}WARNING: Ye pura Panel + Wings + Database uda dega!${NC}"
  read -p "Pakka uninstall karna hai? Type YES: " confirm
  if [ "$confirm" != "YES" ]; then echo -e "${YELLOW}Cancel kar diya.${NC}"; pause; return; fi
  echo -e "${CYAN}Uninstall ho raha hai...${NC}"
  systemctl stop wings nginx mysql mariadb 2>/dev/null || true
  systemctl disable wings 2>/dev/null || true
  rm -rf /var/www/pterodactyl /etc/pterodactyl /usr/local/bin/wings /etc/systemd/system/wings.service /backup/umeshplayzz
  rm -f /usr/local/bin/umesh-backup /root/umeshplayzz-backup.sh
  mysql -u root -e "DROP DATABASE IF EXISTS pterodactyl;" 2>/dev/null || true
  systemctl daemon-reload
  echo -e "${GREEN}[+] Uninstall Complete! VPS clean hai.${NC}"
  pause
}

full_install() {
  FULL_MODE=1
  echo -e "${GREEN}=== FULL INSTALL START ===${NC}"
  install_deps
  install_panel
  install_wings
  install_blueprint
  install_nebula
  do_backup
  FULL_MODE=0
  echo -e "${GREEN}✅ FULL INSTALL COMPLETE!${NC}"
  echo -e "${WHITE}Next: Panel -> Admin -> Nodes -> New Node banao${NC}"
  pause
}

# ============ MAIN MENU LOOP ============
while true; do
show_banner
echo -e "${WHITE}  [1] Full Install (Panel + Wings + Blueprint + Nebula + Backup)${NC}"
echo -e "${WHITE}  [2] Sirf Panel Install${NC}"
echo -e "${WHITE}  [3] Sirf Wings Install${NC}"
echo -e "${WHITE}  [4] Blueprint Install${NC}"
echo -e "${WHITE}  [5] Nebula Theme + Branding${NC}"
echo -e "${WHITE}  [6] Cloudflare Tunnel Setup${NC}"
echo -e "${WHITE}  [7] Backup / Restore Menu${NC}"
echo -e "${WHITE}  [8] SSHX System (Terminal Share)${NC}"
echo -e "${WHITE}  [9] Uninstall (Pura Panel Udao)${NC}"
echo -e "${RED}  [0] Exit${NC}"
echo -e "${PURPLE}============================================================${NC}"
read -p "Option chuno [0-9]: " opt
case $opt in
  1) full_install ;;
  2) install_panel ;;
  3) install_wings ;;
  4) install_blueprint ;;
  5) install_nebula ;;
  6) setup_cloudflare ;;
  7) backup_menu ;;
  8) sshx_system ;;
  9) uninstall_all ;;
  0) echo -e "${GREEN}Thanks for using UMESHPLAYZZ ❤️🔥${NC}"; exit 0 ;;
  *) echo -e "${RED}Galat option! 0-9 me se chuno.${NC}"; sleep 1 ;;
esac
done
