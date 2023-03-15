


# Actions
# https://stimulus.hotwired.dev/reference/actions
# • DOM event listener をコントローラー内のメソッドに接続する。

# • 命名規則
# - キャメルケース
# - イベント名との重複を避ける
# - アクションの動作を考慮して命名する

# • 要素のdefault event の場合、イベントを省略可

# | Element | Default Event |
# | a | click |
# | button | click |
# | details | toggle |
# | form | submit |
# | input | input |
# | input type=submit | click |
# | select | change |
# | textarea | input |


# • Global Events ...ドキュメントやウィンドウにGlobal event をlistenできる

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <div data-controller="gallery"
#      data-action="resize@window->gallery#layout">
# </div>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • アクションにlistener オプションを設定可

# • アクションメソッドはイベントリスナーとして機能する。
# - DOMイベントオブジェクトにアクセス
# 1. キーボード入力のキーコードを読み込む
# 2. マウス操作を読み込む
# 3. input イベントからデータを読み込む
# 4. submit 要素からパラメタを読み込む
# 5. ブラウザのデフォルトの挙動を変更

# • イベントプロパティ

# | Event Property | Value |
# | event.type | The name of the event (e.g. "click") |
# | event.target | The target that dispatched the event (i.e. the innermost element that was clicked) |
# | event.currentTarget | The target on which the event listener is installed (either the element with the data-action attribute, or document or window) |
# | event.params | The action params passed by the action submitter element |


# • イベントハンドリング

# | Event Method | Result |
# | event.preventDefault() | Cancels the event’s default behavior (e.g. following a link or submitting a form) |
# | event.stopPropagation() | Stops the event before it bubbles up to other listeners on parent elements |


# • 複数のアクションを定義可能
# - Event#stopImmediatePropagation() により任意の時点でアクションチェーンを停止可

# • アクションパラメタ
# - submit 要素からparamsを受け取れる

