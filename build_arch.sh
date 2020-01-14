#!/bin/bash

is_project_root(){
    folder_content='';
    folder_content=`ls *.yaml`;
    if [ $folder_content == '' ]; then
        echo "it is not"
    else
        echo "it is root of the project"
    fi;
}

is_project_root