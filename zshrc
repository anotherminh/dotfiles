# -------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------

# Add custom functions directory to fpath
fpath=("$MAIN_DIR/.devcontainer/zsh-functions" $fpath)

# Load zsh functions
autoload ${fpath[1]}/*(:t)

# -------------------------------------------------------------------
# Aliases | Git
# -------------------------------------------------------------------
alias g="git"
alias p="push"
alias grc="git rebase --continue"
alias gaa="git add -A && git commit --amend --no-edit" # or using signed commits -- alias aa="add -A && git commit -S --amend --no-edit"
alias gpohf="git push origin HEAD --force-with-lease"
alias gap="gaa && gpohf"
alias gempty="git commit --allow-empty -m \"empty commit to re-run all CI jobs\" && git push"
alias gfmp="gfm dev && gamp \"Merge dev\""