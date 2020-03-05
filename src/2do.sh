#!/bin/bash

DATA_DIR=~/.2do
mkdir -p $DATA_DIR

PROG=`echo $0 | rev | cut -d'/' -f1 | rev`

function delete_todo
  {
    cd $DATA_DIR
    while true
      do
        print "delete `pwd`/$@?(y/n)"
        read choice
        if [[ $choice == "y" ]]
          then
            rm -rf $@
            break
        elif [[ $choice == "n" ]]
          then
            break
          fi
        rm -rf $@
      done
  }

function create_todo
  {
    cd $DATA_DIR
    clear
    while true
      do
        printf "Todolist title: "
        read title
        mkdir $title
        if [[ $? == 0 ]]
          then
            show_todo $title
            break
          fi
        clear
        echo Error: could not create $title todo list! try again.
      done
  }

function list_todos
  {
    cd $DATA_DIR
    while true
      do
        clear
        todos=(`ls`)
        todos_count=${#todos[@]}

        for((i=0;i<todos_count;i++))
          do
            echo $i: ${todos[$i]}
          done

        read choice

        if [ $choice -eq $choice -a $choice -lt $todos_count -a $choice -ge 0 ]
          then
            show_todo ${todos[$choice]}
          else
            case $choice in
              n)
                create_todo
                ;;
              d*)
                delete_todo ${choice:1}
                ;;
              q)
                exit 0
                ;;
              *)
                continue
                ;;
            esac
          fi
        break
      done
  }

if [[ $# == 0 ]]
  then
    list_todos
    exit 0
  fi

