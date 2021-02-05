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
