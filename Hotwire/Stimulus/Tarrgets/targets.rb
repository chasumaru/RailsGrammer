

# Targets

# • コントローラー内の要素を参照する

# • data-{identifier}-target="ターゲット名" 
# • 
# • コントローラーで static targets 配列によりターゲットを指定すると、プロパティが利用できる

# ☐ this.[name]Target ...単一のターゲット
# ☐ this.[name]Targets ...(scope内の)全てのターゲット
# ☐ this.has[name]Target ...存在のboolean値

# • 要素は複数のターゲットを持つことができ、複数のコントローラーから参照できる

# • ターゲットがあった場合の処理を書ける

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# if (this.hasResultsTarget) {
#   this.resultsTarget.innerHTML = "…"
# }
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# • 接続・切断時のコールバック

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# export default class extends Controller {
#   static targets = [ "item" ]

#   itemTargetConnected(element) {
#     this.sortElements(this.itemTargets)
#   }

#   itemTargetDisconnected(element) {
#     this.sortElements(this.itemTargets)
#   }

#   // Private
#   sortElements(itemTargets) { /* ... */ }
# }
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - それぞれ接続, 切断時に実行される。
# ※注意アリ



