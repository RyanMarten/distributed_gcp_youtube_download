# Downloading the transcripts
```
gsutil cp download_hdvila10m_transcripts.sh gs://youtube_download/hdvila10m/
gcloud beta batch jobs submit hdvila10m-transcripts-test-2 --location=us-central1 --config=job_hdvila10m_transcripts_test.json
gcloud beta batch jobs submit hdvila10m-transcripts-2 --location=us-central1 --config=job_hdvila10m_transcripts.json
```

# Uploading the inputs to the batch job
```
gsutil -m cp -r ~/data/hdvila/csv gs://youtube_download/hdvila10m/csv
gsutil cp ~/data/hdvila/hdvila10m_clips.csv gs://youtube_download/hdvila10m/
gsutil cp download_hdvila10m.sh gs://youtube_download/hdvila10m/
gcloud beta batch jobs submit hdvila10m --location=us-central1 --config=job_hdvila10m.json
```