import requests
from bs4 import BeautifulSoup
import csv

link = requests.get(f"https://www.iplt20.com/stats/2021/most-runs")
soup = BeautifulSoup(link, 'lxml')


for runs in soup.find_all("Runs"):
    runs_information = link.find('div', class_='js-table')

