# Dotfiles

## 初回準備

```sh
mkdir -p ~/.config
git clone https://github.com/near129/.dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
```

## 初回適用

nix-darwinとHome Managerをまとめて適用する場合:

```sh
sudo nix --extra-experimental-features 'nix-command flakes' \
  run nix-darwin/master#darwin-rebuild -- switch --flake .#default
```

Home Managerだけを適用する場合:

```sh
nix --extra-experimental-features 'nix-command flakes' \
  run home-manager/master -- switch --flake .#near129
```

## 設定の適用

```sh
# nix-darwin＋Home Manager
nh darwin switch -H default

# Home Manager
nh home switch -c near129
```

## 依存の更新

```sh
cd ~/.config/dotfiles
nix flake update
```

更新と適用をまとめて行う場合:

```sh
# nix-darwin＋Home Manager
nh darwin switch -H default --update

# Home Manager単独
nh home switch -c near129 --update
```

## 検証

```sh
cd ~/.config/dotfiles
nix flake check
```
