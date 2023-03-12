


# 論理演算
# • to ...であること
# • not_to/ to_not ...でないこと

# • be ...不等号と組み合わせて大小判定
# - equal? メソッドを内部で利用(真偽の検証)
# ※ eq ... 内部で == を利用(値の検証)

# • be_xxx ...返り値が真偽であるメソッド
# ex)
# - be_empty?
# - be_present?
# - be_valid?

# • be_truthy/falthy ...返り値が真偽のメソッドを検証
# ex)
# - (user.save).to be_truthy

# • change抹茶
# - expect の引数に中括弧を使う
# 型)
# expect {X}.to change {Y}.from(A).to(B) ...XするとYがAからBに変わる

# • include ...基本的に配列オブジェクトに使う

# • raise_error ...エラーの検証

# • be_within(Y).of(X) ...数値 ...Xが±Yに収まること




