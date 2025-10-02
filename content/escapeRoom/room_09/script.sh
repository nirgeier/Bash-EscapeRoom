#!/bin/bash

source /home/escape/escapeRooms/_utils.sh
###
### This script will test if the user solved the puzzle
###

# Function to calculate sum
function calculate_sum {

    # Start the sum variable
    sum=0
    # loop from 1 to the desired number
    for (( i=1; i<=$1; i++ ))
    do
        # Calculate the result
        sum=$((sum + i))
    done
    # Print out result
    echo $sum
}

# Test the function with random number
for i in {1..5}
do
    # Generate random number
    NUMBER=$(shuf -i 1-1000 -n 1)
    echo -e "Testing ${BYELLOW}escape $NUMBER${NO_COLOR}"

    # calculate usign user script
    SUM=$(escape $NUMBER)
    # calculated using our script
    EXPECTED=$(calculate_sum $NUMBER)

    # Verify if the results are equal
    if [ "$SUM" == "$EXPECTED" ] 
    then    
        echo -e "${GREEN}Passed [$SUM]${NO_COLOR}"
    else
        echo -e "${RED}Failed [$SUM]${NO_COLOR}"
        exit 1
    fi    
done

echo -e ""
echo -e ""
echo -e "${CYAN}--------------------------------------------------------------${NO_COLOR}"
echo -e "${CYAN}Well Done !!!${NO_COLOR}"
echo -e ""
echo -e "${GREEN}The password for the next room is: ${BYELLOW}linux${BGreen}is${BYELLOW}free${NO_COLOR}"
echo -e ""
echo -e ""
