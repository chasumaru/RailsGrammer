# https://railsguides.jp/active_record_querying.html#%E6%9D%A1%E4%BB%B6%E3%81%A7%E3%83%97%E3%83%AC%E3%83%BC%E3%82%B9%E3%83%9B%E3%83%AB%E3%83%80%E3%82%92%E4%BD%BF%E3%81%86


### 概要

# Active Recordは複数のRDBMと互換性がある
#- MySQL, MariaDB, PostgreSQL, SQLite

## 基本的なSQLの仕組み

#1 クエリメソッドをSQLクエリに変換する
#2 SQLクエリの結果をDBから取得する
#3 結果をレコード毎に、Rubyオブジェクトとしてインスタンス化する



### クエリメソッド

#- データベースからオブジェクトを取り出す


### クエリメソッド一覧



## find ...主キー(ID)に対応するオブジェクトを取得

# 単一のオブジェクトを取得
Customer.find(10)

# SQL
SELECT * FROM customers WHERE (customers.id = 10) LIMIT 1


# 複数のオブジェクトを取得(配列を渡す)
Customer.find([1, 10])

# SQL
SELECT * FROM customers WHERE (customers.id IN (1,10))


# レコードがない場合 #=> 
ActiveRecord::RecordNotFound




## take ...ランダム取得

# 単一のオブジェクトを取得
Customer.take

# SQL
SELECT * FROM customers LIMIT 1


# 複数のオブジェクトを取得(個数を指定)
customers = Customer.take(2)


# レコードがない場合 #=> nil




## first ...先頭のレコードを取得

# 単一のオブジェクトを取得
Customer.first

# SQL
SELECT * FROM customers ORDER BY customers.id ASC LIMIT 1


# 複数のオブジェクトを取得(個数を指定)
customers = Customer.first(3)


# 指定カラムのソート結果で実行
Customer.order(:first_name).first

# SQL
SELECT * FROM customers ORDER BY customers.first_name ASC LIMIT 1


# レコードがない場合 #=> nil




## last ...末尾のレコードを取得

# 単一のオブジェクトを取得
Customer.last

# SQL
SELECT * FROM customers ORDER BY customers.id DESC LIMIT 1


# 複数のオブジェクトを取得(個数を指定)
customers = Customer.first(3)


# レコードがない場合 #=> nil




## find_by ...条件にマッチする最初のレコードを取得

#- ソートされない点に注意

Customer.find_by first_name: 'Lifo'

# 同上
Customer.where(first_name: 'Lifo').take

# SQL
SELECT * FROM customers WHERE (customers.first_name = 'Lifo') LIMIT 1


# 複数のオブジェクトを取得(個数を指定)
customers = Customer.first(3)

# Postsコントローラー内で、user_idカラムの値と等しい主キーを持つUserオブジェクトを取得する
@user = User.find_by(id: user_id)


# レコードがない場合 #=> nil



## where ...レコードの取得条件を文字列,配列,ハッシュのいずれかで指定する

##1 条件を文字列で指定する場合
Book.where("title = 'タイトル!'")

# SQLインジェクションの某弱性があるコード(paramsの式展開#{})
Book.where("title LIKE '%#{params[:title]}%'")

# SQLインジェクションを防ぐコード
#- 第一引数に条件を指定する文字列を記述し、第二引数に[?]へ代入する変数を設定する
Book.where("title = ?", params[:title])



##2 条件を配列で指定する場合

# SQLインジェクションを防ぐコード(複数の条件)
Book.where("title = ? AND out_of_print = ?", params[:title], false)

# 条件でプレースホルダを利用する
Book.where("created_at >= :start_date AND created_at <= :end_date",
  { start_date: params[:start_date], end_date: params[:end_date] })

# sanitize_sql_like ...SQLのLIKEワイルドカード(%, _)をエスケープする
#- ワイルドカードはDBに対して、indexの利用不可など意外な結果をもたらす可能性がある
Book.where("title LIKE ?",
  Book.sanitize_sql_like(params[:title]) + "%")



##3 条件をハッシュで指定する場合

#- キーに条件付けするカラムを指定し、値に期待する条件を指定する。


#1 等値条件

Book.where(out_of_print: true)

# SQL
SELECT * FROM books WHERE (books.out_of_print = 1)

# belongs_toリレーションシップで、関連付けキーを利用
#- ポリモーフィック関連付けでも同様
author = Author.first
Book.where(author: author)
Author.joins(:books).where(books: { author: author })


# 複数のwhereメソッドを指定した場合 #=> AND
Book.where(out_of_print: true).where(out_of_print: false)

