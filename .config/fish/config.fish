# Something...
set -gx PATH $PATH $HOME/.krew/bin
set fish_greeting

function fish_greeting
  echo 	
  echo (fortune -s)
  echo 
end

# Alias Setup
alias kc=kubectl
alias kcgc='kubectl config get-contexts'
alias tf='terraform'
alias ll='ls -lha'
alias gts='git status'
alias kcx='kubectx'
alias kcn='kubens'
alias history='history --show-time="%a %H %M %S - " --reverse'
alias jf='jfrog'
export GPG_TTY=(tty) # For Yadm Encrypt command to work.
cd ~/repos


