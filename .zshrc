# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$PATH
# export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH

export EDITOR='nvim'

bindkey '^ ' autosuggest-accept

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

