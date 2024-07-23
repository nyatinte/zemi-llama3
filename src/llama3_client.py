
import requests
import json

class Llama3Client:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url

    def generate(self, prompt, model="llama3"):
        url = f"{self.base_url}/api/generate"
        data = {
            "model": model,
            "prompt": prompt
        }
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return response.json()['response']
        else:
            return f"Error: {response.status_code}, {response.text}"

    def chat(self, messages, model="llama3"):
        url = f"{self.base_url}/api/chat"
        data = {
            "model": model,
            "messages": messages
        }
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return response.json()['message']['content']
        else:
            return f"Error: {response.status_code}, {response.text}"

    def list_models(self):
        url = f"{self.base_url}/api/tags"
        response = requests.get(url)
        if response.status_code == 200:
            return response.json()['models']
        else:
            return f"Error: {response.status_code}, {response.text}"

    def pull_model(self, model="llama3"):
        url = f"{self.base_url}/api/pull"
        data = {"name": model}
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return "Model pulled successfully"
        else:
            return f"Error: {response.status_code}, {response.text}"

# 使用例
if __name__ == "__main__":
    client = Llama3Client()

    # モデルのリストを取得
    print("Available models:", client.list_models())

    # Llama3モデルをプル（まだ存在しない場合）
    print(client.pull_model())

    # テキスト生成
    prompt = "Explain the concept of artificial intelligence in simple terms."
    print("Generated text:", client.generate(prompt))

    # チャット
    messages = [
        {"role": "user", "content": "What is the capital of France?"},
        {"role": "assistant", "content": "The capital of France is Paris."},
        {"role": "user", "content": "What is its population?"}
    ]
    print("Chat response:", client.chat(messages))