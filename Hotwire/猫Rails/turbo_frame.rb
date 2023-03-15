



# # https://zenn.dev/shita1112/books/cat-hotwire-turbo/viewer/tutorial-2


# 文法

# 置換したい箇所をturbo_frame_tag で囲う

# • ページネーション (Turbo Frame)
# - URL が変更されない→advance 属性で解消
# - 検索フォームの入力内容が保存



# ルール

# • turbo frame が適用されたかはURLが変わらないことから判断できる
# •  <turbo-frame>内のリンクからのリクエストはTurbo Frame リクエストになる
# •  <turbo-frame>外のリンクからのリクエストにTurbo Frameを適用させる場合、data-turbo-frame 属性を指定する


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# -   <%= search_form_for @search do |f| %>

# +   <%# data-turbo-frame属性を指定する %>
# +   <%= search_form_for @search, html: { data: { turbo_frame: "cats-list" } } do |f| %>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# • 引数
# →文字列 ...id が固定
# →オブジェクト ...dom_idを利用して自動変換

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%# これらは全て同じ %>
# <%= turbo_frame_tag cat do %>
# <%= turbo_frame_tag dom_id(cat) do %>
# <%= turbo_frame_tag "cat_#{cat.id}" do %>

# <%# ↑の3つはこんなHTMLになる %>
# <turbo-frame id="cat_1">...</turbo-frame>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# 用途
# • ページネーションで必要な要素のみ置換(高速化)
# • 検索時に検索結果となる一覧部分だけを更新したい
# • Flashメッセージ(失敗時)の表示

# 内部構造

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%= turbo_frame_tag "cats-list" do %>
#   <div>置換したい箇所</div>
# <% end %>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <turbo-frame id="cats-list">
#   <div>置換したい箇所</div>
# </turbo-frame>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 1. サーバーによるturbo_frame_tag の解釈
# 2. クライアント(Turbo) による<turbo-frame>の解釈