# SQL
SELECT * FROM books WHERE out_of_print = 1 AND out_of_print = 0



#2 範囲条件

# 前日に作成されたオブジェクトを検索
Book.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)

# SQL (BETWEEN文)
SELECT * FROM books WHERE (books.created_at BETWEEN '2008-12-21 00:00:00' AND '2008-12-22 00:00:00')

# 終端を持たない範囲オブジェクトを指定
Book.where(created_at: (Time.now.midnight - 1.day)..)

# SQL
SELECT * FROM books WHERE books.created_at >= '2008-12-21 00:00:00'



#3 サブセット条件

# 条件ハッシュに配列を渡す
Customer.where(orders_count: [1,3,5])

# SQL(IN式)
SELECT * FROM customers WHERE (customers.orders_count IN (1,3,5))



#4 NOT条件

# SQLのNOTクエリをwhere.notで表す
#- whereに引数を付けずに呼び出し,直後にwhere条件にnotを渡してチェインすることで生成?
Customer.where.not(orders_count: [1,3,5])

# SQL
SELECT * FROM customers WHERE (customers.orders_count NOT IN (1,3,5))


# null許容(nullable)カラムにnil値を持つレコードは、非nil値を指定したハッシュ条件で、レコードが返らない

Customer.create!(nullable_country: nil)
Customer.where.not(nullable_country: "UK")
#=> []

Customer.create!(nullable_country: "UK")
Customer.where.not(nullable_country: nil)
#=> [#<Customer id: 2, nullable_country: "UK">]



#5 OR条件

# ２つのリレーションをまたいでOR条件を使いたい場合
#- orメソッドの引数に2つ目のリレーションを渡す
Customer.where(last_name: 'Smith').or(Customer.where(orders_count: [1,3,5]))

# SQL
SELECT * FROM customers WHERE (customers.last_name = 'Smith' OR customers.orders_count IN (1,3,5))



#6 AND条件

# where条件のチェイン
Customer.where(last_name: 'Smith').where(orders_count: [1,3,5])

# SQL
SELECT * FROM customers WHERE customers.last_name = 'Smith' AND customers.orders_count IN (1,3,5)


# リレーション間の論理的な交差(共通集合)を表すAND条件
Customer.where(id: [1, 2]).and(Customer.where(id: [2, 3]))

# SQL
SELECT * FROM customers WHERE (customers.id IN (1, 2) AND customers.id IN (2, 3))




### ソート

# order ...レコードを特定の順序で並べ替える


## 昇順ソート

# 特定のカラムについて昇順ソート
Book.order(:created_at)
Book.order(created_at: :asc)
Book.order("created_at")
Book.order("created_at ASC")

# 複数カラムについて昇順ソート
Book.order(:title, :created_at)
Book.order("title", "created_at")
Book.order("title ASC, created_at ASC")



## 降順ソート

# 特定のカラムについて、降順ソート
Book.order(created_at: :desc)
Book.order("created_at DESC")

# 複数カラムについて降順ソート
Book.order(title: :desc, created_at: :desc)
Book.order("title DESC", "created_at DESC")



## 混合ソート
Book.order(:title, created_at: :desc)
Book.order(title: :asc, created_at: :desc)




### 特定のカラムを取得

# [Model.find] はSQLの [select * ]に相当する

## select ...特定のカラムのみを結果から取得する
Book.select(:isbn, :out_of_print)
Book.select("isbn, out_of_print")

# SQL
SELECT isbn, out_of_print FROM books


# 複数のselectメソッドを指定した場合 #=> OR
Book.select(:title, :isbn).select(:created_at)

# SQL
SELECT books.title, books.isbn, books.created_at FROM books


#※ 取得したオブジェクトに対して関連付けを扱う場合、idメソッド(属性)が必要。idメソッドは下記のエラーを発生しないため注意する。

# 存在しない属性にアクセスしようとした場合 #=>
ActiveRecord::MissingAttributeError



## distinct ...特定のカラムで、重複のない一意の値を1レコードだけ取り出す
query = Customer.select(:last_name).distinct

# SQL
SELECT DISTINCT last_name FROM customers

# distinctの解除(重複の有無を問わない)
query.distinct(false)




### 取得するレコード数の調節


## limit ...取得するレコード数の上限を指定する
Customer.limit(5)

# SQL
SELECT * FROM customers LIMIT 5


## offset ...レコードの先頭からスキップするレコード数を指定

# 最初の30人をスキップして、31人目から最大5人の顧客を返す場合
Customer.limit(5).offset(30)

