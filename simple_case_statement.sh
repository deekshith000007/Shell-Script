#/usr/bin/env bash
#Simple usage of case statement
read -p "Enter first number : " a
read -p "Enter second number : " b
read -p "Select your option(1.Addition,2.Sub,3.Mul,4.Div)" opt

case $opt in
	1)
		echo "you selected addition"
		echo "The sum of $a and $b is $((a+b))"
		;;
	2)
		echo "you selected subtraction"
		echo "Ths sub of $a and $b is $((a-b))"
		;;
	3)
		echo "you selected multiplication"
		echo "The multiplication of $a and $b is $((a*b))"
		;;
	4)
		echo "you selected division"
		echo "The division of $a and $b is $((a/b))"
		;;
	*)
		echo "you selected invalid option"
		;;

esac
