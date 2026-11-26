#!/bin/bash
# ==================================================
#  UMESHPLAYZZ - ALL IN ONE v7.2 COMPACT MENU
#  Run: bash <(curl -s https://ptero.royalnodes.bond)
#  Minecraft Hosting - Panel + Wings + Cloudflare
#  + Blueprint + Themes + Extensions + Backup + Restore
#  + Node + SSL + Firewall + Performance + Panel Tools
#  Brand: UMESHPLAYZZ | Discord: discord.gg/royalnodes
#  YouTube: @twumeshyt | Hosted: royalnodes.bond
# ==================================================

if [ -z "$UMESH_REEXEC" ] && [ ! -t 0 ]; then
  export UMESH_REEXEC=1
  curl -fsSL https://ptero.royalnodes.bond -o /tmp/umesh-install.sh 2>/dev/null || wget -qO /tmp/umesh-install.sh https://ptero.royalnodes.bond 2>/dev/null || true
  if [ -s /tmp/umesh-install.sh ]; then
    exec bash /tmp/umesh-install.sh
  fi
fi

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

clean_input() {
  echo "$1" | tr -d ' \r\n\t' | tr '[:upper:]' '[:lower:]'
}
ask() {
  local prompt="$1" var="$2" raw=""
  IFS= read -r -p "$prompt" raw || true
  raw=$(echo "$raw" | tr -d '\r')
  printf -v "$var" "%s" "$raw"
}

animated_welcome() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  Loading UMESHPLAYZZ... Please Wait${NC}"
sleep 0.4
echo -e "${CYAN}  ██╗   ██╗███╗   ███╗███████╗███████╗██╗  ██╗${NC}"
echo -e "${CYAN}  ██║   ██║████╗ ████║██╔════╝██╔════╝██║  ██║${NC}"
echo -e "${CYAN}  ██║   ██║██╔████╔██║█████╗  ███████╗███████║${NC}"
echo -e "${CYAN}  ██║   ██║██║╚██╔╝██║██╔══╝  ╚════██║██╔══██║${NC}"
echo -e "${CYAN}  ╚██████╔╝██║ ╚═╝ ██║███████╗███████║██║  ██║${NC}"
echo -e "${CYAN}   ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝${NC}"
echo -e "${PURPLE}============================================================${NC}"
echo -e "${YELLOW}  🔥 UMESHPLAYZZ - ALL IN ONE v7.2 COMPACT 🔥${NC}"
echo -e "${GREEN}  Minecraft Hosting Setup - Lag Free | Smooth | No Error${NC}"
echo -e "${CYAN}  Discord: discord.gg/royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${PINK}  Panel | Wings | Blueprint | Themes | Extensions${NC}"
echo -e "${PINK}  Cloudflare | SSL | Backup | Node | Performance${NC}"
echo -e "${PURPLE}============================================================${NC}"
sleep 0.6
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
echo -e "${CYAN}  Closing... Bye Bye! See You Again 🔥${NC}"
sleep 0.6
exit 0
}

show_banner() {
clear
echo -e "${PURPLE}============================================================${NC}"
echo -e "${CYAN}  🔥 UMESHPLAYZZ - ALL IN ONE v7.2 🔥${NC}"
echo -e "${GREEN}  Minecraft Hosting | Panel | Wings | Blueprint | Themes${NC}"
echo -e "${CYAN}  Discord: discord.gg/royalnodes | YouTube: @twumeshyt${NC}"
echo -e "${PURPLE}============================================================${NC}"
}

pause() {
  if [ "$FULL_MODE" = "1" ]; then return; fi
  echo ""
  IFS= read -r -p "Press Enter to continue... " _ || true
}

check_panel() {
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}[!] Please install Panel first${NC}"; return 1; fi
  return 0
}
check_blueprint() {
  if ! check_panel; then return 1; fi
  if ! command -v blueprint &> /dev/null; then echo -e "${RED}[!] Please install Blueprint first${NC}"; return 1; fi
  return 0
}
check_wings() {
  if [ ! -f /usr/local/bin/wings ]; then echo -e "${RED}[!] Please install Wings first${NC}"; return 1; fi
  return 0
}

bp_install() {
  local name="$1"
  echo -e "${CYAN}  -> Installing: $name ...${NC}"
  if ! cd /var/www/pterodactyl 2>/dev/null; then echo -e "${RED}  Panel folder not found!${NC}"; return 1; fi
  if blueprint -install "$name"; then
    echo -e "${GREEN}  [OK] $name Installed!${NC}"
  elif blueprint -i "$name"; then
    echo -e "${GREEN}  [OK] $name Installed!${NC}"
  else
    echo -e "${YELLOW}  [!] $name auto install failed - Enable manually in Panel Blueprint Extensions${NC}"
    return 1
  fi
  php artisan view:clear 2>/dev/null || true
  php artisan config:clear 2>/dev/null || true
  chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
  return 0
}

