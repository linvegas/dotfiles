#!/usr/bin/env sh

# Version to be used as root user

# pkg_list_url="https://raw.githubusercontent.com/MisterConscio/dotfiles/main/pkglist.txt"
pkg_list="pkglist.txt"
aur_list="aurlist.txt"
dotfiles_repo="https://github.com/MisterConscio/dotfiles.git"
aurhelper="yay"
aurhelper_git="https://aur.archlinux.org/yay.git"
falsename="conscio"

bold=$(tput bold)
normal=$(tput sgr0)

# Some export for building a few packages
export GNUPGHOME="${XDG_DATA_HOME:-/home/$name/.local/share}/gnupg"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-/home/$name/.config}/npm/npmrc"
export GOPATH="${XDG_DATA_HOME:-/home/$name/.local/share}/go"

error() {
  echo -e "\n${bold}${1:-Ocorreu algum erro}${normal}\n"
  sleep 2
  exit 1
}

message() {
  echo -e "\n${bold}$1${normal}\n" >&2
  sleep 1
}

hello() {
  echo -e "\n${bold}Bem vindo${normal}\n"
  sleep 2
  echo "Irá começar o script de instalação"
  sleep 2
  echo "Esse script é destinado para sistemas ${bold}Arch Linux${normal}"
  sleep 2
  read -p "Antes de começar, por farvor ${bold}informe seu usuário${normal}: " name
  [[ ! $(id -u "$name") ]] && error "O usuário ${name} não existe"
  echo "${bold}Vamos-lá ${name} :)${normal}"
  sleep 1
}

mkfilestruct() {
  message "Estrutura de arquivos"
  sudo -u "$name" mkdir -pv /home/$name/.config/{mpd,ncmpcpp,zsh} \
    /home/$name/.cache/zsh \
    /home/$name/.local/{src,share/{gnupg,npm}} \
    /home/$name/media/{pic/screenshot,vid,mus,samp,proj} \
    /home/$name/{dev,doc}
  message "Finalizada"
}

setpacman() {
  message "Configuração do pacman e sudoers"
  pacman --noconfirm --needed -S pacman-contrib

  sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//;/^#VerbosePkgLists$/s/#//" /etc/pacman.conf
  sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf

  cp -v /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
  echo "Testando velocidade dos repositórios..."
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

  sudo pacman --noconfirm -Syy
  message "Finalizada"
}

dotfiles() {
  message "Repositório dos dotfiles"
  dotdir="/home/$name/dotfiles"
  pacman --noconfirm --needed -S stow git
  echo -e "\nClonando o repositório dos dotfiles..."
  # curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    # "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  sudo -u "$name" git clone "$dotfiles_repo" $dotdir
  cd $dotdir
  sudo -u "$name" stow -v \
    i3 alacritty x11 zsh \
    polybar xdg scripts gtk \
    dircolors mpd ncmpcpp dunst \
    lf fontconfig rofi nvim \
    zathura tmux
  # nvim -c "PlugInstall|q|q"
  message "Finalizada"
}

pacinstall() {
  message "Instalação de programas"
  # echo "Baixando lista de aplicativos..."
  # curl -sLO "$pkg_list_url"
  [[ ! -e "$dotdir/$pkglist" ]] && error "O arquivo $pkg_list não existe"
  echo "${bold}Iniciando a instalação...${normal}"
  sudo pacman --noconfirm --needed -S - < "$pkg_list"
  message "Finalizada"
}

aurinstall() {
  message "Instalação do Yay"
  echo "Instalando ${aurhelper} como AUR helper..."
  local aurdir="/home/$name/.local/src/$aurhelper"
  sudo -u "$name" git clone "$aurhelper_git" $aurdir
  cd $aurdir
  sudo -u "$name" makepkg -sirc --noconfirm || error
  message "Finalizada"
}

aurpkg() {
  message "Instalação de pacotes AUR"
  echo "Instalando pacotes do AUR..."
  cd "$dotdir"
  sudo -u "$name" yay -S --removemake --noconfirm - < "$aur_list"
  message "Finalizada"
}

changeshell() {
  message "Mundança de shell para zsh"
  echo "Mudando o shell para zsh..."
  chsh -s /usr/bin/zsh "$name"
  chsh -s /usr/bin/zsh root
  message "Finalizada"
}

addgroups() {
  message "APA 8: Adcionando ao usuário grupos"
  usermod -aG video,audio,lp,network,kvm,storage,i2c "$name"
  echo "command: usermod -aG video,audio,lp,network,kvm,storage $name"
  message "Finalizada"
  exit 1
}

cleanup() {
  message "ETAPA 9: Limpeza"
  rm -v ~/muhinstall.sh ~/pkglist.txt
  rm -v ~/.bash_logout ~/.bashrc ~/.bash_profile
  message "ETAPA 9: Finalizada"
}

# Atualização de sistema inicial
pacman --noconfirm -Syyu ||
  error "Você não está rodando o script como root ou não possui acesso à internet"

# Mesangem de boas vindas e informação do usuário
hello || error

# Estrutura de arquivos pessoal
mkfilestruct || error

# Configuração do pacman e arquivo temporário sudoers
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/09_sudotemp
trap 'rm -f /etc/sudoers.d/09_sudotemp' QUIT EXIT
setpacman || error

# Repositório dos dotfiles
dotfiles || error

# Instalação dos programas
pacinstall || error

# Instalação do yay
aurinstall || error

# Instalação de pacotes AUR
aurpkg || error

# Mudança de shell para zsh
changeshell || error

# Gerenciamento de grupos
addgroups || error

# Limpeza
cleanup || error

echo -e "Defaults timestamp_timeout=60\nDefaults timestamp_type=global" > /etc/sudoers.d/01_sudo_time
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/02-sudo-wheel

echo -e "\n${bold}Parece que tudo ocorreu bem, por favor, reinicie o sistema${normal}"
