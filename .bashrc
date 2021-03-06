# Start SSH Agent on boot
if [ -f ~/.agent.env ] ; then
    . ~/.agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning new agent… "
        eval `ssh-agent | tee ~/.agent.env`
        ssh-add
    fi 
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.agent.env`
    ssh-add
fi

function tomp3 {
  ARR=("$@")

  for FIN in "${ARR[@]}";
    do
  	  FOUT=${FIN%.*}.mp3
      ffmpeg -i "$FIN" -codec:a libmp3lame -qscale:a 0 "$FOUT"
    done
}

function thumbify {
  ffmpeg -i "$1" -r 0.06 -vf scale=-1:240 -vf drawtext="fontsize=60:fontcolor=yellow:text='timestamp: %{pts \: hms}': fontcolor=white: box=1: x=(w-tw)/2: y=h-(2*lh): boxcolor=0x00000000@1" -vcodec png "%d.png"
}

function combine60fps {
  IN_PATTERN=${1-%04d.png}
  ffmpeg -framerate 60 -i "$IN_PATTERN" -c:v libx264 -pix_fmt yuv420p out.mp4
}

function psd2png {
  FOUT=${1%.*}.png
  magick convert "$1[0]" $FOUT
}

function ytmp3 {
	youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 "$1"
}