ensure_deps() {
  if ! command -v curl &> /dev/null || ! command -v wget &> /dev/null || ! command -v git &> /dev/null; then
    echo -e "${CYAN}[*] Installing Dependencies...${NC}"
    apt update -y 2>/dev/null || true
    apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release mariadb-client htop net-tools ufw 2>/dev/null || apt install -y curl wget git unzip tar zip cron 2>/dev/null || true
  fi
}
install_deps() {
  echo -e "${CYAN}[*] System Update + Dependencies...${NC}"
  apt update -y || apt update || true
  apt upgrade -y || true
  apt install -y curl wget sudo git unzip tar zip cron certbot python3 software-properties-common apt-transport-https ca-certificates gnupg lsb-release mariadb-client htop net-tools ufw || apt install -y curl wget git unzip tar zip cron certbot python3 || true
  echo -e "${GREEN}[+] System Ready!${NC}"
}
install_docker() {
  if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}[*] Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o /tmp/docker.sh; sh /tmp/docker.sh; systemctl enable --now docker || true
  fi
}

# ============ INSTALL - PANEL + WINGS ============
install_panel() {
  ensure_deps
  echo -e "${CYAN}[*] Panel Install...${NC}"
  sleep 1
  curl -fsSL -o /tmp/ptero-installer.sh https://pterodactyl-installer.se || curl -fsSL -o /tmp/ptero-installer.sh https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh
  if [ ! -s /tmp/ptero-installer.sh ]; then echo -e "${RED}[!] Download Failed! Check Internet.${NC}"; pause; return 1; fi
  bash /tmp/ptero-installer.sh
  if [ ! -d "/var/www/pterodactyl" ]; then
    echo -e "${YELLOW}Retrying with GitHub installer...${NC}"
    curl -fsSL -o /tmp/ptero2.sh https://raw.githubusercontent.com/pterodactyl-installer/pterodactyl-installer/master/install.sh
    bash /tmp/ptero2.sh
  fi
  if [ ! -d "/var/www/pterodactyl" ]; then echo -e "${RED}[!] Panel Install Failed! Try Again.${NC}"; pause; return 1; fi
  echo -e "${GREEN}[+] Panel Installed!${NC}"; pause; return 0
}
install_wings() {
  ensure_deps
  echo -e "${CYAN}[*] Wings Install...${NC}"
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
  echo -e "${GREEN}[+] Wings Installed!${NC}"
  echo -e "${YELLOW}Node Setup: Use Node Menu - Paste Config${NC}"
  pause
}
install_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== INSTALL MENU ===${NC}"
  echo -e "${WHITE}  [1] Panel Install${NC}"
  echo -e "${WHITE}  [2] Wings Install${NC}"
  echo -e "${WHITE}  [3] Install Panel + Wings Both${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-3: " i_raw; i=$(clean_input "$i_raw")
  case $i in
    1) install_panel ;;
    2) install_wings ;;
    3) install_panel && install_wings ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ BLUEPRINT + THEMES ============
install_blueprint() {
  echo -e "${CYAN}[*] Blueprint Install...${NC}"
  if ! check_panel; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  curl -fsSL -o /tmp/blueprint.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh || { echo -e "${RED}[!] Download Failed!${NC}"; pause; return 1; }
  printf "y\ny\ny\n" | bash /tmp/blueprint.sh || bash /tmp/blueprint.sh
  ln -sf /var/www/pterodactyl/blueprint.sh /usr/local/bin/blueprint 2>/dev/null || true
  if ! command -v blueprint &> /dev/null; then echo -e "${YELLOW}[!] Blueprint command not found, Check Panel.${NC}"; pause; return 1; fi
  echo -e "${GREEN}[+] Blueprint Installed!${NC}"; pause
}
install_nebula() {
  echo -e "${CYAN}[*] Nebula Theme Install...${NC}"
  if ! check_blueprint; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  mkdir -p /tmp/nebula && cd /tmp/nebula; rm -f nebula.blueprint nebula.zip
  wget -O nebula.blueprint "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.blueprint "https://github.com/NebulaThemes/Nebula/releases/latest/download/nebula.blueprint" 2>/dev/null || wget -O nebula.zip "https://github.com/BlueprintFramework/nebula/releases/latest/download/nebula.zip" 2>/dev/null || true
  if [ -f nebula.blueprint ] && [ -s nebula.blueprint ]; then
    cp nebula.blueprint /var/www/pterodactyl/nebula.blueprint; cd /var/www/pterodactyl || return 1; bp_install nebula || true
  elif [ -f nebula.zip ] && [ -s nebula.zip ]; then
    unzip -o nebula.zip -d /var/www/pterodactyl/; cd /var/www/pterodactyl || return 1; bp_install nebula || true
  else
    echo -e "${RED}[!] Nebula Download Failed! Upload manually in Panel Blueprint Extensions${NC}"; pause; return 1
  fi
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
  echo -e "${GREEN}[+] Nebula Installed! Enable it in Panel Blueprint Extensions${NC}"; pause
}
install_theme_generic() {
  local theme_name="$1"
  echo -e "${CYAN}[*] $theme_name Theme Install...${NC}"
  if ! check_blueprint; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  bp_install "$theme_name" || echo -e "${YELLOW}[!] $theme_name not found in Blueprint - Check Panel Blueprint Extensions for available themes${NC}"
  pause
}
blueprint_themes_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== BLUEPRINT + THEMES ===${NC}"
  echo -e "${WHITE}  [1] Blueprint Install${NC}"
  echo -e "${WHITE}  [2] Nebula Theme${NC}"
  echo -e "${WHITE}  [3] Enigma Theme${NC}"
  echo -e "${WHITE}  [4] Reaper Theme${NC}"
  echo -e "${WHITE}  [5] Midnight Theme${NC}"
  echo -e "${WHITE}  [6] Update Blueprint${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-6: " bt_raw; bt=$(clean_input "$bt_raw")
  case $bt in
    1) install_blueprint ;;
    2) install_nebula ;;
    3) install_theme_generic "enigma" ;;
    4) install_theme_generic "reaper" ;;
    5) install_theme_generic "midnight" ;;
    6) printf "y\n" | blueprint -update 2>/dev/null || { curl -fsSL -o /tmp/bp-up.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh; bash /tmp/bp-up.sh; } || true; echo -e "${GREEN}[+] Blueprint Updated!${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ EXTENSIONS - 12 OPTIONS ============
