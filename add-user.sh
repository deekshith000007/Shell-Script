#!/usr/bin/env bash
#this script creates the new user on the local system
#you must supply username as an arugument to the script
#optionally you can also provide a comment for the account as an argument
#Password must be automatically genertated for the account
#username password and the host will be displayed
#this is line is for test
#1)make sure that the script is being excecuted with super user previlages
if [[ "${UID}" -ne 0 ]]
then
	echo "please run with sudo or superuser previlages"
	exit 1
fi

#2)if they dont supply atleast one argument then give them help
if [[ "${#}" -lt 1 ]]
then
	echo "usage: ${0} user_name [comment].."
	echo "create an account on the local system with name of user_name and a comment field of the comment"
	exit 1
fi

#3)The first parameter is the username
USERNAME="${1}"

#4)rest of the parameters are the account comment
shift
COMMENT="${@}"

#5)Generate the password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

#6)Create the user with password 
useradd -c "${COMMENT}"-m ${USERNAME}

#7)checking weather the username succeded
if [[ "${?}" -ne 0 ]]
then
	echo "the account could not be created"
exit 1

fi
#8)set the password
echo ${PASSWORD} | passwd --stdin ${USERNAME}

#9)check to see if the password command succeded
#if [[ "${?}"-ne 0 ]]
#then 
#	echo "the password for the account could not be set"
#	exit 1
#fi

#10)force password change
passwd -e ${USERNAME}
	
	
#11)Displaying the username passwd and hostname
echo
echo 'username'
echo "${USERNAME}"
echo "${PASSWORD}"
echo "${HOSTNAME}"






