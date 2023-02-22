#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t --csv -c"
#order:
# atomic_num, name, symbol, type, mass, melting, boiling
PRINT_INFO(){
  ATOMIC_NUM=$1
  NAME=$2
  SYMBOL=$3
  TYPE=$4
  MASS=$5
  MELTING=$6
  BOILING=$7

  echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
}

CHECK_ARGUMENT(){
  ELEMENT=""

  if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then 
    #echo "It's a element symbol"  
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol ILIKE '$1'")          
  elif [[ $1 =~ ^[0-9]*$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1")
    #echo "It's an element number"
  else
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE name ILIKE '$1'")    
    #echo "It's a name"
  fi

  #echo -e "element:\n$ELEMENT"
  if [[ $ELEMENT ]]
    then
      echo $ELEMENT | while IFS=',' read ATOMIC_NUM SYMBOL NAME
      do
        # search for prperties
        PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, t.type 
                            FROM properties 
                            JOIN types t USING(type_id)
                            WHERE atomic_number = $ATOMIC_NUM")
        echo $PROPERTIES | while IFS=',' read AT_MASS MELTING BOILING TYPE
        do
        #order:
        # atomic_num, name, symbol, type, mass, melting, boiling
          PRINT_INFO $ATOMIC_NUM $NAME $SYMBOL $TYPE $AT_MASS $MELTING $BOILING
        done
      done
    else
      echo "I could not find that element in the database."
  fi
}




# if no argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  CHECK_ARGUMENT $1
fi