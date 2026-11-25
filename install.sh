#!/bin/bash
# ==================================================
#  UMESHPLAYZZ - ALL IN ONE v6.3 FINAL FIXED
#  Run: bash <(curl -s https://ptero.royalnodes.bond)
#  Minecraft Hosting - Panel + Wings + Cloudflare
#  + Blueprint + Nebula + All Extensions + Backup
#  Brand: UMESHPLAYZZ | Discord: discord.gg/royalnodes
#  YouTube: @twumeshyt | Hosted: royalnodes.bond
# ==================================================

# ===== REAL FIX FOR bash <(curl ...) =====
# bash <(...) me $0 = bash hota hai, /dev/fd nahi. Isliye stdin check karenge.
# Agar stdin pipe hai aur hum pehli baar chal rahe hai, toh khud ko file me save karke re-run karo
if [ -z "$UMESH_REEXEC" ] && [ ! -t 0 ]; then
  export UMESH_REEXEC=1
  curl -fsSL https://ptero.royalnodes.bond -o /tmp/umesh-install.sh 2>/dev/null || wget -qO /tmp/umesh-install.sh https://ptero.royalnodes.bond 2>/dev/null || true
  if [ -s /tmp/umesh-install.sh ]; then
    exec bash /tmp/umesh-install.sh
  fi
fi
exec < /dev/tty 2>/dev/null || true

export DEBIAN_FRONTEND=noninteractive
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
PINK='\033[1;35m'
NC='\033[0m'
WHITE='\033[1;37m'
FULL_MODE=0

if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}[!] Please run as root: sudo bash install.sh${NC}"
  exit 1
fi

animated_welcome() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  Loading UMESHPLAYZZ... Please Wait${NC}"
sleep 0.5
echo -e "${CYAN}  ██╗   ██╗███╗   ███╗███████╗███████╗██╗  ██╗${NC}"
echo -e "${CYAN}  ██║   ██║████╗ ████║██╔════╝██╔════╝██║  ██║${NC}"
echo -e "${CYAN}  ██║   ██║██╔████╔██║█████╗  ███████╗███████║${NC}"
echo -e "${CYAN}  ██║   ██║██║╚██╔╝██║██╔══╝  ╚════██║██╔══██║${NC}"
echo -e "${CYAN}  ╚██████╔╝██║ ╚═╝ ██║███████╗███████║██║  ██║${NC}"
echo -e "${CYAN}   ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}"
echo -e "${PURPLE}============================================================${NC}"
echo -e "${YELLOW}  🔥 UMESHPLAYZZ - ALL IN ONE v6.3 🔥${NC}"
echo -e "${GREEN}  Minecraft Hosting Setup - Lag Free | Smooth | No Error${NC}"
echo -e "${CYAN}  Discord: discord.gg/royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${PINK}  Panel | Wings | Cloudflare | Blueprint | Nebula | Extensions${NC}"
echo -e "${PURPLE}============================================================${NC}"
sleep 0.8
}
animated_welcome

animated_exit() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${GREEN}  ✅ THANK YOU FOR USING UMESHPLAYZZ ✅${NC}"
echo -e "${CYAN}  ██╗   ██╗███╗   ███╗███████╗███████╗██╗  ██╗${NC}"
echo -e "${CYAN}  ██║   ██║████╗ ████║██╔════╝██╔════╝██║  ██║${NC}"
echo -e "${CYAN}  ██║   ██║██╔████╔██║█████╗  ███████╗███████║${NC}"
echo -e "${CYAN}  ██║   ██║██║╚██╔╝██║██╔══╝  ╚════██║██╔══██║${NC}"
echo -e "${CYAN}  ╚██████╔╝██║ ╚═╝ ██║███████╗███████║██║  ██║${NC}"
echo -e "${CYAN}   ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}"
echo -e "${YELLOW}  Discord: discord.gg/royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${GREEN}  Panel: royalnodes.bond | Made with Love by UMESHPLAYZZ${NC}"
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  Closing... Bye Bye! Fir Milenge 🔥${NC}"
sleep 0.8
exit 0
}

show_banner() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  🔥 UMESHPLAYZZ - ALL IN ONE v6.3 🔥${NC}"
echo -e "${GREEN}  Minecraft Hosting | Panel | Wings | Blueprint | Nebula${NC}"
echo -e "${CYAN}  Discord: discord.gg/royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${PURPLE}============================================================${NC}"
}

