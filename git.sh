set -e
push-tag() {
	local tag_name = $1
	git push origin $tag_name
}
delete-tag() {
	local tag_name = $1
	git push --delete origin $tag_name
}
setup() {
	git config --global user.name "David Liu"
	git config --global user.email "david-khala@hotmail.com"
	git config --global pull.rebase true
}
sync() {
	local upstreamBranch=$1
	git rebase $upstreamBranch $2
}

# Git clone or update
update-clone() {
	
	local reposURL=$1
	local branch=$2

	local projectName

	local dirname=${3:-$PWD}

	if [[ ${reposURL} == github* ]]; then
		update-clone "https://${reposURL}.git" $branch
	elif [[ ${reposURL} == https://* ]]; then
		projectName=$(echo ${reposURL} | cut -d '/' -f 5 | cut -d '.' -f 1)

	elif [[ ${reposURL} == git@* ]]; then
		echo ...using SSH
		projectName=$(echo ${reposURL} | cut -d '/' -f 2 | cut -d '.' -f 1)
	else
		echo "Invalid git repository URL: ${reposURL}"
		exit 1
	fi

	if [[ ! -d ${dirname}/${projectName} ]]; then
		git clone "$reposURL"
	fi
	cd "${dirname}/${projectName}"
	git pull
	if [[ -n $branch ]]; then
		git checkout $branch
	fi
	echo "${dirname}/${projectName}"
}
current-branch(){
	git rev-parse --abbrev-ref HEAD

}
set-remote(){
	local remote=${1:-origin}
 	local branch=$(current-branch) 
	git branch --set-upstream-to=$remote/$branch
}
$@
