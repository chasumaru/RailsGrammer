

### 概要

# URLの認識
#アクションの呼び出し
#Rackアプリケーションの呼び出し

# リソースの定義
# 複数リソースの定義
# 名前空間によるグループ化


# config/routes.rbにルーティングを定義する



#### ルーティングの種類


### リソースルーティング

## idを伴うリソースのルーティング
resources :resource_name
#- idnex
#- new
#- create
#- edit
#- update
#- destroy


## idを伴わない、リソースルーティング
resource :resource_name


## 複数リソースの定義

# ①
resources :photos, :books, :videos

# ②
resources :photos
resources :books
resources :videos



### ネストしたリソース

# https://railsguides.jp/routing.html#%E3%83%8D%E3%82%B9%E3%83%88%E3%81%97%E3%81%9F%E3%83%AA%E3%82%BD%E3%83%BC%E3%82%B9


## リソースの論理的なネスト関係を反映する
#- リソースのネストの階層は一回まで(推奨)

# Modelの例
class Magazine < ApplicationRecord
  has_many :ads
end

class Ad < ApplicationRecord
  belongs_to :magazine
end

# ネストしたルーティング
resources :magazines do
  resources :ads
end


# 生成されるパス
/magazines/:magazine_id/ads/:id #=> showアクション

# 生成される名前付きルート
magazine_ads_path #=> index

# 引数にインスタンスを渡す名前付きルート
magazine_ad_path(@magazine, @ad)



## 浅いネスト

# https://railsguides.jp/routing.html#%E6%B5%85%E3%81%84%E3%83%8D%E3%82%B9%E3%83%88


# ① idを持たないアクションのみネストする例

resources :articles do
  resources :comments, only: [:index, :new, :create]
end

resources :comments, only: [:show, :edit, :update, :destroy]

# shallowオプション(同上)

resources :articles do
  resources :comments, shallow: true
end

# ② shallowオプションのサンプル
resources :articles, shallow: true do
  resources :comments
  resources :quotes
  resources :drafts
end

# ② shallowメソッド(同上)
shallow do
  resources :articles do
    resources :comments
    resources :quotes
    resources :drafts
  end
end



### ヘルパー

## pathヘルパー, urlヘルパー

# pathヘルパーが設定されると、対応するurlヘルパーが設定される

photos_path #=> /photos
new_photo_path #=> /photos/new
edit_photo_path(:id) #=> photos/:id/edit
photo_path(:id) #=> photos/:id

# 引数にインスタンスを渡す名前付きルート①
magazine_ad_path(@magazine, @ad)

# 引数にインスタンスを渡す名前付きルート②
url_for([@magazine, @ad])

# 引数にインスタンスを渡す名前付きルート③
[@magazine, @ad]


# 1冊の雑誌にだけリンクしたい場合
#=> <%= link_to 'Magazine details', @magazine %>

# 配列の最初の要素にアクション名を挿入する記法
#=> <%= link_to 'Edit Ad', [:edit, @magazine, @ad] %>



## asオプション ...任意のルーティングに名前を指定
get 'exit', to: 'sessions#destroy', as: :logout







### グループ化

# https://railsguides.jp/routing.html#%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%A9%E3%81%AE%E5%90%8D%E5%89%8D%E7%A9%BA%E9%96%93%E3%81%A8%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0


## namespace ...特定のディレクトリを指定したURL

#- Admin::ArticlesController
#- app/controllers/admin/articles
#- 名前付きルートはネストを反映
#=> 例) new_admin_article_path

# namespace①

namespace :admin do
  resources :articles
end

# namespace②
resources :articles, path: '/admin/articles'



## scope ...コントローラー名のネストが不要

#- ArticlesController
#- app/controllers/admin/articles
#- 名前付きルートはscopeを使わない場合と同じ
#=> 例) new_article_path

# scope①
scope '/admin' do
  resources :articles
end

# scope②
resources :articles, path: '/admin/articles'



## scope_module ...特定のディレクトリ名を省略したURL

#- Admin::ArticlesController
#- app/controllers/articles
#- 名前付きルートはscopeを使わない場合と同じ
#=> 例) new_article_path

# scope module①
scope module: 'admin' do
  resources :articles
end

# scope module②
resources :articles, module: 'admin'



## scope, shallow_pathオプション ...指定したパラメータをmemberアクションのパスの冒頭に追加

# 特徴
articles/:article_id/comments #=> index
sekret/comments/:id #=> パスのみ変更された(show)
comment_path #=> show

# 例
scope shallow_path: "sekret" do
  resources :articles do
    resources :comments, shallow: true
  end
end



## scope, shallow_prefixオプション ...指定したパラメータをmemberアクションの名前付きルートの冒頭に追加

# 特徴
articles/:article_id/comments #=> index
comments/:id #=> show
sekret_comment_path #=> 名前付きルートのみ変更(show)

# 例
scope shallow_prefix: "sekret" do
  resources :articles do
    resources :comments, shallow: true
  end
end


## member ...resourceにidを伴うパスを追加

#- photos/:id/preview
#- preview_photo_path

# memberブロック
resources :photos do
  member do
    get :preview
  end
end

# onオプション(同上)
resources :photos do
  get 'preview', on: :member
end



## collection ...resourceにidが不要なパスを追加

resources :photos do
  collection do
    get 'search'
  end
end

#onオプション
resources :photos do
  get :search, on: :collection
end



## concern ...他のルーティングで利用できる共通のルーティングを宣言する

concern :commentable do
  resources :comments
end

concern :image_attachable do
  resources :images, only: :index
end

# concernの利用①
resources :messages, concerns: :commentable

# concernの利用②
resources :articles, concerns: [:commentable, :image_attachable]

# concernの利用②と同等
resources :articles do
  resources :comments
  resources :images, only: :index
end




### リソースフルでないルーティング

## 単数形リソース

# 自身のid以外を参照しないページのルーティング

# ①
get 'profile', to: 'users#show'

# ②
get 'profile', action: :show, controller: 'users'


# パラメータを割り当てるルーティング
#- ()丸カッコ ...パラメータの有無が任意
get 'photos(/:id)', to: 'photos#display'




### その他

# DSL ...ドメイン固有言語



### 参考サイト

# https://railsguides.jp/routing.html
# https://qiita.com/senou/items/f1491e53450cb347606b