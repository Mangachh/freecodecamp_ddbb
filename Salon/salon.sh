#!/bin/bash

PSQL="psql -X -U freecodecamp -d salon --tuples-only --csv -c"

# menu for service
SERVICE_MENU(){

  # if argument, print
  if [[ $1 ]]; then echo -e "\n$1"; fi

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  # show services
  echo "$SERVICES" | while IFS=',' read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done 

  # read input
  read SERVICE_ID_SELECTED

  # check if not number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    SERVICE_MENU "Please input the number of the service. What would you like today?"
  else
    # number, look for a name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    
    if [[ -z $SERVICE_NAME ]]
    then
      #no name, repeat
      SERVICE_MENU "I could not find that service. What would you like today?"
    else 
      CUSTOMER_MENU "$SERVICE_ID_SELECTED" "$SERVICE_NAME"
    fi  
  fi
}

CUSTOMER_MENU(){
  SERVICE_ID=$1
  SERVICE_NAME=$2
  echo -e "\nWhat's your phone number?"

  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  # put time
  echo -e "\nWhat time would you like your $SERVICE_NAME"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name LIKE '$CUSTOMER_NAME'")  
  INSERT_APPOINTMENT_RES=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  
}

echo -e "\n~~~~ Salon Pepotes ~~~~\n" 
SERVICE_MENU "Welcome to Pepotes, how can I help you?"