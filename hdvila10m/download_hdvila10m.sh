# /mnt/share is mounted to the GCS buckets at gcs://youtube_download, but GCSFUSE is super slow so use gsutil commands for cp and mv, still need the /mnt/ because that is where the script is uploaded to for the batch job
export HOME="/tmp" #https://www.gnu.org/software/parallel/man.html needs a $HOME defined
shard=$(printf "%05d\n"  $BATCH_TASK_INDEX)
echo "Processing batch index $BATCH_TASK_INDEX (shard $shard)"

# install dependencies
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq update
sudo apt-get -qq install -y parallel yt-dlp

# videos, logs, input csvs
name=hdvila10m
bucket=gs://youtube_download/$name
log_file=download_$shard.log
input_file=input_$shard.csv

# download input csv (id,url) and log file (if exists, resume)
gsutil cp $bucket/csv/$input_file ./$input_file
gsutil cp $bucket/log/$log_file ./$log_file

# run the downloads in parallel
parallel --resume -v -a ./$input_file --colsep ', ' --joblog ./$log_file -j 200% 'yt-dlp "https://youtube.com/watch?v={1}" --quiet -P home:./  -f "best[height=1080][ext=mp4]/best[ext=mp4]/best" -o "%(id)s_%(section_start)06d_%(section_end)06d.%(ext)s" --download-sections "*{2}-{3}"  --force-keyframes-at-cuts && gsutil mv "./{1}_*.mp4" "{3}' ::: "$bucket/video/" 