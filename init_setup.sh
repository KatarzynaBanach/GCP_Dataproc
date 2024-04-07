BUCKET=salary_123456789
REGION=europe-central2

gcloud services enable dataproc.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com

# cluster & bucket creation TODO -> in terraform or cluster in shell
# gcloud dataproc clusters export EXISTING_CLUSTER_NAME \
    # --region=REGION \
    # --destination=cluster.yaml

# gcloud dataproc clusters import NEW_CLUSTER_NAME \
#     --region=REGION \
#     --source=cluster.yaml

# TODO: region = europe-central2, zone - auto, image version 2.2.10-debian12, single node(1 master, 0 workers), machine type of master node: e2-standard-2, primary disk size 150 GB, Internal IP only: no, network: default, 

gcloud storage buckets create gs://$BUCKET --location=$REGION
