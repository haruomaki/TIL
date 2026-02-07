# Linux一般操作

## ホスト名

```bash
# 確認
uname -n
hostname
hostnamectl

# 変更
sudo hostnamectl set-hostname toyohime-UbuntuVPS
```

## ユーザ

全ユーザ表示：

```bash
# 
sudo awk -F: '
BEGIN {
  printf "%-18s %-6s %-6s %-20s %-15s %s\n",
         "USER","UID","GID","HOME","PASSWD","SHELL"
}
NR==FNR {
  # shadow 側を先に読む
  if ($2=="!" || $2=="!!") pwd[$1]="LOCKED"
  else if ($2=="")         pwd[$1]="NO_PASSWORD"
  else                     pwd[$1]="PASSWORD_SET"
  next
}
{
  printf "%-18s %-6s %-6s %-20s %-15s %s\n",
         $1,$3,$4,$6,(pwd[$1]?pwd[$1]:"N/A"),$7
}
' /etc/shadow /etc/passwd
```

## SSH

ログイン試行等のログ監視

```bash
# 失敗
sudo journalctl -u ssh | grep "Failed password for invalid user" | less

# 成功
sudo journalctl -u ssh | grep "Accepted" | less
```

## GPG

鍵の作成。（メインキーと署名用のサブキー）

```bash
gpg --full-generate-key
```

- 有効期限 → 1y（1年。後で延長できる）
- 名前 → GitHubに表示されても良い名前
- メール → GitHubに登録しているメール

```bash
# 確認
gpg --list-secret-keys --keyid-format=long

# [追記] パスフレーズの無効化
gpg --pinentry-mode loopback --passwd KEY
```

署名と検証。

```bash
gpg --armor --detach-sign README.md
gpg --verify README.md.asc README.md
```

Gitのコミット署名。[GitHubの設定画面](https://github.com/settings/gpg/new)から。

```bash
gpg --armor --export you@example.com
git config --global user.signingkey BBBBBBBBBBBBBBBB # gitに使う鍵を教える
git config --global commit.gpgsign true # GPG署名をデフォルトでON
```
