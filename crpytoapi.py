from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json
import pandas as pd
import os
from time import time, sleep
import seaborn as sns
import matplotlib.pyplot as plt

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
pd.set_option('display.float_format', lambda x: '%.5f' % x)

# creating api function

def api_runner():
    global df
    url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"

    parameters = {
        'start':'1',
        'limit': '15',
        'convert': 'USD'
    }
    headers = {
        'ACcepts': 'application/json',
        'X-CMC_PRO_API_KEY': "19559581-a85a-4798-a224-00847edf20b1"
    }

    session = Session()
    session.headers.update(headers)

    try:
        response = session.get(url, params = parameters)
        data = json.loads(response.text)
        # print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
        print(e)

    pd.set_option('display.max_columns', None)
    pd.json_normalize(data['data'])
    pd.set_option('display.float_format', lambda x: '%.5f' % x)

    df = pd.json_normalize(data['data'])
    df['timestamp'] = pd.to_datetime('now')
    df

    if not os.path.isfile(r'C:\Users\bdani\Documents\Datadocs\python\cryptodata1.csv'):
        df.to_csv(r'C:\Users\bdani\Documents\Datadocs\python\cryptodata1.csv', header='column_names')
    else: 
        df.to_csv(r'C:\Users\bdani\Documents\Datadocs\python\cryptodata1.csv', mode='a', header=False)

# creating loop

for i in range(5):
    api_runner()
    print('Api runner completed successfully')
    sleep(60)

exit()

# useful info : you can use groupby function to focus on sets of data. You can then stack them for better use (info in rows rather than columns for visual display purposes) and convert back to dataframe. Examples below

df2 = df.groupby('name', sort=false)['columnname'].mean()
df3 = df2.stack()
df4 = d3.to_frame(name ='values')

# we now lack an index however. so we can create one

pd.Index(range(no.ofrows))
df5 = df4.reset_index()
df6= df5.rename(columns={'level_1': 'percent_change'})

# visualization steps
sns.catplot(x='percent_change', y ='values', hue='name', data = df6, kind ='point')
df6['percent_change'] = df6['percent_change'].replace(['quote.USD.percent_change_1h'], ['1h']) # and so on, same replacements for other 'h' values too

# query only one type of coin then display
df6= df6.query("name == 'Bitcoin'")
sns.set_theme(style = 'darkgrid')
sns.lineplot(x = 'timestamp', y = 'quote.USD.price', data= df6)