extensions_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== EXTENSIONS MENU ===${NC}"
  echo -e "${WHITE}  [1] Version Changer${NC}"
  echo -e "${WHITE}  [2] Player Management${NC}"
  echo -e "${WHITE}  [3] Plugin Installer${NC}"
  echo -e "${WHITE}  [4] Hux Register${NC}"
  echo -e "${WHITE}  [5] Snowflakes${NC}"
  echo -e "${WHITE}  [6] MOTD Maker${NC}"
  echo -e "${WHITE}  [7] Icon Importer${NC}"
  echo -e "${WHITE}  [8] Server Splitting${NC}"
  echo -e "${WHITE}  [9] Allocation Manager${NC}"
  echo -e "${WHITE}  [10] Server Importer${NC}"
  echo -e "${WHITE}  [11] File Manager${NC}"
  echo -e "${WHITE}  [12] Install All Extensions${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select Extension 0-12: " e_raw; e=$(clean_input "$e_raw")
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
    10) if check_blueprint; then bp_install "server-importer"; fi; pause ;;
    11) if check_blueprint; then bp_install "file-manager"; fi; pause ;;
    12)
      if ! check_blueprint; then pause; continue; fi
      echo -e "${CYAN}[*] Installing All Extensions...${NC}"
      for ext in version-changer player-manager plugin-installer hux-register snowflakes motd-maker icon-importer server-splitting allocation-manager server-importer file-manager; do bp_install "$ext" || true; done
      cd /var/www/pterodactyl 2>/dev/null || true; chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true; php artisan queue:restart 2>/dev/null || true; systemctl restart nginx 2>/dev/null || true
      echo -e "${GREEN}[+] All Extensions Installed! Enable in Panel Blueprint Extensions${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ NETWORK - CLOUDFLARE + SSL + FIREWALL ============
setup_cloudflare() {
  ensure_deps
  echo -e "${CYAN}[*] Cloudflare Tunnel Setup...${NC}"
  ask "Enter Cloudflare Tunnel Token: " CF_TOKEN_RAW
  CF_TOKEN=$(echo "$CF_TOKEN_RAW" | tr -d ' \r\n\t')
  if [ -z "$CF_TOKEN" ]; then echo -e "${RED}[!] Token Empty!${NC}"; pause; return 1; fi
  echo -e "${CYAN}Installing cloudflared...${NC}"
  curl -fsSL --output /tmp/cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb" || { echo -e "${RED}[!] Download Failed!${NC}"; pause; return 1; }
  dpkg -i /tmp/cloudflared.deb || apt -f install -y || true
  cloudflared service install "$CF_TOKEN" || { echo -e "${RED}[!] Cloudflare Install Failed! Check Token.${NC}"; pause; return 1; }
  systemctl enable cloudflared || true; systemctl restart cloudflared || true
  echo -e "${GREEN}[+] Cloudflare Connected!${NC}"; pause
}
ssl_setup() {
  echo -e "${CYAN}[*] SSL Setup...${NC}"
  if ! check_panel; then pause; return 1; fi
  ask "Enter Your Domain Example panel.royalnodes.bond: " SSL_DOMAIN_RAW
  SSL_DOMAIN=$(echo "$SSL_DOMAIN_RAW" | tr -d ' \r\n\t')
  if [ -z "$SSL_DOMAIN" ]; then echo -e "${RED}[!] Domain Empty!${NC}"; pause; return 1; fi
  ask "Enter Email: " SSL_EMAIL_RAW
  SSL_EMAIL=$(echo "$SSL_EMAIL_RAW" | tr -d ' \r\n\t')
  if [ -z "$SSL_EMAIL" ]; then SSL_EMAIL="admin@$SSL_DOMAIN"; fi
  certbot --nginx -d "$SSL_DOMAIN" --non-interactive --agree-tos -m "$SSL_EMAIL" 2>/dev/null || certbot --nginx -d "$SSL_DOMAIN" 2>/dev/null || echo -e "${YELLOW}SSL failed - Check domain points to this VPS IP${NC}"
  systemctl restart nginx 2>/dev/null || true
  echo -e "${GREEN}[+] SSL Done!${NC}"; pause
}
firewall_setup() {
  echo -e "${CYAN}[*] Firewall Setup...${NC}"
  ensure_deps
  ufw allow 22/tcp 2>/dev/null || true
  ufw allow 80/tcp 2>/dev/null || true
  ufw allow 443/tcp 2>/dev/null || true
  ufw allow 8080/tcp 2>/dev/null || true
  ufw allow 2022/tcp 2>/dev/null || true
  ufw allow 25565:25575/tcp 2>/dev/null || true
  ufw --force enable 2>/dev/null || true
  ufw status 2>/dev/null || true
  echo -e "${GREEN}[+] Firewall ON - Ports 22, 80, 443, 8080, 2022, 25565-25575 Open${NC}"; pause
}
network_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== NETWORK MENU ===${NC}"
  echo -e "${WHITE}  [1] Cloudflare Tunnel Setup${NC}"
  echo -e "${WHITE}  [2] SSL Setup${NC}"
  echo -e "${WHITE}  [3] Firewall Setup${NC}"
  echo -e "${WHITE}  [4] SSHX System${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-4: " n_raw; n=$(clean_input "$n_raw")
  case $n in
    1) setup_cloudflare ;;
    2) ssl_setup ;;
    3) firewall_setup ;;
    4) sshx_system ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}
