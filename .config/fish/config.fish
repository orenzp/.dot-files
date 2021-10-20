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
    echo Hi Tux!
    ntpdate ntp.ubuntu.com 2>/dev/null
case Darwin
    
case '*'
    echo Hi, stranger!
end