# SQL
SELECT * FROM customers LIMIT 5 OFFSET 30




### グループ

# https://qiita.com/niwasawa/items/81408ca8b4facf13a81e

## group ...検索メソッドで実行されるSQLに, GROUP BY句 を追加したい場合

# 注文（order）作成日のコレクションを検索したい場合
Order.select("created_at").group("created_at")

# SQL
SELECT created_at
FROM orders
GROUP BY created_at

#- GROUP BY句 で指定したカラムは「集約キー」, 「グループ化列」と呼ぶ


# グループ化した項目の合計を取得
Order.group(:status).count

# SQL
SELECT COUNT (*) AS count_all, status AS status
FROM orders
GROUP BY status


# having ...groupメソッドで条件を指定する

#- SQLのGROUPBY句 におけるHAVING句 に相当

# priceが$200を超えている注文が、created_atごとにグループ化され、それぞれの合計金額を返す
big_orders = Order.select("created_at, sum(total) as total_price")
                  .group("created_at")
                  .having("sum(total) > ?", 200)

# 最初のOrderオブジェクトの合計金額を出力
big_orders[0].total_price

# SQL
SELECT created_at as ordered_date, sum(total) as total_price
FROM orders
GROUP BY created_at
HAVING sum(total) > 200




### 条件の上書き

## unscope ...特定の条件を除去する

Book.where('id > 100').limit(20).order('id desc').unscope(:order)

# SQL
SELECT * FROM books WHERE id > 100 LIMIT 20

# SQL(unscopeなしの場合)
SELECT * FROM books WHERE id > 100 ORDER BY id desc LIMIT 20


# 特定のwhere句でunscopeを指定する場合
Book.where(id: 10, out_of_print: false).unscope(where: :id)


# unscopeをリレーションに適用すると、それにマージされるすべてのリレーションにも影響する
Book.order('id desc').merge(Book.unscope(:order))

# SQL
SELECT books.* FROM books



## only ...適用する条件を限定する

Book.where('id > 10').limit(20).order('id desc').only(:order, :where)

# SQL
SELECT * FROM books WHERE id > 10 ORDER BY id DESC

# SQL(onlyなしの場合)
SELECT * FROM books WHERE id > 10 ORDER BY id DESC LIMIT 20



## reselect ...既存のselectメソッドを上書きする

Book.select(:title, :isbn).reselect(:created_at)

# SQL
SELECT books.created_at FROM books



## reorder ...デフォルトのスコープの並び順を上書きする
# クラス内の関連付けで定義する -> {order}
class Author < ApplicationRecord
  has_many :books, -> { order(year_published: :desc) }
end

Author.find(10).books

# SQL
SELECT * FROM authors WHERE id = 10 LIMIT 1
SELECT * FROM books WHERE author_id = 10 ORDER BY year_published DESC


# reoderでデフォルトのスコープの並び順に対して、別の並び順を指定
Author.find(10).books.reorder('year_published ASC')



## reverse_order ...デフォルトのスコープの並び順を逆にする

Book.where("author_id > 10").order(:year_published).reverse_order

# SQL
SELECT * FROM books WHERE author_id > 10 ORDER BY year_published DESC



## rewhere ...既存のwhereメソッドを上書きする

Book.where(out_of_print: true).rewhere(out_of_print: false)

# SQL
SELECT * FROM books WHERE out_of_print = 0




### Nullリレーション

# none ...チェイン(chain)可能な空のリレーションを返す
Book.none

#- メソッドまたはスコープへのチェイン可能な応答が必要で、しかも結果を一切返したくない場合に便利

# 例) リレーションを返すメソッドの定義

Book.first.highlighted_reviews.average(:rating)
# => 本1冊あたりの平均レーティングを返す

class Book
  # レビューが5件以上の場合にレビューを返す
  # それ以外の本はレビューなしとみなす
  def highlighted_reviews
    if reviews.count > 5
      reviews
    else
      Review.none # レビュー5件未満の場合
    end
  end
end




### 読み取り専用オブジェクト

## readonly ...DBから取得したオブジェクトに対して、変更を明示的に禁止する

# 例外が発生するコード
customer = Customer.readonly.first
customer.visits += 1
customer.save #=> ERROR

# 変更の試みをした場合の返り値
ActiveRecord::ReadOnlyRecord




### レコードの更新をロックする

## 楽観的ロック(optimistic)

# 前提条件
#1 複数のuserが同じレコードを同時編集できる
#2 データの衝突が最小限

# レコードがオープンされてから変更があった場合のエラー #=>
ActiveRecord::StaleObjectError



