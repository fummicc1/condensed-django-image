## Condensed django image

Docker のマルチステージを活用した docker image
（Django と PostgreSQL の image を使用）

- 注意: `postgres:14`は m1 mac で動作しないので`postgres:12`を使用しています。よしなにアップグレードしてください

## 使い方

### 1. docker image の生成

以下のコマンドで dokcer image を作成します

```sh
docker build -t sample_multistage:0.1 .
```

`-t`オプションはイメージに名前とバージョンをつけます。

### 2. docker container の作成

以下のコマンドで docker container を生成します。

```sh
docker run --name sample_multistage \
-itd -p 5432:5432 -p 8000:8000 \
-v db_data:/var/lib/postgresql/data \
79d339cacea9
```

オプションなどの説明

- `d` ... detached（バックグラウンドプロセスで実行）
- `i` ... コンテナの入力に接続
- `t` ... 擬似ターミナルの割り当て
- `p` ... ポートのバインド
- `v` ... ボリュームのバインド
- `79d339cacea9` ... step1 で生成した image の ID（`docker image ls`で見つける）

### 3. 動作確認

[django application](http://127.0.0.1:8000)にアクセスできることを確認します
