# -------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------

# Add custom functions directory to fpath
DOTFILES_DIR="${0:A:h}"
fpath=("$DOTFILES_DIR/zsh-functions" $fpath)

# Load zsh functions
autoload ${fpath[1]}/*(:t)

# -------------------------------------------------------------------
# Prompt (vcs_info)
# -------------------------------------------------------------------

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats       ' %F{cyan}%b%f%u%c%m'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}%b%f|%F{yellow}%a%f%u%c%m'

zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
    local -a gitstatus
    (( ahead )) && gitstatus+=("%F{green}↑${ahead}%f")
    (( behind )) && gitstatus+=("%F{red}↓${behind}%f")
    hook_com[misc]+="${(j: :)gitstatus:+ ${(j: :)gitstatus}}"
}

setopt PROMPT_SUBST
precmd() { vcs_info }
PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %# '

# -------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------
alias v="vim"
alias g="git"
alias p="push"
alias grc="git rebase --continue"
alias gaa="git add -A && git commit --amend --no-edit" # or using signed commits -- alias aa="add -A && git commit -S --amend --no-edit"
alias gpohf="git push origin HEAD --force-with-lease"
alias gap="gaa && gpohf"
alias gempty="git commit --allow-empty -m \"empty commit to re-run all CI jobs\" && git push"
alias gfmp="gfm dev && gamp \"Merge dev\""
