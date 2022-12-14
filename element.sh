#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

IS_NUMBER() {
  # get data
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
  if [[ -z $DATA ]]
  then
    echo "I could not find that element in the database."
  else
    # display the data
    echo "$DATA" | while read TID BAR ANUMBER BAR SYMBOL BAR NAME BAR AMASS BAR MPOINT BAR BPOINT BAR TYPE
    do
      echo "The element with atomic number $ANUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MPOINT celsius and a boiling point of $BPOINT celsius."
    done
  fi
}

IS_STRING() {
    # get data
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'")
  if [[ -z $DATA ]]
  then
    echo "I could not find that element in the database."
  else
    # display the data
    echo "$DATA" | while read TID BAR ANUMBER BAR SYMBOL BAR NAME BAR AMASS BAR MPOINT BAR BPOINT BAR TYPE
    do
      echo "The element with atomic number $ANUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MPOINT celsius and a boiling point of $BPOINT celsius."
    done
  fi
}

# argument conditional
if [[ "$1" =~ ^[0-9]+$ ]]
then
  IS_NUMBER "$1"
elif [[ "$1" =~ ^[A-Za-z]+$ ]]
then
  IS_STRING "$1"
else
  echo Please provide an element as an argument.
fi