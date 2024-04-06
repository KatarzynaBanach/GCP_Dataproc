CLUSTER_NAME=mycluster
REGION=europe-central2
PYTHON_SCRIPT=salary_analysis.py
BUCKET=salary_123456789

gcloud dataproc jobs submit pyspark \
       --cluster $CLUSTER_NAME \
       --region $REGION \
       $PYTHON_SCRIPT \
       -- --bucket=$BUCKET
