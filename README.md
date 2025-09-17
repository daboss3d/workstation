Stow tips 
----------------- 


Copying .bashrc

```shell 
mkdir stow-files/bash

# move files 
mv .bashrc stow-files/bash/

# stow .bashrc - it will create a simlink in ~
stow bash 

# list files to check simlink
ls -la ~
```
```







