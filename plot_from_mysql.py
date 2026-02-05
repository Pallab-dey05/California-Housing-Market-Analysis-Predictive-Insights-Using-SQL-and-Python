import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv("housing.csv")

# Style
sns.set(style="whitegrid")

# 1️⃣ Income vs House Value
plt.figure(figsize=(8,5))
sns.scatterplot(x="median_income", y="median_house_value", data=df)
plt.title("Median Income vs Median House Value")
plt.show()

# 2️⃣ Ocean Proximity Impact
plt.figure(figsize=(8,5))
sns.boxplot(x="ocean_proximity", y="median_house_value", data=df)
plt.title("Housing Prices by Ocean Proximity")
plt.xticks(rotation=30)
plt.show()

# 3️⃣ Housing Age vs Price
plt.figure(figsize=(8,5))
sns.lineplot(x="housing_median_age", y="median_house_value", data=df)
plt.title("Housing Age vs Median House Value")
plt.show()

# 4️⃣ Rooms vs House Value
plt.figure(figsize=(8,5))
sns.scatterplot(x="total_rooms", y="median_house_value", data=df)
plt.title("Total Rooms vs House Value")
plt.show()

# 5️⃣ Population Distribution
plt.figure(figsize=(8,5))
sns.histplot(df["population"], bins=50, kde=True)
plt.title("Population Distribution")
plt.show()

# 6️⃣ Correlation Heatmap
plt.figure(figsize=(10,7))
sns.heatmap(df.corr(numeric_only=True), annot=True, cmap="coolwarm")
plt.title("Correlation Heatmap")
plt.show()
