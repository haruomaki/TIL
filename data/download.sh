#!/usr/bin/env bash

INPUT="μ's Memorial CD-BOX「Complete BEST BOX」.csv"
OUTDIR="/mnt/c/Users/alex/Music/μ's Memorial CD-BOX「Complete BEST BOX」"

mkdir -p "$OUTDIR"

tail -n +2 "$INPUT" | while IFS=',' read -r index disc title artist url llfans; do
    echo "■■■■■■ ダウンロード $title ■■■■■■"
    yt-dlp \
        -f "bestaudio[ext=m4a]" \
        --embed-thumbnail \
        --embed-metadata \
        -o "$OUTDIR/$index.%(ext)s" \
        "$url"
    # yt-dlp \
    #     -f "bestaudio[ext=m4a]" \
    #     --embed-thumbnail \
    #     --add-metadata \
    #     # --metadata "title=$title" \
    #     --metadata "artist=$artist" \
    #     # --metadata "album_artist=μs" \
    #     # --metadata "tracknumber=$index" \
    #     # --metadata "album=\"μ's Memorial CD-BOX「Complete BEST BOX」\"" \
    #     -o "$OUTDIR/$index.%(ext)s" \
    #     "$url"

done
