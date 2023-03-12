

### 概要

# URLの認識
#アクションの呼び出し
#Rackアプリケーションの呼び出し

# リソースの定義
# 複数リソースの定義
# 名前空間によるグループ化



### ルーティングの種類

## namespace ...controllerの名前空間によるグループ化
#- 特定のディレクトリを指定したURL


# namespace①
scope '/admin' do
  resources :tweets
end

# namespace②
resources :tweets, path: '/admin/tweets'



## scope 
#- 特定のディレクトリ名を省略したURL

# scope①
scope module: 'admin' do
  resources :tweets
end

# scope②
resources :posts, module: 'admin'



## member ...resourceにidを伴うパスを追加

resources :photos do
  member do
    get :preview
  end
end



## collection ...resourceにidが不要なパスを追加

resources :photos do
  collection do
    get :search
  end
end

#onオプション
resources :photos do
  get :search, on: :collection
end








### 参考サイト

# https://railsguides.jp/routing.html
# https://qiita.com/senou/items/f1491e53450cb347606b