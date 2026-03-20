# my standard config
git config --global pull.rebase true

git config --global user.name "David Liu"
git config --global user.email david-khala@hotmail.com

ignore(){
  git config --global core.excludesfile $1 
}

$@
