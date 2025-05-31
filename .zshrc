# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$PATH
# export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

export GTEST_COLOR=yes

merge_compile_commands() {
    find .build_"$1" -name compile_commands.json -type f -print0 | xargs -0 jq -s '[.[][]]' > compile_commands.json
}

function build-dev-image {
    docker build --build-arg UID=$(id -u) \
                 --build-arg GID=$(id -g) \
                 --build-arg USER=$(id -un) \
                 --build-arg HOME=$HOME \
                 -t ivo-dev-container $HOME/Workspace/dotfiles
}

function start-dev-container {
    docker run \
        --network host \
        -it \
        -v /opt/certi-x-tools/:/opt/certi-x-tools/  \
        -v /var/cache/buildroot-dl/:/var/cache/buildroot-dl/  \
        -u $(id -un) \
        -w $PWD \
        -v $HOME:$HOME  \
        -it --rm ivo-dev-container bash
}

source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

export EDITOR='nvim'
export VISUAL='nvim'
# if ! command -v helix &> /dev/null ; then
#     alias helix=hx
#     export EDITOR='hx'
#     export VISUAL='hx'
# else
#     export EDITOR='helix'
#     export VISUAl='helix'
# fi

if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    # zgenom compdef

    # Ohmyzsh base library
    zgenom ohmyzsh

    # You can also cherry pick just parts of the base library.
    # Not loading the base set of ohmyzsh libraries might lead to issues.
    # While you can do it, I won't recommend it unless you know how to fix
    # those issues yourself.

    # Remove `zgenom ohmyzsh` and load parts of ohmyzsh like this:
    # `zgenom ohmyzsh path/to/file.zsh`
    # zgenom ohmyzsh lib/git.zsh # load git library of ohmyzsh

    # plugins
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/sudo
    # just load the completions
    # zgenom ohmyzsh --completion plugins/docker-compose

    # Install ohmyzsh osx plugin if on macOS
    [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

    # prezto options
    # zgenom prezto editor key-bindings 'emacs'
    # zgenom prezto prompt theme 'sorin'

    # prezto and modules
    # If you use prezto and ohmyzsh - load ohmyzsh first.
    # zgenom prezto
    # zgenom prezto command-not-found

    # Load prezto tmux when tmux is installed
    # if hash tmux &>/dev/null; then
    #     zgenom prezto tmux
    # fi

    zgenom load zsh-users/zsh-syntax-highlighting
    # zgenom load /path/to/super-secret-private-plugin

    # use a plugin file
    # The file must only contain valid parameters for `zgenom load`

    # bulk load
    zgenom loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # add binaries
    # zgenom bin tj/git-extras

    # completions
    zgenom load zsh-users/zsh-completions

    # theme
    # zgenom load agkozak/agkozak-zsh-prompt
    zgenom load spaceship-prompt/spaceship-prompt spaceship
    # zgenom load eendroroy/alien
    # zgenom load eendroroy/alien-minimal

    zgenom load agkozak/zsh-z
    zgenom load zsh-users/zsh-autosuggestions

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
    # Uncomment if you set ZDOTDIR manually
    # zgenom compile $ZDOTDIR

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
source <(fzf --zsh)

bindkey '^ ' autosuggest-accept

# export EDITOR='nvim'
# export VISUAL='nvim'
export FZF_DEFAULT_OPTS="--bind=tab:down,btab:up,ctrl-o:toggle"
export FZF_DEFAULT_COMMAND='fd --color=never --type f --hidden --no-ignore-vcs --follow --exclude .git --exclude .ccache --exclude .cache --exclude *.o'
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config
alias fd='fd --color=never --type f --hidden --no-ignore-vcs --follow --exclude .git --exclude .ccache --exclude .cache --exclude \*.o'

export ALIEN_THEME="bnw"

export ALIEN_SECTIONS_LEFT=(
  # battery
  user
  path
  # newline
  # ssh
  # venv
  prompt
)

export ALIEN_SECTIONS_RIGHT=(
  exit
  vcs_branch:async
  vcs_status:async
  vcs_dirty:async
  time
)

export AM_PROMPT_END_TAG=' $'       # previously `PROMPT_END_TAG`
export AM_PROMPT_START_TAG_COLOR=81  # previously `PROMPT_START_TAG_COLOR`
export AM_PROMPT_END_TAG_COLOR=81    # previously `PROMPT_END_TAG_COLOR`
export AM_DIR_EXPANSION_LEVEL=3
export AM_HIDE_EXIT_CODE=1

SPACESHIP_PROMPT_ORDER=(
  user           # Username section
  host           # Hostname section
  dir            # Current directory section
  sudo           # Sudo indicator
  char           # Prompt character
)

SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_USER_SHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_RPROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL_ROOT="#"
SPACESHIP_CHAR_SYMBOL="$"

SPACESHIP_RPROMPT_ORDER=(
  exit_code      # Exit code section
  exec_time      # Execution time
  git            # Git section (git_branch + git_status)
  time           # Time stamps section
)

function pde() {
    if [ -f .pde.sh ]; then
        #TODO: ask if it should run and then save the result
        source .pde.sh
    fi
    zellij --layout pde
}

export TPV_PF_FRIENDLY_NAME="Ivo's Notebook"
export TPV_PF_DEVICE_NAME="Computer"
export TPV_PF_MANUFACTURER="PC"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
