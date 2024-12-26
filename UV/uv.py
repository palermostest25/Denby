import requests
import time
from datetime import datetime

API_KEY = 'openuv-1qlkrgrltjh35iz-io'  # OpenUV API Key
PERIODIC_CHECK_SECONDS = 1800  # Check every 30 minutes
uv_index_previous = None
NTFY_URL = 'https://ntfy.sh/denby_uv'

def fetch_uv_index():
    global uv_index_previous
    headers = {'x-access-token': API_KEY}
    response = requests.get("https://api.openuv.io/api/v1/uv?lat=-31.9505&lng=115.8605", headers=headers)
    uv_data = response.json()
    uv_index_current = uv_data['result']['uv']
    if uv_index_current != uv_index_previous:
        uv_index_previous = uv_index_current
        write_to_file(uv_index_current)
        send_ntfy_notification(uv_index_current)

def write_to_file(uv_index):
    with open("uv_index_perth.txt", "a") as file:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        file.write(f"{timestamp}: UV Index - {uv_index}\n")

def send_ntfy_notification(uv_index):
    message = f"UV Index Update: {uv_index}"
    response = requests.post(NTFY_URL, data=message)
    if response.status_code == 200:
        print("Notification sent successfully.")
    else:
        print("Failed to send notification.")

while True:
    fetch_uv_index()
    time.sleep(3600)