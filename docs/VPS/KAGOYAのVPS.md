# KAGOYAのVPS始め方

OSはUbuntu Serverを選択。
Web上のコンソールからはユーザ名 `root` & パスワードで入れる。
SSHからは後述の設定後ユーザ名 `ubuntu` で入れる。

## ログイン用認証キー

SSH用の鍵ペアのこと。KAGOYA側で生成してくれて、秘密鍵をDLさせられる。
ファイル名は例えば `toyohimeVPSのログイン用認証キー.key`。
これを `.ssh` 直下に配置＆ファイル名変更する。

```powershell
C:\Users\alex\.ssh\toyohimeVPS

# 念のためパーミッション設定
icacls C:\Users\alex\.ssh\toyohimeVPS /inheritance:r
icacls C:\Users\alex\.ssh\toyohimeVPS /grant:r alex:R

# known_hostsの更新
ssh-keygen -R 133.***.***.***

# 接続！
ssh -i "C:\Users\alex\.ssh\toyohimeVPS" ubuntu@133.***.***.***
```

秘密鍵のフルパス指定を省略したい場合、`C:\Users\[ユーザー名]\.ssh\config` に以下を記述する：

```config
Host toyohime
    HostName 133.***.***.***
    User ubuntu
    IdentityFile C:\Users\alex\.ssh\***のログイン用認証キー.key
```

## ドメイン取得

レジストラは[adm.jp](https://adm.jp)、DNSホスティングは抱き合わせの[FREENS.JP](https://freens.jp)で行う。

AレコードをVPSサーバのものに設定する。

```dns
$TTL 300
@ IN SOA ns1.freens.jp. root.ns1.freens.jp. (2601311827 10800 3600 604800 86400)
;
 IN NS ns1.freens.jp.
 IN MX 0 haruomaki.jp.
 IN TXT "v=spf1 mx ~all"
 IN A 133.18.104.232
www IN CNAME haruomaki.jp.
```

```pwsh
❯ nslookup haruomaki.jp
サーバー:  UnKnown
Address:  240b:12:47e2:3000:1266:82ff:fea6:956c

権限のない回答:
名前:    haruomaki.jp
Address:  133.18.***.***
```

応答が返ってくれば、インターネット上でDNSが機能していることが確かめられる。

### 余談：DNSレコード解説

- `A` IPv4アドレス
- `AAAA` IPv6アドレス
- `MX` メールサーバのホスト名
- `CNAME` **ドメイン名のエイリアス**を設定する。`www.hoge.com`を`hoge.com`に転送するなど
- `NS` 「自分は知らないけどこの人なら知ってるはずだよ」
- `TXT` 拡張情報
- `SOA` メタ情報
