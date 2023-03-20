
# Table of Contents

1.  [Texcker](#org72323c8)
    1.  [Adding A Package To The Image](#org18bb713)
    2.  [Running The Docker Image](#org943f425)



<a id="org72323c8"></a>

# Texcker

![img](./bitmap.png)

This is a latex container that is build from the ground up with a user specific packages. This packages are hand picked by the user thus reducing the image bundle size and the overall storage consumption.

The default repos that the script will look for the packages are:

    mirrors=(
    	"https://mirrors.ctan.org/macros/latex/contrib"
    	"https://mirrors.ctan.org/macros/generic"
    )

The user can change this mirrors addresses or even include another ones.


<a id="org18bb713"></a>

## Adding A Package To The Image

To add packages to the image the user has to add the package name to the `pkgs` array in the `latex_deps.sh` script.

    #List of packages that the user wants to be present in the image
    pkgs=(
        "tabularray"
        "ninecolors"
        "multirow"
        "xcolor"
        "soul"
        "textpos"
    )

*Note:* Be sure that the packages are available in one or more of the mirrors. In case a package can not be found the script will continue without installing  set package.

Run the command: `docker build . -t [your_image_name]`

This will create a custom latex image with the required dependencies.


<a id="org943f425"></a>

## Running The Docker Image

Once the image is built(or pull from dockerhub) mount a host path volume to where the files are going to be compiled. The image will automatically run and compile all the necesary files.

    docker container run --name [container_name] --rm --volume /your/latex/files/path:/app [image_name]

Happy coding!!!

