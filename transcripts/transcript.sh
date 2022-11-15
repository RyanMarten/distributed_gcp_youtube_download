# skip donwload skips the video
yt-dlp --list-subs https://www.youtube.com/watch?v=Ye8mB6VsUHw 

# write english (if you want only english non-translated do en-en not n*)
yt-dlp --write-sub --sub-lang en*,EN* --sub-format vtt --skip-download https://www.youtube.com/watch?v=Ye8mB6VsUHw 

# Specify automatic subs
yt-dlp --write-sub --write-auto-subs  --sub-lang en*,EN* --sub-format vtt --skip-download -o "%(id)s.%(ext)s" https://www.youtube.com/watch?v=Ye8mB6VsUHw 

# write just info.json
yt-dlp --skip-download  --write-info-json -o "%(id)s.%(ext)s" https://www.youtube.com/watch?v=Ye8mB6VsUHw 

# download corresponiding video
yt-dlp -f "best[height=1080][ext=mp4]/best[ext=mp4]/best"  -o "%(id)s_%(section_start)06d_%(section_end)06d.%(ext)s" --download-sections "*10-20" --force-keyframes-at-cuts  https://www.youtube.com/watch?v=Ye8mB6VsUHw 