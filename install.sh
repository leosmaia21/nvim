

# get the name of the current shell
shell=$(basename "$SHELL")

# determine the rc file based on the shell type
case "$shell" in
  "bash") rcfile=".bashrc" ;;
  "zsh") rcfile=".zshrc" ;;
  "fish") rcfile=".config/fish/config.fish" ;;
  "tcsh") rcfile=".tcshrc" ;;
  "csh") rcfile=".cshrc" ;;
  *) rcfile="" ;;
esac

# print the rc file name and location
if [ -n "$rcfile" ] && [ -f "$HOME/$rcfile" ]; then
	echo "\033[1;32mInstalling neovim\033[0;37m"
	
	git clone https://github.com/leosmaia21/nvim ~/.config/nvim

	
	mkdir ~/.config/nvim/appimage
	wget  -q --show-progress https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O ~/.config/nvim/appimage/nvim
	chmod u+x ~/.config/nvim/appimage/nvim

	#check if libfuse2 package is installed
	if [ $(dpkg-query -W -f='${Status}' libfuse2 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "\033[1;32m You don't have libfuse2 installed, you can install it later manually or extract the appimage now\033[0;37m"
		echo "\033[1;32m Do you want to extract the appimage now? (y/n)\033[0;37m"
		read -r extract
		if [ "$extract" = "y" ]; then
			cd ~/.config/nvim/appimage
			./nvim --appimage-extract
			echo 'export PATH="$HOME/.config/nvim/appimage/squashfs-root/usr:$PATH"' >> ~/$rcfile
		else
			echo 'export PATH="$HOME/.config/nvim/appimage:$PATH"' >> ~/$rcfile
		fi
	else
		echo 'export PATH="$HOME/.config/nvim/appimage:$PATH"' >> ~/$rcfile
	fi

	
	echo "\033[1;32mAdded nvim to $rcfile\033[0;37m"

	echo "Installing pynvim"
	pip3 -q install pynvim

	echo "\033[1;32mDownloading and installing Hack font\033[0;37m"
	wget  -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip
	
	mkdir ~/.fonts
	unzip -qq Hack.zip -d ~/.fonts
	rm Hack.zip
	fc-cache -f

	echo "\033[4;32mDo you want to configure tmux? (y/n)\033[0;37m"
	read -r tmux
	if [ "$tmux" = "y" ]; then
		echo "Copying tmux config file to ~/.tmux.conf"
		cp ~/.config/nvim/tmux.conf ~/.tmux.conf
	fi

	echo "\033[1;31mReopen your terminal and run 'nvim' to start using it!"
	echo "\033[1;31mEnjoy! and unistall vscode, is not a suggestion is an order, you fkng soy dev!\033[0;37m"
	echo "\033[1;32mBtw there is a tmux cheatsheet in ~/.config/nvim  \033[0;37m"


else
  echo "Could not determine rc file for shell '$shell'."
fi
#
#
# rm *.zip
# rm *.tar.*
#
# cd ~/.config
# fc-cache -f
#
# echo ""
# echo "Tadam!!! Fecha o terminal e volta abrir"
# echo "usa o nvim em vez do vim"
# echo "Aceito MbWay e dinheiro"
# source ~/.zshrc
