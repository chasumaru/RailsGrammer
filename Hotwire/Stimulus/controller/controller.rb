



# Controller
# Stimulus Reference (hotwired.dev)
# • アクセス
# 1. this.application ...アプリケーション
# 2. this.element ...HTML要素
# 3. this.identifier ...識別子

# • 特徴
# - 命名規則
# ①[identifier]_controller.js ...(_)
# ②複数単語 ...ケバブケース(-) か(_)で命名
# ③コントローラークラス内のメソッド名, プロパティ名...キャメルケースで命名

# コントローラーを2つ設定しても、パラメタが渡されるのは前者のみ


# - コントローラー間は独立している
# - data-controller属性からインスタンスを作る

# スコープ
# - コントローラーは子孫要素にスコープを作る
# • ネストされたコントローラーは排反である

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <ul id="parent" data-controller="list">
#   <li data-list-target="item">One</li>
#   <li data-list-target="item">Two</li>
#   <li>
#     <ul id="child" data-controller="list">
#       <li data-list-target="item">I am</li>
#       <li data-list-target="item">a nested list</li>
#     </ul>
#   </li>
# </ul>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • 要素に複数のコントローラーを指定可能

# • 記法
# - メソッド名, プロパティ名: キャメルケース
# - 複数単語の場合はケバブケース

# • その他
# - importmap, webpack はコントローラーを自動登録
# - コントローラー間の接続も可能