# 楽観的ロックカラム ...テーブルにlock_versionという名前のinteger型のカラムを用意し、ActiveRecordがレコードの更新を検知し、lock_versionカラムの値を1ずつ増やす。これにより、更新リクエストを失敗させる。

# https://railsguides.jp/active_record_querying.html#%E6%A5%BD%E8%A6%B3%E7%9A%84%E3%83%AD%E3%83%83%E3%82%AF%EF%BC%88optimistic%EF%BC%89




## 悲観的ロック(optimistic)

# https://railsguides.jp/active_record_querying.html#%E6%82%B2%E8%A6%B3%E7%9A%84%E3%83%AD%E3%83%83%E3%82%AF%EF%BC%88pessimistic%EF%BC%89

Book.transaction do
  book = Book.lock.first
  book.title = 'Algorithms, second edition'
  book.save!
end

# SQL (MySQL)
SQL (0.2ms)   BEGIN
Book Load (0.3ms)   SELECT * FROM books LIMIT 1 FOR UPDATE
Book Update (0.4ms)   UPDATE books SET updated_at = '2009-02-07 18:05:56', title = 'Algorithms, second edition' WHERE id = 1
SQL (0.8ms)   COMMIT


# MySQL特有の[LOCK IN SHARE]式を設定する場合
Book.transaction do
  book = Book.lock("LOCK IN SHARE MODE").find(1)
  book.increment!(:views)
end




### テーブルの結合

# joins ...INNER JOIN, カスタムクエリに利用
# left_outer_joins ...LEFT OUTER JOINクエリの生成に利用


## join ...以下の利用方法がある

##1 SQLフラグメント(生のSQL)を引数に利用し、JOIN句を指定
Author.joins("INNER JOIN books ON books.author_id = authors.id AND books.out_of_print = FALSE")

# SQL
SELECT authors.* FROM authors INNER JOIN books ON books.author_id = authors.id AND books.out_of_print = FALSE



##2 単一関連付けを結合する

# joinsメソッドを利用して、関連付けでJOIN句を指定
#- モデルで定義されている関連付け名のショートカットを利用


# レビュー付きのすべての本で、Bookオブジェクトを1つ返す
Book.joins(:reviews)

# SQL
SELECT books.* FROM books
  INNER JOIN reviews ON reviews.book_id = books.id

# 重複のない一意の本を表示する場合
Book.joins(:reviews).distinct



##3 複数の関連付けをする場合

Book.joins(:author, :reviews)

# SQL ...著者があり、レビューが1件以上ついている本をすべて表示する
SELECT books.* FROM books
  INNER JOIN authors ON authors.id = books.author_id
  INNER JOIN reviews ON reviews.book_id = books.id



##4 ネストした関連付けを結合する場合


# 単一レベル
Book.joins(reviews: :customer)

# SQL ...顧客のレビューが付いている本をすべて返す
SELECT books.* FROM books
  INNER JOIN reviews ON reviews.book_id = books.id
  INNER JOIN customers ON customers.id = reviews.customer_id


# 複数レベル
Author.joins(books: [{ reviews: { customer: :orders } }, :supplier] )

# SQL ...顧客のレビューが付いていて、かつ、注文した本のすべての著者と、それらの本の仕入先（suppliers）を返す
SELECT * FROM authors
  INNER JOIN books ON books.author_id = authors.id
  INNER JOIN reviews ON reviews.book_id = books.id
  INNER JOIN customers ON customers.id = reviews.customer_id
  INNER JOIN orders ON orders.customer_id = customers.id
INNER JOIN suppliers ON suppliers.id = books.supplier_id



##5 結合テーブルで条件を指定する

# 配列,および文字列条件を利用し、結合テーブルに条件を指定する。
#※ ハッシュ条件の場合、特殊な構文を利用する

time_range = (Time.now.midnight - 1.day)..Time.now.midnight
Customer.joins(:orders).where('orders.created_at' => time_range).distinct

# ハッシュ条件をネストした記法(同上)
time_range = (Time.now.midnight - 1.day)..Time.now.midnight
Customer.joins(:orders).where(orders: { created_at: time_range }).distinct


#※ 高度な条件指定や、既存の名前付きスコープを再利用する場合 #=> merge

# 名前付きスコープを追加
class Order < ApplicationRecord
  belongs_to :customer

  scope :created_in_time_range, ->(time_range) {
    where(created_at: time_range)
  }
end

# created_in_time_rangeスコープ内でmerge
time_range = (Time.now.midnight - 1.day)..Time.now.midnight
Customer.joins(:orders).merge(Order.created_in_time_range(time_range)).distinct



