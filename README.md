# Dotfiles

个人 dotfiles 配置仓库。

这个仓库采用手动安装方式：先查看差异，再备份，再按文件复制。仓库不提供批量覆盖脚本。

## 目录结构

```text
configs/
  bash/bashrc        -> ~/.bashrc
  git/gitconfig      -> ~/.gitconfig
  tmux/tmux.conf     -> ~/.tmux.conf
  vim/vimrc          -> ~/.vimrc
  python/pdbrc       -> ~/.pdbrc
```

## 备份当前配置

安装前先备份本机已有配置：

```bash
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

[ -f ~/.bashrc ] && cp -a ~/.bashrc "$BACKUP_DIR/bashrc"
[ -f ~/.gitconfig ] && cp -a ~/.gitconfig "$BACKUP_DIR/gitconfig"
[ -f ~/.tmux.conf ] && cp -a ~/.tmux.conf "$BACKUP_DIR/tmux.conf"
[ -f ~/.vimrc ] && cp -a ~/.vimrc "$BACKUP_DIR/vimrc"
[ -f ~/.pdbrc ] && cp -a ~/.pdbrc "$BACKUP_DIR/pdbrc"

echo "Backup saved to: $BACKUP_DIR"
```

## 安装 Bash 配置

```bash
install -m 0644 configs/bash/bashrc ~/.bashrc
bash -n ~/.bashrc
source ~/.bashrc
```

## 安装 Git 配置

```bash
install -m 0644 configs/git/gitconfig ~/.gitconfig
git config --global --list --show-origin
git var GIT_AUTHOR_IDENT
```

## 安装 Tmux 配置

```bash
install -m 0644 configs/tmux/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

当前 tmux 配置使用 `C-a` 作为 prefix，并保留窗口和 pane 从 `0` 开始编号。

## 安装 Vim 配置

```bash
install -m 0644 configs/vim/vimrc ~/.vimrc
```

安装 vim-plug：

```bash
mkdir -p ~/.vim/autoload ~/.vim/plugged

curl -fLo ~/.vim/autoload/plug.vim \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

安装 Vim 插件：

```bash
vim +PlugInstall +qall
```

推荐依赖：

```bash
sudo apt install ripgrep universal-ctags
```

说明：

- `ripgrep` 用于 Vim 里的 `:Rg`
- `universal-ctags` 用于 Tagbar
- `coc.nvim` 需要 `node`

验证 Vim 配置能加载：

```bash
vim -Nu ~/.vimrc -n -es +'qall!'
```

## 安装 pdb 配置

```bash
install -m 0644 configs/python/pdbrc ~/.pdbrc
```

验证：

```bash
python3 -m pdb -c continue - <<'PY'
print("pdb ok")
PY
```

## 常用检查

```bash
bash -n ~/.bashrc
git config --global --list --show-origin
tmux source-file ~/.tmux.conf
vim -Nu ~/.vimrc -n -es +'qall!'
```
