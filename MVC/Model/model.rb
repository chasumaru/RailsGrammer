


# https://pikawaka.com/ruby/attr_accessor

# • インスタンスメソッド ...、インスタンス変数を扱うクラスメソッド
# - インスタンスメソッド経由でクラス外からインスタンス変数へのアクセスが可能となる
# - getter, setter, initialize メソッドなどが含まれる

# • attr_accessor ...getter + setter の省略記法
# - ActiveRecord の継承により、テーブルに定義したカラムには自動的にアクセサメソッドが設定される
# →テーブルに定義したカラム以外に値を持たせたい場合に利用する

# • attr_reader ...getter の省略記法
# • attr_writer ...setter の省略記法

# - getter

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# def age
#   @age
# end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# - setter

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# def age=(age)
#   @age = age
# end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# → user.age = 3 ... 同じ。( user.age=(3)) 




# *疑問
# - attr_accessor を使う場面は?
# https://techracho.bpsinc.jp/hachi8833/2021_04_08/104703

# https://techlife.cookpad.com/entry/2020/12/25/155741

