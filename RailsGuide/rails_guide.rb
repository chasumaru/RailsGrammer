

### 参考サイト

# https://techracho.bpsinc.jp/hachi8833/2021_04_08/104703
# https://techlife.cookpad.com/entry/2020/12/25/155741



### Task一覧

## Guideの深掘りをする項目

# active_record
# assets
# form_helper
# rendering



#### Railsを始めよう

# https://railsguides.jp/getting_started.html


### Rails概要

## DRY ...Don't Repeat Yourself
# 繰り返しを避けよ

#- 再利用性
#- 保守性
#- 拡張性


## COC ...Convention Over Configuration
# 設定より規約が優先

#- Railsのデフォルト設定をフル活用



### 環境構築

## 必要なソフトウェア(Windows)

# Ruby Installer
#=> Ruby, SQLite3


# gem install rails ...Rails Gemのインストール
# rails --version




### アプリケーションの作成

## Generator ...特定のタスクを開始するのに必要なファイルを自動で作成する

# rails new ...Railsアプリケーションの基盤となるディレクトリ構造を自動で作成する
rails new Blog

#- Gemfileで指定されたGemが[bundle install]コマンドによりインストールされる




### Webサーバーの起動

# bin/rails server ...Blogディレクトリでサーバー(Puma)起動
#- http://localhost:3000 でブラウザ表示




### 機能の実装手順



##1 Controllerの実装

# rails g cotroller ControllerName action_name, ...コントローラーと対応するアクションを作成する
#- viewファイル, testファイル, helperファイルが作成される
#- Controller名は複数形

##2 Routingの実装

# config/routes.rb ...ルーティングを作成する


##3 Viewの実装

# コントローラーのアクションに対応するviewファイルを編集する


##4 Modelを実装する場合

# rails g model ModelName column_name: data_type, ...モデルを作成し、対応する
#- modelファイル, migrationファイル, testファイル, fixturesファイルが作成される
#- Model名は単数形

# マイグレーションの実行
rails db:migrate

# https://railsguides.jp/getting_started.html#%E3%83%A2%E3%83%87%E3%83%AB%E3%82%92%E7%94%A8%E3%81%84%E3%81%A6%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%A8%E3%82%84%E3%82%8A%E3%81%A8%E3%82%8A%E3%81%99%E3%82%8B
















### 留意事項

## Railsではアプリケーションのクラスやモジュールは、どこからでも参照できる(オートロードが有効)
# https://railsguides.jp/autoloading_and_reloading_constants.html

#- app/ディレクトリ配下で、requireを書いてはいけない

# requireを書く必要がある場合

#1 lib/ ディレクトリ配下にあるファイルを参照する場合
#2 Gemfileで requre: falseが指定されているgem依存を読み込む場合