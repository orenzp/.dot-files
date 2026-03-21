# Something...
set -gx PATH $PATH $HOME/.krew/bin
set fish_greeting

function fish_greeting
  if command -v fortune >/dev/null
    echo 	
    echo (fortune -s)
    echo 
  end
end

if tty >/dev/null 2>&1
  export GPG_TTY=(tty) # For Yadm Encrypt command to work.
end

if test -d ~/repos
  cd ~/repos
end

switch (uname)
case Linux
    #echo Hi Linux!
    if command -v ntpdate >/dev/null
      ntpdate ntp.ubuntu.com 2>/dev/null
    end
case Darwin
    #echo Hi Darwin
case '*'
    echo Hi, stranger!
end


#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
if functions -q fzf_configure_bindings
  fzf_configure_bindings --variables=\e\e --processes=\eP
end

# Setting PATH for Python 3.10
# The original version is saved in /Users/oz638q/.config/fish/config.fish.pysave
if test -d "/Library/Frameworks/Python.framework/Versions/3.10/bin"
  set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"
end

if test -S "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
  set -gx SSH_AUTH_SOCK $HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
end

# ASDF tool to manage runtime version for cli like kubectl
if test -f /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
else if test -f $HOME/.asdf/asdf.fish
  source $HOME/.asdf/asdf.fish
end


# nvm.fish configuration - only install if interactive
if status is-interactive
  if not functions -q nvm
    if not functions -q fisher
      curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    end
    # fisher install jorgebucaran/nvm.fish
  end
end

# Set up Homebrew
if test -f /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
else if test -f /usr/local/bin/brew
  eval (/usr/local/bin/brew shellenv)
end

export PATH="$HOME/.local/bin:$PATH"