pause() {
  if [ "$FULL_MODE" = "1" ]; then return; fi
  echo ""
  read -p "Press Enter to continue... " _ < /dev/tty || true
}

check_panel() {
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}[!] Pehle Panel Install Karo (Option 1)${NC}"; return 1; fi
  return 0
}
check_blueprint() {
  if ! check_panel; then return 1; fi
  if ! command -v blueprint &> /dev/null; then echo -e "${RED}[!] Pehle Blueprint Install Karo (Option 3)${NC}"; return 1; fi
  return 0
}

bp_install() {
  local name="$1"
  echo -e "${CYAN}  -> Installing: $name ...${NC}"
  if ! cd /var/www/pterodactyl 2>/dev/null; then echo -e "${RED}  Panel folder nahi mila!${NC}"; return 1; fi
  if blueprint -install "$name" < /dev/tty 2>/dev/null; then
    echo -e "${GREEN}  [OK] $name Installed!${NC}"
  elif blueprint -i "$name" < /dev/tty 2>/dev/null; then
    echo -e "${GREEN}  [OK] $name Installed!${NC}"
  else
    echo -e "${YELLOW}  [!] $name auto install nahi hua - Panel -> Blueprint -> Extensions se manually ENABLE karo${NC}"
    return 1
  fi
  php artisan view:clear 2>/dev/null || true
  php artisan config:clear 2>/dev/null || true
  chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
  return 0
}

ensure_deps() {
  if ! command -v curl &> /dev/null || ! command -v wget &> /dev/null || ! command -v git &> /dev/null; then
    echo -e "${CYAN}[*] Deps Installing... [AUTO]${NC}"
    apt update -y 2>/dev/null || true
    apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release mariadb-client 2>/dev/null || apt install -y curl wget git unzip tar zip cron 2>/dev/null || true
  fi
}
install_deps() {
  echo -e "${CYAN}[*] System Update + Deps [AUTO]${NC}"
  apt update -y || apt update || true
  apt upgrade -y || true
  apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release mariadb-client || apt install -y curl wget git unzip tar zip cron certbot python3 || true
  echo -e "${GREEN}[+] System Ready!${NC}"
}

install_docker() {
  if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}[*] Docker Installing... [AUTO]${NC}"
    curl -fsSL https://get.docker.com -o /tmp/docker.sh; sh /tmp/docker.sh; systemctl enable --now docker || true
  fi
}

install_panel() {
  ensure_deps
  echo -e "${CYAN}[*] Panel Install...${NC}"
  echo -e "${YELLOW}Ab Domain / Email / Password puchega - Yahi pe dalna hai.${NC}"
  sleep 1
  curl -fsSL -o /tmp/ptero-installer.sh https://pterodactyl-installer.se || curl -fsSL -o /tmp/ptero-installer.sh https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh
  if [ ! -s /tmp/ptero-installer.sh ]; then echo -e "${RED}[!] Download Failed! Internet check karo.${NC}"; pause; return 1; fi
  bash /tmp/ptero-installer.sh < /dev/tty
  if [ ! -d "/var/www/pterodactyl" ]; then
    echo -e "${YELLOW}Retry with GitHub installer...${NC}"
    curl -fsSL -o /tmp/ptero2.sh https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh
    bash /tmp/ptero2.sh < /dev/tty
  fi
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}[!] Panel Failed! Dobara try karo.${NC}"; pause; return 1; fi
  echo -e "${GREEN}[+] Panel Installed!${NC}"; pause; return 0
}

install_wings() {
  ensure_deps
  echo -e "${CYAN}[*] Wings Install [AUTO - Minecraft Ready]${NC}"
  install_docker
  curl -fsSL -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64" || { echo -e "${RED}[!] Wings Download Failed!${NC}"; pause; return 1; }
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
  systemctl daemon-reload; systemctl enable wings || true
  echo -e "${GREEN}[+] Wings Installed! Minecraft Servers Ready!${NC}"
  echo -e "${YELLOW}Node Setup: Panel -> Admin -> Nodes -> New Node -> Config -> /etc/pterodactyl/config.yml -> systemctl restart wings${NC}"
  pause
}

