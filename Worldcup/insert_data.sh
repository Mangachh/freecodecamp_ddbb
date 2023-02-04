#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

RESULT_INSERT="INSERT 0 1"

# insert method 
INSERT_TEAM(){
  if [[ $1 ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1'")

    if [[ -z $TEAM_ID ]]
    then
      echo -e "\nID not found for $1. Inserting..."
      RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$1')")

      if [[ $RESULT = $RESULT_INSERT ]]
      then
        echo -e "$1 Inserted correctly\n"
      fi
    fi
  fi  
}



cat games.csv | while IFS=',' read YEAR ROUND WIN OPP W_GOALS O_GOALS
do
  # echo $WIN $OPP
  if [[ $WIN != "winner" ]]
  then
  # insert the teams
    INSERT_TEAM "$WIN"
    INSERT_TEAM "$OPP"

  # insert games
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WIN'")
  LOSER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")

  echo -e "\nInserting game between $WIN and $OPP"
  RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                             VALUES($YEAR, '$ROUND', $WINNER_ID, $LOSER_ID, $W_GOALS, $O_GOALS)")
  
  if [[ $RESULT == $RESULT_INSERT ]]
  then
    echo -e "Game inserted correctly"
  fi

  fi
done

