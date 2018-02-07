#!/bin/bash

hour=`/bin/date +%H`
minute=`/bin/date +%M`
bpoAppVersion=`curl -s https://app.bitpool.com/\#\/login?\pane=organisation | grep bpoAppVersion | cut -d '"' -f 2`

multtime=$(($hour * $minute))

echo bpoAppVersion\ = $bpoAppVersion
echo Время\ = $hour:$minute

if (($bpoAppVersion < $multtime))
then
	echo Вывод\ $bpoAppVersion\ '<'\ $multtime
 
elif (($bpoAppVersion > $multtime))
then
	echo Вывод\ $bpoAppVersion\ '>'\ $multtime

elif (($bpoAppVersion == $multtime))
then
	echo Вывод\ $bpoAppVersion\ =\ $multtime

else
	echo ВНИМАНИЕ!!!
	echo Отсутствует\ доступ\ к\ сетевлму\ ресурсу!!!
fi

