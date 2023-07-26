# Install

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/leosmaia21/nvim/main/install.sh)"
```
Add to zshrc
```
ZSH_THEME="simple"
plugins=(git
    	zsh-autosuggestions
)
alias cc="clang"
alias nau="nautilus . &"
alias tmux="tmux -f '$HOME/.config/nvim/.tmux.conf'"
setopt no_share_history
unsetopt share_history
```
