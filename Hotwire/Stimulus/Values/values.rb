
# https://stimulus.hotwired.dev/reference/values

# • 特別なコントローラー属性を利用してHTML data属性を扱う。

# - HTML) data-[identifier]-[name]-value  ...ケバブケース
# - JS) キャメルケース

# • static values で扱うvalue とそのデータ型を定義

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# value’s name on the left and its type on the right.

# export default class extends Controller {
#   static values = {
#     url: String,
#     interval: Number,
#     params: Object
#   }
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • データ型はJS とHTML のトランスコードを決定する
# - エンコード ...文字列→エンコード文字に変換
# - URLエンコード ...日本語などをURLの規格に変換する

# • valueプロパティ
# 1. this.[name]Value ...getter
# - データ属性をインスタンスにデコードする
# 3. this.[name]Value= ...setter
# - データ属性をコントローラーの要素に設定
# 4. this.has[name]Value ... boolean


# 参考)
# • data属性 ...カスタムデータ属性
# - HTML とDOM間での情報のやり取り
# - HTML インターフェイスを利用