install_blueprint() {
  echo -e "${CYAN}[*] Blueprint Install [AUTO]${NC}"
  if ! check_panel; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  curl -fsSL -o /tmp/blueprint.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh || { echo -e "${RED}[!] Download Failed!${NC}"; pause; return 1; }
  printf "y\ny\ny\n" | bash /tmp/blueprint.sh || bash /tmp/blueprint.sh < /dev/tty
  ln -sf /var/www/pterodactyl/blueprint.sh /usr/local/bin/blueprint 2>/dev/null || true
  if ! command -v blueprint &> /dev/null; then echo -e "${YELLOW}[!] Blueprint command nahi mila, Panel check karo.${NC}"; pause; return 1; fi
  echo -e "${GREEN}[+] Blueprint Installed!${NC}"; pause
}

install_nebula() {
  echo -e "${CYAN}[*] Nebula Theme Install [AUTO]${NC}"
  if ! check_blueprint; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  mkdir -p /tmp/nebula && cd /tmp/nebula; rm -f nebula.blueprint nebula.zip
  wget -O nebula.blueprint "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.blueprint "https://github.com/NebulaThemes/Nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.zip "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.zip" 2>/dev/null || true
  if [ -f nebula.blueprint ] && [ -s nebula.blueprint ]; then
    cp nebula.blueprint /var/www/pterodactyl/nebula.blueprint; cd /var/www/pterodactyl || return 1; bp_install nebula || true
  elif [ -f nebula.zip ] && [ -s nebula.zip ]; then
    unzip -o nebula.zip -d /var/www/pterodactyl/; cd /var/www/pterodactyl || return 1; bp_install nebula || true
  else
    echo -e "${RED}[!] Nebula Download Failed! Panel -> Blueprint -> Extensions se upload karo.${NC}"; pause; return 1
  fi
  echo -e "${CYAN}[*] UMESHPLAYZZ Branding Applying...${NC}"
  mkdir -p /var/www/pterodactyl/public/themes/umeshplayzz
  cat > /var/www/pterodactyl/public/themes/umeshplayzz-custom.css << 'EOF'
/* UMESHPLAYZZ - MINECRAFT HOSTING */
:root { --umesh-primary: #8b5cf6; --umesh-secondary: #06b6d4; --umesh-accent: #22c55e; }
EOF
  echo "UMESHPLAYZZ - Discord: discord.gg/royalnodes - YouTube: @twumeshyt" > /var/www/pterodactyl/public/themes/umeshplayzz/readme.txt
  cd /var/www/pterodactyl || return 1
  php artisan view:clear 2>/dev/null || true; php artisan config:clear 2>/dev/null || true
  chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
  php artisan queue:restart 2>/dev/null || true; systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}[+] Nebula + UMESHPLAYZZ Branding Done! Panel -> Blueprint -> Extensions me ENABLE karo.${NC}"; pause
}

extensions_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== EXTENSIONS MENU - UMESHPLAYZZ ===${NC}"
  echo -e "${WHITE}  [1] Version Changer (Minecraft Version Change)${NC}"
  echo -e "${WHITE}  [2] Player Management (Players Manage)${NC}"
  echo -e "${WHITE}  [3] Plugin Installer (1-Click Plugins)${NC}"
  echo -e "${WHITE}  [4] Hux Register (Register System)${NC}"
  echo -e "${WHITE}  [5] Snowflakes (Winter Effect)${NC}"
  echo -e "${WHITE}  [6] MOTD Maker (Server MOTD)${NC}"
  echo -e "${WHITE}  [7] Icon Importer (Server Icon)${NC}"
  echo -e "${WHITE}  [8] Server Splitting (Split Servers)${NC}"
  echo -e "${WHITE}  [9] Allocation Manager (IPs / Ports)${NC}"
  echo -e "${WHITE}  [10] Install ALL Extensions (Popular All)${NC}"
  echo -e "${WHITE}  [0] Back to Main Menu${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  read -p "Select Extension [0-10]: " e < /dev/tty
  case $e in
    1) if check_blueprint; then bp_install "version-changer"; fi; pause ;;
    2) if check_blueprint; then bp_install "player-manager"; fi; pause ;;
    3) if check_blueprint; then bp_install "plugin-installer"; fi; pause ;;
    4) if check_blueprint; then bp_install "hux-register"; fi; pause ;;
    5) if check_blueprint; then bp_install "snowflakes"; fi; pause ;;
    6) if check_blueprint; then bp_install "motd-maker"; fi; pause ;;
    7) if check_blueprint; then bp_install "icon-importer"; fi; pause ;;
    8) if check_blueprint; then bp_install "server-splitting"; fi; pause ;;
    9) if check_blueprint; then bp_install "allocation-manager"; fi; pause ;;
    10)
      if ! check_blueprint; then pause; continue; fi
      echo -e "${CYAN}[*] Installing ALL Extensions... [AUTO]${NC}"
      for ext in version-changer player-manager plugin-installer hux-register snowflakes motd-maker icon-importer server-splitting allocation-manager; do bp_install "$ext" || true; done
      cd /var/www/pterodactyl 2>/dev/null || true; chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true; php artisan queue:restart 2>/dev/null || true; systemctl restart nginx 2>/dev/null || true
      echo -e "${GREEN}[+] ALL Extensions Process Done! Panel -> Blueprint -> Extensions me ENABLE karo.${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

