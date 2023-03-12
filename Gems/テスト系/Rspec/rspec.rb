

### 概要

# BDD (振舞駆動開発)

# 複雑なテストも可能



### テストの分類

## Model Spec

## System Spec ...振る舞いに対するテスト
# Controller
# Model
# View

## Request Spec ...統合テスト




# https://qiita.com/jnchito/items/42193d066bd61c740612

# • describe ...文字列またはクラスを指定
# -  複数のdescribeブロック,exampleを置ける。
# • context
# - 条件分岐
# • before ...全データの共通処理
# - インスタンス変数の設定
# • it ...exampleを宣言
# • expect (実際の挙動).to (想定した挙動)

# 詳細ルール
# • 原則,１つのexample内に1つのexpectation
# • 一番外側のdescribeのみRspec. は省略不可
# • インスタンスメソッドの場合, describe ‘#greet’ のように書く。
# • let ...変数全般を定義できる
# - 遅延評価=必要な瞬間に呼び出し
# ->遅延評価が原因によるテスト失敗に注意
# →before全般の代わり
# • subject ...テスト対象object, または処理が1つである場合にDRY化
# - expect{} →is_expected に置き換え
# - it の文字列を削除
# • shared_examples, it_behaves_like ...example の再利用
# • shared_context, include_context ...context の再利用

# テストの保留
# • pending ...処理の保留
# • xit ...example の保留
# • xcontent ...content 全体の保留
# • xdescribe ...describe 全体の保留













### 参照サイト


## 基本

# https://qiita.com/kaito-h/items/d3a4ea56bc7cb695306a
# https://qiita.com/shogo-1988/items/d19cd5068cdeb825176d
# https://qiita.com/jnchito/items/42193d066bd61c740612

# https://qiita.com/NasuPanda/items/561101eb3ba01f8fe4c7?msclkid=95137e44c53811eca6a573b76420133b
# https://zenn.dev/fu_ga/books/ff025eaf9eb387
#- Railsチュートリアル関連


## その他

# https://qiita.com/yu_yukke/items/3692efec64e9c06ffdd5