



# # https://zenn.dev/shita1112/books/cat-hotwire-turbo/viewer/turbo-drive#turbo-drive%E3%81%AE%E5%87%A6%E7%90%86%E3%81%AE%E6%B5%81%E3%82%8C

# 特徴
# • 画面遷移時に<body>だけを置換
# →遷移の高速化

# • GET以外のリンクではdata-turbo-method 属性を指定
# - 内部でform に変換され、formは入れ子にできない。



# できること
# • Turbo の部分的な無効化・有効化
# - data-turbo="false"

# ①(全体は有効)一部を無効化
# ②(全体は有効)一部を無効化し、その中身を有効化
# ③(全体は無効)一部を有効化

# • プログレスバーのスタイル変更
# • アセット更新時の強制リロード
# - data-turbo-track
# • 指定ページの強制リロード
# - <meta name="turbo-visit-control" content="reload">
# • 画面遷移時にHTML を保持 →例) オーディオ再生
# - data-turbo-permanent
# • ブラウザ履歴の操作

# • キャッシュのクリア
# - Turbo.clearCache()
# • 確認ダイアログ (カスタマイズ可)
# - data-turbo-confirm

# • オートスクロール ...次の属性を利用
# - autoscroll: true 
# - data-autoscroll-block ...位置を指定

# • turbo_frame_request?
# - variant を定義→ デバイスでviewを切り替え


# <Turbo のイベント>

# # https://zenn.dev/shita1112/books/cat-hotwire-turbo/viewer/event
# 頻出な物とそのパターンを覚えれば良い。



# <Turbo の注意点>

# • 画面遷移時にDOMContentLoadedが発火しない

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# // 通常
# document.addEventListener("DOMContentLoaded", function() {
#   // ...
# })
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - 代わりにturbo:load を利用する
# →画面遷移の度に発生させる

# •バリデーションエラー 時のrender
# - render :new, status: :unprocessable_entity

# • 確認ダイアログの設定

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%# ボタンの場合 %>
# <%= button_to "削除", cat, method: :delete, class: "btn btn-sm btn-outline-danger", form: { data: { turbo_confirm: "本当に削除しますか？" } } %>
# <%# リンクの場合 %>
# <%= link_to "削除", cat, class: "btn btn-sm btn-outline-danger", data: { turbo_method: :delete, turbo_confirm: "本当に削除しますか？" } %>


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# <JSからの操作>
# • Turbo.session.drive = false ...アプリ全体でTurbo無効化
# • Turbo.visit(パス) ...画面遷移
# • Turbo.clearCache() ...キャッシュのクリア



