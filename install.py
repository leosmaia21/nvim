import os


def install():

    # get current shell rc file
    shell = os.environ["SHELL"]
    if shell.endswith("bash"):
        rc_file = os.path.expanduser("~/.bashrc")
    elif shell.endswith("zsh"):
        rc_file = os.path.expanduser("~/.zshrc")
    else:
        raise Exception("Unsupported shell: {}".format(shell))

    nvim_url = "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"

    # install neovim
    print("Downloading neovim appimage to HOME folder...")
    os.system("wget {} -q --show-progress -O ~/nvim".format(nvim_url))
    os.system("chmod u+x ~/nvim")

    with open(rc_file, "a") as f:
        f.write("\nalias nvim=\"~/nvim\"\n")
        tmux = input("Do you want to configure tmux? [y/n]: ")
        if tmux == "y":
            v = "alias tmux=\"tmux -f '$HOME/.config/nvim/.tmux.conf'\""
            f.write(v + "\n")
    #source rc file 
    os.system("source {}".format(rc_file))

if __name__ == "__main__":
    install()