setup_cloudflare() {
  ensure_deps
  echo -e "${CYAN}[*] Cloudflare Tunnel Setup...${NC}"
  echo -e "${YELLOW}Abhi Token puchega - Yahi pe dalna hai.${NC}"
  read -p "Enter Cloudflare Tunnel Token: " CF_TOKEN < /dev/tty
  CF_TOKEN=$(echo "$CF_TOKEN" | tr -d ' ' | tr -d '\n' | tr -d '\r')
  if [ -z "$CF_TOKEN" ]; then echo -e "${RED}[!] Token Empty!${NC}"; pause; return 1; fi
  echo -e "${CYAN}Installing cloudflared... [AUTO]${NC}"
  curl -fsSL --output /tmp/cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb" || { echo -e "${RED}[!] Download Failed!${NC}"; pause; return 1; }
  dpkg -i /tmp/cloudflared.deb || apt -f install -y || true
  cloudflared service install "$CF_TOKEN" || { echo -e "${RED}[!] Cloudflare Install Failed! Token check karo.${NC}"; pause; return 1; }
  systemctl enable cloudflared || true; systemctl restart cloudflared || true
  echo -e "${GREEN}[+] Cloudflare Connected!${NC}"; pause
}

do_backup() {
  mkdir -p /backup/umeshplayzz
  DATE=$(date +%F-%H-%M)
  DB_PASS=""; DB_USER="pterodactyl"; DB_NAME="pterodactyl"
  if [ -f /var/www/pterodactyl/.env ]; then
    DB_PASS=$(grep "^DB_PASSWORD=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_USER=$(grep "^DB_USERNAME=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_NAME=$(grep "^DB_DATABASE=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_USER=${DB_USER:-pterodactyl}; DB_NAME=${DB_NAME:-pterodactyl}
  fi
  echo -e "${CYAN}Creating Backup... [AUTO]${NC}"
  if [ -n "$DB_PASS" ]; then mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true
  else mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true; fi
  tar -czf "/backup/umeshplayzz/files-$DATE.tar.gz" /var/www/pterodactyl /etc/pterodactyl 2>/dev/null || true
  echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
  find /backup/umeshplayzz -type f -mtime +7 -delete 2>/dev/null || true
  if [ -f "/backup/umeshplayzz/files-$DATE.tar.gz" ]; then echo -e "${GREEN}[+] Backup Done: /backup/umeshplayzz/files-$DATE.tar.gz${NC}"; else echo -e "${YELLOW}[!] Backup file nahi bana, Panel install hai ya nahi check karo.${NC}"; fi
}

upload_backup_to_website() {
  echo -e "${CYAN}=== BACKUP UPLOAD TO WEBSITE ===${NC}"
  echo -e "${YELLOW}Backup ko website pe upload karo - Data Loss ka tension khatam.${NC}"
  echo -e "${WHITE}Example: https://royalnodes.bond/upload.php${NC}"
  read -p "Enter Upload URL (Enter to skip): " UPLOAD_URL < /dev/tty
  if [ -z "$UPLOAD_URL" ]; then echo -e "${YELLOW}Upload Skipped - Local Backup hi rahega.${NC}"; return; fi
  LATEST=$(ls -t /backup/umeshplayzz/files-*.tar.gz 2>/dev/null | head -1)
  if [ -z "$LATEST" ]; then echo -e "${RED}[!] Koi backup nahi mila! Pehle backup banao.${NC}"; return; fi
  echo -e "${CYAN}Uploading $LATEST ...${NC}"
  if curl -fsSL -F "file=@$LATEST" "$UPLOAD_URL" > /dev/null 2>&1; then echo -e "${GREEN}[+] Backup Website pe Upload Ho Gaya!${NC}"; else echo -e "${RED}[!] Upload Failed! URL check karo.${NC}"; fi
}

setup_backup_auto() {
  echo -e "${CYAN}[*] Auto Backup Setup [AUTO]${NC}"
  cat > /root/umeshplayzz-backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%F-%H-%M)
mkdir -p /backup/umeshplayzz
DB_PASS=$(grep "^DB_PASSWORD=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_USER=$(grep "^DB_USERNAME=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_NAME=$(grep "^DB_DATABASE=" /var/www/pterodactyl/.env 2>/dev/null | cut -d '=' -f2 | tr -d '"' | tr -d "'")
DB_USER=${DB_USER:-pterodactyl}; DB_NAME=${DB_NAME:-pterodactyl}
if [ -n "$DB_PASS" ]; then mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql 2>/dev/null || mysqldump -u root "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql
else mysqldump -u root "$DB_NAME" > /backup/umeshplayzz/panel-$DATE.sql; fi
tar -czf /backup/umeshplayzz/files-$DATE.tar.gz /var/www/pterodactyl /etc/pterodactyl 2>/dev/null
echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
find /backup/umeshplayzz -type f -mtime +7 -delete
EOF
  chmod +x /root/umeshplayzz-backup.sh
  (crontab -l 2>/dev/null | grep -v umeshplayzz-backup; echo "0 3 * * * /root/umeshplayzz-backup.sh") | crontab -
  ln -sf /root/umeshplayzz-backup.sh /usr/local/bin/umesh-backup
  do_backup
  echo -e "${GREEN}[+] Auto Backup ON! Daily 3 AM | Command: umesh-backup${NC}"
}

backup_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== BACKUP MENU - NO DATA LOSS ===${NC}"
  echo -e "${WHITE}  [1] Create Backup Now [AUTO]${NC}"
  echo -e "${WHITE}  [2] Enable Auto Backup (Daily 3 AM) [AUTO]${NC}"
  echo -e "${WHITE}  [3] Upload Backup to Website [AUTO]${NC}"
  echo -e "${WHITE}  [4] View Backup List${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  read -p "Select [0-4]: " b < /dev/tty
  case $b in
    1) do_backup; pause ;;
    2) setup_backup_auto; pause ;;
    3) upload_backup_to_website; pause ;;
    4) ls -lh /backup/umeshplayzz/ 2>/dev/null || echo -e "${YELLOW}No backups.${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

