Stow tips 
----------------- 

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
```


### local - e.g stow local 
will symlink to .local/bin wich is on the path, so scripts will run from anywhere 

### alecritty 
will symlink to .config/alacritty

---



pandoc -s  --highlight-style my-theme.json  --to html5 --standalone --metadata title="test" tmux.md  > /tmp/tmux.html

andoc -s  --highlight-style breezedark --to html5 --standalone --metadata title="test" tmux.md  > /tmp/tmux.html







