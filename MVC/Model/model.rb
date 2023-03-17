

### CoC


## 命名ルール

# ActiveRecordが適切に処理をするために、必要なルール

# モデルのクラス名 #=> 単数形(キャメルケース)
# DBのテーブル名 #=> 複数形(スネークケース)


## Railsの複数形化メカニズム ...非常に強力な変換

# person <-> people



## Schemaのルール ...カラム名のルール

# 外部キー ...[テーブル名の単数形]_id
#- モデル間の関連付けを作成してくれる

# 主キー ...デフォルト :id

# :crdated_at ...レコード作成に現在の日付時刻を設定する
# :updated_at ...レコード作成,更新時に現在の日付時刻を設定する
# :lock_version ...[Optimistic Locking]を追加
#- https://api.rubyonrails.org/v7.0/classes/ActiveRecord/Locking.html
# :type ...[Single Table Inheritance]利用時に指定
# https://api.rubyonrails.org/v7.0/classes/ActiveRecord/Base.html#class-ActiveRecord::Base-label-Single+table+inheritance
# :関連付け_type ...ポリモーフィック関連付けの設定
# :テーブル名_count ...関連付けで、所属するオブジェクトの数をキャッシュする
#- (例) Articleクラスにcomments_countカラムを設定 → @article.comments.count でキャッシュが利用される



## アクセサメソッド
# https://pikawaka.com/ruby/attr_accessor

# ActiveRecord の継承により、テーブルに定義したカラムには自動的にアクセサメソッドが設定される

#- アクセサメソッドは、テーブルに定義したカラム以外にデータを保持する場合に利用する




### ActiveRecord のモデルを作成

# モデルの作成 = ApplicationRecordクラスのサブクラスを定義すること
class Product < ApplicationRecord
end




### 命名ルールの上書き

# ApplicationRecord < ActiveRecord::Base
#- ActiveRecord::Base ...有用なメソッドが多数定義されている

## ActiveRecord::Base.table_name= ...テーブル名を上書き
class Product < ApplicationRecord
  self.table_name = "my_products"
end

# set_fixture_class ...テーブル名の変更に合わせて、テストのフィクスチャ(my_products.yml)に対応するクラス名を定義する
class ProductTest < ActiveSupport::TestCase
  set_fixture_class my_products: Product
  fixtures :my_products
  # ...
end



## ActiveRecord::Base.primary_key= ...テーブルの主キーのカラム名を上書き
class Product < ApplicationRecord
  self.primary_key = "product_id"
end




### CRUD


## CREATE ...ActiveRecordのオブジェクトを作成し、DBに保存する

# createメソッド
user = User.create(name: "David", occupation: "Code Artist")

# createメソッド(同上)
user = User.create do |u|
  u.name = "David"
  u.occupation = "Code Artist"
end



## READ ...DBのデータを参照する

# https://railsguides.jp/active_record_querying.html



## UPDATE ...取得したActiveRecordオブジェクトの属性を変更し、DBに保存する

# update ...一つのレコードの属性を変更

# update_all ...複数のレコードの属性を一度に変更



## DELETE ...取得したActiveRecordオブジェクトをDBから削除する

# destory ...一つのレコードを削除

# destory_all ...複数のレコードを削除




### Validation

# https://railsguides.jp/active_record_validations.html

# モデルがDBに保存される前に、状態を検証する
#- DBの永続化に重要



### Callback

# https://railsguides.jp/active_record_callbacks.html

# モデルのライフサイクル内で、特定のイベント時に実行される処理を定義する



### Migration

# https://railsguides.jp/active_record_migrations.html

# DBスキーマを管理するためのDSL
#- ActiveRecordと接続されたDBに対して実行される
