#!/bin/bash

DEBUG_FILE=~/DEBUG_FILE_HERE

rm $DEBUG_FILE

while true
do
  nice -n 20 ./vuln_fast "PAYLOAD STRING HERE"
done
