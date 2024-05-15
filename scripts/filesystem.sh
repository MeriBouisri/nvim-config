#!/usr/bin/env bash

echo "Calling utils.sh from lua"

file_exists() {
  local filename=$1

  if [ -f $filename ]; then
    exit 0
  fi

  exit 1
}

dir_exists() {
  local dirname=$1

  if [ -d $dirname ]; then
    exit 0
  fi

  exit 1
}

create_dir() {
	mkdir $1
	exit $?
}

create_file() {
	touch $1
	exit $?	
}

if declare -f "$1" > /dev/null
then
	[[ "$1" = _* ]] && exit 1
	"$@"
else
	echo "[scripts/filesystem.sh] ERROR : '$1' is not a known function name" >&2
	exit 1
fi


