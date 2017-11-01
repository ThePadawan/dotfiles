alias gp='git push'
alias unlock='exec ssh-agent bash --rcfile <(echo ". ~/.bashrc; eval ssh-agent -s; ssh-add ~/.ssh/id_rsa")'
function gitall {
  if [[ -z $1 ]]; then
    echo "You must specify a dictionary pattern."
    return
  fi
  ls -d $1 | xargs -P10 -I{} git -C {} pull --rebase
}
