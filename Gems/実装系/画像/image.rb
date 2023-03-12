

### 画像について
# ページダウンロード時にデータ量の大部分を占める

# https://developers.google.com/speed/docs/insights/OptimizeImages?hl=ja

## 項目
# • エンコードするデータの種類
# • 画像形式の機能
# • 画像の設定
# • 解像度

# • ベクター形式での配信
# • CSS による代替表現

# • GIF, PNG は可逆圧縮 ...圧縮による影響が少ない
# - GIF →基本はPNG に変換する

# ex)  MiniMagick

convert INPUT.gif_or_png -strip [-resize WxH] [-alpha Remove] OUTPUT.png


# https://qiita.com/chabudai/items/8ebb63fe1d4608777807


# • JPEG ...非可逆圧縮
#- 画質は85以下に必ず設定する
#- 輝度, 色への感度を考慮し、クロマサンプリング4:2:0
#- 10kB を超える場合、プログレッシブJPEGを利用

convert INPUT.jpg -sampling-factor 4:2:0 -strip [-resize WxH] [-quality N] [-interlace JPEG] [-colorspace Gray/sRGB] OUTPUT.jpg






# 不明

# ☐ アップロード前画像縮小
# https://stackoverflow.com/questions/61022559/writing-active-storage-output-to-tempfile
# https://qiita.com/chappy_30313331/items/ac0a320c899f9fe1d23a
#- ImageMagick だとリサイズ処理がうまくいくが、vipsだとダメ
#- vipsは情報不足






