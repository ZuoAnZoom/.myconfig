#!/bin/bash
script_dir=$(cd "$(dirname "$0")"; pwd)
script_path=$script_dir/$(basename "$0")

echo "[INFO] script_dir: $script_dir"
echo "[INFO] script_path: $script_path"
echo "[INFO] HOME: $HOME"

create_symlink(){
  if [ "$#" -ne 1 ]; then
    echo "[ERROR] 1 param required!"
    return 1
  fi

  file="$1"
  source_path=$script_dir/$file
  target_path=$HOME/$file
  echo "[INFO] source_path: $source_path"
  echo "[INFO] target_path: $target_path"
  if [ ! -e "$source_path" ]; then
    echo "[ERROR] '$source_path' not exist!"
    return 1
  fi
  
  ln -s "$source_path" "$target_path"

  if [ $? -eq 0 ]; then
    echo "[INFO] Successfully create cymlink, '$source_path' -> '$target_path'"
  else
    echo "[ERROR] Create symlink failed, '$source_path' -> '$target_path'"
  fi
}

# tmux config
create_symlink ".tmux.conf"
create_symlink ".tmux.conf.local"

# zsh
create_symlink ".zshrc"
echo "[INFO] please execute following command if plugin not found: 'git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'"
