# new mac settings

## 初めに

特に何もなければソフトウェアアップデートからosのアップデート

## mac設定

Finder の環境設定→詳細で「すべてのファイル名拡張子を表示」をオンにする。

共有からコンピュータ名の変更とリモートログイン許可
トラックパッドとキーボードのスピードMAX

## brew

```shell
% cd /opt
% sudo mkdir homebrew
% sudo chown -R $USER .
% curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
% vi ~/.zshrc
export PATH=/opt/homebrew/bin:$PATH
% source ~/.zshrc
% brew -v
% brew update
```

## gcc

```shell
brew install gcc
ln /opt/homebrew/bin/gcc-10 /opt/homebrew/bin/gcc
```

もしclangになったらPATHの順番を変更

## zsh

```shell
brew install zsh
vi /etc/shells # 一番下にzshパス
chsh -s /opt/homebrew/bin/zsh
```

### prezto

https://github.com/sorin-ionescu/prezto
`prompt -s pure`

## サイトから入れたもの

- vscode (preview)
- docker desktop (preview)
- karabiner(怪しいらしい)
- chrome
- iterm2
- homebrew
- slack
- google drive
- better touch tools
- cliipy
- tunnelblick(vpn)
- joplin
- typora
- deepl
- discord
- alfred
- zoom

## app store

- line
- runcat

## todo

- [ ] dotfil
- [ ] neovim
- [ ] pyenv + python
- [x] rust
- [ ] drop box
- [ ] pycharm
- [ ] office
- [ ] bitwarden
- [x] brew install

```
bat docker exa fd gcc git wget youtube-dl zsh httpie jq neovim pyenv zsh zsh-autosuggestions
```