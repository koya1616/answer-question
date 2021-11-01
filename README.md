# exactly
<img width="1433" alt="スクリーンショット" src="https://user-images.githubusercontent.com/87183507/138557348-18a401f4-6419-4f08-bd46-dd81733d620a.jpg">

## URL
・[htt](ec2-18-222-4-208.us-east-2.compute.amazonaws.com)

### ゲストログイン
- メールアドレス：guest@gmail.com
- パスワード：g12345


## 概要
exactlyは誰でも、どんなジャンルの悩みでも解決できるQ&Aサイトです。
フォロー機能などもあるので、ユーザー同士の繋がりも可能です。

## 使用技術

- Ruby2.6.3
- Rails5.2.6
- slim
- jQuery
- Bootstrap
- MySQL5.7
- AWS(RDS, EC2, S3, cloud9, Route53,)

## アプリケーションについて
### 背景・目的
良いWEBアプリケーションというのはユーザー同士が盛り上げて自動的にサービスが自走することだと感じました。
そのため、ユーザー同士が多く繋がれる機能を実装したいと感じました。
また、以下の点も考慮しました。
- より良いサービスを作れるエンジニアになるためにも技術力を高めたいと感じ、多くの機能を実装すると決めました。
- プログラミングの勉強をしていて、悩みや問題は解決されるべきと思ったため。

## 工夫した点
### 技術面
- ソースコードは可読性や保守性を高めることを意識しました。
### ユーザー目線
- UIUXはできるだけシンプルでわかりやすさを求めました。
![UIUX](https://user-images.githubusercontent.com/87183507/139357472-04fb34a7-04ef-4ec9-8e95-920e57743f8f.jpg)


## 苦労した点
- 複雑なコードが多くなっていくのでリファクタリングをするのが難しかったです。
- 本番環境へデプロイする時の設定が難しかったです。

## 機能一覧
### 回答機能
- CRUD機能
- いいね機能
- コメント機能
- 1画面で多くの機能を使うことができる。
![S__29892626](https://user-images.githubusercontent.com/87183507/139357540-c37db551-58a9-412a-b7b0-bb57aee4de80.jpg)

### カテゴリー機能
- 質問、投稿、ユーザーにポリモーフィックで紐づけ
- カテゴリーはユーザーにフォローされることができる

### コメント機能
- 質問に対してコメントすることができます。

### ユーザー認証
- ログイン、サインアップ機能(devise)
- email、パスワード、ユーザー名必須(ログイン時はemailとパスワードのみ)

### フォロー、フォロワー機能
- ユーザーどうしのコミュニティを広げることができます。

### いいね機能
- ボタン一つでユーザー達の関心度がわかります。

### 質問機能
- CRUD機能
- カテゴリー機能をつけることで質問の内容がわかりやすいとおもいます。
- 同カテゴリーの質問を「関連する質問」として表示できます(サブクエリを使用)

### 検索機能
- カテゴリー別、解決済み、未解決、フリーワードで質問を検索可能

### ストック機能
- 質問をストックすることができます。

### 通知機能
- 質問に回答が来た時
- 質問、投稿、回答にコメントがついた時
- フォローされた時
- 質問がストックされた時

### ランキング機能
- 回答数、質問数でランキング表示

