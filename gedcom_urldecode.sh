#!/bin/bash


#Internal Field Separator (evita que espaços sejam usados como delimitadores e por isso evita dois ou mais espaços sejam unidos em um só) 
IFS=''

newEXT="urldecoded"

cat /dev/null >  $1.$newEXT
cat $1 | while read line 
do
	./urldecode.sh $line >> $1.$newEXT
done

echo "Finalizado..."