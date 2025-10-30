export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_reduce_blanks

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit load zdharma-continuum/history-search-multi-word
zinit light-mode for \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting \
    wintermi/zsh-mise
autoload compinit; compinit

zshaddhistory() {
    [[ "$?" == 0 ]]
}

function aws-sso-refresh {
    for PROF in $(grep sso-session ~/.aws/config | sed -e 's/^\[sso-session \(.*\)\]/\1/' | sort); do
        echo "Refresh token for profile '${PROF}'..."
        aws sso login --profile ${PROF} > /dev/null 2>&1
        echo "==> $(aws sts get-caller-identity --profile ${PROF} --query "Arn" --output text)"
    done
}

eval "$(op completion zsh)"
eval "$(starship init zsh)"

case "$(uname)" in
    Darwin)
        alias ls="ls -G"
        ;;
    Linux)
        alias ls="ls --color=auto"
        alias pbcopy="wl-copy"
        alias pbpaste="wl-paste"
        ;;
esac

if [[ "${TERM_PROGRAM}" == "ghostty" ]]; then
    fastfetch
fi
