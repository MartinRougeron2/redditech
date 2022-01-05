import requests

class API:
    def __init__(self, url):
        self.r = requests.get(url)
        print(self.r.status_code)
        print(self.r.text)

if (__name__ == "__main__"):
    token = "nffbghgjyGY23739CHSC6dzdèz_bd"
    API("https://www.reddit.com/api/v1/authorize?client_id=K8_N7ZiJEjVTZgw8FOltdQ&response_type=code&state=" + token + "&redirect_uri=https://127.0.0.1/callback&duration=permanent&scope=identity")