sshx_system() {
  echo -e "${CYAN}[*] SSHX System...${NC}"
  if ! command -v sshx &> /dev/null; then curl -sSf https://sshx.io/get -o /tmp/sshx.sh; sh /tmp/sshx.sh; fi
  echo -e "${GREEN}SSHX Ready! Command: sshx${NC}"
  echo -e "${YELLOW}WARNING: Do not share link with strangers!${NC}"
  ask "Start SSHX now? Type y or n: " yn_raw; yn=$(clean_input "$yn_raw")
  if [ "$yn" = "y" ]; then sshx; fi
  pause
}

# ============ BACKUP + RESTORE ============
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
  echo -e "${CYAN}Creating Backup...${NC}"
  if [ -n "$DB_PASS" ]; then mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true
  else mysqldump -u root "$DB_NAME" > "/backup/umeshplayzz/panel-$DATE.sql" 2>/dev/null || true; fi
  tar -czf "/backup/umeshplayzz/files-$DATE.tar.gz" /var/www/pterodactyl /etc/pterodactyl 2>/dev/null || true
  echo "Backup Done: $DATE" >> /backup/umeshplayzz/log.txt
  find /backup/umeshplayzz -type f -mtime +7 -delete 2>/dev/null || true
  if [ -f "/backup/umeshplayzz/files-$DATE.tar.gz" ]; then echo -e "${GREEN}[+] Backup Done: /backup/umeshplayzz/files-$DATE.tar.gz${NC}"; else echo -e "${YELLOW}[!] Backup file not created, Check Panel install.${NC}"; fi
}
upload_backup_to_website() {
  echo -e "${CYAN}=== BACKUP UPLOAD TO WEBSITE ===${NC}"
  echo -e "${WHITE}Example: https://royalnodes.bond/upload.php${NC}"
  ask "Enter Upload URL or press Enter to skip: " UPLOAD_URL_RAW
  UPLOAD_URL=$(echo "$UPLOAD_URL_RAW" | tr -d ' \r\n\t')
  if [ -z "$UPLOAD_URL" ]; then echo -e "${YELLOW}Upload Skipped - Local Backup only.${NC}"; return; fi
  LATEST=$(ls -t /backup/umeshplayzz/files-*.tar.gz 2>/dev/null | head -1)
  if [ -z "$LATEST" ]; then echo -e "${RED}[!] No backup found! Create backup first.${NC}"; return; fi
  echo -e "${CYAN}Uploading $LATEST ...${NC}"
  if curl -fsSL -F "file=@$LATEST" "$UPLOAD_URL" > /dev/null 2>&1; then echo -e "${GREEN}[+] Backup Uploaded to Website!${NC}"; else echo -e "${RED}[!] Upload Failed! Check URL.${NC}"; fi
}
restore_backup() {
  echo -e "${CYAN}=== RESTORE BACKUP ===${NC}"
  ls -lh /backup/umeshplayzz/ 2>/dev/null || { echo -e "${RED}[!] No backups found${NC}"; pause; return; }
  ask "Enter Backup File Name Example files-2026-01-01.tar.gz: " RESTORE_FILE_RAW
  RESTORE_FILE=$(echo "$RESTORE_FILE_RAW" | tr -d ' \r\n\t')
  if [ ! -f "/backup/umeshplayzz/$RESTORE_FILE" ]; then echo -e "${RED}[!] File not found!${NC}"; pause; return; fi
  ask "Are you sure? Type YES to restore: " RESTORE_CONFIRM_RAW
  RESTORE_CONFIRM=$(clean_input "$RESTORE_CONFIRM_RAW")
  if [ "$RESTORE_CONFIRM" != "yes" ]; then echo -e "${YELLOW}Cancelled${NC}"; pause; return; fi
  echo -e "${CYAN}Restoring Files...${NC}"
  tar -xzf "/backup/umeshplayzz/$RESTORE_FILE" -C / 2>/dev/null || true
  SQL_FILE=$(echo "$RESTORE_FILE" | sed 's/files-/panel-/; s/.tar.gz/.sql/')
  if [ -f "/backup/umeshplayzz/$SQL_FILE" ] && [ -f /var/www/pterodactyl/.env ]; then
    echo -e "${CYAN}Restoring Database $SQL_FILE ...${NC}"
    DB_PASS=$(grep "^DB_PASSWORD=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_USER=$(grep "^DB_USERNAME=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    DB_NAME=$(grep "^DB_DATABASE=" /var/www/pterodactyl/.env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "/backup/umeshplayzz/$SQL_FILE" 2>/dev/null || mysql -u root "$DB_NAME" < "/backup/umeshplayzz/$SQL_FILE" 2>/dev/null || echo -e "${YELLOW}Database restore failed, files restored${NC}"
  fi
  chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
  systemctl restart nginx 2>/dev/null || true
  systemctl restart wings 2>/dev/null || true
  echo -e "${GREEN}[+] Restore Done! Files + Database Restored${NC}"; pause
}
setup_backup_auto() {
  echo -e "${CYAN}[*] Auto Backup Setup...${NC}"
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
  echo -e "${CYAN}=== BACKUP MENU ===${NC}"
  echo -e "${WHITE}  [1] Create Backup Now${NC}"
  echo -e "${WHITE}  [2] Enable Auto Backup${NC}"
  echo -e "${WHITE}  [3] Upload Backup to Website${NC}"
  echo -e "${WHITE}  [4] Restore Backup${NC}"
  echo -e "${WHITE}  [5] View Backup List${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-5: " b_raw; b=$(clean_input "$b_raw")
  case $b in
    1) do_backup; pause ;;
    2) setup_backup_auto; pause ;;
    3) upload_backup_to_website; pause ;;
    4) restore_backup ;;
    5) ls -lh /backup/umeshplayzz/ 2>/dev/null || echo -e "${YELLOW}No backups.${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ NODE + WINGS ============
