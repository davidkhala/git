create-from-commit(){
  local commit_sha=$1 # list commit_sha by `git log`
  git format-patch -1 $1
}

$@
