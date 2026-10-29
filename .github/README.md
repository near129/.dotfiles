GitHub Actions の依存関係は `.github/workflows/actions.lock` に固定します。
workflow の `uses` を変更したときは、次のコマンドで lockfile を再生成してください。
lockfile は手編集しません。

```sh
gh extension install github/gh-actions-lock --pin v0.4.0
gh actions-lock
gh actions-lock --verify
```

Dependabot が GitHub Actions と Nix flake inputs の更新 PR を作成します。
更新確認は毎週月曜日の午前4時（Asia/Tokyo）に設定しています。
実行時刻には遅延が発生する場合があります。
GitHub Actions と Nix は、それぞれのエコシステム内で更新を1つの PR にまとめます。
GitHub Actions には、既存の10日間の cooldown を適用します。
Dependabot は Action のバージョンと対応する `actions.lock` を同じ PR で更新します。
Nix は `flake.lock` を更新します。

通常の CI は Actions lockfile を検証し、`nix flake check --no-update-lock-file` を実行します。
CI では `flake.lock` を更新しません。

Dependabot が同じリポジトリ内で作成した main 向けの PR に、自動 squash merge を設定します。
自動マージ用 workflow は `pull_request_target` で起動し、PR のコードを checkout せず、GitHub CLI で自動マージを有効にするだけです。
マージ対象はイベントに記録された head commit と照合します。

リポジトリで自動マージを有効にし、main の必須チェックに `workflows`、`check (ubuntu-latest)`、`check (macos-latest)` を指定する必要があります。
PR 必須のブランチ保護を維持し、すべての必須チェックが成功してから自動マージします。
チェックが失敗した PR はマージしません。
