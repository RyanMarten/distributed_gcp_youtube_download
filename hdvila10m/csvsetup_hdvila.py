# wget ~/data/https://hdvila.blob.core.windows.net/dataset/hdvila100m.zip
# unzip ~/data/hdvila100m.zip -d ~/data

import json
import jsonlines
from datetime import datetime
import random

'''
hdvila/hdvila_partX.jsonl where X is 0...10
Each line contains all the clips for that video
{   
    'video_id':'QMi8x8o55Ns',
    'url': 'https://www.youtube.com/watch?v=QMi8x8o55Ns',
    'clip': [
                {'clip_id': 'QMi8x8o55Ns.1.mp4', 'span': ['00:00:17.759', '00:00:23.279']}
                ...
                {'clip_id': 'QMi8x8o55Ns.16.mp4', 'span': ['00:04:52.140', '00:05:03.350']}
            ],
}
'''


# Take only 3 clips per video (which Make-A-Video paper did) * 3.1M videos =  total of 9.3M clips
# similar to acav20m, each fold will hold 10,000 videos


def time_to_sec(time):
    (h, m, s) = time.split(':')
    return int(h) * 3600 + int(m) * 60 + float(s)

csv_shard = open("/home/ryanm/data/hdvila/hdvila10m_clips.csv", "w")
for i in range(11):
    start = datetime.now()
    with open(f"/home/ryanm/data/hdvila/hdvila_part{i}.jsonl", "r") as f:
        for video in jsonlines.Reader(f):
            yt_id = video['video_id']
            clips = video['clip']
            if len(clips) > 3:
                clips = random.sample(clips, 3)

            for clip in clips:
                ts_start = time_to_sec(clip['span'][0])
                ts_end = time_to_sec(clip['span'][1])

                csv_shard.write(f'{yt_id}, {ts_start:.1f}, {ts_end:.1f}\n')

    end = datetime.now()
    print("part %d complete: elapsed time %s" % (i, end - start))