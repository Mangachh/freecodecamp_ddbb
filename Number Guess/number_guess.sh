#!/bin/bash

PSQL="psql -U freecodecamp -d number_guess -t --csv -c"
GENERATED=$(( $RANDOM % 1000 + 1 ))

echo "Enter your username: " 
read USERNAME

# check username in the database
USER_ID=$($PSQL "SELECT user_id FROM users WHERE name LIKE '$USERNAME' ")

if [[ $USER_ID ]]
then
  
  NUM_GAMES=$($PSQL "SELECT COUNT(*) FROM scores WHERE user_id = $USER_ID GROUP BY user_id")
  BEST_GAME=$($PSQL "SELECT MIN(score) FROM scores WHERE user_id = $USER_ID GROUP BY user_id")
  # echo The user exist
  echo "Welcome back, $USERNAME! You have played $NUM_GAMES games, and your best game took $BEST_GAME guesses."
else
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # insert
  INSERT_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
  echo -e "\n$INSERT_RESULT"
  # get the id 
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name LIKE '$USERNAME' ")
  
fi
# if exist
#else
  # 


echo $GENERATED
echo "Guess the secret number between 1 and 1000:"
read GUESS
ATTEMPS=1


#while guess != number:
while [[ $GUESS -ne $GENERATED ]]
do
  # if guess > 5:
  if [[ ! $GUESS =~ ^[0-9]*$ ]]
  then
    echo "That is not an integer, guess again:"
    read GUESS
  elif [[ $GUESS -gt $GENERATED ]]
    then
    echo "It's lower than that, guess again:" 
    read GUESS
  else
    echo "It's higher than that, guess again:"
    read GUESS
  fi
    
  ATTEMPS=$(( $ATTEMPS + 1 ))
done

# insert attemps
INSERT_ATT_RESULT=$($PSQL "INSERT INTO scores(user_id, score) VALUES($USER_ID, $ATTEMPS)")
echo "You guessed it in $ATTEMPS tries. The secret number was $GENERATED. Nice job!"


