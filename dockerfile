FROM ubuntu:20.04

RUN apt update && apt -y upgrade && apt install -y curl wget sudo

RUN useradd -m user_Llama3
RUN gpasswd -a user_Llama3 sudo

# Ollamaのインストール
RUN curl -fsSL https://ollama.com/install.sh | sh

# 作業ディレクトリの設定
WORKDIR /home/user_Llama3

# ポート番号を環境変数で設定可能に (Ollamaのデフォルトポートは11434)
ENV PORT 11434

# ポートの公開
EXPOSE $PORT

# エントリーポイントの設定
ENTRYPOINT ["ollama"]
CMD ["serve"]