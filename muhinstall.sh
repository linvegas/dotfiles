#!/usr/bin/env sh

# Version to be used as root user

pkg_list_url="https://raw.githubusercontent.com/MisterConscio/dotfiles/main/pkglist.txt"
pkg_list="pkglist.txt"
dotfiles_repo="https://github.com/MisterConscio/dotfiles.git"
aurhelper="yay"
aurhelper_git="https://aur.archlinux.org/yay.git"

bold=$(tput bold)
normal=$(tput sgr0)

# Some export for building a few packages
# export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
# export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
# export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

error() {
  echo -e "\n${bold}$1${normal}\n" >&2
  sleep 2
  exit 1
}

message() {
  echo -e "\n${bold}${1:-Ocorreu algum erro}${normal}\n"
  sleep 3
}

hello() {
  echo -e "\n${bold}Bem vindo${normal}\n"
  sleep 3
  echo "Irá começar o script de instalação"
  sleep 3
  echo "Esse script é destinado para sistemas ${bold}Arch Linux${normal}"
  sleep 5
  read -p "Antes de começar, por farvor ${bold}informe seu usuário${normal}: " name
  [[ ! $(id -u "$name") ]] && error "O usuário ${name} não existe"
  echo "${bold}Vamos-lá ${name} :)${normal}"
  sleep 1
}

mkfilestruct() {
  message "Estrutura de arquivos"
  mkdir -pv /home/$name/.config/{mpd,ncmpcpp,zsh}
  mkdir -pv /home/$name/.cache/zsh
  mkdir -pv /home/$name/.local/{src,share/{gnupg,npm}}
  mkdir -pv /home/$name/media/{pic/screenshot,vid,mus,samp,proj}
  mkdir -pv /home/$name/{dev,doc}
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

  echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/sudo-temp

  sudo pacman --noconfirm -Syy
  message "Finalizada"
}

dotfiles() {
  message "Repositório dos dotfiles"
  pacman --noconfirm --needed -S stow git
  echo -e "\nClonando o repositório dos dotfiles..."
  # curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    # "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  git clone "$dotfiles_repo" "/home/$name/dotfiles"
  cd "/home/$name/dotfiles"
  stow -v \
    i3 alacritty x11 zsh \
    polybar xdg scripts gtk \
    dircolors mpd ncmpcpp dunst \
    lf fontconfig rofi nvim \
    zathura tmux
  # nvim -c "PlugInstall|q|q"
  message "Finalizada"
  exit 0
}

pacinstall() {
  message "ETAPA 3: Instalação de programas"
  echo "Baixando lista de aplicativos..."
  curl -sLO "$pkg_list_url"
  echo "${bold}Iniciando a instalação...${normal}"
  sudo pacman --noconfirm --needed -S - < "$pkg_list"
  message "ETAPA 3: Finalizada"
}

aurinstall() {
  message "ETAPA 5: Instalação do Yay"
  echo "Instalando ${aurhelper} como AUR helper..."
  cd ~/.local/src
  git clone "$aurhelper_git"
  cd yay
  makepkg -sirc --noconfirm
  message "ETAPA 5: Finalizada"
}

aurpkg() {
  message "ETAPA 6: Instalação de pacotes AUR"
  echo "Instalando pacotes do AUR..."
  cd ~/dotfiles
  yay -S --removemake --noconfirm - < aurlist.txt
  message "ETAPA 6: Finalizada"
}

changeshell() {
  message "ETAPA 7: Mundança de shell para zsh"
  echo "Mudando o shell para zsh"
  chsh -s /usr/bin/zsh "$USER"
  message "ETAPA 7: Finalizada"
}

addgroups() {
  message "ETAPA 8: Adcionando ao usuário grupos"
  sudo usermod -aG video,audio,lp,network,kvm,storage,i2c $USER
  echo "command: usermod -aG video,audio,lp,network,kvm,storage $USER"
  message "ETAPA 8: Finalizada"
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
trap 'rm -f /etc/sudoers.d/sudo-temp' EXIT
setpacman || error

# Repositório dos dotfiles
dotfiles || error

pacinstall || error
aurinstall || error
aurpkg || error
changeshell || error
addgroups || error
cleanup || error

echo -e "\n${bold}Parece que tudo ocorreu bem, por favor, reinicie o sistema${normal}"
