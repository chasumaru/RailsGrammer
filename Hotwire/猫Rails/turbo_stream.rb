


# # https://zenn.dev/shita1112/books/cat-hotwire-turbo/viewer/turbo-streams-fetch

# 特徴
# • フォームからGET以外のリクエストが送られた場合のみ使える(create, update, destroy)

# 用途
# • Flashメッセージ(成功時)の表示


# • TurboFrame → TurboStreamにする
# - リダイレクトを削除→テンプレートのレンダリング
# - action名.turbo_stream.erb テンプレートを作成

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%= turbo_stream.replace @cat %>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - ※同じ

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%= turbo_stream.replace @cat do %>
#   <%= render partial: "cats/cat",
#              locals: { cat: @cat } %>
# <% end %>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - locals ...partial に渡すパラメタ

# • メソッド の種類

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # 追加
# - append: targetの末尾に追加
# - prepend: targetの先頭に追加
# - before: targetの前に追加
# - after: targetの後に追加

# # 更新
# - replace: targetを更新（target要素も含めて更新）
# - update: targetを更新（target要素のコンテンツだけ更新）

# # 削除
# - remove: targetを削除
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • _all メソッド 
# - ターゲット指定をID 属性ではなく、CSSクエリセレクタを使う


# • turbo_stream.erb を作らずにコントローラーにインランイン化できる
# - 分かりにくくなるので非推奨

# • layout/application.turbo_stream.erb レイアウトテンプレートにFlashを移す
# ※<turbo-frame>内からのフォーム送信の場合、レイアウトテンプレートが省略？

# • TurboFrame リクエストとTurboStreamリクエストはどちらもtrueの場合が存在
# - html レンダリング→ TurboaFrame
# - turbo_stream レンダリング→TurboStream

# • クライアントでJSが無効の場合にturbo_streamの代わりにhtmlをrender するようフォールバックできる

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   def update
#     if @cat.update(cat_params)
#       respond_to do |format|
#         # JavaScriptが有効の場合はturbo_streamをレンダリングする（turbo_streamが優先される）
#         format.turbo_stream { ... }

#         # JavaScriptが無効の場合はhtmlをレンダリングする
#         format.html { ... }
#       end
#     else
#       render :edit, status: :unprocessable_entity
#     end
#   end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# • Turbo Stream のターゲットは<turbo-frame>以外でも可能




# その他
# # https://zenn.dev/shita1112/books/cat-hotwire-turbo/viewer/turbo-streams-websocket
# - Turbo Stream Broadcast について
