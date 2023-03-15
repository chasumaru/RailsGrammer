
流れ)
1. クライアント側: 「更新する」ボタンをクリックした時に、Turboがフォームからのリクエストをインターセプトする。フォームからのリクエストの場合、Acceptリクエストヘッダーにturbo_streamフォーマットを追加してfetchする。具体的にはAccept: text/vnd.turbo-stream.html, text/html, application/xhtml+xmlとなる。
2. サーバー側: Acceptヘッダーのtext/vnd.turbo-stream.htmlにより、フォーマットがturbo_streamになる。そのためrenderでupdate.turbo_stream.erbビューを利用する。
3. クライアント側: レスポンスされた<turbo-stream action="replace" target="cat_1">...</turbo-stream>をTurboが処理して、#cat_1を<template>要素のコンテンツでreplaceする。


• Webソケット ...非同期の配信?
• HTMLフラグメントをWebソケット経由で送信→レスポンスHTMLによってページが更新される
- 別のAPI の構築は不要
- JSON の混乱
- JS でHTML構造を再実装する必要なし

• Action Cable





利用する機能
• リアルタイムチャット機能
- websocketsが必要か

備考)

• 特徴的なヘルパーが複数存在する

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 追加
- append: targetの末尾に追加
- prepend: targetの先頭に追加
- before: targetの前に追加
- after: targetの後に追加

# 更新
- replace: targetを更新（target要素も含めて更新）
- update: targetを更新（target要素のコンテンツだけ更新）

# 削除
- remove: targetを削除
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

• GET以外のHTTPメソッドの実行時に利用できる
→index, show, edit, destroy では使えない

• Turbo Frameとの使い分け

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Turbo Frames
- index
- show
- edit
- new
- update（バリデーションエラー時）
- create（バリデーションエラー時）

# Turbo Streams
- update（成功時）
- create（成功時）
   → destroy（成功時）
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- 基本的にTurbo Framesを使う

