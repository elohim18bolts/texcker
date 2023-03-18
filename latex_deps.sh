#!/usr/bin/env sh


pkgs=(
    "tabularray"
    "ninecolors"
    "multirow"
    "xcolor"
    "soul"
    "textpos"
)

mirrors=(
	"https://mirrors.ctan.org/macros/latex/contrib"
	"https://mirrors.ctan.org/macros/generic"
)

apt update;
apt install texlive-latex-recommended ca-certificates curl unzip --no-install-recommends -y;

tex_mf_home=$(kpsewhich -var-value=TEXMFHOME)

#create package directory
pkg_dir=${tex_mf_home}/tex/latex
mkdir -p $pkg_dir

#Install latex dependencies
for pkg in ${pkgs[@]}
do
	if [[ ! -z $(find / -iname ${pkg}.sty) ]]
	then
		echo "$pkg found. Skipping..."
		continue;
	fi
	for mirror in ${mirrors[@]}
	do
		echo "Searching in mirror: ${mirror}/${pkg}.zip"
		#Get pkg status
		pkg_status=$(curl ${mirror}/${pkg}.zip -L --head | grep 200 | wc -l)
		if [[ $pkg_status -eq 1 ]]
		then
			echo "Downloading $pkg from $mirror"
			[[ ! -d ${pkg_dir}/${pkg} ]] && curl -L ${mirror}/${pkg}.zip --output  /tmp/${pkg}.zip && \
		     unzip /tmp/${pkg}.zip -d ${pkg_dir}/
			break
	        else
			     echo "Package ${pkg} not found"
		fi
        done
     #Check if there is the .sty file; if not file found, compile it(using the command tex file.ins
     work_dir=$(pwd)
     [[ ! -f ${pkg_dir}/${pkg}/${pkg}.sty ]] && cd ${pkg_dir}/${pkg}/ && tex ${pkg}.ins
     cd $work_dir
done
