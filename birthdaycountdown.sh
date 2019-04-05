ARRAY=(31 28 31 30 31 30 31 31 30 31 30 31)

answer=0

echo -n "Hello $USER"

#No offset argument
if ["$#" -eq 0]
then
	echo "The current date is `date`"

	day=$(date +%d)
	month=$(date +%m)
	year=$(date +%Y)
	
#Offset is greater than 15 years
else if ["$#" -gt 5475]
then
	echo "Offset is greater than 15 years, offsetting by exactly 15 years"
	echo "Offset date is `date -d "+5475 days"`"
	day=$((date -d "+5475 days" +%d))
	month=$((date -d "+5475 days" +%m))
	year=$((date -d "+5475 days" +%Y))

#Any other offset
else
	echo "Date is offset by $1 days"
	echo "Date is `date -d "+$1 days"`"
	day=$((date -d "+$1 days" +%d))
	month=$((date -d "+$1 days" +%m))
	year=$((date -d "+$1 days" +%Y))
fi	

start=true
while (($start != "stop"))
	echo -n "Enter your birth month (MM): "
	read bMonth
	echo -n "Enter your birth day (DD): "
	read bDay

	#Array starts at index 0, so assign i to month - 1
	i=$(($month - 1))

	#Loop until we are in the same month
	while (($i != $bMonth -1))
	do
		#add the number of days in the current month to the answer, found in ARRAY
		answer=$(($answer + ${ARRAY[$i]}))

		#If the current year is a leap year, and we are in february, add an extra day
		if (($i==1 && $(($year%400)) == 0 && $(($year%100))!=0))
		then
			answer=$(($answer+1))
		fi

		#incremnt i
		i=$(($i + 1))

		#set i to 0 if we go beyond 11, and add a year
		if (($i > 11))
		then
			i=0
			year=$(($year+1))
		fi
	done

	# We're in the same month, add days if necessary (add 0 if we are on the same day)
	if ((day <= bDay))
	then
		answer=$(($answer + $(($bDay - $day))))

	#subtract days if we need to
	else
		answer=$(($answer - $(($day - $bDay))))
	fi

	if ((0 == $answer))
	then
	# The current day is their birthday print message
		echo "Happy birthday"
	else
		echo "There are $answer days until your birthday!"
	fi

	#check and print festive messages

	if (($day == 31 && $month == 10))
	then 
		echo "Today is Halloween, have a spooky day!"
	elif (($day == 25 && $month == 12))
	then
			echo "Today is Christmas, we wish you a merry Christmas and a happy new year!"

	elif (($day == 1 && $month == 7))
	then
			echo "Today is Canada Day, Happy Canada Day!"
	elif (($day == 17 && $month == 3))
	then
			echo "Today is St Patrick's day, don't drink too much! ;)"
	fi


	#check if birthday falls on holiday

	if (($bDay == 31 && $bMonth == 10))
	then 
		echo "Your birthday falls on Halloween, have a spooky birthday!"
	elif (($bDay == 25 && $bMonth == 12))
	then
			echo "Your birthday falls on Christmas, we wish you a merry birthday and a happy new year!"

	elif (($bDay == 1 && $bMonth == 7))
	then
			echo "Your birthday falls on Canada Day, Happy birthday and Canada Day!"
	elif (($bDay == 17 && $bMonth == 3))
	then
			echo "Your birthday falls on St Patrick's day, happy birthday lad/lassie"
	fi
	
	echo -n "Type 'stop' to end program, enter any key input another birthday: "
	read start
done

