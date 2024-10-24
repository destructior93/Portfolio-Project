import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv(r"C:\Users\bdani\Documents\Datadocs\excel\netflix_titles.csv")
# df.info()

#replacements

df['country'].fillna(df['country'].mode()[0])

df.replace(np.nan,{'cast': 'No Data'}, inplace=True)
df.replace(np.nan,{'director': 'No Data'}, inplace=True)

# drops

df.dropna(inplace=True)

# drop duplicates

df.drop_duplicates(inplace=True)

#checking info before exporting

df.isnull().sum()
df.info()

df.to_csv(r"C:\Users\bdani\Documents\Datadocs\excel\netflix_titles_trim.csv", index=False)
# Palette
# sns.palplot(['#221f1f', '#b20710', '#e50914','#f5f5f1'])

# plt.title('Netflix brand palette ',loc='left',fontfamily='serif', fontsize=15,y=1.2)
# plt.show()