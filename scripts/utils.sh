#!/usr/bin/env bash

file_exists() {
  local filename=$1

  if [ -f $filename ]; then
    exit 0
  fi

  exit 1
}

directory_exists() {
  local dirname=$1

  if [ -d $dirname ]; then
    exit 0
  fi

  exit 1
}

while getopts ":f:d:" opt; do
  case "${opt}" in
    f)
      file_exists $OPTARG
      ;;

    d)
      directory_exists $OPTARG
      ;;
  esac
done