## left_outer_joins

# 関連レコードの有無に関わらず、レコードのセットを取得する場合

Customer.left_outer_joins(:reviews).distinct.select('customers.*, COUNT(reviews.*) AS reviews_count').group('customers.id')

# SQL ...すべての顧客を返し、さらに顧客がレビューを付けていればレビュー数を返す。レビューを付けていない場合はレビュー数を返さない
SELECT DISTINCT customers.*, COUNT(reviews.*) AS reviews_count FROM customers
LEFT OUTER JOIN reviews ON reviews.customer_id = customers.id GROUP BY customers.id




### 関連付けのeager loading

# eager loading ...Model.findによって返されるオブジェクトに関連付けられたレコードに対し、最小限のクエリ件数で取得すること

## N + 1 問題

# 10冊の本を取得するクエリ(1件)
books = Book.limit(10)
# last_nameを取得するためのクエリ(10件)
books.each do |book|
  puts book.author.last_name
end
#=> 計11件のクエリ



## N + 1問題の解消メソッド


##1 includes

# ActiveRecordが指定された全ての関連付けを、最小限のクエリ件数で取得してくれる

books = Book.includes(:author).limit(10)

books.each do |book|
  puts book.author.last_name
end
#=> 計2件のクエリ

# SQL
SELECT books.* FROM books LIMIT 10
SELECT authors.* FROM authors
  WHERE authors.book_id IN (1,2,3,4,5,6,7,8,9,10)


# 複数の関連付けをeager loading
Customer.includes(:orders, :reviews)


# ネストした関連付けハッシュ
Customer.includes(orders: {books: [:supplier, :author]}).find(1)
#=> id=1の顧客を検索し、関連付けられたすべての注文、それぞれの本の仕入先と著者を読み込みます


# eager loading された関連付けに対して条件を指定する場合
Author.includes(:books).where(books: { out_of_print: true })

# SQL
SELECT authors.id AS t0_r0, ... books.updated_at AS t1_r5 FROM authors LEFT OUTER JOIN books ON books.author_id = authors.id WHERE (books.out_of_print = 1)

#- whereメソッドでは[LEFT OUTER JOIN]が、joinsメソッドでは[INNER JOIN]がクエリに利用される。joinsメソッドの場合、結合条件のマッチが必要



##2 preload

# ActiveRecordは指定した関連付けを、1つの関連付けあたり1件のクエリを実行する

books = Book.preload(:author).limit(10)

books.each do |book|
  puts book.author.last_name
end
#=> 計2件のクエリ



##3 eager_load

# ActiveRecordが指定された全ての関連付けを[LEFT OUTER JOIN]で読み込む

books = Book.eager_load(:author).limit(10)

books.each do |book|
  puts book.author.last_name
end
#=> 計2件のクエリ




### 複数オブジェクトの処理

#- 多数のレコードに対する反復処理


# メモリ節約のアンチパターン
Customer.all.each do |customer|
  NewsMailer.weekly(customer).deliver_now
end

#- allメソッドでテーブル全体を一度に取り出している。また、eachメソッドで一行ごとに、オブジェクトを生成している。

#=> 巨大なモデルオブジェクトの配列がメモリを圧迫する
#=> バッチ処理が推奨




### バッチ処理

# 数千件以上のレコードに対する繰り返し処理で有効


## バッチ分割①

# https://railsguides.jp/active_record_querying.html#find-each

# find_eachメソッド ...レコードのバッチを1つ取り出す→各レコードを1つのモデルとして個別にブロックにyieldする。(バッチから1000件のレコードを取得)

Customer.find_each do |customer|
  NewsMailer.weekly(customer).deliver_now
end

#- 順序指定は設定が複雑



## find_eachのオプション

# :batch_size ...一度のバッチで取得するレコード数を指定
Customer.find_each(batch_size: 5000) do |customer|
  NewsMailer.weekly(customer).deliver_now
end


# :start ...レコードの取得開始IDを指定する
#- 中断したバッチ処理の再開する場合に有用(最後に実行された処理のIDがチェックポイントとして保存済みであることが必要)

Customer.find_each(start: 2000) do |customer|
  NewsMailer.weekly(customer).deliver_now
end


# :finish ...レコードの取得終了IDを指定する
Customer.find_each(start: 2000, finish: 10000) do |customer|
  NewsMailer.weekly(customer).deliver_now
end


# :error_on_ignore ...リレーション内に特定の順序がある場合に例外を発生させる?



## バッチ分割②

# find_in_batchesメソッド ...レコードのバッチを1つ取り出す→バッチ全体をモデルの配列としてブロックにyield

