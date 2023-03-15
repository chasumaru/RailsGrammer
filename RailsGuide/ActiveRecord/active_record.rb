



### Assosiation(関連付け)

# 関連付けをModelに宣言する → Modelのクラスメソッドが追加される

# 双方関連付け → モデルの親子関係を意識する



### 関連付けの宣言

## belongs_to ...子モデルで親モデルを定義する
belongs_to :user

#- 子モデルに外部キーが必要
#- user_id のカラム名を持つ場合、自動的に外部キー制約が設定される


## reference ...外部キー制約を自動で設定し、indexも作成する
reference :user


## has_one ...一対一の関連付け
has_one :supplier_account


## has_one :through



## has_many ...子モデルの外部キーに①一意でないindexと、②外部キー制約を設定する
has_many :posts


# throughオプション ...中間テーブル(joinモデル)の設定

has_many :liked_posts, through: :likes


# sourceオプション ... データ参照先のテーブルを指定

#- 関連付け元の名前を自動で推論できない場合
#- 関連付けが重複する場合
# https://qiita.com/yskan/items/2239b538f73428bfb6ce

# 例) 中間テーブル(Likes)を介してPostsテーブルからデータを参照する(重複あり)
has_many :like_posts, through: :likes, source: :post

# 例) 投稿にいいねしたユーザーを取得(重複なし)
has_many :users, through: :likes 


# class_nameオプション ...関連付けるテーブル名を明示的に指定する

#- 外部キー制約を必要に応じて追加する

# 仮にcreate_postsというテーブル名を利用する場合
- has_many :posts
+ has_many :create_posts, class_name: 'Post', foreign_key :user_id




## has_and_belongs_to_many
#- has_many :throughと異なり、中間テーブルが介在しない。
#- joinモデルを別途作成することが必要
#- ※joinモデルでvalidation, callback, 属性の追加などが必要な場合、has_many :through を使う


## ポリモーフィック関連付け
# 1つのモデルが複数のモデルに属性していることを表現する
#- belongs_to でモデル間のインターフェイスとなる属性にpolimorphic: tureを指定




### その他注意事項

# キャッシュ制御
#- 最後に実行したクエリ結果はキャッシュに保持される
#- キャッシュの再読み込み ...reloadメソッド


## 名前衝突の回避
#- attributes, connection 等,ActiveRecord: :Baseのインスタンスで利用されている名前


## スキーマの更新

# 関連付けのスコープ制御
#- 関連付けにより探索されるのは現在のモジュールのスコープ下にあるオブジェクトのみ


# 双方向関連付け
# Active Record
#- :through , foreign_key オプションの双方向関連付けを認識しない
#→ has_many にinverse_of オプションを追加？
# ※現在のrailsではinverse_of を使わずに(DBにアクセスせずに) 関連付けられたインスタンスを参照できる
#- inverse_of オプションが必要なケースは
#→ has_many に条件を指定した場合(明示が必要)

class User < ApplicationRecord has_many :posts,-> () { where(deleted: false) }
end




### 関連付けの詳細

## belongs_to
# 以下のメソッドが追加(belongs_to :user を想定)

user
user=(associate)
build_user(name = {})
create_user(name = {})
create_user!(name = {})
reload_user
user_changed?
user_previously_changed?

#- create! の場合、エラーがraiseされる

# 以下のオプションが追加

:autosave
:class_name
:counter_cache
:dependent
:foreign_key
:primary_key
:inverse_of
:polymorphic
:touch
:validate
:optional

#- autosave ...新規+更新オブジェクトの保存
#- :counter_cache ...検索効率の上昇
#- dependent: destroy ...destroyメソッドの実行
#- dependent: delete ... DBからレコードを削除


# belongs_toのスコープ
#- スコープブロック内で全てのクエリメソッドを利用可
#- inverse_of オプションは不要?

# where
# includes
# readonly
# select

#- where ...条件指定
#- includes ...eager loading
# ex) author > book > chapter で@chapter.book.author のクエリ頻度が高い場合に、author にincludes を設定すると効率的。

#- readonly ...読み取り専用として、関連付けのデータを取り出す
#- select ...SQL のSELECT文を上書き, 取得するカラムを限定
# ※select ではforeign_key オプションの指定が必要


## has_many

# 追加されるメソッド

@user.posts
@user.posts<<(@post1, ...)
@user.posts.delete(@post1, ...)
@user.posts.destroy(@post1, ...)
@user.posts=(@user1.posts)
@user.post_ids
@post_ids=(@user.post_ides)
@user.posts.clear
@user.posts.empty?
@user.posts.size
@user.posts.find(...)
@user.posts.where(...)
@user.posts.exists?(...)
@user.posts.build(attributes = {})
@user.posts.create(attributes = {})
@user.posts.create!(attributes = {})
@user.posts.reload

#- clear ...dependent オプションに従う
#- post_ids ...posts(コレクション)に含まれるオブジェクトのid を返す
#- where ...条件に一致するオブジェクトを取得する
# ※遅延読み込みであるため、呼び出されるときにクエリが実行される


# クエリはまだ発生しない
@available_books = @author.books.where(available: true)

# # ここでクエリが発生する.
@available_book = @available_books.first





### Migration

# create_table
# t.reference :user  ...外部キーとindex を付与





### Validation


## validates_uniqueness_of ...一意制約

#- validates_uniqueness_of :[対象モデルの外部キー], scope: :[参照する外部キー]

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :user_id
end









### 用語

# 主キー ...テーブルのレコードを一意に識別する値

# 外部キー ...参照先テーブルのデータを取得するための値

# 外部キー制約...実際に外部キー参照元(親)のカラムにある値しか外部キーに入れられない制約
#- 子テーブルの外部キーの値が存在する場合、対応する親テーブルのレコードは削除できない 


# 中間テーブルの役割

#- 存在しないレコードの自動削除
#- モデルのクラスメソッドのショートカット

# 例
@document.section.paragraphs #=> @document.paragraphs


# インデックス ...テーブル中の特定のカラムに設定し、検索効率を高める
# 条件)
#- 大量のデータを格納するレコード
#- 格納される値が異なる
#- 検索が良く行われる
# 例) posts/title






### 参考サイト

# https://pikawaka.com/rails/association
#- 関連付け

# https://prograshi.com/framework/rails/references_and_foreign-key/
#- 外部キー制約