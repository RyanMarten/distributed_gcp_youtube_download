# total_vids = 9_690_805
# num_tasks = 969 this should match number of tasks in job_hdvila10m.json
# vids_per_task = 10_0000
meta_dir=/home/ryanm/data/hdvila/csv
task_file=/home/ryanm/data/hdvila/hdvila10m_clips.csv
mkdir -p $meta_dir
split -l 10000 --suffix-length=5 -d --additional-suffix=.csv $task_file $meta_dir/input_  