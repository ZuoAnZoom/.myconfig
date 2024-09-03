# My config files


My dot config files for my Linux/Mac systems.

They are managed by [GNU-stow](https://www.gnu.org/software/stow/).


## Setup

1. Clone this repo to your home directory.

```shell
$ git clone https://github.com/ZuoAnZoom/.myconfig.git $HOME/.myconfig
```

2. Setup.

Using `config.sh` to set up. Including both apps and configs.

```shell
$ bash -c '$HOME/.myconfig/config.sh'  # it will setup stow, wget, git, zsh, tmux, fzf by default.
$ bash -c '$HOME/.myconfig/config.sh nvim <other-app> ...'  # add other apps
```

FYI:

- If you only need the dot files, install stow first, then using stow to set up the dot files.

```shell
$ sudo apt install stow
$ cd $HOME/.myconfig
$ stow zsh
$ stow tmux
$ stow nvim
$ stow ...
```

- If you just want to quickly setup zsh and tmux, you can use the following command:

```shell
$ cd $HOME && git clone https://github.com/ZuoAnZoom/.myconfig.git && cd .myconfig && bash -c './ln.sh'
```


## Reference

### Tmux
Use [oh my tmux](https://github.com/gpakosz/.tmux) with some customize options.


### zsh
Use [oh my zsh](https://ohmyz.sh).

FYI: Include fzf, nvim setups.

### Git
Use [git-delta](https://github.com/dandavison/delta) with some customize options.

FYI: [git-lfs](https://git-lfs.com/) required.
