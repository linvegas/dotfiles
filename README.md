# MisterConscio dotfiles
## Instalation:

The repo it's supposed to be used with [GNU/stow](https://www.gnu.org/software/stow/).

```sh
curl -LO "https://raw.githubusercontent.com/MisterConscio/dotfiles/main/pkglist.txt"
```

```sh
sudo pacman -S --needed - < pkglist.txt
```

```sh
git clone https://github.com/MisterConscio/dotfiles.git
```

```sh
cd dotfiles
stow zsh
stow x11
```

## List of useful packages (pacman/aur):
#### Media Apps
* mpv
* sxiv
* zathura
* yt-dlp

#### CLI Tools
* nvim
* lf
* tldr
* bashtop
* tree
* bat
* gdu
* stow
* fzf
* pulsemixer
* ncmpcpp
* beets
* mpc
* espeak-ng
* ddcutil
* uzip

#### For Window Managers
* xorg-xinit
* xwallpaper
* xcolor
* xclip
* python-pywal
* polybar
* maim
* dunst
* dmenu
* rofi
* redshift
* xcompmgr
* xxs-lock
* numlockx

#### Fonts
* noto-fonts
* noto-fonts-emoji
* ttf-hack
* ttf-inconsolata
* nerd-fonts-droid-sans-mono
* ttf-font-awesome

#### Terminal Screensaver
* cmatrix
* pipes.sh
* asciiquarium

#### Themes
* papirus-icon-theme
* xcursor-breeze

#### Wallpapers
* archlinux-wallpaper
