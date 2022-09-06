#!/usr/bin/env sh

pkg_list_url="https://raw.githubusercontent.com/MisterConscio/dotfiles/main/pkglist.txt"
pkg_list="pkglist.txt"
dotfiles_repo="https://github.com/MisterConscio/dotfiles.git"
aurhelper="yay"
aurhelper_git="https://aur.archlinux.org/yay.git"

bold=$(tput bold)
normal=$(tput sgr0)

error() {
  echo "Algum erro aconteceu, finalizando"
  exit 1
}

hello() {
  echo "Iniciando a instalação do sistema MisterConscio"
  sleep 1
  echo "Os pacotes e configurações a serem instalados foram feitos para a distribuição ${bold}Arch Linux${normal} e seus derivados"
  sleep 1
  echo "Vamos-lá :)"
  sleep 1
}

mkfilestruct() {
  echo "Construindo estrutura de arquivos..."
  mkdir -pv ~/.config/{mpd,ncmpcpp,zsh}
  mkdir -pv ~/.cache/zsh
  mkdir -pv ~/.local/{src,share/gnupg}
  mkdir -pv ~/media/{pic/screenshot,vid,mus}
  mkdir -pv ~/dev ~/docx
}

pacinstall() {
  echo "Baixando lista de aplicativos..."
  curl -sLO "$pkg_list_url"
  echo "${bold}Iniciando a instalação...${normal}"
  sudo pacman --noconfirm --needed -S - < "$pkg_list"
}

aurinstall() {
  echo "Instalando ${aurhelper} como AUR helper..."
  cd ~/.local/src
  git clone "$aurhelper_git"
  cd yay
  makepkg -sirc
}

aurpkg() {
  echo "Instalando pacotes do AUR..."
  cd ~/dotfiles
  yay -S --removemake --nocofirm - < aurlist.txt

}

dotfiles() {
  echo -e "\nClonando o repositório dos dotfiles..."
  git clone "$dotfiles_repo"
  cd dotfiles
  stow \
    i3 alacritty x11 zsh \
    polybar xdg scripts gtk \
    dircolors mpd ncmpcpp dunst
}

changeshell() {
  echo "Mudando o shell para zsh"
  chsh -s /usr/bin/zsh
}

hello || error
mkfilestruct || error
pacinstall || error
dotfiles || error
aurinstall || error
aurpkg || error
changeshell || error

echo -e "\nParece que tudo ocorreu bem, por favor, reinicie o sistema"