node_setup() {
  echo -e "${CYAN}=== NODE SETUP ===${NC}"
  if ! check_wings; then pause; return 1; fi
  echo -e "${WHITE}Step 1: Go to Panel Admin Nodes New Node and create Node${NC}"
  echo -e "${WHITE}Step 2: Copy Node Config YAML${NC}"
  echo -e "${WHITE}Step 3: Paste below - Type END in new line to finish${NC}"
  echo -e "${YELLOW}Paste Config - Press Enter then paste, then type END:${NC}"
  [ -f /etc/pterodactyl/config.yml ] && cp /etc/pterodactyl/config.yml /etc/pterodactyl/config.yml.bak 2>/dev/null || true
  : > /tmp/new-config.yml
  while IFS= read -r line; do
    line=$(echo "$line" | tr -d '\r')
    if [ "$(clean_input "$line")" = "end" ]; then break; fi
    echo "$line" >> /tmp/new-config.yml
  done
  if [ -s /tmp/new-config.yml ]; then
    cp /tmp/new-config.yml /etc/pterodactyl/config.yml
    chmod 600 /etc/pterodactyl/config.yml
    echo -e "${GREEN}Config Saved! Restarting Wings...${NC}"
    systemctl restart wings 2>/dev/null || true
    sleep 2
    systemctl status wings --no-pager 2>/dev/null | head -15 || true
    echo -e "${GREEN}[+] Node Setup Done! Wings Running${NC}"
  else
    echo -e "${RED}[!] Config Empty! Old Config Restored${NC}"
    [ -f /etc/pterodactyl/config.yml.bak ] && cp /etc/pterodactyl/config.yml.bak /etc/pterodactyl/config.yml 2>/dev/null || true
  fi
  pause
}
wings_restart() {
  echo -e "${CYAN}[*] Restarting Wings...${NC}"
  systemctl restart wings 2>/dev/null || true
  sleep 2
  systemctl status wings --no-pager 2>/dev/null | head -12 || true
  echo -e "${GREEN}[+] Wings Restarted${NC}"; pause
}
node_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== NODE + WINGS MENU ===${NC}"
  echo -e "${WHITE}  [1] Node Setup - Paste Config${NC}"
  echo -e "${WHITE}  [2] Wings Restart${NC}"
  echo -e "${WHITE}  [3] Wings Status${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-3: " nd_raw; nd=$(clean_input "$nd_raw")
  case $nd in
    1) node_setup ;;
    2) wings_restart ;;
    3) systemctl status wings --no-pager 2>/dev/null | head -20 || echo -e "${YELLOW}Wings not running${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ PANEL TOOLS ============
