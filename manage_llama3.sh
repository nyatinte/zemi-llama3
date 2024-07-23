#!/bin/bash

# エラーが発生したら即座に停止
set -e

IMAGE_NAME="llama3_image"
CONTAINER_NAME="llama3_container"
DEFAULT_PORT=11434

# 使用方法を表示する関数
show_usage() {
    echo "使用方法: $0 [build|start|stop|restart|run] [PORT]"
    echo "  build   : Dockerイメージをビルドします"
    echo "  start   : コンテナを起動します"
    echo "  stop    : コンテナを停止します"
    echo "  restart : コンテナを再起動します"
    echo "  run     : Llama3を実行します"
    echo "  PORT    : オプション。使用するポート番号（デフォルト: $DEFAULT_PORT）"
}

# イメージをビルド
build_image() {
    echo "Dockerイメージをビルドしています..."
    sudo docker build -t $IMAGE_NAME .
}

# コンテナを起動
start_container() {
    local port=${1:-$DEFAULT_PORT}
    echo "コンテナを起動しています（ポート: $port）..."
    if [ ! "$(sudo docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$(sudo docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
            sudo docker rm $CONTAINER_NAME
        fi
        sudo docker run -d --name $CONTAINER_NAME -p $port:11434 -e PORT=$port $IMAGE_NAME
    else
        echo "コンテナは既に実行中です"
    fi
}

# コンテナを停止
stop_container() {
    echo "コンテナを停止しています..."
    sudo docker stop $CONTAINER_NAME
}

# コンテナを再起動
restart_container() {
    local port=${1:-$DEFAULT_PORT}
    stop_container
    start_container $port
}

# Llama3を実行
run_llama3_8b() {
    echo "Llama3を実行しています..."
    sudo docker exec -it $CONTAINER_NAME ollama run llama3
}

run_llama3_70b() {
    echo "Llama3を実行しています..."
    sudo docker exec -it $CONTAINER_NAME ollama run llama3:70b
}

# メイン処理
case "$1" in
    build)
        build_image
        ;;
    start)
        start_container $2
        ;;
    stop)
        stop_container
        ;;
    restart)
        restart_container $2
        ;;
    run)
        run_llama3_8b
        ;;
    run_70b)
        run_llama3_70b
        ;;
    *)
        show_usage
        exit 1
        ;;
esac

echo "操作が完了しました。"