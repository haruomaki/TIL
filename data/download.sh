#!/usr/bin/env bash

INPUT="μ's Memorial CD-BOX「Complete BEST BOX」.csv"
OUTDIR="/mnt/c/Users/alex/Music/μ's Memorial CD-BOX「Complete BEST BOX」"

mkdir -p "$OUTDIR"

tail -n +2 "$INPUT" | while IFS=',' read -r index disc title artist date url llfans; do
    echo "■■■■■■ ダウンロード $title ■■■■■■"
    yt-dlp \
        -f "bestaudio[ext=m4a]" \
        --embed-thumbnail \
        --embed-metadata \
        --postprocessor-args "ffmpeg:
            -metadata album_artist=\"μ's\"
            -metadata track=$index/118
            -metadata disc=$disc/13
            -metadata date=$date
        " \
        -o "$OUTDIR/$index %(title)s.%(ext)s" \
        "$url"
done
