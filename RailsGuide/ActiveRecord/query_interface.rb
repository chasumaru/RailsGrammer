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


# レコードがない場合 #=> ActiveRecord::RecordNotFound




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


# レコードがない場合 #=> nil




## where ...レコードの取得条件を文字列,配列,ハッシュのいずれかで指定する

##1 条件を文字列で指定する場合
Book.where("title = 'タイトル!'")

# SQLインジェクションの某弱性があるコード(paramsの式展開#{})
Book.where("title LIKE '%#{params[:title]}%'")

# SQLインジェクションを防ぐコード
#- 第一引数の文字列で表された条件で、[?]の位置に続く引数の値が代入される。
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

#※ 取得したオブジェクトに対して関連付けを扱う場合、idメソッド(属性)が必要。idメソッドは下記のエラーを発生しないため注意する。

# 存在しない属性にアクセスしようとした場合
#=> ActiveRecord::MissingAttributeError


## distinct ...特定のカラムで、重複のない一意の値を1レコードだけ取り出す
query = Customer.select(:last_name).distinct

# SQL
SELECT DISTINCT last_name FROM customers

# distinctの解除(重複の有無を問わない)
query.distinct(false)







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





6 LimitとOffset


7 グループ
- @user.post のコレクションを検索し、size メソッドで投稿数を得る

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Order.select("created_at").group("created_at")

@user = User.find_by(id: user_id)?
@post_count = @user.posts.count?size?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




14 関連付けをeager loadingする
N+1クエリ問題

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
books = Book.limit(10)

books.each do |book|
  puts book.author.last_name
end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

• 呼び出すのに1回, 関連付けモデルを得るのに10回

• N+1回避
- include ...欲しい関連付けモデルを最小限のクエリで取得する(eager loading)
- preload ...欲しい関連付けモデルを事前に取得する
- eager_load ...LEFT OUTER JOIN によるeager loading



21 オブジェクトの存在チェック
- exists?() ...一つでも引数の値が存在すればtrue
- any? ...一つでも存在すれば
- 






