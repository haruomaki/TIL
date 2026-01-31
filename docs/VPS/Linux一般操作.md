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

## ssh

ログイン試行等のログ監視

```bash
sudo journalctl -u ssh | less
```
