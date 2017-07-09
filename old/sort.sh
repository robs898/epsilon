#!/bin/bash
coins='/usr/share/nginx/html/coins.txt'
soaring='/home/rmackenzie8/epsilon/soaring'
sinking='/home/rmackenzie8/epsilon/sinking'
rm $coins
touch $coins
for coin in $(cat $soaring | sort | uniq); do
  echo "$coin,$(grep $coin $soaring | wc -l),$(grep $coin $sinking | wc -l)" >> $coins
done
for coin in $(cat $sinking | sort | uniq); do
  echo "$coin,0,$(grep $coin $sinking | wc -l)" >> $coins
done
