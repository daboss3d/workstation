Stow tips 
----------------- 

### Installation 

```shell

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/stow-files/config/.config/tmux/plugins/
git clone https://github.com/vaaleyard/tmux-dotbar.git ~/stow-files/config/.config/tmux/plugins/

# stow the files (make links in home dir)
stow config

# source the tmux config file to apply changes
tmux source ~/.config/tmux/tmux.conf
```





### e.g. for bash

```shell 
mkdir stow-files/bash

# move files 
mv .bashrc stow-files/bash/

# stow bash - it will create a simlink in ~ of .bashrc to stow-files/bash/.bashrc
stow bash

# list files to check simlink
ls -la ~
```



### local - e.g stow local 
will symlink to .local/bin wich is on the path, so scripts will run from anywhere 

### alecritty 
will symlink to .config/alacritty

---



pandoc -s  --highlight-style my-theme.json  --to html5 --standalone --metadata title="test" tmux.md  > /tmp/tmux.html

andoc -s  --highlight-style breezedark --to html5 --standalone --metadata title="test" tmux.md  > /tmp/tmux.html







