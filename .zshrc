# Path configuration
typeset -U path # Keep path entries unique
path=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/opt/homebrew/opt/openjdk/bin"
    "/Users/ivomachado/.antigravity/antigravity/bin"
    "/Users/ivomachado/.lmstudio/bin"
    "/Users/ivomachado/.opencode/bin"
    $path
)
export PATH

# Zsh History Options
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Environment Variables
export EDITOR='nvim'
export VISUAL='nvim'
export GTEST_COLOR=yes
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export FZF_DEFAULT_OPTS="--bind=tab:down,btab:up,ctrl-o:toggle"
export FZF_DEFAULT_COMMAND='fd --color=never --type f --hidden --no-ignore-vcs --follow --exclude .git --exclude .ccache --exclude .cache --exclude "*.o"'

# Device Info
export TPV_PF_FRIENDLY_NAME="Ivo's Notebook"
export TPV_PF_DEVICE_NAME="Computer"
export TPV_PF_MANUFACTURER="PC"

# Zgenom Plugin Manager
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then
    echo "Creating a zgenom save..."
    zgenom compdef
    zgenom ohmyzsh
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/sudo
    [[ "$(uname -s)" = "Darwin" ]] && zgenom ohmyzsh plugins/macos

    # Theme - Powerlevel10k (extremely fast and optimized)
    zgenom load romkatv/powerlevel10k powerlevel10k

    # Plugins
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-completions
    zgenom load agkozak/zsh-z
    zgenom load zsh-users/zsh-autosuggestions
    
    zgenom loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS

    zgenom save
    zgenom compile "$HOME/.zshrc"
fi

# FZF initialization (modern syntax)
if command -v fzf >/dev/null; then
    source <(fzf --zsh)
fi

bindkey '^ ' autosuggest-accept

# Helper Functions
merge_compile_commands() {
    find .build_"$1" -name compile_commands.json -type f -print0 | xargs -0 jq -s '[.[][]]' > compile_commands.json
}

# To customize your prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
