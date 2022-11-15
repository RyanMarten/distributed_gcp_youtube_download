# total_vids = 10,727,607
# num_tasks = 1000 this should match number of tasks in job_webvid10m.json
# vids_per_task = 10,728

original_file=./webvid10m_train.csv
task_file=./webvid10m_train.txt
gsutil cp gs://youtube_download/webvid10m/webvid10m_train.csv $original_file # why is this so SLOW? 70MB/s
csvcut -c videoid,contentUrl $original_file | sed 1d > $task_file
gsutil cp $task_file gs://youtube_download/webvid10m/webvid10m_train.txt #uploading is 100MB/s

csv_dir=/home/ryanm/csv
mkdir -p $csv_dir

split -l 10728 --suffix-length=5 -d --additional-suffix=.txt $task_file $csv_dir/input_  
gsutil -m cp -r $csv_dir gs://youtube_download/webvid10m/csv