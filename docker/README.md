## Docker Development Commands:

```sh
# build (imageを生成)
docker compose -f docker/docker-compose.yml build
# run (テスト実行) 本番は docker compose up -d で実行
docker compose -f docker/docker-compose.yml run --rm --service-ports mirakurun
# run w/ env (デバッグ実行)
docker compose -f docker/docker-compose.yml run --rm --service-ports -e LOG_LEVEL=3 mirakurun
```
