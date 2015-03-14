# ビープ音を鳴らさない
setopt nolistbeep 

# 色設定
autoload -U colors; colors

# タイトル設定
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# プロンプト指定
PROMPT="
[%n] %{${fg[yellow]}%}%~%{${reset_color}%}
%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "
PROMPT2='[%n]> '
autoload -Uz vcs_info # 以下、VSCの設定
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'



# もしかして機能
setopt correct
SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < %B%r%b %{$fg[red]%}? [Yes!(y), No!(n),a,e]:${reset_color} "

# 補完設定 
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
setopt list_packed # 補完が詰めて表示される
setopt noautoremoveslash # ディレクトリのスラッシュを削除しない

# 補完の追加設定
fpath=(~/.zsh/completion ${fpath})
autoload -U compinit
compinit

# コマンド履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Emacsライクキーバインド
bindkey -e

# auto_cd(ディレクトリ名だけでcd)
setopt auto_cd

# 移動したディレクトリの記憶（「cd -<tab>」で補完）
autoload -U compinit
compinit
setopt auto_pushd

# alias
setopt complete_aliases

case "${OSTYPE}" in
darwin*)
   alias ls="ls -G"
   alias ll="ls -lG"
   alias la="ls -laG"
   ;;
 linux*)
   alias ls='ls --color'
   alias ll='ls -l --color'
   alias la='ls -la --color'
   ;;
esac
alias du="du -h"
alias df="df -h"
alias vi="vim"
alias -s py=python

