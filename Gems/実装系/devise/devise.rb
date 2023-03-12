



### Helper

# user_signed_in? ...ログインの判定

def index
  flash[:notice] = "ログインユーザーになると閲覧できます" unless user_signed_in?
end

# current_user ...ログイン中のユーザーのModelオブジェクト

# before_action :authenticate_user! ...ログイン済みユーザーにのみアクセスを可能にする

# user_session ...セッション情報へのアクセス



#### Deviseモジュール


### confirmationモジュール

# send_confirmation_instructions ...手動でConfirmメールを送信
ser.send_confirmation_instructions

# confirmする
#- 具体的にはconfirmed_atに現在時刻を設定する
user.confirm

# confirmed? ...認証済みならtrue
user.confirmed?



### Database Authenticatableモジュール


# user.password ...ユーザーインスタンスの持つパスワード
#- 内部で暗号化して`encrypted_password`にセットする
user.password = "password"
user.encrypted_password  #=> "$2a$12$V/xUMhmLEZApbyv2Y0jI4eyJ0gYE8JlVPL2/1Yr9jcFXChnQzC0Hi"


# valid_password?('password') ...引数に与えられたパスワードを検証し、真偽値を返す
#- 引数のパスワードをハッシュ化してencrypted_passwordの値と比較する
user.valid_password?('password') #=> true


# clean_up_passwords ...passwordとpassword_confirmationにnilをセットする
user.clean_up_passwords
user.password #=> nil
user.password_confirmation #=> nil



### rememberableモジュール

# remember_me! ...remember_tokenを作成
user.remember_me!

# forget_me! ...remember_tokenを削除
user.forget_me!

# serialize_into_cookie(user) ...引数のuserオブジェクトのプロパティを元にcookieを作成
User.serialize_into_cookie(user)

# serialize_from_cookie(cookie_string) ...cookie情報を元にuserを取得
User.serialize_from_cookie(cookie_string)




### Recoverableモジュール

# パスワードリセットメール送信
user.send_reset_password_instructions

# パスワードリセット
# user.reset_password(new_password, new_password_confirmation)
user.reset_password('password123', 'password123')

# reset_password_tokenが有効期限内かどうかを、reset_password_sent_atを使い判定
user.reset_password_period_valid? #=> true

# tokenを使ってuserを取得
User.with_reset_password_token(token) #=> user




### Lockableモジュール

# ロック(メール送信もする)
user.lock_access!

# ロック(メール送信しない)
user.lock_access!(send_instructions: false)

# アンロック
user.unlock_access!

# アンロックのメール送信
user.resend_unlock_instructions



### Validatableモジュール
#- 内部でvaldationを設定





### Deviseで実現可能な機能

# https://nekorails.hatenablog.com/entry/2021/03/18/110200

# • Twitterログイン
# • ログアウト後のリダイレクト先を変更
# • テストでdeviseのメソッドを実行
# - sign_in, sign_outなど
# • 管理者権限の実装
# • 別のModel からcurrent_userを利用
# • ログインユーザの切り換え(開発環境)
# • メールによる招待機能
# • エンタープライズなセキュリティ機能
# - 秘密の質問機能



### 参照サイト


## まとめサイト

# https://nekorails.hatenablog.com/entry/2021/03/18/110200
#- Devise入門 64のレシピ


# https://patorash.hatenablog.com/entry/2020/04/09/112421
#- 論理削除, 日本語化



## 基本の手順

# https://qiita.com/cigalecigales/items/16ce0a9a7e79b9c3974e?msclkid=640282d8c4e811ecb93787d3a024b0b9

# https://qiita.com/70yama/items/dbf428a51830e70aa9bd?msclkid=8cca81b6c88711ec82f9765808c62d5f

# https://teratail.com/questions/139633
#- resource_nameについて

# https://patorash.hatenablog.com/entry/2020/04/09/112421
#- 論理削除(MySQLは不可)




## Rails7との不整合

# https://qiita.com/MASAHIDE-HIGASHI/items/1f26c04fb5d5c46ab70b?msclkid=0e21bf51c64011ecb0787efe559aaa46

# https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be





## 備考

# • devise は内部でWardenを利用している
# - warden ...Rackミドルウェアを介して認証を行う