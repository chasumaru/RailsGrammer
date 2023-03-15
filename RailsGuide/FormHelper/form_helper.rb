

# • CSRF対策に<input>にname="authentication_token" が設定されている

# • label には何の意味が?

# • ラジオボックス ...一度に一項目しか選択できない
# • チェックボックス ...複数選択可


# 1.3 その他のヘルパー

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# <%= form.text_area :message, size: "70x5" %>
# <%= form.hidden_field :parent_id, value: "foo" %>
# <%= form.password_field :password %>
# <%= form.number_field :price, in: 1.0..20.0, step: 0.5 %>
# <%= form.range_field :discount, in: 1..100 %>
# <%= form.date_field :born_on %>
# <%= form.time_field :started_at %>
# <%= form.datetime_local_field :graduation_day %>
# <%= form.month_field :birthday_month %>
# <%= form.week_field :birthday_week %>
# <%= form.search_field :name %>
# <%= form.email_field :address %>
# <%= form.telephone_field :phone %>
# <%= form.url_field :homepage %>
# <%= form.color_field :favorite_color %>
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




# 2 モデルオブジェクトを扱う
# • form_with (非推奨: form_for) ...フォームヘルパー
# - フォームビルダーオブジェクトとモデルオブジェクトを紐づける
# • |form|, |f| ...フォームビルダーオブジェクト



#  セレクトボックスを簡単に作成する



# 4 日付時刻フォームヘルパーを使う



# 6.1 アップロード可能なファイル
# - プレビュー機能の実装











