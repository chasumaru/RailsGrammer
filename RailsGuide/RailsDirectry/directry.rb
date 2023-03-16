
# ルート(/)下のディレクトリの概要を整理


### app/


## model

## view

## controller

## helper

## mailer

## channel

## job

## assets




### bin/ ...railsスクリプト

## セットアップ, アップデート, デプロイ用のスクリプトファイルなど


### config/ ...各種設定ファイル
# https://railsguides.jp/configuring.html

## routes.rb

## database.yml



### config.ru

## Rackベースのサーバ用のRack設定ファイル



### db/

## schema.rb

## migration


### Gemfile

## Gemの依存関係


### Gemfile.lock



### lib/

## アプリケーションで利用する拡張モジュールを置く


### log/

## アプリケーションのログファイルを置く



### public/ ...外部に公開されるアセット

## 静的なファイル

## コンパイル済みアセット



### Rakefile

## コマンドラインから実行できるタスクを探索して読み込む
#- Rails全体のコンポーネントに対して定義
#- 独自の定義タスクはlib/tasks配下に設置する(推奨)


### README.md

## アプリケーションの概要を簡潔に説明する



### storage/

## Active Storageファイル



### test/ ...テスト関連ファイル



### tmp/ ...一時ファイル

## キャッシュ

## pid



### vendor/ ...サードパーティー製コードを設置

## 外部のGemfileなど



### .gitattributes ...gitリポジトリ内の特定のパスについて、メタデータを定義


### .gitignore ...gitに登録しないファイルを設定


### ruby-version