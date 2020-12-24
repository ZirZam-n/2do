#!/bin/bash

BIN_DIR=/usr/local/bin
BIN_PATH=$BIN_DIR/2do
SOURCE_DIR=./src
SOURCE_PATH=$SOURCE_DIR/2do.sh
PROG=`echo $0 | rev | cut -d'/' -f1 | rev`

should_ask=0

function ask
{
  printf "$*"
  if [[ $should_ask -eq 1 ]]
    then
      printf "?"
      read s
    else
      echo ""
    fi
}

function check_args
{
  arg=$1
  shift
  for var in "$@"
    do
      if [[ $var == $arg ]]
        then
          return 1
        fi
    done
  return 0
}

function print_help
{
  cat <<EOF
usage:  $PROG <OPTIONS>
  OPTIONS:
    -y    dont wait for response to questions
    -u    uninstall Ternote
    -h    print this help and exit
EOF
}

function install
{
  ask "add execute permission to 2do"
  chmod +x $SOURCE_PATH
  
  ask "copy 2do to $BIN_DIR"
  sudo cp $SOURCE_PATH $BIN_PATH

  ask "done"
}

function uninstall
{
  ask "remove $BIN_PATH"
  sudo rm $BIN_PATH

  ask done
}

check_args "-h" "$@"
if [[ $? -eq 1 ]]
  then
    print_help
    exit 0
  fi

check_args "-y" "$@"
if [[ $? -eq 0 ]]
  then
    echo "after each question, if you agree just press [ENTER],"
    echo "  otherwise press [Ctrl]+c to exit"
    echo "  also you can add \`-y\` arg to avoid asking"
    echo
    should_ask=1
  fi

check_args "-u" "$@"
if [[ $? -eq 1 ]]
  then
    uninstall
  else
    install
  fi

