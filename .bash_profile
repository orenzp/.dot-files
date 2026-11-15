
eval "$(/opt/homebrew/bin/brew shellenv bash)"

complete -C /opt/homebrew/bin/packer packer


# Added by Antigravity CLI installer
export PATH="/Users/oren.zipori/.local/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/oren.zipori/.antigravity-ide/antigravity-ide/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/oren.zipori/.lmstudio/bin"
# End of LM Studio CLI section


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/private/tmp/google-cloud-sdk/path.bash.inc' ]; then . '/private/tmp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/private/tmp/google-cloud-sdk/completion.bash.inc' ]; then . '/private/tmp/google-cloud-sdk/completion.bash.inc'; fi
