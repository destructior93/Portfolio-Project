#import libs

import pandas as pd
from bs4 import BeautifulSoup
import requests
import time
import datetime

#hooking to the website data

url = 'https://www.amazon.co.uk/s?k=kitchen+rack'
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36"}
page = requests.get(url, headers=headers)
soup1 = BeautifulSoup(page.content, features="html.parser")
soup2 = BeautifulSoup(soup1.prettify(), features="html.parser")

print(item["a-offscreen"] for item in soup2.find_all() if "a-offscreen" in item.attrs)