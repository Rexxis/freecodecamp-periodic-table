#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

IS_NUMBER() {
  echo $1 is a number
}

IS_STRING() {
  echo $1 is a string
}

if [[ "$1" =~ ^[0-9]+$ ]]; then
  IS_NUMBER "$1" >&2
else
  IS_STRING "$1" >&2
fi