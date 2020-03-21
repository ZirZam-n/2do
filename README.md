# 2do
Create and mange todo lists in terminal

This script is based on bash and I've written it in Ubuntu. But I think it can be used in any Linux distro!

## Requirements
There isn't any complex requirement to run it; Just some simple commands like `awk`, `cut`, etc.


## Install
Follow these steps to install and use 2do:

* Clone the project and `cd` into its root folder.

* Add execute permission to setup.sh file.

```
chmod +x setup.sh
```

* Then run setup script. You can use `-h` flag to see help or use `-y` flag to avoid answering script questions. A command in this script needs sudo permission, so run this script as root or enter sudo password whenever it's asked!
```
./setup.sh
```

* Now you can run this app anywhere in terminal with the `2do` command.

## Usage
First of all, remind that there's a concept "Project". Don't panic! It's just a nickname for "TO-DO List".

As you can see with `2do -h`, here's the details about running 2do:
```
Usage: 2do <project>      open list of project <project> todos
       2do -l             list all available projects
           --list
       2do --drop-lists   remove all the projects and todo items
       2do -h             print this help and exit
           --help
```

Also after running this is program by issuing `2do your_project_name`, it may be a little complicated to add and edit to-do items. In this case, you may issue '?' or 'h' command in the program to print a minimal help.
```
  l: list todos
  n: create new todo
  d <id>: delete todo with id=<id>
  todo <id>: change status of todo <id> to `TODO`
  doing <id>: change status of todo <id> to `DOING`
  done <id>: change status of todo <id> to `DONE`
  q: quit
  [h|?]: show this help
```

## Uninstall
As simple as you installed 2do, you can uninstall it. Just run:
```
./setup.sh -u
```

## Contribution
We want this script to be as minimal as possible! But create an issue in the case you think a useful feature can be added to this script!

