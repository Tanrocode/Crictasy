import requests
import json
import random

keys = []

def get_data(date):

    url = f"https://cricket-live-data.p.rapidapi.com/results-by-date/{date}"

    headers = {
        'x-rapidapi-host': "cricket-live-data.p.rapidapi.com",
        'x-rapidapi-key': f"{random.choice(keys)}"
     }

    response = requests.request("GET", url, headers=headers)
    json_response = json.dumps(response)


date_input = input("select date")
print(get_data(date_input))

    