sshx_system() {
  echo -e "${CYAN}[*] SSHX System [AUTO]${NC}"
  if ! command -v sshx &> /dev/null; then curl -sSf https://sshx.io/get -o /tmp/sshx.sh; sh /tmp/sshx.sh; fi
  echo -e "${GREEN}SSHX Ready! Command: sshx${NC}"
  echo -e "${YELLOW}WARNING: Link kisi stranger ko mat dena!${NC}"
  read -p "Start SSHX now? (y/n): " yn < /dev/tty
  if [[ "$yn" == "y" || "$yn" == "Y" ]]; then sshx; fi
  pause
}

update_system() {
  echo -e "${CYAN}[*] Updating System + Panel + Blueprint + Wings [AUTO]${NC}"
  apt update && apt upgrade -y; apt autoremove -y || true
  if [ -d "/var/www/pterodactyl" ]; then
    cd /var/www/pterodactyl || return 1
    php artisan down 2>/dev/null || true
    php artisan migrate --seed --force 2>/dev/null || true
    php artisan view:clear 2>/dev/null || true; php artisan config:clear 2>/dev/null || true
    chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
    php artisan queue:restart 2>/dev/null || true; php artisan up 2>/dev/null || true
    blueprint -update < /dev/tty 2>/dev/null || { curl -fsSL -o /tmp/bp-up.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh; bash /tmp/bp-up.sh < /dev/tty; } || true
    echo -e "${GREEN}[+] Panel + Blueprint Updated!${NC}"
  fi
  if [ -f /usr/local/bin/wings ]; then
    curl -fsSL -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64" || true
    chmod u+x /usr/local/bin/wings; systemctl restart wings 2>/dev/null || true
    echo -e "${GREEN}[+] Wings Updated!${NC}"
  fi
  systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}✅ EVERYTHING UPDATED!${NC}"; pause
}

