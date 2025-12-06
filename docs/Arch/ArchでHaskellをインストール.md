1. ghcupを使う
2. pacmanベース

2は静的/動的リンクの問題やstackがフルに使えない問題があったので、1がいいかも。

pacmanのhaskell関係パッケージは基本的に使わず、全部ghcup（および配下のstack）に任せる。



# ghcupとstack

stackはデフォルトでは、自分でghcのバージョンを管理する。その管理にghcupを使わせるようにするには設定が必要。<https://www.haskell.org/ghcup/guide/#stack-integration>

`~/.stack/config.yaml`を編集すればよい。

```bash
stack new (プロジェクト名) simple
```

でプロジェクト作成。

