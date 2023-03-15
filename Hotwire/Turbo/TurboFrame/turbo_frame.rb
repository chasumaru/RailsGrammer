

流れ)
1. リンク,フォームからのリクエスト
2. fetchによる非同期リクエスト
3. レスポンスの<turbo-frame>要素を抜き出して現在のページの<turbo-frame>を置換する

特徴
• public にキャッシュされたrootページによる自動的な遅延ロード
- カスタムJS が不要


利用する機能
• CRUD 操作


使い方
• turbo_frame_tagヘルパー

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<%= turbo_frame_tag "cats-list" do %>
  <div>置換したい箇所</div>
<% end %>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

• レンダリング時

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<turbo-frame id="cats-list">
  <div>置換したい箇所</div>
</turbo-frame>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



チュートリアル2 Turboで管理画面をSPA風にする｜猫でもわかるHotwire入門 Turbo編 (zenn.dev)
• Drive → Frames に変更
- ページネーションの高速化
- ページネーション時にURLが変化しない
- 検索フォームの入力内容が保持されるetc...

• data-turbo-frame属性
- turbo-frameの外側にあるとき有効
- 検索機能など