uninstall_all() {
  echo -e "${RED}WARNING: Panel + Wings + Database Delete Ho Jayega!${NC}"
  read -p "Are you sure? Type YES to confirm: " confirm < /dev/tty
  if [ "$confirm" != "YES" ]; then echo -e "${YELLOW}Cancelled.${NC}"; pause; return; fi
  systemctl stop wings nginx mysql mariadb 2>/dev/null || true; systemctl disable wings 2>/dev/null || true
  rm -rf /var/www/pterodactyl /etc/pterodactyl /usr/local/bin/wings /etc/systemd/system/wings.service /backup/umeshplayzz
  rm -f /usr/local/bin/umesh-backup /root/umeshplayzz-backup.sh
  mysql -u root -e "DROP DATABASE IF EXISTS pterodactyl;" 2>/dev/null || true
  systemctl daemon-reload
  echo -e "${GREEN}[+] Uninstall Complete! VPS Clean.${NC}"; pause
}

full_install() {
  FULL_MODE=1
  echo -e "${GREEN}=== FULL AUTO INSTALL STARTED ===${NC}"
  echo -e "${YELLOW}Panel me Domain / Email / Password tum daloge, baaki sab AUTO.${NC}"
  sleep 1
  install_deps
  if ! install_panel; then echo -e "${RED}[!] Panel Fail, Full Install Ruk Gaya.${NC}"; FULL_MODE=0; pause; return 1; fi
  install_wings
  install_blueprint
  install_nebula
  echo -e "${CYAN}[*] Installing ALL Extensions [AUTO]${NC}"
  if check_blueprint; then for ext in version-changer player-manager plugin-installer hux-register snowflakes motd-maker icon-importer server-splitting allocation-manager; do bp_install "$ext" || true; done; fi
  setup_backup_auto
  FULL_MODE=0
  show_banner
  echo -e "${GREEN}✅ FULL AUTO INSTALL COMPLETE! ✅${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  echo -e "${WHITE}Panel + Wings + Blueprint + Nebula + All Extensions Done!${NC}"
  echo -e "${CYAN}Backup: Daily 3 AM | Command: umesh-backup${NC}"
  echo -e "${YELLOW}LAST STEP:${NC}"
  echo -e "${WHITE}1. Panel -> Admin -> Nodes -> New Node${NC}"
  echo -e "${WHITE}2. Config -> nano /etc/pterodactyl/config.yml${NC}"
  echo -e "${WHITE}3. systemctl restart wings${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  pause
}

while true; do
show_banner
echo -e "${WHITE}  [1] Panel Install (Domain Yahi Puchega)${NC}"
echo -e "${WHITE}  [2] Wings Install [AUTO - Minecraft Ready]${NC}"
echo -e "${WHITE}  [3] Blueprint Install [AUTO]${NC}"
echo -e "${WHITE}  [4] Nebula Theme + UMESHPLAYZZ Branding [AUTO]${NC}"
echo -e "${WHITE}  [5] Extensions Menu (Version Changer, Player Manager, Plugin Installer, Hux, Snowflakes, MOTD, Icon, All)${NC}"
echo -e "${WHITE}  [6] Cloudflare Tunnel Setup (Token Yahi Puchega)${NC}"
echo -e "${WHITE}  [7] Backup Menu (Backup + Website Upload + Auto Backup)${NC}"
echo -e "${WHITE}  [8] SSHX System${NC}"
echo -e "${WHITE}  [9] Update System (Panel + Blueprint + Wings) [AUTO]${NC}"
echo -e "${WHITE}  [10] FULL AUTO - Panel + Wings + Blueprint + Nebula + All Extensions + Backup${NC}"
echo -e "${WHITE}  [11] Uninstall${NC}"
echo -e "${RED}  [0] Exit${NC}"
echo -e "${PURPLE}============================================================${NC}"
read -p "Select Option [0-11]: " opt < /dev/tty
case $opt in
  1) install_panel ;;
  2) install_wings ;;
  3) install_blueprint ;;
  4) install_nebula ;;
  5) extensions_menu ;;
  6) setup_cloudflare ;;
  7) backup_menu ;;
  8) sshx_system ;;
  9) update_system ;;
  10) full_install ;;
  11) uninstall_all ;;
  0) animated_exit ;;
  *) echo -e "${RED}Invalid option! Choose 0-11.${NC}"; sleep 1 ;;
esac
done
