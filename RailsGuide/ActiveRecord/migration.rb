

### 概要

# https://railsguides.jp/active_record_migrations.html

# DBスキーマを管理するためのDSLであり、生のSQLが不要

# migrationを変更することで、テーブル、カラム、エントリの追加・削除を行う。


# migrationを元に、db/schema.rbファイルを更新する



### migrationの基礎

# サンプル) Productsテーブルの作成
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      #- nameカラム, データ型はstring
      t.string :name
      t.text :description
      #- timestampsマクロ → created_at, updated_atカラムを追加する
      t.timestamps
    end
  end
end



## reversible ...migrationの取り消し

class ChangeProductsPrice < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :price, :string }
        dir.down { t.change :price, :integer }
      end
    end
  end
end

# changeメソッドをup, downメソッドで書き換えた場合
class ChangeProductsPrice < ActiveRecord::Migration[7.0]
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end




### migrationの作成

# db/migrate ...migrationファイルの保存場所

#- migrationファイル名(スネークケース)がmigrationクラス名(キャメルケース)に対応する

# ex)
# ファイル名: 20080906120000_create_products.rb
# クラス名: CreateProducts




### rails generationコマンド

# rails g migration クラス名


## 基本形


##1 add_column文 ...テーブルにカラムを追加する

# コマンド
bin/rails generate migration AddDetailsToProducts part_number:string price:decimal

# 作成されたmigrationファイル
class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
  end
end



##2 remove_column文 ...テーブルからカラムを削除する

# コマンド
bin/rails generate migration RemovePartNumberFromProducts part_number:string

# 作成されたmigrationファイル
class RemovePartNumberFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :part_number, :string
  end
end



##3 create_table文 ...テーブルとカラムを作成する

#- Create〇〇 #=> テーブル名(キャメルケース)

# コマンド
bin/rails generate migration CreateProducts name:string part_number:string

# 作成されたmigrationファイル
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :part_number

      t.timestamps
    end
  end
end



## データ型にリファレンス型を指定した場合

# コマンド
bin/rails generate migration AddUserRefToProducts user:references

# 作成されたmigrationファイル
class AddUserRefToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :user, foreign_key: true
  end
end

#1 user_idカラムを追加
#2 user_idカラムに外部キー制約を設定
#3 user_idカラムにindexを設定
#4 ポリモーフィック関連付けのカラムを作成
#5 Modelファイルにbelongs_toを追加



## 複数のカラムを追加する場合(参考)

# コマンド
bin/rails generate migration AddDetailsToProducts part_number:string price:decimal

# 作成されたmigrationファイル
class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
  end
end



## Joinテーブルを作成する場合

# JoinTable Model1 Model2 key_name1 key_name2

# コマンド
bin/rails generate migration CreateJoinTableCustomerProduct customer product

# 作成されたmigrationファイル
class CreateJoinTableCustomerProduct < ActiveRecord::Migration[7.0]
  def change
    create_join_table :customers, :products do |t|
      # t.index [:customer_id, :product_id]
      # t.index [:product_id, :customer_id]
    end
  end
end







### Rallback

# migrationの一部が失敗するとロールバックされず、手動で変更を解消する必要が生じる。