# 1回あたり1000人の顧客の配列をadd_customersに渡す
Customer.find_in_batches do |customers|
  export.add_customers(customers)
end


## find_each_batchesのオプション

# :batch_size
# :start
# :finish
# :error_on_ignore

Customer.find_in_batches(batch_size: 2500, start: 5000) do |customers|
  export.add_customers(customers)
end




### スコープ

# 利用頻度の高いクエリをscopeに設定する
# scopeはクラス定義内で定義する
# scopeメソッドはActiveRecord::Relationオブジェクトを返す。

# シンプルなscope
class Book < ApplicationRecord
  scope :out_of_print, -> { where(out_of_print: true) }
end



## スコープ呼び出し

#1 クラスから呼び出す
Book.out_of_print
#=> #<ActiveRecord::Relation> # all out of print books

#2 Bookオブジェクトを利用する関連付けで呼び出す
author = Author.first
author.books.out_of_print
#=> #<ActiveRecord::Relation> # all out of print books by `author`

#3 別のscope内でチェイン
class Book < ApplicationRecord
  scope :out_of_print, -> { where(out_of_print: true) }
  scope :out_of_print_and_expensive, -> { out_of_print.where("price > 500") }
end



## スコープに引数を渡す

class Book < ApplicationRecord
  scope :costs_more_than, ->(amount) { where("price > ?", amount) }
end

# 例)関連付けオブジェクトからの呼び出し
author.books.costs_more_than(100.10)



## 条件文を伴うスコープ

#- 条件文の評価がfalseになった場合でも、ActiveRecord::Relationが返る点に注意。(クラスメソッドの場合はnilが返る)
class Order < ApplicationRecord
  scope :created_before, ->(time) { where("created_at < ?", time) if time.present? }
end



### デフォルトスコープ

# 指定したscopeをモデルのすべてのクエリに適用する
class Book < ApplicationRecord
  default_scope { where(out_of_print: false) }
end

irb> Book.new
=> #<Book id: nil, out_of_print: false>
irb> Book.unscoped.new
=> #<Book id: nil, out_of_print: nil>


# 条件が複雑な場合は、クラスメソッドが推奨?(返り値は意識)
class Book < ApplicationRecord
  def self.default_scope
    # ActiveRecord::Relationを返すべき
  end
end


# 引数にArrayを設定する場合は注意
#- default_scopeの引数はHashのデフォルト値に変換されない
class Book < ApplicationRecord
  default_scope { where("out_of_print = ?", false) }
end

irb> Book.new
=> #<Book id: nil, out_of_print: nil>



##スコープのマージ

class Book < ApplicationRecord
  scope :in_print, -> { where(out_of_print: false) }
  scope :out_of_print, -> { where(out_of_print: true) }

  scope :recent, -> { where('year_published >= ?', Date.current.year - 50 )}
  scope :old, -> { where('year_published < ?', Date.current.year - 50 )}
end


# scopeのAND条件(マージ: クラスメソッドと同様)
Book.out_of_print.old

# SQL
SELECT books.* FROM books WHERE books.out_of_print = 'true' AND books.year_published < 1969


# scopeメソッドとwhereメソッドの混用
Book.in_print.where('price < 100')

# SQL
SELECT books.* FROM books WHERE books.out_of_print = 'false' AND books.price < 100


# 末尾のwhere句をスコープよりも優先したい場合 #=> merge
Book.in_print.merge(Book.out_of_print)


# 優先順位) merge > default_scope > scope, where



## 全てのスコープの削除

# unscoped ...デフォルトスコープも適用されない


# 例①
Book.unscoped.all

# SQL
SELECT books.* FROM books


# 例②
Book.where(out_of_print: true).unscoped.all

# SQL
SELECT books.* FROM books


# ブロックを指定する場合
Book.unscoped { Book.out_of_print }

# SQL
SELECT books.* FROM books WHERE books.out_of_print



## スコープとクラスメソッドの違い

# https://techtechmedia.com/difference-between-scope-and-class-method-rails/

# スコープの方が再利用性が高い。
#- スコープのチェイン
#- 可読性

#※ クラスメソッドでは、チェインの際にErrorが発生する可能性がある。
#- クラスメソッドは条件に合うオブジェクトが無い場合、nilが格納されるため。

# スコープに引数が渡される場合、クラスメソッドで定義することが推奨されている。




### 動的検索

# カラムが存在すると、ActiveRecordによって自動的に追加されるメソッド

# Customerモデルに :first_nameカラムが存在する場合
Customer.find_by_first_name("Chasu")

