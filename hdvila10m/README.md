# Create the csv shards
```
gsutil cp download_hdvila10m_transcripts.sh gs://youtube_download/hdvila10m/
gsutil -m cp -r ~/data/hdvila/csv gs://youtube_download/hdvila10m/csv

gsutil cp ~/data/hdvila/hdvila10m_clips.csv gs://youtube_download/hdvila10m/
gsutil cp download_hdvila10m.sh gs://youtube_download/hdvila10m/
```

# Downloading the videos
```
gcloud beta batch jobs submit hdvila10m --location=us-central1 --config=job_hdvila10m.json
```

# Downloading the transcripts
```
gcloud beta batch jobs submit hdvila10m-transcripts-test --location=us-central1 --config=job_hdvila10m_transcripts_test.json
gcloud beta batch jobs submit hdvila10m-transcripts --location=us-central1 --config=job_hdvila10m_transcripts.json
```