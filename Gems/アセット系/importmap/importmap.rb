


# リファクタリング用
# https://techracho.bpsinc.jp/hachi8833/2021_10_07/112183

# https://zenn.dev/takeyuweb/articles/996adfac0d58fb
# https://github.com/rails/importmap-rails?msclkid=76980bbacf7c11ec89eb0415834acd29
# https://laboradian.com/import-maps/?msclkid=da687d03cf7b11ec8e0b5cc53ba1c54e

# importmap ...ESModuleのURLを制御するWeb標準
# 特徴)
# • ES6 をそのまま使う
# - トランスパイルしない
# - bundler不要 ...webapcker(JSbuild)が不要?
# - npm( yarn)不要





# • <％= javascript_importmap_tags％>
# →importmap_tags_helper.rb を生成
# - プリロード
# - application.js などからJSモジュールを参照

# その他
# - env で環境を指定
# - 特定のページに適応


# $ ./bin/rails importmap:install

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create application.js module as entrypoint
# create  app/javascript/application.js
# Configure importmap paths in config/importmap.rb
# create  config/importmap.rb
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# 用法

# 1. ./bin/importmap pin vue
# 2. importmap.rbの確認 urlが動作するかを確認
# 3. JS/application.js ...import 文?を記述
# 4. Ⅴiewファイルに記述

# 文法

# Viewファイル

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <script type="importmap">{
#   "imports": {
#     "パッケージ名":"取得先のURL"
#   }
# }</script>
# <script type="module">
#   import "application";
# </script>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# • "components": "/assets/components/index-12345.js" ...path指定
# • "react": "https://ga.jspm.io/npm:react@17.0.2/index.js" ...URL指定
# • "application" 

# assets/application.js

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# import { Hello } from "components";
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# • ブラウザによって"components"に対応する: "/assets/components/index-12345.js"からダウンロードされ、exportされたHelloオブジェクトをimport。

# config/iportmap.rb

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# pin "application", preload: true
# pin_all_from "app/javascript/components", under: "components"
# pin "react", to: "https://ga.jspm.io/npm:react@17.0.2/index.js"
# pin "react-dom", to: "https://ga.jspm.io/npm:react-dom@17.0.2/index.js"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# • pin "パッケージ名", to: "取得先のURL"
# - パッケージ名はapp/javascript/内のファイル名と対応
# - to: ...リモートサーバ上のモジュールのURLを指定
# - preload: true ...モジュールと依存関係を先に取得

# • pin_all_from(ディレクトリ,under: , to: , preload)
# - 指定したディレクトリ以下のファイルをマッピングに追加
# - under



# コマンド
# • bin/importmap コマンド ...importmap.rbにパッケージを追加・削除
# - パッケージとその依存モジュールも追加



# 用語
# ☐ import文 ...モジュールの取得先URLを制御
# - ESModuleが読み込めるブラウザで使用
# ☐ import()式
# ☐ export


# 不明
# ☐ preload: true
# →rel ="modulepreload" ...ESModuleのプリロードに必要
# ☐ import.rbでは文字列の('')は解釈されない


# できないこと
# ☐ JSXの処理 ...プリコンパイルが必要
# - React コンポーネントはクラスのみ

# ☐ npmモジュールのアップデート



# ディレクトリ
# • config/importmap.rb ...DSLを利用したマッピングの設定
# • app/assets/javascripts/application.js ...requireで自動的に全てのページで展開される。
# • config/initializers/assets.rb ...アセットパイプラインの探索パスの設定を追加


# デプロイ時
# railsのアセットパイプラインと本番環境のデプロイについて - Qiita



# 流れ

# <head>タグに記載された<%= javascript_importmap_tags %> でページにinlinedされる。
# <script type="importmap"> タグ内に JSON が設定される。
# es-module-shim がロードされる
#  <script type="module">import "モジュール名"</script> によってapp/javascript/application.js(論理的エントリーポイント) からモジュールがimportされる。

# • app/javascript/application.js ...importmapで定義されたモジュールをimoportして設定する。
# - <script type="module"> タグの中身を記述(Viewに書く必要はない?)


# エラー
# importmap-rails を試してみました - MoguraDev
# - js が反映されない

# サンプル
# importmap-rails を試してみました - MoguraDev
# Rails7 rails/importmap-railsの概要 | (hazm.jp)
# importmapのサンプル - @ledsun blog (hatenablog.com)
# browser esm互換のURLに変更したら動いた。





