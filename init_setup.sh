BUCKET=salary_123456789
REGION=europe-central2

gcloud services enable dataproc.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com

# cluster & bucket creation TODO -> in terraform

gcloud storage buckets create gs://$BUCKET --location=$REGION
