# fluentd image
fluentd の Docker イメージです。GKEのポッド上でのサイドカーコンテナとしての
使い方を想定していますが、Aggregator などとして単体でデプロイすることも可能だと思います。

## リファレンスデザイン
[Fluentd GCP Image](https://github.com/GoogleCloudPlatform/k8s-stackdriver/tree/master/fluentd-gcp-image)

## fluentd の設定方法
`/etc/fluent/config.d` 以下の全ての `.conf` ファイルを読みます。
GKE 上でデプロイする際に、configmap から設定をデプロイしてください。

## fluentd のプラグインインストール
Gemfile にプラグインを追加してビルドしてください。

## fluentd の引数
`FLUENTD_ARG` 環境変数が fluentd コマンドに渡されます。

## Makefile のターゲット
```bash
# Gemfile.lock の依存関係を無視してパッケージをアップデートする。
make update-dependencies
```
