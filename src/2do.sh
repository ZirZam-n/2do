#!/bin/bash

DATA_DIR=~/.2do
mkdir -p $DATA_DIR

PROG=`echo $0 | rev | cut -d'/' -f1 | rev`

function delete_todolist
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

function create_todolist
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

function show_todolist
{
  cd $DATA_DIR/$1
  clear
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
          show_todolist ${todos[$choice]}
        else
          case $choice in
            n)
              create_todolist
              ;;
            d*)
              delete_todolist ${choice:1}
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

function list_todolists
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
          show_todolist ${todos[$choice]}
        else
          case $choice in
            n)
              create_todolist
              ;;
            d*)
              delete_todolist ${choice:1}
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
    list_todolists
    exit 0
  fi

