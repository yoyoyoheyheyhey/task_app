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
|5|ラベル|label|string||||||全て半角かつ小文字|
|6|ユーザーID|user_id|integer||||FK||登録者のID|

![er_img](https://user-images.githubusercontent.com/60313195/76681300-fc924b80-6634-11ea-90e3-7cc8e3a17777.png)