panel_user_create() {
  echo -e "${CYAN}=== CREATE PANEL USER ===${NC}"
  if ! check_panel; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  echo -e "${YELLOW}Panel will ask Email Username Password, enter there${NC}"
  php artisan p:user:make
  echo -e "${GREEN}[+] User Create Done!${NC}"; pause
}
panel_password_reset() {
  echo -e "${CYAN}=== PASSWORD RESET ===${NC}"
  if ! check_panel; then pause; return 1; fi
  cd /var/www/pterodactyl || return 1
  ask "Enter User Email: " PR_EMAIL_RAW
  PR_EMAIL=$(echo "$PR_EMAIL_RAW" | tr -d ' \r\n\t')
  if [ -z "$PR_EMAIL" ]; then echo -e "${RED}[!] Email Empty!${NC}"; pause; return 1; fi
  php artisan p:user:password "$PR_EMAIL" || echo -e "${YELLOW}Use Panel Forgot Password or try again${NC}"
  pause
}
panel_tools_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== PANEL TOOLS ===${NC}"
  echo -e "${WHITE}  [1] Create Panel User${NC}"
  echo -e "${WHITE}  [2] Reset User Password${NC}"
  echo -e "${WHITE}  [3] Clear Panel Cache${NC}"
  echo -e "${WHITE}  [4] Restart Panel Services${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-4: " pt_raw; pt=$(clean_input "$pt_raw")
  case $pt in
    1) panel_user_create ;;
    2) panel_password_reset ;;
    3) if check_panel; then cd /var/www/pterodactyl; php artisan view:clear 2>/dev/null || true; php artisan config:clear 2>/dev/null || true; php artisan cache:clear 2>/dev/null || true; php artisan queue:restart 2>/dev/null || true; echo -e "${GREEN}[+] Cache Cleared${NC}"; fi; pause ;;
    4) systemctl restart nginx 2>/dev/null || true; systemctl restart wings 2>/dev/null || true; cd /var/www/pterodactyl 2>/dev/null && php artisan queue:restart 2>/dev/null || true; echo -e "${GREEN}[+] Services Restarted${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ MINECRAFT + SYSTEM + LOGS ============
minecraft_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== MINECRAFT SERVERS ===${NC}"
  echo -e "${WHITE}  [1] Paper - Best Performance${NC}"
  echo -e "${WHITE}  [2] Purpur - Paper + Extra Features${NC}"
  echo -e "${WHITE}  [3] Fabric - Mods${NC}"
  echo -e "${WHITE}  [4] Forge - Mods${NC}"
  echo -e "${WHITE}  [5] Vanilla - Original Minecraft${NC}"
  echo -e "${WHITE}  [6] Spigot - Plugins${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-6: " m_raw; m=$(clean_input "$m_raw")
  case $m in
    1) echo -e "${GREEN}Paper: Panel - Create Server - Egg Paper - Version 1.20.4 - RAM 4096 MB${NC}"; pause ;;
    2) echo -e "${GREEN}Purpur: Panel - Create Server - Egg Purpur - Version 1.20.4 - RAM 4096 MB${NC}"; pause ;;
    3) echo -e "${GREEN}Fabric: Panel - Create Server - Egg Fabric - Version 1.20.1 - RAM 4096 MB${NC}"; pause ;;
    4) echo -e "${GREEN}Forge: Panel - Create Server - Egg Forge - Version 1.20.1 - RAM 6144 MB${NC}"; pause ;;
    5) echo -e "${GREEN}Vanilla: Panel - Create Server - Egg Vanilla - Version Latest - RAM 2048 MB${NC}"; pause ;;
    6) echo -e "${GREEN}Spigot: Panel - Create Server - Egg Spigot - Version 1.20.4 - RAM 4096 MB${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}