# :last_nameカラムとのAND検索
Customer.find_by_first_name_and_last_name("Chasu", "maru")




### メソッドチェイン

# 複数のテーブルからデータをフィルタして取得
Customer
  .select('customers.id, customers.last_name, reviews.body')
  .joins(:reviews)
  .where('reviews.created_at > ?', 1.week.ago)

# SQL
SELECT customers.id, customers.last_name, reviews.body
FROM customers
INNER JOIN reviews
  ON reviews.customer_id = customers.id
WHERE (reviews.created_at > '2019-01-08')


# 複数のテーブルから特定のデータを取得
Book
  .select('books.id, books.title, authors.first_name')
  .joins(:author)
  .find_by(title: 'Abstraction and Specification in Program Development')

# SQL ...find_byは最初のマッチ結果のみを返す
SELECT books.id, books.title, authors.first_name
FROM books
INNER JOIN authors
  ON authors.id = books.author_id
WHERE books.title = $1 [["title", "Abstraction and Specification in Program Development"]]
LIMIT 1




### レコードの検索結果に応じた連続処理


# find_or_create_by ...指定した属性を持つレコードが存在すれば取得し、存在しなければレコードを作成する

Customer.find_or_create_by(first_name: 'Andy')
#=> #<Customer id: 5, first_name: "Andy", last_name: nil, title: nil, visits: 0, orders_count: nil, lock_version: 0, created_at: "2019-01-17 07:06:45", updated_at: "2019-01-17 07:06:45">

# SQL
SELECT * FROM customers WHERE (customers.first_name = 'Andy') LIMIT 1
BEGIN
INSERT INTO customers (created_at, first_name, locked, orders_count, updated_at) VALUES ('2011-08-30 05:22:57', 'Andy', 1, NULL, '2011-08-30 05:22:57')
COMMIT


# find_or_create_by! ...作成されるオブジェクトにValidationが適用される

# Validation
validates :orders_count, presence: true

Customer.find_or_create_by!(first_name: 'Andy')
# Error
ActiveRecord::RecordInvalid: Validation failed: "Orders count can't be blank"



## レコードが存在しない場合、特定のプロパティの値を設定してからレコードを作成する


# locked属性をfalseに設定する①

Customer.create_with(locked: false).find_or_create_by(first_name: 'Andy')


# locked属性をfalseに設定する②
#- このクエリを再度実行すると、ブロックは実行されない

Customer.find_or_create_by(first_name: 'Andy') do |c|
  c.locked = false
end



# find_or_initialize_by ...find_or_create_byがcreateメソッドを内部で実行するのに対して、newを内部で実行する

#- メソッド実行時点では、DBに保存されていない

nina = Customer.find_or_initialize_by(first_name: 'Nina')
#=> #<Customer id: nil, first_name: "Nina", orders_count: 0, locked: true, created_at: "2011-08-30 06:09:27", updated_at: "2011-08-30 06:09:27">

# SQL
SELECT * FROM customers WHERE (customers.first_name = 'Nina') LIMIT 1

nina.persisted?
=> false

nina.new_record?
=> true

# オブジェクトをDBに保存する場合
nina.save




### SQLでの検索


## find_by_sql ...独自のSQLでレコードを検索し、インスタンスの配列を返す

Customer.find_by_sql("SELECT * FROM customers INNER JOIN orders ON customers.id = orders.customer_id ORDER BY customers.created_at desc")
#=> [#<Customer id: 1, first_name: "Lucas" ...>, #<Customer id: 2, first_name: "Jan" ...>, ...]



## select_all ...find_by_sqlメソッドと異なり、ActiveRecord::Resultクラスのインスタンスを返す

#- to_a ...各レコードに対応するハッシュマップを返す

Customer.connection.select_all("SELECT first_name, created_at FROM customers WHERE id = '1'").to_a
#=> [{"first_name"=>"Rafael", "created_at"=>"2012-11-10 23:23:45.281189"}, {"first_name"=>"Eileen", "created_at"=>"2013-12-09 11:22:35.221282"}]




### pluck ...一つ以上のカラムを取得するクエリで利用し、指定したカラムの値の配列を対応するデータ型で返す

# 例①: 条件を指定
Book.where(out_of_print: true).pluck(:id)
#=> [1, 2, 3]

# SQL
SELECT id FROM books WHERE out_of_print = true


# 例②: 一意の値のみを取得
Order.distinct.pluck(:status)
#=> ["shipped", "being_packed", "cancelled"]

# SQL
SELECT DISTINCT status FROM orders


