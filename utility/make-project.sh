#!/bin/bash

make-cpp-project-directory() {
    local usage="make-cpp-project-directory -d [directory-name] -n [project-name] -c [compiler] -v [version] -l [\"lib1,lib2,lib3\"]"

    local directory=""
    local proj_name=""
    local compiler="g++"
    local cpp_version="20"
    local libs=()

    while getopts ":d:n:c:v:l:" opt; do
        case $opt in
            d) directory=$OPTARG ;;
            n) proj_name=$OPTARG ;;
            c) compiler=$OPTARG ;;
            v) cpp_version=$OPTARG ;;

            l)
                IFS=','
                for lib in $OPTARG; do
                    echo "appending ${lib// /}"
                    libs += ${lib// /}
                done
        esac
    done

    if [ -z "${directory}" ]; then
        echo "Must provide directory name."
        echo "${usage}"
        return
    fi

    if [ -z "${proj_name}" ]; then
        echo "Must provide project name."
        echo "${usage}"
        return
    fi

    mkdir -p "${directory}"
    cd "${directory}"

    local makefile_template="${HOME}/Templates/Makefile"
    if [[ ! -e "${makefile_template}" ]]; then
        echo "Makefile template does not exist."
        return
    fi

    cp "${makefile_template}" "Makefile"
    sed -i "s/!!\[compiler\]/${compiler}/g" "Makefile"
    sed -i "s/!!\[cpp_version\]/${cpp_version}/g" "Makefile"
    sed -i "s/!!\[libs\]/${libs}/g" "Makefile"
    sed -i "s/!!\[proj_name\]/${proj_name}/g" "Makefile"

    mkdir "include" "src" "assets"

    cd - > /dev/null
}
