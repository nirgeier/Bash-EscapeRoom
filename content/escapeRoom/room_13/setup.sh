#!/bin/bash
# Creates a chain of symlinks: start.link -> link_a -> link_b -> link_c -> treasure.txt
echo "link42" > treasure.txt
ln -s treasure.txt link_c
ln -s link_c link_b
ln -s link_b link_a
ln -s link_a start.link
