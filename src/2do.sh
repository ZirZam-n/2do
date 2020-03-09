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
  id=`cat lastid`

  printf "Todo description: "
  read description

  mkdir $id
  echo $description > $id/desc
  echo TODO > $id/state

  echo `expr $id + 1` > lastid
}

function list_todos
{

  todos=(`(ls -d */ 2> /dev/null) | cut -d'/' -f1`)
  echo List of todos
  for todo in ${todos[@]}
    do
      echo $todo: `cat ./$todo/state` `cat ./$todo/desc`
    done
}

function switch_todo
{
  test $# -eq 2 || echo Invalid command! && return 1
  test -d $2 || echo No such todo! && return 1

  comm=${$1,,}
  case $comm in
    "todo")
      status=TODO
      ;;
    "doing")
      status=DOING
      ;;
    "done")
      status=DONE
      ;;
    *)
      echo Invalid command! && return 1
      ;;
  esac
  
}

function command_handler
{
  printf "> "
  read choice

  case $choice in
    l)
      list_todos
      ;;
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
      switch_todo $choice
      ;;
  esac
}

while true
  do
    command_handler
  done

