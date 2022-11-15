export HOME="/tmp" #https://www.gnu.org/software/parallel/man.html needs a $HOME defined
shard=$(printf "%05d\n"  $BATCH_TASK_INDEX)
echo "Processing batch index $BATCH_TASK_INDEX (shard $shard)"

# install dependencies
DEBIAN_FRONTEND=noninteractive
sudo apt-get -qq update
sudo apt-get -qq install -y parallel wget 

# videos, logs, input csvs
bucket=gs://youtube_download/webvid10m
log_file=download_$shard.txt
input_file=input_$shard.txt

# download input csv (id,url) and log file (if exists, resume)
gsutil cp $bucket/csv/$input_file ./$input_file
gsutil cp $bucket/log/$log_file ./$log_file

# (add gsutil -q for quiet), but the rate of "copying" is actually helpful logging, can look at total errors to see total number of videos downloaded
# time parallel --dry-run --bar -v --resume --joblog ./$log_file -a ./$input_file --colsep , -j $(nproc --all) 'echo {1} // {2} // {3}' ::: "$bucket/video/train"
time parallel --resume --joblog ./$log_file -a ./$input_file --colsep , -j $(nproc --all) 'wget -qO "./{1}.mp4" {2} && gsutil mv "./{1}.mp4" "{3}/{1}.mp4"' ::: "$bucket/video/train/$shard"

# upload log file 
gsutil cp ./$log_file $bucket/log/$log_file
echo "Completed batch index $BATCH_TASK_INDEX (shard $shard)"