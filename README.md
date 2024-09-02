# My config files


My dot config files for my Linux/Mac systems.

They are managed by [GNU-stow](https://www.gnu.org/software/stow/).


## Setup

1. Install stow.
```shell
$ sudo apt install stow
```

2. Clone this repo.
```shell
$ cd $HOME && git clone https://github.com/ZuoAnZoom/.myconfig.git
```

3. Setup using stow.
```shell
$ cd $HOME/.myconfig
$ stow zsh
$ stow tmux
$ stow nvim
$ stow ...
```


PS: If you just want to quickly setup just zsh and tmux, you can use the following command:
```shell
$ cd $HOME && git clone https://github.com/ZuoAnZoom/.myconfig.git && cd .myconfig && bash -c './ln.sh'
```


## Config Reference

### Tmux config
Use [oh my tmux](https://github.com/gpakosz/.tmux) with some customize options.

- fzf include.


### zsh config
Use [oh my zsh](https://ohmyz.sh).


### Git config
Use [git-delta](https://github.com/dandavison/delta) with some customize options.

FYI: [git-lfs](https://git-lfs.com/) required.
