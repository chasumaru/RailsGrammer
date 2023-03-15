

# LifeCycleCallback
# https://stimulus.hotwired.dev/reference/lifecycle-callbacks
# • コントローラーの接続(→ connect()メソッドの実行) 
# 1. controller が指定されていること
# 2. 要素が存在すること

# • ターゲットの接続
# 1. 指定したtarget の要素が子要素にあること
# 2. 要素のdata-{identifier}-target 属性が存在すること
# - コントローラーの接続前にターゲットが接続される

# • コントローラーの接続解除
# 1. 要素が明示的に削除(remove)された場合
# 2. 親要素がdocumentから削除された場合
# 3. data-controller属性の変更
# 4. Turbo によるページ遷移

# • ターゲットの接続解除
# 1. 略
# 2. 略
# 3. data-{identifier}-target の変更
# 4. 略
