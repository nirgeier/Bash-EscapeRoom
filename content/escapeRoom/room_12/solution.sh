echo addresses.txt   | \
  xargs head -n 1000  | \
  cut -d, -f5 | \
  xargs printf "%s+" | \
  sed 's/.$//' | \
  xargs -I {}  | \
  bc


