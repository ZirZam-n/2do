#!/bin/bash

DATA_DIR=~/.2do
mkdir -p $DATA_DIR
cd $DATA_DIR

PROG=`echo $0 | rev | cut -d'/' -f1 | rev`

function delete_todo
{
  while true
    do
      printf "delete `pwd`/$*?(y/n) "
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
      printf "%d: %s\t\t%s\n" $todo "`cat ./$todo/state`" "`cat ./$todo/desc`"
    done
}

function switch_todo
{
  if [[ $# -ne 2 ]]
    then
      print_help short
      return 1
    fi
  
  if ![[ -d $2 ]]
    then
      print_help short
      return 1
    fi

  comm=${1,,}
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
      print_help short && return 1
      ;;
  esac
  
  echo $status > $2/state
  
}

function print_help
{
  if [[ $1 == "short" ]]
    then
      echo use '?' or 'h' command for help.
      return 0
    fi
cat <<EOF
  l: list todos
  n: create new todo
  d <id>: delete todo with id=<id>
  todo <id>: change status of todo <id> to \`TODO\`
  doint <id>: change status of todo <id> to \`DOING\`
  done <id>: change status of todo <id> to \`DONE\`
  q: quit
  [h|?]: show this help
EOF
}

function command_handler
{
  printf "> "
  read choice

  arg1=`echo $choice | awk '{print $1}'`
  arg2=`echo $choice | awk '{print $2}'`


  case $arg1 in
    l)
      list_todos
      ;;
    n)
      create_todo
      ;;
    d)
      delete_todo $arg2
      ;;
    q)
      exit 0
      ;;
    h)
      print_help
      ;;
    \?)
      print_help
      ;;
    *)
      switch_todo $arg1 $arg2
      ;;
  esac
}

test $# -eq 1 && test $1 == "-l" && ls && exit
(test $# -eq 1 && PROJECT=$1) || PROJECT=default

echo PROJECT: $PROJECT
mkdir -p $PROJECT
cd $PROJECT

test -f lastid || echo 0 > lastid

while true
  do
    command_handler
  done