system_info() {
  echo -e "${CYAN}=== SYSTEM INFO ===${NC}"
  echo -e "${WHITE}Hostname: $(hostname)${NC}"
  echo -e "${WHITE}OS: $(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')${NC}"
  echo -e "${WHITE}CPU: $(nproc) Cores${NC}"
  echo -e "${WHITE}RAM: $(free -h 2>/dev/null | grep Mem | awk '{print $2}') Total | $(free -h 2>/dev/null | grep Mem | awk '{print $3}') Used${NC}"
  echo -e "${WHITE}Disk: $(df -h / 2>/dev/null | tail -1 | awk '{print $2}') Total | $(df -h / 2>/dev/null | tail -1 | awk '{print $3}') Used${NC}"
  echo -e "${WHITE}IP: $(curl -s --max-time 5 ifconfig.me 2>/dev/null || hostname -I | awk '{print $1}')${NC}"
  echo -e "${WHITE}Uptime: $(uptime -p 2>/dev/null)${NC}"
  echo -e "${CYAN}--- Services ---${NC}"
  for s in nginx wings docker mariadb mysql cloudflared; do
    if systemctl is-active --quiet "$s" 2>/dev/null; then echo -e "${GREEN}  $s : Running${NC}"; else echo -e "${RED}  $s : Stopped${NC}"; fi
  done
  pause
}
health_check() {
  echo -e "${CYAN}[*] Health Check Running...${NC}"
  [ -d "/var/www/pterodactyl" ] && echo -e "${GREEN}[OK] Panel Installed${NC}" || echo -e "${RED}[FAIL] Panel Not Installed${NC}"
  [ -f /usr/local/bin/wings ] && echo -e "${GREEN}[OK] Wings Installed${NC}" || echo -e "${RED}[FAIL] Wings Not Installed${NC}"
  command -v blueprint &> /dev/null && echo -e "${GREEN}[OK] Blueprint Installed${NC}" || echo -e "${YELLOW}[WARN] Blueprint Not Installed${NC}"
  command -v docker &> /dev/null && echo -e "${GREEN}[OK] Docker Installed${NC}" || echo -e "${RED}[FAIL] Docker Not Installed${NC}"
  [ -f /etc/pterodactyl/config.yml ] && echo -e "${GREEN}[OK] Wings Config Found${NC}" || echo -e "${YELLOW}[WARN] Wings Config Missing - Create Node First${NC}"
  systemctl is-active --quiet nginx && echo -e "${GREEN}[OK] Nginx Running${NC}" || echo -e "${RED}[FAIL] Nginx Not Running${NC}"
  systemctl is-active --quiet docker && echo -e "${GREEN}[OK] Docker Running${NC}" || echo -e "${RED}[FAIL] Docker Not Running${NC}"
  systemctl is-active --quiet wings && echo -e "${GREEN}[OK] Wings Running${NC}" || echo -e "${YELLOW}[WARN] Wings Not Running - Restart After Config${NC}"
  df -h / | tail -1 | awk '{print "Disk Free: " $4}'
  free -h | grep Mem | awk '{print "RAM Free: " $4}'
  echo -e "${GREEN}Health Check Done!${NC}"; pause
}
performance_tuning() {
  echo -e "${CYAN}[*] Performance Tuning - Lag Free Setup...${NC}"
  if [ ! -f /swapfile ]; then
    fallocate -l 4G /swapfile 2>/dev/null || dd if=/dev/zero of=/swapfile bs=1M count=4096 2>/dev/null || true
    chmod 600 /swapfile 2>/dev/null || true; mkswap /swapfile 2>/dev/null || true; swapon /swapfile 2>/dev/null || true
    grep -q swapfile /etc/fstab 2>/dev/null || echo "/swapfile none swap sw 0 0" >> /etc/fstab
    echo -e "${GREEN}Swap Created${NC}"
  else echo -e "${GREEN}Swap Already Exists${NC}"; fi
  grep -q "net.core.rmem_max" /etc/sysctl.conf 2>/dev/null || echo "net.core.rmem_max=16777216" >> /etc/sysctl.conf
  grep -q "net.core.wmem_max" /etc/sysctl.conf 2>/dev/null || echo "net.core.wmem_max=16777216" >> /etc/sysctl.conf
  grep -q "net.ipv4.tcp_rmem" /etc/sysctl.conf 2>/dev/null || echo "net.ipv4.tcp_rmem=4096 87380 16777216" >> /etc/sysctl.conf
  grep -q "net.ipv4.tcp_wmem" /etc/sysctl.conf 2>/dev/null || echo "net.ipv4.tcp_wmem=4096 65536 16777216" >> /etc/sysctl.conf
  grep -q "vm.swappiness" /etc/sysctl.conf 2>/dev/null || echo "vm.swappiness=10" >> /etc/sysctl.conf
  sysctl -p 2>/dev/null || true
  echo -e "${GREEN}[+] Performance Tuning Done! VPS Lag Free - Docker Images Safe${NC}"; pause
}
system_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== SYSTEM TOOLS ===${NC}"
  echo -e "${WHITE}  [1] System Info${NC}"
  echo -e "${WHITE}  [2] Health Check${NC}"
  echo -e "${WHITE}  [3] Performance Tuning${NC}"
  echo -e "${WHITE}  [4] Minecraft Servers${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-4: " s_raw; s=$(clean_input "$s_raw")
  case $s in
    1) system_info ;;
    2) health_check ;;
    3) performance_tuning ;;
    4) minecraft_menu ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}
