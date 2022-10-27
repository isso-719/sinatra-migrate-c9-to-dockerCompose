# config/database.yml
cat <<'EOF' > config/database.yml
default_env: &default
  adapter: postgresql
  encoding: unicode
  database: s_count

development:
  <<: *default
  host: db
  username: postgres
  password:

production:
  <<: *default
EOF

# docker-compose.yml
cat <<'EOF' > docker-compose.yml
version: '3.9'
services:
  web:
    build: .
    command: bundle exec ruby app.rb -o 0.0.0.0
    ports:
      - 8080:4567
    volumes:
      - .:/app
    depends_on:
      - db
    environment:
      - RACK_ENV=development

  db:
    image: postgres
    ports:
      - 3306:3306
    volumes:
      - postgres_volume:/var/lib/postgresql/data
    environment:
        POSTGRES_HOST_AUTH_METHOD: 'trust'

volumes:
  postgres_volume:
EOF

# dockerfile
cat <<'EOF' > Dockerfile
FROM ruby:3.0.0

WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN bundle install
EOF

# 最後に
echo '===基本コマンドを紹介します==='
echo 'コンテナの起動: docker-compose up -d'
echo 'コンテナの停止: docker-compose down'
echo 'データベースの作成: docker-compose run web rake db:create'
echo 'データベースのマイグレーション: docker-compose run web rake db:migrate'
echo 'データベースのドロップ: docker-compose down --volume'
echo 'Web アプリケーションのリンク: http://localhost:8080'
