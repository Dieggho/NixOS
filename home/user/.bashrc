# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;38m\]\w\[\033[00m\]\$ '
#PS1='$ '

## Colorize the ls output ##
alias ls='ls --color=auto'

alias \
shrc="nano ~/.bashrc" \
myip="curl ident.me;echo" \
weather="curl -4 http://wttr.in/Sao-Paulo" \
mynix="clear; fastfetch; lsblk -f;" \
nixed="sudo nano /etc/nixos/configuration.nix" \
nixup="sudo nixos-rebuild switch --upgrade" \
nixrm="sudo nix-collect-garbage --delete-old;sudo /run/current-system/bin/switch-to-configuration boot" \
nixs="nix-env -qaP" \
nixlsg="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system" \
hyprc="nano /home/void/.config/hypr/hyprland.conf" \
Nix="clear ; fastfetch"

lss () {
  du -hc "$1" | sort -rh | head -20
}
unset HISTFILE
