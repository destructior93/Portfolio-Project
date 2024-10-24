import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv(r"C:\Users\bdani\Documents\Datadocs\python\worldpop2024.csv")
df.info()
df.describe()
shownullvalues = df.isnull().sum()
df.sort_values(by='Population (2024)', ascending=False).head()
# print(df)

df.corr(numeric_only=True)
sns.heatmap(df.corr(numeric_only=True), annot=True)
plt.show()

df.boxplot()