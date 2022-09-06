#!/usr/bin/env sh

pkg_list_url="https://raw.githubusercontent.com/MisterConscio/dotfiles/main/pkglist.txt"
pkg_list="pkglist.txt"
dotfiles_repo="https://github.com/MisterConscio/dotfiles.git"
aurhelper="yay"
aurhelper_git="https://aur.archlinux.org/yay.git"

bold=$(tput bold)
normal=$(tput sgr0)

# Some export for building a few packages
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

error() {
  echo -e "\n${bold}Algum erro aconteceu, finalizando${normal}\n"
  sleep 2
  exit 1
}

message() {
  echo -e "\n${bold}$1${normal}\n"
  sleep 3
}

hello() {
  echo -e "\n${bold}Bem vindo ${USER}${normal}\n"
  sleep 3
  echo "Irá começar o scrip de instalação"
  sleep 3
  echo "Esse script é destinado para sistemas ${bold}Arch Linux${normal}"
  sleep 5
  echo "Vamos-lá :)"
  sleep 1
}

mkfilestruct() {
  message "ETAPA 1: Estrutura de arquivos"
  mkdir -pv ~/.config/{mpd,ncmpcpp,zsh}
  mkdir -pv ~/.cache/zsh
  mkdir -pv ~/.local/{src,share/gnupg}
  mkdir -pv ~/media/{pic/screenshot,vid,mus}
  mkdir -pv ~/dev ~/docx
  message "ETAPA 1: Finalizada"
}

pacinstall() {
  message "ETAPA 2: Instalação de programas"
  echo "Baixando lista de aplicativos..."
  curl -sLO "$pkg_list_url"
  echo "${bold}Iniciando a instalação...${normal}"
  sudo pacman --noconfirm --needed -S - < "$pkg_list"
  message "ETAPA 2: Finalizada"
}

dotfiles() {
  message "ETAPA 3: Repositório dos dotfiles"
  echo -e "\nClonando o repositório dos dotfiles..."
  git clone "$dotfiles_repo" "$HOME"
  cd dotfiles
  stow -v \
    i3 alacritty x11 zsh \
    polybar xdg scripts gtk \
    dircolors mpd ncmpcpp dunst \
    lf
  message "ETAPA 3: Finalizada"
}

aurinstall() {
  message "ETAPA 4: Instalação do Yay"
  echo "Instalando ${aurhelper} como AUR helper..."
  cd ~/.local/src
  git clone "$aurhelper_git"
  cd yay
  makepkg -sirc
  message "ETAPA 4: Finalizada"
}

aurpkg() {
  message "ETAPA 5: Instalação de pacotes AUR"
  echo "Instalando pacotes do AUR..."
  cd ~/dotfiles
  yay -S --removemake --noconfirm - < aurlist.txt
  message "ETAPA 5: Finalizada"
}

changeshell() {
  message "ETAPA 6: Mundança de shell para zsh"
  echo "Mudando o shell para zsh"
  chsh -s /usr/bin/zsh "$USER"
  message "ETAPA 6: Finalizada"
}

addgroups() {
  message "ETAPA 7: Adcionando ao usuário grupos"
  sudo usermod -aG video,audio,lp,network,kvm,storage $USER
  message "ETAPA 7: Finalizada"
}

cleanup() {
  message "ETAPA 8: Limpeza"
  rm -v ~/muhinstall.sh ~/pkglist.txt
  rm -v ~/.bash_logout ~/.bash_history ~/.bashrc ~/.bash_profile
  message "ETAPA 8: Finalizada"
}

hello || error
mkfilestruct || error
pacinstall || error
dotfiles || error
aurinstall || error
aurpkg || error
changeshell || error
addgroups || error
cleanup || error

echo -e "\nParece que tudo ocorreu bem, por favor, reinicie o sistema"
