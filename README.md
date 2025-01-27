# 初期設定

## 環境構築

railsとmysqlをdocker composeで構築します

```bash
docker compose build # Dockerイメージのビルド
```

## DBのセットアップ
はじめにデータベースのセットアップが必要が必要になります
スキーマ管理は ridgepole を使用しています

```bash
docker compose up -d # docker-compose.yml に記載されているコンテナを起動
docker compose exec app bundle exec rails db:create # データベースの作成
docker compose exec app bundle exec ridgepole --config config/database.yml --file db/Schemafile --apply # マイグレーションの実行
```

## seedデータの投入
seedデータを投入します
seedデータは `db/seeds.rb` に記載されており、fakerを使用してランダムなデータを生成しています
DBパフォーマンスを見るためにある程度のデータが必要なため、seedのインポートにはそれなりに時間がかかります

```bash
docker compose exec app bundle exec rails db:seed
```

# TIPS
## スキーマの変更
スキーマの変更を行う場合は `db/Schemafile` を変更してください
変更後は以下のコマンドでマイグレーションを実行してください

```bash
docker compose exec app bundle exec ridgepole --config config/database.yml --file db/Schemafile --apply
```

## DBに直接接続する場合

以下の情報で接続できます

- host: localhost
- port: 3306
- user: root
- password: rootpassword
- database: demo_dbdb_demo_tutorial_development

コンソールから接続する場合

```bash
docker compose exec app mysql -h db -u root -D db_demo_tutorial_development -p
```

## ロック状況を確認する方法
以下で見れる
最低限欲しい情報だけ抜き出しているので、必要に応じてカラムを増やすといい
```sql
SELECT engine_transaction_id, lock_status, object_name, partition_name, index_name, lock_mode, lock_type, lock_data FROM performance_schema.data_locks;
```