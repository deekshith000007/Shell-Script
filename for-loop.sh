#!/usr/bin/env bash
<< mycom
for a in 1 2 3 4 5
do 
	echo "welcome to the clas $a times"

done

for a in eat sleep gym wakeup
do 
echo "see guys i like $a"
done
mycom

for a in {1..100}
do 
	rm -rf Data_$a
done

