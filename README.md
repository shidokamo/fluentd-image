# fluentd sidecar image
fluentd の Docker イメージです。GKEのポッド上でのサイドカーコンテナとしての
使い方を想定しているため最低限のプラグインしかインストールされていません。
Aggregator などとして単体でデプロイすることも可能だと思いますがその際はプラグインを追加してください。

## リファレンスデザイン
[Fluentd GCP Image](https://github.com/GoogleCloudPlatform/k8s-stackdriver/tree/master/fluentd-gcp-image)

## debian-base-amd64:v1.0.0
非常に軽量の debian イメージです。サイドカーとして多くの pod にデプロイする関係上これは重要です。
sh などの最低限のツールは搭載されていますが、例えば、/bin/bash などを実行することはできません。
`apt-get` は使用できますが、より便利な `clean-install` というコマンドが提供されています。

v1.0.0 は、version 9.8 の debian ディストリビューションを使用しています。

## fluentd の設定方法
`/etc/fluent/config.d` 以下の全ての `.conf` ファイルを読みます。
GKE 上でデプロイする際に、configmap から設定をしてください。

## ビルド方法：fluentd のプラグインのカスタマイズ (Gemfile の更新）
Gemfile を更新して、`make build` を行なってください。
依存関係が解決できなかった場合、ビルドが失敗します。

イメージの作成に成功したら、`update-dependencies` で Gemfile.lock を更新できます。

## fluentd の引数
`FLUENTD_ARG` 環境変数が fluentd コマンドに渡されます。

