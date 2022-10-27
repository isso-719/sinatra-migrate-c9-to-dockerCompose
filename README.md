# sinatra-migrate-c9-to-dockerCompose

Cloud9 上にある Sinatra のコードを docker-compose で使用できるようにする Shell ファイル。

1. スクリプト (sinatra-migrate-c9-to-docker-compose.sh) をプロジェクトフォルダに入れる
2. `cd` でプロジェクトフォルダに移動
3. `sh migrate-c9-to-docker-compose.sh` を実行
4. `docker-compose up -d` でコンテナの起動
5. `docker-compose run web rake db:create` でデータベースの作成
6. `docker-compose run web rake db:migrate` でデータベースのマイグレーション
7. ブラウザで http://localhost:8080 にアクセスで動作確認
8. `docker-compose down` でコンテナの停止

ex. `docker-compose down --volume` でデータベースのドロップ => 4 からやり直す必要あり
