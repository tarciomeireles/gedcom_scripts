#!/bin/bash


#Corrige o problema apresentadao em: https://github.com/fisharebest/webtrees/issues/794
# [PADRAO DE GEDCOM DO MYHERITAGE, MAS FORA DO PADRÃO GEDCOM]
# 1 NAME Jane /Black/
# 2 _MARNM White
#
# [PADRAO GEDCOM]
# 1 NAME Jane /Black/
# 1 NAME Jane /White/
# 2 TYPE married




newEXT="WithMarriedName"



#Internal Field Separator (evita que espaços sejam usados como delimitadores e por isso evita dois ou mais espaços sejam unidos em um só) 
IFS=''

i=1
iTagsModificadas=0
dti=$(date)
TotalOriginal=$(wc -l $1 | cut -f1 -d" ")
echo "Tamanho do Arquivo Original $1: $TotalOriginal"
cat /dev/null >  $1.$newEXT
cat $1 | while read line 
do
  
   TMPGIVN=$(echo $line | grep "2 GIVN " | sed -n -e 's/^.*GIVN //p')
   if [ ${#TMPGIVN} -ne 0 ]
	then
		GIVN=$TMPGIVN
	fi
   TMPMARNM=$(echo $line | grep "2 _MARNM " | sed -n -e 's/^.*_MARNM //p')
   if [ ${#TMPMARNM} -ne 0 ]
	then
		MARNM=$TMPMARNM
	fi
  
	if [ ${#MARNM} -ne 0 ]
		then
			echo "ENCONTRADA TAG _MARNM: GIVN:$GIVN | _MARNM:$MARNM"
			NEWLINE=$(echo "1 NAME $GIVN /$MARNM/")
			echo "MODIFICANDO: '$line' ->  '$NEWLINE'"
			echo -e "$NEWLINE\r" >> $1.$newEXT
			echo -e "2 TYPE married\r" >> $1.$newEXT
			#limpando variaveis
			GIVN=""
			MARNM=""
			NEWLINE=""
			let iTagsModificadas=iTagsModificadas+1
		else
			echo $line >> $1.$newEXT
	fi
	
	echo "LINHA:$i/$TotalOriginal MODIFICADAS: $iTagsModificadas"
	let i=i+1

done

dtf=$(date)

echo "Tamanho do Arquivo Original $1: $TotalOriginal"
TotalNewFile=$(wc -l $1.$newEXT | cut -f1 -d" ")
echo "Tamanho do Novo Arquivo $1.$newEXT: $TotalNewFile, Registros Modificados: $iTagsModificadas "
echo "Tempo de duracao: $dti $dtf"