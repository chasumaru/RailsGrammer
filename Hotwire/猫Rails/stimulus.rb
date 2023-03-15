


# 利用手順

# • rails g stimulus コントローラー名
# - jsbundling-rails の場合はindex.js にcontrollerが登録される
# • 特定のcontroller.js に処理を記述

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# import {Controller} from "@hotwired/stimulus"

# #コントローラークラスの定義
# export default class extends Controller {
#   アクション名() {
#   }
# }
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • HTML要素に対してdata-turbo_frame 属性の他にdata-controller属性, data-action属性を追加

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <div data-controller="JSコントローラー名">
#  <input data-コントローラー名-target="ターゲット名" type="text">
#  button data-action="click->コントローラー名#アクション名"ボタン</button>
# </div>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





# メモ

# • インスタントサーチにはDebounceを利用

# 用途
# • インスタントサーチ
# • モーダル
# • ページネーション・ソート・検索時のURLを更新
# • 無限スクロール
# • FlashのToast化



# • フォームではSubmit() の代わりにrequestSubmit() を使う
# - Turboによるインターセプトが必要



# Sidebar or Navigation Bar with Hotwire Turbo - General - Hotwire Discussion
# サイドバー(navバー)
# • Point
# - URL が変更される
# - 遅延ロードをバーに組み込むと、バーが点滅する
# - 遅延ロードの利点：キャッシュの改善→複雑なメニューでのメリットが大きい

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# document.getElementById("navigation").src = "/nav";
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - turbo_frameにURLを指定?遅延ロードに関係?





