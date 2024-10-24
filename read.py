import pandas as pd
df = pd.read_csv(r"C:\Users\bdani\Documents\Datadocs\python\worldpop2024.csv")
top10 = df[df['#'] <= 10]
specific_countries = ['Brazil', 'Bangladesh']
dispspeccount= df[df['Country (or dependency)'].isin(specific_countries)]
print(dispspeccount)
