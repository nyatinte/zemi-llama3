# Llama3 研究環境

## 概要
この環境は、研究室でLlama3を使用するために構築されたDockerベースの設定です。Llama3は最新の大規模言語モデルで、自然言語処理タスクに広く使用されています。

## 前提条件
- Ubuntu 20.04 LTS 以上
- Docker Engine がインストールされていること
- sudo 権限を持つユーザーアカウント

## セットアップ手順

1. リポジトリのクローン:
   ```sh
   git clone [このリポジトリのURL]
   cd [リポジトリ名]
   ```

2. 管理スクリプトに実行権限を付与:
   ```sh
   chmod +x manage_llama3.sh
   ```

3. Dockerイメージのビルド:
   ```sh
   ./manage_llama3.sh build
   ```

## 使用方法

### コンテナの管理
- コンテナの起動:
  ```sh
  ./manage_llama3.sh start
  ```
  カスタムポートを使用する場合（例：8080）:
  ```sh
  ./manage_llama3.sh start 8080
  ```

- コンテナの停止:
  ```sh
  ./manage_llama3.sh stop
  ```

- コンテナの再起動:
  ```sh
  ./manage_llama3.sh restart
  ```

### Llama3の実行
- Llama3を起動:
  ```sh
  ./manage_llama3.sh run
  ```

### APIを使用する場合
PythonスクリプトからLlama3 APIを使用する場合は、`llama3_client.py`を参照してください。

## 注意点
- メモリ要件：Llama3 8Bモデルには少なくとも16GB、70Bモデルには64GB以上のRAMが推奨されます。
- 初回実行時はモデルのダウンロードに時間がかかる場合があります。
- GPUを利用する場合は、追加の設定が必要です。

## トラブルシューティング
- `sudo`コマンドが使用できない場合は、[sudoersファイルのエラー対処方法](https://qiita.com/tks_00/items/bc04bc477d9019341859)を参照してください。
- Dockerの動作に問題がある場合は、[Ubuntu へのDocker Engineインストール手順](https://docs.docker.com/engine/install/ubuntu/)を確認してください。
- `manage_llama3.sh`スクリプトのヘルプを表示:
  ```sh
  ./manage_llama3.sh
  ```

## ファイル構成
- `Dockerfile`: Llama3環境のDockerイメージ定義
- `manage_llama3.sh`: Dockerコンテナ管理用スクリプト
- `src/llama3_client.py`: Llama3 API用Pythonクライアント (要 rye, `rye sync`)

## 参考資料
- [Llama3の環境構築からCUIでの実行まで](https://qiita.com/masa3000/items/8ed69d2036255e5f0af2)
- [Ollama 公式ドキュメント](https://ollama.com/library/llama3)

<!-- ## ライセンス
このプロジェクトは[ライセンス名]の下で公開されています。詳細は`LICENSE`ファイルを参照してください。

## 貢献
バグ報告や機能リクエストは、Issueトラッカーを使用してください。プルリクエストも歓迎します。

## 連絡先
質問や支援が必要な場合は、[担当者名や連絡先]までご連絡ください。 -->