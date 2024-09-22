# Something...
set -gx PATH $PATH $HOME/.krew/bin
set fish_greeting

function fish_greeting
  echo 	
  echo (fortune -s)
  echo 
end

export GPG_TTY=(tty) # For Yadm Encrypt command to work.
cd ~/repos

switch (uname)
case Linux
    #echo Hi Linux!
    ntpdate ntp.ubuntu.com 2>/dev/null
case Darwin
    #echo Hi Darwin
case '*'
    echo Hi, stranger!
end


#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# Setting PATH for Python 3.10
# The original version is saved in /Users/oz638q/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

# ADFS tool to manage runtime version for cli like kubectl
source /opt/homebrew/opt/asdf/libexec/asdf.fish