# 例③: 複数のカラムのネスト配列を取得
Customer.pluck(:id, :first_name)
#=> [[1, "David"], [2, "Fran"], [3, "Jose"]]

# SQL
SELECT customers.id, customers.first_name FROM customers



## pluckの活用事例

# 置き換え①
Customer.select(:id).map { |c| c.id }
Customer.select(:id).map(&:id)
↓
Customer.pluck(:id)


# 置き換え②
Customer.select(:id, :first_name).map { |c| [c.id, c.first_name] }
↓
Customer.pluck(:id, :first_name)



## 大規模, 利用頻度の高いクエリでのパフォーマンス改善

#- pluckメソッドは配列を返すので、オーバーライドを行うモデルメソッドは使えない

class Customer < ApplicationRecord
  def name
    "私は#{first_name}"
  end
end

# モデルメソッド(name)を使う場合
Customer.select(:first_name).map &:name
=> ["私はDavid", "私はJeremy", "私はJose"]

Customer.pluck(:first_name)
=> ["David", "Jeremy", "Jose"]


## pluckの後ろにはスコープをチェイン出来ない

# pluckメソッドはクエリを直接トリガするため
#- selectなどのRelationスコープはチェイン可能

Customer.pluck(:first_name).limit(1)
#=> NoMethodError: undefined method `limit' for #<Array:0x007ff34d3ad6d8>

Customer.limit(1).pluck(:first_name)
#=> ["David"]



## pluckマメ知識

# リレーションオブジェクトにincludesがある場合、eager loadingが不必要なクエリでも、pluckが勝手にeager loadingを引き起こす

assoc = Customer.includes(:reviews)
assoc.pluck(:id)
SELECT "customers"."id" FROM "customers" LEFT OUTER JOIN "reviews" ON "reviews"."id" = "customers"."review_id"

# 回避策(unscope)
assoc.unscope(:includes).pluck(:id)




## ids ...テーブルの主キーを使っているリレーションのIDをすべて取得

# 例①
Customer.ids

# SQL
SELECT id FROM customers


# 例②
class Customer < ApplicationRecord
  self.primary_key = "customer_id"
end

Customer.ids

# SQL
SELECT customer_id FROM customers




### オブジェクトの存在を判定


## exists?() ...findと同様のクエリで、真偽値を返す

# 基本
Customer.exists?(1) 


# 引数に渡した複数の値の内、一つでも一致すればtrue
Customer.exists?(id: [1,2,3])
Customer.exists?(first_name: ['Jane', 'Sergei'])


# 引数なしで利用する場合 #=> モデルやリレーション
Customer.where(first_name: 'Ryan').exists?

#- 引数なしのexists?メソッドは、any?, many? とほぼ同じ

Order.any?
# => SELECT 1 FROM orders LIMIT 1
Order.many?
# => SELECT COUNT(*) FROM (SELECT 1 FROM orders LIMIT 2)




### 計算

# 計算メソッドはモデル、リレーションに対して(チェインを含めて)実行できる

# モデルに直接実行
Customer.count
SELECT COUNT(*) FROM customers

# リレーションに直接実行
Customer.where(first_name: 'Ryan').count
SELECT COUNT(*) FROM customers WHERE (first_name = 'Ryan')


# 複雑
Customer.includes("orders").where(first_name: 'Ryan', orders: { status: 'shipped' }).count

# SQL
SELECT COUNT(DISTINCT customers.id) FROM customers
  LEFT OUTER JOIN orders ON orders.customer_id = customers.id
  WHERE (customers.first_name = 'Ryan' AND orders.status = 0)




### Enum

# https://railsguides.jp/active_record_querying.html#enum
# https://api.rubyonrails.org/v7.0/classes/ActiveRecord/Enum.html



### Explain




### SQLの基礎


## 内部結合と外部結合

# https://www.sejuku.net/blog/82169

# 内部結合 ...結合するテーブルの両方に、結合に利用したカラムの値が存在するレコードが残る。

# 外部結合 ...結合するテーブルの内、片方のテーブルのデータは全て残り、かつ結合に利用したカラムの値が存在しない場合はNULLを格納する

# 左外部結合 ...FROMで指定したテーブルのレコードが必ず残る外部結合。
SELECT 必要なカラム
FROM テーブル1(左側)
LEFT JOIN テーブル2(右側)
USING(結合に使うカラム名);

# 右外部結合 ...RIGHT JOINで指定したテーブルのレコードが必ず残る外部結合
SELECT 必要なカラム
FROM テーブル1(左側)
RIGHT JOIN テーブル2(右側)
USING(結合に使うカラム名);
