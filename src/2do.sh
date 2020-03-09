#!/bin/bash

DATA_DIR=~/.2do
mkdir -p $DATA_DIR
cd $DATA_DIR

test -f lastid || echo 0 > lastid

PROG=`echo $0 | rev | cut -d'/' -f1 | rev`

function delete_todo
{
  while true
    do
      print "delete `pwd`/$*?(y/n)"
      read choice
      if [[ $choice == "y" ]]
        then
          rm -rf "$*"
          break
      elif [[ $choice == "n" ]]
        then
          break
        fi
    done
}

function create_todo
{
  clear
  id=`cat lastid`

  printf "Todo description: "
  read title

  mkdir $id
  echo $description > $id/desc
  echo TODO > $id/state
  show_todo $title

  echo `expr $id + 1` > lastid
}

function list_todos
{
  while true
    do
      clear
      todos=(`ls -d */ | cut -d'/' -f1`)

      for todo in ${todos[@]}
        do
          echo $todo: `cat ./$todo/status` `cat ./$todo/desc`
        done
    done
}

function switch_todo
{
  if [[ $# -ne 2 ]]
    then
      echo Invalid command!
    fi
  
}

function command_handler
{
  printf "> "
  read choice

  test $choice -eq $choice 2> /dev/null
  if [ $? -eq 0 ]
    then
      switch_todo $choice
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
        help)
          print_help
          ;;
        *)
          echo Invalid command!
          ;;
      esac
    fi
}

if [[ $# == 0 ]]
  then
    list_todos
    exit 0
  fi

