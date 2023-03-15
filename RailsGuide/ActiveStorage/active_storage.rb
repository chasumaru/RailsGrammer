
# https://railsguides.jp/active_storage_overview.html

### テーブル構造について

# active_storage_blobs..ファイルのメタ情報の管理
# active_storage_attachments ...中間テーブル


## 特徴

# Active Storageではblob型として画像をテーブルに保存する。
#- 画像のパスをDBに保存し、画像はS3 などの外部ストレージに結びつける

# blob型 ...任意のバイナリデータを格納するデータ型
#- グラフィックイメージ, サテライトイメージ, ビデオクリップ

# ダイレクトアップロード機能を利用すると、不完全なvalidationになる。




### 利用方法
# ActiveStorageに巨大画像を保存させない
#=> 画像サイズのvalidation
#=> 画像を圧縮してDBに保存する(ストレージの節約)
# ActiveStorageに大量の画像を保存させない
#=> 画像数のvalidation
