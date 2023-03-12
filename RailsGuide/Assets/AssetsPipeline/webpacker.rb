


# https://railsguides.jp/webpacker.html#webpacker%E3%81%8Csprockets%E3%81%A8%E7%95%B0%E3%81%AA%E3%82%8B%E7%90%86%E7%94%B1
# - ヘルパー(asset) の種類
# - webpacker:install で生成されるファイル




# • sprockets ...Gemを用いることでコードを追加
# 用途)
# - 移行にコストがかかるレガシーアプリの場合
# - Gemで統合したい場合 

# 特徴)
# - sass-rails ...assets圧縮に必要
# - sassc-rails ...sass-railsの代わり


# • Webpacker ...sprockets より多くのものを統合
# 用途)
# - npm パッケージを使いたい場合
# - 最新のJS機能, ツールを利用したい場合

# 特徴)
# - 自動コンパイル


# 実装)
# - Yarn ...必要。JSの依存関係のインストール,管理
# - Node.js ...必要




# • importmap
# <%= javascript_importmap_tags %>
# - ??