logs_menu() {
  while true; do
  show_banner
  echo -e "${CYAN}=== LOGS MENU ===${NC}"
  echo -e "${WHITE}  [1] Wings Logs${NC}"
  echo -e "${WHITE}  [2] Nginx Logs${NC}"
  echo -e "${WHITE}  [3] Panel Logs${NC}"
  echo -e "${WHITE}  [4] Docker Logs${NC}"
  echo -e "${WHITE}  [0] Back${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  ask "Select 0-4: " lg_raw; lg=$(clean_input "$lg_raw")
  case $lg in
    1) journalctl -u wings --no-pager -n 50 2>/dev/null || echo -e "${YELLOW}No Wings logs${NC}"; pause ;;
    2) tail -n 50 /var/log/nginx/error.log 2>/dev/null || echo -e "${YELLOW}No Nginx logs${NC}"; pause ;;
    3) tail -n 50 /var/www/pterodactyl/storage/logs/laravel.log 2>/dev/null || echo -e "${YELLOW}No Panel logs${NC}"; pause ;;
    4) docker ps 2>/dev/null || echo -e "${YELLOW}Docker not running${NC}"; pause ;;
    0) return ;;
    *) echo -e "${RED}Invalid!${NC}"; sleep 1 ;;
  esac
  done
}

# ============ UPDATE + UNINSTALL + FULL AUTO ============
update_system() {
  echo -e "${CYAN}[*] Updating System + Panel + Blueprint + Wings...${NC}"
  apt update && apt upgrade -y; apt autoremove -y || true
  if [ -d "/var/www/pterodactyl" ]; then
    cd /var/www/pterodactyl || return 1
    php artisan down 2>/dev/null || true
    php artisan migrate --seed --force 2>/dev/null || true
    php artisan view:clear 2>/dev/null || true; php artisan config:clear 2>/dev/null || true
    chown -R www-data:www-data /var/www/pterodactyl 2>/dev/null || true
    php artisan queue:restart 2>/dev/null || true; php artisan up 2>/dev/null || true
    printf "y\n" | blueprint -update 2>/dev/null || { curl -fsSL -o /tmp/bp-up.sh https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh; bash /tmp/bp-up.sh; } || true
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
  echo -e "${RED}WARNING: Panel + Wings + Database will be deleted!${NC}"
  ask "Are you sure? Type YES to confirm: " confirm_raw; confirm=$(clean_input "$confirm_raw")
  if [ "$confirm" != "yes" ]; then echo -e "${YELLOW}Cancelled.${NC}"; pause; return; fi
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
  sleep 1
  install_deps
  if ! install_panel; then echo -e "${RED}[!] Panel Failed, Full Install Stopped.${NC}"; FULL_MODE=0; pause; return 1; fi
  install_wings
  install_blueprint
  install_nebula
  echo -e "${CYAN}[*] Installing All Extensions...${NC}"
  if check_blueprint; then for ext in version-changer player-manager plugin-installer hux-register snowflakes motd-maker icon-importer server-splitting allocation-manager server-importer file-manager; do bp_install "$ext" || true; done; fi
  performance_tuning
  firewall_setup
  setup_backup_auto
  FULL_MODE=0
  show_banner
  echo -e "${GREEN}✅ FULL AUTO INSTALL COMPLETE! ✅${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  echo -e "${WHITE}Panel + Wings + Blueprint + Nebula + All Extensions Done!${NC}"
  echo -e "${CYAN}Backup: Daily 3 AM | Command: umesh-backup${NC}"
  echo -e "${YELLOW}LAST STEP:${NC}"
  echo -e "${WHITE}1. Use Node Menu - Paste Config${NC}"
  echo -e "${WHITE}2. systemctl restart wings${NC}"
  echo -e "${PURPLE}============================================================${NC}"
  pause
}

# ============ MAIN MENU - COMPACT 12 OPTIONS ONLY ============
while true; do
show_banner
echo -e "${WHITE}  [1] Install - Panel + Wings${NC}"
echo -e "${WHITE}  [2] Blueprint + Themes${NC}"
echo -e "${WHITE}  [3] Extensions Menu${NC}"
echo -e "${WHITE}  [4] Network - Cloudflare + SSL + Firewall + SSHX${NC}"
echo -e "${WHITE}  [5] Backup Menu${NC}"
echo -e "${WHITE}  [6] Node + Wings Menu${NC}"
echo -e "${WHITE}  [7] Panel Tools${NC}"
echo -e "${WHITE}  [8] System Tools + Minecraft${NC}"
echo -e "${WHITE}  [9] Logs Menu${NC}"
echo -e "${WHITE}  [10] Full Auto Install${NC}"
echo -e "${WHITE}  [11] Update System${NC}"
echo -e "${WHITE}  [12] Uninstall${NC}"
echo -e "${RED}  [0] Exit${NC}"
echo -e "${PURPLE}============================================================${NC}"
ask "Select Option 0-12: " opt_raw; opt=$(clean_input "$opt_raw")
case $opt in
  1) install_menu ;;
  2) blueprint_themes_menu ;;
  3) extensions_menu ;;
  4) network_menu ;;
  5) backup_menu ;;
  6) node_menu ;;
  7) panel_tools_menu ;;
  8) system_menu ;;
  9) logs_menu ;;
  10) full_install ;;
  11) update_system ;;
  12) uninstall_all ;;
  0) animated_exit ;;
  *) echo -e "${RED}Invalid option! Choose 0-12. You typed: $opt_raw${NC}"; sleep 1 ;;
esac
done
