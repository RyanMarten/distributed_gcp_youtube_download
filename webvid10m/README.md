# generate csv
`./csvsetup_webvid10m.sh`

# script to bucket
`gsutil cp download_webvid10m.sh gs://youtube_download/webvid10m/`

# test
```
gcloud beta batch jobs submit webvid10m-test --location=us-central1 --config=job_webvid10m_test.json
gcloud beta batch jobs delete webvid10m-test --location=us-central1
```

# actual
```
gcloud beta batch jobs submit webvid10m --location=us-central1 --config=job_webvid10m.json
```
