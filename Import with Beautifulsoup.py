from bs4 import BeautifulSoup
import requests
import pandas as pd

url = 'https://www.worldometers.info/co2-emissions/co2-emissions-by-country/'
page = requests.get(url)
soup = BeautifulSoup(page.text, features="html.parser")

table = soup.find_all('table')[0]
world_titles = table.find_all('th')
column_data = table.find_all('tr')
# print(world_titles)

world_table_titles = [title.text.strip() for title in world_titles]
# print(world_table_titles)
df = pd.DataFrame(columns = world_table_titles)

for row in column_data[1:]:
    row_data = row.find_all('td')
    indiv_row_data = [data.text.strip() for data in row_data]
    # print(indiv_row_data)
    length = len(df)
    df.loc[length] = indiv_row_data

df.to_csv(r'C:\Users\bdani\Documents\Datadocs\python\worldco2emission2024.csv', index = False)


