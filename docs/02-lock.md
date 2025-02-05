## ロック系

ターミナルを2つ開いて、それぞれのターミナルで以下のコマンドを実行する。
ロック時に、READMEにあるように、 以下のクエリでロック状態を確認もしてみる

```sql
SELECT engine_transaction_id, lock_status, object_name, partition_name, index_name, lock_mode, lock_type, lock_data FROM performance_schema.data_locks;
```

### 行ロック

ターミナル1

```sql
BEGIN;
SELECT * FROM lock_tests WHERE id = 1 FOR UPDATE;

-- ここでターミナル2に移動

SELECT * FROM lock_tests WHERE id >= 9 FOR UPDATE;
-- ここでターミナル2に移動

ROLLBACK;
```

ターミナル2

```sql
BEGIN;
UPDATE lock_tests SET name = 'after' WHERE id = 1; -- 処理が終わらないはず
-- Ctrl + C で終了
INSERT INTO lock_tests (id, name) VALUES (2, 'test'); -- 処理が完了しないはず
-- ターミナル1へ戻る
-- 処理が進みINSERTが完了する

INSERT INTO lock_tests (name) VALUES ('test'); -- 最後のレコードである9以上のため、末尾に追加ができず処理が完了しないはず
-- ターミナル1へ戻る

ROLLBACK;
```

### デッドロック

#### デッドロックが発生する場合

ターミナル1

```sql
BEGIN;
UPDATE members SET name = 'after1' where id = 1;

-- ここでターミナル2に移動

UPDATE shops SET name = 'after1' where id = 2; -- 処理が完了しないが、ここでターミナル2に移動

ROLLBACK;
```

ターミナル2

```sql
BEGIN;
UPDATE shops SET name = 'after2' where id = 2; 

-- ここでターミナル1に移動

UPDATE members SET name = 'after2' where id = 1; -- ターミナル1でエラーになるはず

ROLLBACK;
```

#### デッドロックが発生しない場合

ターミナル1

```sql
BEGIN;
UPDATE members SET name = 'after1' where id = 1;

-- ここでターミナル2に移動
UPDATE shops SET name = 'after1' where id = 2;
ROLLBACK;
-- ターミナル2に移動
```


ターミナル2

```sql
BEGIN;
UPDATE members SET name = 'after2' where id = 1; -- 処理が完了しないが、ここでターミナル1に移動

UPDATE shops SET name = 'after2' where id = 2; 
ROLLBACK;
```

更新対象の順番を揃えておくことで、ロック待ちになりデッドロックが発生しない