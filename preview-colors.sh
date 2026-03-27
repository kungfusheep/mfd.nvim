#!/bin/bash
for i in {0..15}; do
  printf "\e[48;5;${i}m  %2d  \e[0m " "$i"
  if [ "$i" = 7 ]; then echo; fi
done
echo
