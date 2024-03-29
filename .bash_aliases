#work related
function _pg_container() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local container_names="$(docker inspect --format '{{.Name}}' $(docker ps -q) | sed 's/\///g')"
  COMPREPLY=( $(compgen -W "${container_names}" -- $cur ) )
}
function pg_container() {
  local container_name=$1
  local database=${2:-}
  local user=${3:-postgres}
  local password=${4:-123456}

  docker run -it --link ${container_name}:currentpg postgres:9 psql postgres://${user}:${password}@currentpg/${database}
}
complete -F _pg_container pg_container

alias nuke-docker="docker ps -aq | xargs -r docker rm -f && docker volume prune -f"
alias nuke-node='ps -aux | awk '\''{if ($11 ~ /node/){print $2}}'\'' | xargs -n1 kill'
alias nuke-branches="git fetch --prune; git branch -r | awk '{ print $1 }' | egrep -v -f /dev/fd/0 <(git branch | awk '{ print substr($0, 2) }') | xargs git branch -d"

#QOL related
function commitpush() {
  local message="$1"
  git commit -m "$message"
  git push origin "$(git branch 2> /dev/null | awk '{ if ($0 ~ /\*/) { print $2 } }')"
}

alias fix-display="DISPLAY=:0.0 xrandr --output DP-0 --rotate left"
