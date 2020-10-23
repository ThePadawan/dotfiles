alias unlock='exec ssh-agent bash --rcfile <(echo ". ~/.bashrc; eval ssh-agent -s; ssh-add ~/.ssh/id_rsa")'

function tomp3 {
  if [[ -z $1 ]]; then
    echo "You must specify a file to convert."
    return
  fi

  FIN=$1
  FOUT=${FIN%.*}.mp3

  ffmpeg -i "$FIN" -codec:a libmp3lame -qscale:a 0 "$FOUT"
}
