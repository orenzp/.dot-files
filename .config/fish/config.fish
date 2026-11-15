# Set up Homebrew first so brew-installed tools (fortune, fzf, etc.) are on PATH
if test -f /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
else if test -f /usr/local/bin/brew
  eval (/usr/local/bin/brew shellenv)
end

# User local binaries and krew
fish_add_path -g "$HOME/.local/bin" "$HOME/.krew/bin"

if test -d "$HOME/.lmstudio/bin"
  fish_add_path -g "$HOME/.lmstudio/bin"
end

# Default FZF options
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

set fish_greeting

function fish_greeting
  if command -v fortune >/dev/null
    echo
    if test -f ~/.fortunes/jordan_peterson
      fortune -s ~/.fortunes/jordan_peterson
    else
      fortune -s
    end
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
case Darwin
    #echo Hi Darwin
case '*'
    echo Hi, stranger!
end


if functions -q fzf_configure_bindings
  fzf_configure_bindings --variables=\e\e --processes=\eP
end

# Setting PATH for Python 3.10
if test -d "/Library/Frameworks/Python.framework/Versions/3.10/bin"
  fish_add_path -g "/Library/Frameworks/Python.framework/Versions/3.10/bin"
end

if test -S "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
  set -gx SSH_AUTH_SOCK "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
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

