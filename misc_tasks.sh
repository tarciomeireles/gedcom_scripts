#!/bin/bash


#Custom URL decode

#sed -i 's/OLD/NEW/g' $1
sed -i 's/%3A/\:/g' $1
sed -i 's/%2F/\//g' $1
sed -i 's/%C3%B3/ó/g' $1
sed -i 's/%2D/-/g' $1
sed -i 's/%2E/./g' $1
sed -i 's/%2C/,/g' $1



