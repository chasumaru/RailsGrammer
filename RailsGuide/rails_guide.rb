

# https://pikawaka.com/ruby/attr_accessor


### 概要


# ActiveRecord の継承により、テーブルに定義したカラムには自動的にアクセサメソッドが設定される

#- アクセサメソッドは、テーブルに定義したカラム以外にデータを保持する場合に利用する


# attr_reader ...getterメソッドの省略記法
attr_reader :age

#- getterメソッド
def age
  @age
end


# attr_writer ...setterメソッドの省略記法
attr_writer :age

#- setter
def age=(age)
  @age = age
end

# setterメソッド呼び出し①
user.age = 3
# setterメソッド呼び出し②
user.age=(3)




### 参考サイト

# https://techracho.bpsinc.jp/hachi8833/2021_04_08/104703
# https://techlife.cookpad.com/entry/2020/12/25/155741




### 基本用語

# インスタンス変数
# インスタンスメソッド
#- initializeメソッド
# attr_accessor ...getter + setter の省略記法