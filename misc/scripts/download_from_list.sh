#!/bin/bash

# Read each line from ./mylist.txt and download using yt-dlp
while IFS= read -r url || [[ -n $url ]]; do
	yt-dlp \
		-N "9" \
		--buffer-size "256K" \
		--no-resize-buffer \
		--merge-output-format mkv \
		--restrict-filenames \
		--no-mtime \
		--add-metadata \
		--parse-metadata "uploader:^(?P<uploader>.*?)(?:(?= - Topic)|$)" \
		--parse-metadata "%(uploader,channel,creator,artist|null)s:%(uploader)s" \
		--parse-metadata "playlist_index:%(track_number)s" \
		--parse-metadata "playlist_index/%(n_entries)s: %(playlist_index)s/%(n_entries)s" \
		-S "+acodec:opus,asr,abr" \
		-f "ba[acodec=opus]/bestaudio[acodec=opus]/bestaudio/best" \
		-o "%(title)s__.%(ext)s" \
		"$url"
done < ./mylist.txt
