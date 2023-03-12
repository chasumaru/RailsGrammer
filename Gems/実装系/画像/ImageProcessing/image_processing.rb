


# •ImageProcessing
# ->MiniMagickを内包する上位互換のGem
# - 画像サイズを調節可能


# • libvips ...ImageProcessingの画像処理ソフトウェア
# - ImageMagickよりも知名度が低い
# - IM より10倍高速かつメモリ消費1/10
# - jpeg: libjpeg-dev をlibjpeg-turbo-dev に置き換えると2~7倍速


# https://zenn.dev/iloveomelette/articles/76aad4d9ce86d1
# - どうしてもvariantメソッドで表示されなかったが、MiniMagick に変えたら表示された。rails7 ではデフォルトでvipsを利用している
# https://github.com/janko/image_processing
# - Macではvipsだが、ubuntuではlibvipsをインストールする必要があった! 解決!

