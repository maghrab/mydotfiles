# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Changing the color of the prompt to RED
 PS1="\[\033[01;31m\]$PS1\[\033[0m\]"
#function _update_ps1() {
#    PS1="$(powerline-shell $?)"
#}
#
#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

# Changing the colors of the files and directories on ls
# eval `dircolors ~/.dir_colors_dark`

# Aliases
alias la='ls -la'
alias ll='ls -l'
alias _site_pack='cd /usr/lib/python2.7/site-packages'
alias rg='rg --smart-case --type-add "ar:*.{tac,tin,py,ar,am}" --type-add "tac:*.tac" --type-add "tin:*.tin" --no-ignore --color=always'
alias gitv='vim -c Gitv'

## Fzf
#_gen_fzf_default_opts() {
#  local base03="234"
#  local base02="235"
#  local base01="240"
#  local base00="241"
#  local base0="244"
#  local base1="245"
#  local base2="254"
#  local base3="230"
#  local yellow="136"
#  local orange="166"
#  local red="160"
#  local magenta="125"
#  local violet="61"
#  local blue="33"
#  local cyan="37"
#  local green="64"
#
#  # Comment and uncomment below for the light theme.
#
#  ## Solarized Dark color scheme for fzf
#  #export FZF_DEFAULT_OPTS="
#  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
#  #  --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
#  #"
#  ## Solarized Light color scheme for fzf
#  export FZF_DEFAULT_OPTS="
#    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
#    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
#  "
#}
#
#_gen_fzf_default_opts
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# I don't know what that is
# set -o vi
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
