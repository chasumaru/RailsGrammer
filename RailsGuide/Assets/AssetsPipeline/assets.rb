


# アセットパイプライン
# - (本番環境) JS, CSS の統合→HTMLへの落とし込み
# - 最終的にアセットへのパスを変換する



# 1. 高級言語のコンパイル
# - coffee, scss  (開発環境ではここまで)
# 2. アセットの結合 
# - 複数のjsファイルをapplication.jsに統合(CSSも同様)
# 3. アセットの最小化
# - 改行,コメントなど
# 4. digestを付与してpublic/assets下に反映
# 5. HTMLで読み込まれる

# # <%= stylesheet_pack_tag 'application', media :all %>

# - media:all ...適用する画面幅の指定(all: デフォルト)
# - data-turbolinks-trackt="rel"

# • adiminセクション用のマニフェストファイルを作る事もできる。admin.js, admin.css

# • プリプロセスは拡張子によって順序が決まる

# • プリコンパイル時にdigestを生成するメリット
# 1. ブラウザでキャッシュを利用
# 2. アセットの変更は新たなdigestとして反映される


# • production環境
# - アセットはプリコンパイル済みかつ静的なアセットとしてwebサーバから提供
# - config.assets.prefix ...コンパイル済みのアセットの保存場所を指定
# - 他のマニフェスト, スタイルシートをインクルードしたい場合はconfig/initializers/assets.rbに追記する
# ex) admin.css

# • アセットはgemとして外部から持ち込める
# ex) jquery-rails ...標準のJSライブラリを提供









# 用語
# • コンパイル ...機械言語への翻訳
# • プリコンパイル ...コンパイルの準備
# • トランスパイル


# • フィンガープリント ...アセットのプリコンパイル時にwebブラウザでキャッシュする

# • プリコンパイル ...production へのデプロイ時に必要
# - app/assetsのファイルをpublic/assets に置くことで、Webサーバに静的なassetとして処理される

# • 動的コンパイル ...パイプラインへのアセットへのリクエストが直接Sprockets

# • CDN ...ブラウザからアセットをリクエスト→ネットワークのキャッシュがコピーされる。
# - CDNはコンテンツをキャッシュ(保存)する事で動作する
# - curlコマンドによってCDNヘッダが正しくキャッシュされているかを確認する


# Gem
# • sprockets ...プリコンパイルを行う
# • webpacker ...モジュールバンドラ
# - JS依存性の管理
# - プリコンパイル
# • sass-rails ...アセットへのパスを変換するヘルパー
# - image-path("rails.png")→"/assets/rails.png"

