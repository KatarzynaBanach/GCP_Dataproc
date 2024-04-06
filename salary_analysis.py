import argparse
from pyspark.sql import SparkSession
import matplotlib.pyplot as plt
import google.cloud.storage as gcs

parser = argparse.ArgumentParser()
parser.add_argument("--bucket", help="bucket for input and output")
args = parser.parse_args()
gcs_bucket = args.bucket
data_file = "gs://"+gcs_bucket+"//salary.csv"

spark = SparkSession.builder \
    .appName("Simple PySpark Example") \
    .getOrCreate()

df = spark.read.csv(data_file, header=True, inferSchema=True)

row_count = df.count()
print(f'Total rows: {row_count}')
print('Sample of data: ')
df.show(10)

salary_by_category = df.groupBy('Category').sum('Salary').orderBy('sum(Salary)', ascending=False)

df_pd = df.toPandas()
x = df_pd['Age']
y = df_pd['Salary']
plt.figure(figsize=(10, 6))
plt.scatter(x, y)
plt.xlabel("Age")
plt.ylabel("Salary")
plt.title("Age vs Salary")
plt.savefig("age_salary_scatter.png")

bucket = gcs.Client().get_bucket(gcs_bucket)
for blob in bucket.list_blobs(prefix='output/'):
  blob.delete()

bucket.blob('output/age_salary_scatter.png').upload_from_filename('age_salary_scatter.png')
salary_by_category.write.format("csv").mode("overwrite").save(f"gs://{gcs_bucket}/output/salary_by_category")
