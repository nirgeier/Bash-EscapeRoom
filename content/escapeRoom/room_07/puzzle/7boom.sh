
#!/bin/bash

### Here is a sample of 7 boom in bash scripting

# Counter for the boom numbers
boomNumbers=0

### Loop over the range of 1 to 1000
for i in {1..1000}
do
# Check if the number is divided by 7 or if the digit 7 is part of the number 
if (( i % 7 == 0 )) || [[ $i == *7* ]]
    then
        # Increment counter
        let COUNTER++
fi
done

# The result should be 374
echo "Total number of boom numbers between 1 to 1000 are: [$COUNTER]"

