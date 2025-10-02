#/bin/bash

################################################################
# Util section to print in colors.                             #
# This is not part of the  main script, but it's used by it    #
# to print messages in colors, you can skip this part          #
# Get the pwd of the this script                               #
source ../_utils.sh                                            #
################################################################

#
# The creature is hungry
#
if [ ! -f ./food ];
then
  echo -e ""
  echo -e "${BRed}  No No! I am hungry,                            ${NO_COLOR}"
  echo -e "${BRed}  I Dont see any ${BGreen}food${NO_COLOR} ${YELLOW}files around!${NO_COLOR}"
  echo -e "${BRed}  Give me        ${BGreen}food${NO_COLOR} ${YELLOW}please!${NO_COLOR}"
  echo -e ""
  exit 1
fi

#
# He is still hungry
#
group=$(stat -c "%G" food)
if  [ "$group" != "vegan" ];
then
  echo -e ""
  echo -e "${BRed}  Oh No, I forgot to mention that i only eat                           ${NO_COLOR}"
  echo -e "${BRed}  ${BGreen}vegan group${NO_COLOR} ${BRed}food${NO_COLOR}, ${BRed}give me ${BGreen}food${NO_COLOR} ${YELLOW}please!${NO_COLOR}"
  echo -e ""
  exit 1
fi

# Calculate the key to the chest 
key=1
 
for i in {1..36..3}
do 
  b=$(( 2 * key + i  ))
  key=$((key + b))
done

cowsay "MOO MOO MOO ...
 The password to open the chest is $(echo -e ${BRed}$key${NO_COLOR})     "

echo -e ""
echo -e ""
echo -e "${BYELLOW}Linux Usage Statistics (2024) ${NO_COLOR}"
echo -e "${BYELLOW}-----------------------------${NO_COLOR}"
echo -e "- The Linux market share on desktop is less that ${BGreen}2%${NO_COLOR}"
echo -e "${BYELLOW}- ${BGreen}96.3%${NO_COLOR} of the world's top 1 million servers run on Linux${NO_COLOR}"
echo -e "${BYELLOW}- ${BGreen}90%  ${NO_COLOR} of Hollywood's special effects are made on Linux${NO_COLOR}"
echo -e "${BYELLOW}- ${BGreen}90%  ${NO_COLOR} of the public cloud workload runs on Linux${NO_COLOR}"
echo -e "${BYELLOW}- ${BGreen}83.1%${NO_COLOR} of developers claim that they prefer to work on Linux as opposed to other operating systems${NO_COLOR}"
echo -e ""
echo -e ""


