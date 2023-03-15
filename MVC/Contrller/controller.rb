

# # https://nekorails.hatenablog.com/entry/2019/06/13/031003
# #- 猫Rails, ポリモーフィック




# 規約
# • コントローラー名は複数形
# - resourcesなどのrouting generater を利用可

# ActionController::Base


# 4 パラメータ
# 1. クエリ文字列パラメータ ...URLの「?」文字の後に追加
# 2. POSTデータ ...POSTリクエストの一部
# • params ハッシュでパラメータにアクセスする

# 4.1 ハッシュと配列のパラメータ
# • 配列やハッシュを含めることができる
# • パラメータの値は常に文字列になる
# • paramsはキー名にシンボルと文字列を指定可


# 4.5.1 スカラー値を許可する
# •ストロングパラメタにより paramsの不正入力を防ぐ


# 5 セッション
# • コントローラーとビューでのみ利用可
# • ActionDispatch::Session::CookieStore (クライアント)
# • ActionDispatch::Session::CacheStore (Rails)
# • ActionDispatch::Session::ActiveRecordStore (Rails)


# 5.2 Flash
# • リクエスト毎にクリアされる
# - エラーメッセージをview に渡す

# • flashメソッド ...flash[:notice], flash[:alert] .etc...
# • flashオプション ... redirect_to root_path notice “ログアウトしました。”


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <html>
#   <!-- <head/> -->
#   <body>
#     <% flash.each do |name, msg| -%>
#       <%= content_tag :div, msg, class: name %>
#     <% end -%>

#     <!-- more content -->
#   </body>
# </html>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# 5.2.1 flash.now
# • flash.now ...新しいリクエストなしでflashを利用
# - 例) createアクション失敗時のレンダリング


# 9 リクエストフォージェリからの保護
# • XSRF ...目標サイトのデータ追加・変更・削除を行う。
# ☆crerate, update, destroy などの破壊的な操作に対してGET リクエストでアクセスさせないこと
# → RESTful規約に従うことで守られる
# ☆GET以外のリクエストへの対策
# →サーバだけが知る推定不可能なトークンをリクエストに追加すること
# - FormHelper などは自動でトークンを追加してくれる
# - ヘルパーなしでもform_authenticity_token が使える



# 11 HTTP認証
# • 管理者権限を実装する前に考える
# - authenticate メソッド


# 12.2 RESTfulなダウンロード
# • send_dataの代わりにshowアクションの一部としてPDFをダウンロードする機能を実装する


# 14.1 デフォルトの500・404テンプレート











