
### 概要

# XML,JSONなど色々なファイル形式でレンダリングできる


## ページ遷移

# render ...controllerを経由せずにViewを表示する
# redirect_to ...HTTPリクエストをサーバに送信する

#- controllerの処理を実行したい場合、redirect_toにする(インスタンス変数を利用する場合など)


#- :statusオプション ...Turboで意識する
# https://railsguides.jp/layouts_and_rendering.html#status%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3



## content_for ...layout内の名前付きyieldブロックの位置にコンテンツを挿入する
# https://railsguides.jp/layouts_and_rendering.html#content-for%E3%82%92%E4%BD%BF%E3%81%86

## 用途
#- サイドバー,フッターなどの領域に分割し、それぞれに異なるコンテンツを挿入する場合
#- 特定のページでのみJS, CSSファイルを挿入する場合

<html>
  <head>
  <%= yield :head %>
  </head>
  <body>
  <%= yield %>
  </body>
</html>

<% content_for :head do %>
  <title>A simple page</title>
<% end %>

<p>Hello, Rails!</p>




#### rendering

## render "partial_name" ...パーシャルのレンダリング
#- パーシャルのファイル名は(_)アンダースコアから始まるスネークケースが必要
render "header" #=> shared/_header.html.erb


## 用途
# フォームの切り出し
# Turboを実装する上で、パーシャルの切り出し


### オプション

## :layout ...デフォルトのlayoutsディレクトリのレイアウトファイル以外のレイアウトを利用する
render partial: "link_area", layout: "graybar"


## :locals ...パーシャルにローカル変数を渡す
render partial: "form", locals: {zone: @zone}

= form_with model: zone do |form|
  <p>
    <b>Zone name</b><br>
    = form.text_field :name
  </p>
  <p>
    = form.submit
  </p>
end



## :local_assigns ...ローカル変数を特定の条件下でのみ、パーシャルに渡す
# https://railsguides.jp/layouts_and_rendering.html#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E5%A4%89%E6%95%B0%E3%82%92%E6%B8%A1%E3%81%99



## :object ...パーシャルにデフォルトで備わっている、同名のローカル変数にオブジェクトを渡す
render partial: "customer", object: @new_customer

# インスタンスのレンダリングの場合(同上)
render @customer



## :collection ...コレクション(複数インスタンス)のレンダリング

#- 各インスタンスはパーシャルファイル名に対応したローカル変数に格納される。(ex: product)

render partial: "product", collection: @products 

# 省略記法(同上)
render @products

# コレクションが空の場合の代替テキストを設定
render(@products) || "製品はありません。"


# :as ...パーシャル内で独自のローカル変数を利用する場合
render partial: "product", collection: @products, as: :item

# :locals {} ...任意のローカル変数(複数)を渡せる
render partial: "product", collection: @products, as: :item, locals: {title: "Products Page"}


## :spacer_template ...スペーサーテンプレートを指定する

# スペーサーテンプレート ...メインパーシャルのインスタンスと交互にレンダリングする、調節用のセカンドパーシャル

render partial: @products, spacer_template: "product_ruler"
#=> _productパーシャルの間に、_product_rulerパーシャルをレンダリングする


## ネステッドレイアウト

# https://railsguides.jp/layouts_and_rendering.html#%E3%83%8D%E3%82%B9%E3%83%86%E3%83%83%E3%83%89%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E4%BD%BF%E3%81%86

content_for?(:news_content) ? yield(:news_content) : yield

#- 条件演算子を利用した、条件付き部分テンプレートの挿入













