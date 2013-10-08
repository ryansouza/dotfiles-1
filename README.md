dotfiles
========

Home Sweet Home (directory).

How to Make all the Symlinks:
-----------------------------

```
$ ./link.sh
```

How to get Vim Working:
-----------------------

1. Setup [Vundle]:

     ```
     $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
     ```

2. Launch Vim

3. Install all the Vundle Bundles!

  ```vim
  :BundleInstall
  ```

A note about the gitconfig:
---------------------------

I've removed the github section (including my github_token) from the gitconfig and included it via an ```[include]``` directive.  If you'd like to do the same, drop a .github_token file in your home directory and the gitconfig will pick it up.  Be sure to change the user details!
