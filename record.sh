#!/bin/bash

cd ~/temp

if [[ -e .recording.pid ]]; then
	notify-send --expire-time=500 "analyzing recording"
	kill `cat .recording.pid`
	rm .recording.pid
	ruby ./speech_api.rb ./.recording.wav
	read output <<< `ruby ./parse.rb`
	ruby ./analyzer.rb "$output"
else
	notify-send -u low --expire-time=500 "started recording"
	if [[ -e ./.recording.wav ]]; then
		rm ./.recording.wav
	fi 
	rec --encoding signed-integer -q --bits 16 --channels 1 --rate 16000 ./.recording.wav &
	recording_pid=$!
	echo $recording_pid > .recording.pid	
fi
