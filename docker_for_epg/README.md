# Mirakurn & EPGstation Docker イメージ作成から起動まで (TV録画環境)

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


## Mirakurun & EPGstation docker イメージ準備

```
$ git clone -b recisdb-rs https://github.com/norikatsu/Mirakurun   (ブランチ recisdb-rs に自分の編集を加えているのでこれを cloneする )
$ cd Mirakurun
$ docker_for_epg/setup.sh                                                  (必要ディレクトの作成)
$ docker compose -f ./docker_for_epg/docker-compose.yml build
$ cd docker_for_epg
$ docker compose run --rm -e SETUP=true mirakurun
```


## isdb-scannerのスキャン結果などコピー

```
$ sudo cp ./scanned/Mirakurun/channels.yml /opt/mirakurun/config/
$ sudo cp ./scanned/Mirakurun/tuners.yml   /opt/mirakurun/config/
$ sudo cp bcas_keys                        /opt/mirakurun/config/
```



## 起動・停止
```
$ cd  "clone した Mirakurun の docker_for_epg フォルダ" に移動(カレントに docker-compose.yml ファイルがあること)
$ sudo docker compose up -d
```

```
$ cd  "clone した Mirakurun の docker_for_epg フォルダ" に移動(カレントに docker-compose.yml ファイルがあること)
$ sudo docker compose down
```
