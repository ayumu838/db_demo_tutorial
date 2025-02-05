## SELECT系

メモ帳やエディタを開きながら、実行結果を記録しつつ進めてください。

### クエリ

検索
- 前方一致検索: `SELECT * FROM shops WHERE name LIKE 'hill%' LIMIT 10;`
- 後方一致検索: `SELECT * FROM shops WHERE name LIKE '%hill' LIMIT 10;`
- 部分一致検索: `SELECT * FROM shops WHERE name LIKE '%hill%' LIMIT 10;`


並び替え
- 昇順: `SELECT * FROM shops ORDER BY name ASC LIMIT 10;`
  - OFFSETを使った場合: `SELECT * FROM shops ORDER BY name ASC LIMIT 10 OFFSET 9900;`
- 降順: `SELECT * FROM shops ORDER BY name DESC LIMIT 10;`
  - OFFSETを使った場合: `SELECT * FROM shops ORDER BY name DESC LIMIT 10 OFFSET 9900;`

### 手順
1. それぞれのクエリの実行結果と、かかった時間を記録する
1. 実行計画を見て、計画内容を記録する
  - 実行計画: `EXPLAIN` を先頭につけると実行計画を見ることができます
1. `shops.name` にインデックスを張って、実行計画の変化を確認する
  - インデックスの張り方: `Schemafile` にインデックスを張る下記のコードを追記する
    - `t.index [ "name" ], name: "shops_name"` 


