# Distributed Download for Massive Datasets

Downloads WebVid10m in 10 minutes for $100 of GCP credits. Downloading YouTube datasets like ACAV and HDVILA also works pretty well. 

See [this presentation](https://docs.google.com/presentation/d/1i3DnsOmEFcfDuKG7AT22WYUtFVPkFKfcdIcPrVSTFQg/edit#slide=id.g82736d3e0d_0_26) for background. 

## Enable Batch
`gcloud services enable batch.googleapis.com`

## Make your bucket
`gsutil mb -b on -l US gs://youtube_download`

## Example (WebVid)
### Generate CSV shards and upload to bucket
`./csvsetup.sh`

### Upload script to bucket
`gsutil cp download_webvid10m.sh gs://youtube_download/webvid10m/`

### Run a test (single task, single machine) to make sure there are no errors
```
gcloud beta batch jobs submit webvid10m-test --location=us-central1 --config=job_webvid10m_test.json
gcloud beta batch jobs delete webvid10m-test --location=us-central1
```

### Run the full batch job (1,000 tasks and 1,000 machines)
`gcloud beta batch jobs submit webvid10m --location=us-central1 --config=job_webvid10m.json`

# Benchmarking with a test instance
Some times it is useful to manually test your download script before putting it in batch job. 
```
gcloud beta compute instances create benchmarking --machine-type=n2d-highcpu-128 --zone us-east1-b
gcloud compute instances delete benchmarking --zone us-east1-b
gcloud compute ssh --zone "us-east1-b" "benchmarking" 
```
