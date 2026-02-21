# -------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------

# Add custom functions directory to fpath
DOTFILES_DIR="${0:A:h}"
fpath=("$DOTFILES_DIR/zsh-functions" $fpath)

# Load zsh functions
autoload ${fpath[1]}/*(:t)

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
