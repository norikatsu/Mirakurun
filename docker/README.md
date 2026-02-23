## Docker Development Commands:

```
# build (imageを生成)
docker compose -f docker/docker-compose.yml build
# run (テスト実行) 本番は docker compose up -d で実行
docker compose -f docker/docker-compose.yml run --rm --service-ports mirakurun
# run w/ env (デバッグ実行)
docker compose -f docker/docker-compose.yml run --rm --service-ports -e LOG_LEVEL=3 mirakurun
```



## Mirakurun で使用する ./scanned ファイル群を作成

### ISDBScanner を使用 

```
# ソース
$ git clone https://github.com/tsukumijima/ISDBScanner
    
# バイナリインストール (x86_64 環境)
$ sudo wget https://github.com/tsukumijima/ISDBScanner/releases/download/v1.3.2/isdb-scanner -O /usr/local/bin/isdb-scanner
$ sudo chmod +x /usr/local/bin/isdb-scanner
    
# バイナリインストール (arm64 環境)
$ sudo wget https://github.com/tsukumijima/ISDBScanner/releases/download/v1.3.2/isdb-scanner-arm -O /usr/local/bin/isdb-scanner
$ sudo chmod +x /usr/local/bin/isdb-scanner
```
    
使い方
```
$ isdb-scanner --help 
$ isdb-scanner --list-tuners   : 使えるチューナを表示
    
$ isdb-scanner ./scanned/      : BS の有料放送と CS チャンネルをスキャン結果に含めてスキャン -> 結果を ./scanned に出力
  ***  linux_files/config_files/scanned  に保存済み  ***
```


## Mirakurun docker イメージ準備

```
$ git clone -b recisdb-rs https://github.com/norikatsu/Mirakurun   (ブランチ recisdb-rs に自分の編集を加えているのでこれを cloneする )
$ cd Mirakurun
$ docker/setup.sh                                                  (必要ディレクトの作成)
$ docker compose -f ./docker/docker-compose.yml build
$ cd docker 
$ docker compose run --rm -e SETUP=true mirakurun
```


## isdb-scannerのスキャン結果などコピー 

```
$ sudo cp ./scanned/Mirakurun/channels.yml /opt/mirakurun/config/
$ sudo cp ./scanned/Mirakurun/tuners.yml   /opt/mirakurun/config/
$ sudo cp bcas_keys                        /opt/mirakurun/config/
```



## 起動
```
$ cd  "clone した Mirakurun の docker フォルダ" に移動(カレントに docker-compose.yml ファイルがあること)
$ sudo docker compose up -d
```

## 停止
```
$ cd  "clone した Mirakurun の docker フォルダ" に移動(カレントに docker-compose.yml ファイルがあること)
$ sudo docker compose down
```
