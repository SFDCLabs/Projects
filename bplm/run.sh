#!/bin/bash
main_menu() {
    case $1 in 
        CLEAR_DOCS)
            echo "inside clear docs"
            # rm -rf docs/*
            ;;

        DOCS)
            echo "inside docs"
            # java -jar lib/apex.jar -s "sfdx-src/main/default/classes" -t "docs/"
            ;;
        *)
            echo "inside default"
            help_menu
            ;;
    esac
}

help_menu() {
    echo "help"
}

main_menu $1
