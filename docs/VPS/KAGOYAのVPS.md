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
    HostName [VPSのIPアドレス]
    User [ユーザー名]
    IdentityFile C:\Users\[ユーザー名]\.ssh\toyohimeVPS
```

TODO: ユーザ一覧確認方法など、よくあるコマンド一覧を作成する。
