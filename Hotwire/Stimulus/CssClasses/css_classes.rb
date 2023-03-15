

# 無理に使う必要はない


# • クラスのハードコーディング -> データ属性+コントローラープロパティ 
# - 論理名でCSSクラスを参照
# -
# • data-{identifier}-{論理名}-class

# • static classes でCSSクラスを論理名で定義
# → 設定されるプロパティ
# 1. this.[論理名]Class ...単一のクラス
# 2. this.[論理名]Classes ...複数のクラス
# 3. this.has[論理名]Class ...boolean

# 注意
# • class属性をdata-controller 属性と同じ要素に指定する必要

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <form data-controller="search"
#       data-search-loading-class="bg-gray-500 animate-spinner cursor-busy">
#   <input data-action="search#loadResults">
# </form>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# • DOM classList API のadd(), 及びremove() メソッドで要素にCSSを付け外しするのに使う

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# export default class extends Controller {
#   static classes = [ "loading" ]

#   loadResults() {
#     this.element.classList.add(this.loadingClass)

#     fetch(/* … */)
#   }
# }
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - ローディングインジケーターを表示

# • 複数のCSSクラスのプロパティを適用することもできる



