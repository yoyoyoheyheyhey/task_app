# 動作確認ユーザー作成手順
```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server

管理者ユーザーでのログイン方法
login_id: test999@example.com
password: testtest

一般ユーザーでのログイン方法
login_id: test1@example.com
password: testtest
```

# テーブル定義

論理名: ユーザー  
物理名: users
|項番|カラム論理名|カラム物理名|データ型|桁数|NotNull|初期値|主キー|インデックス|コメント|  
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|ID|id|integer||○||PK|
|2|名前|name|string||○|
|3|メールアドレス|email|string||○|||unique
|4|パスワード|password_digest|string||○|

論理名: タスク  
物理名: tasks  
|項番|カラム論理名|カラム物理名|データ型|桁数|NotNull|初期値|主キー|インデックス|コメント|  
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|ID|id|integer||○||PK|
|2|タイトル|title|string||○|
|3|内容|content|text||○|
|4|優先度|priority|integer||○|0|||0:未着手, 1: 着手中,2:完了|
|5|ユーザーID|user_id|integer||||FK||登録者のID|


論理名: ラベル  
物理名: labels  
|項番|カラム論理名|カラム物理名|データ型|桁数|NotNull|初期値|主キー|インデックス|コメント|  
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|ID|id|integer||○||PK|
|2|ラベル名|label_name|string||○||||全て半角かつ小文字|  

![er_img](https://user-images.githubusercontent.com/60313195/76682098-724de580-663c-11ea-9dd4-3c454bedafe8.png)

# Herokuへのデプロイ手順
すでにアプリを作成している場合　3から進める
1. heroku login
1. heroku create  
1. git add .
1. git commit -m '変更内容'
1. git push origin 作業ブランチ名
1. プルリクエストを行う。
1. 承認された場合、GitHub上でmergeする。
1. Githubの作業ブランチを削除する。
1. git checkout master (Localにてmasterブランチに切り替える
1. git pull origin master (差分を取り込む
1. git branch -d ブランチ名 (Localの作業ブランチを削除する
1. git push heroku master
1. heroku run rails db:migrate

# バージョン情報
Ruby: 2.6.5  
Rails: 5.2.3  
psql: 12.2  