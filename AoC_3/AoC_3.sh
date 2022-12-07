#!/bin/bash
sum=0
sum2=0
while read line
do
  first=${line:0:${#line}/2}
  second=${line:${#line}/2}

  i=0
  while [ $i -ne ${#first} ]
  do
      c=${first:$i:1}
      if [[ $common != *$c* && $second == *$c* ]]
      then
        common=$c
      fi
    ((i++))
  done

  LC_CTYPE=C printf -v asciiVal "%d" "'${common~~}"
  if [ $asciiVal -gt 96 ]
  then
    sum=$(($sum+asciiVal-70))
  else
    sum=$(($sum+asciiVal-64))
  fi
done < input
echo $sum

while read l1
do
  read l2
  read l3

  longestWord=''
  other1=''
  other2=''
  if [[ ${l1} -gt ${l2} && ${l1} -gt ${l3} ]]
  then
    longestWord=$l1
    other1=$l2
    other2=$l3
  elif [[ ${l2} -gt ${l1} && ${l2} -gt ${l3} ]]
  then
    longestWord=$l2
    other1=$l1
    other2=$l3
  else
    longestWord=$l3
    other1=$l1
    other2=$l2
  fi

  i=0
  while [ $i -ne ${#longestWord} ]
  do
      c=${longestWord:$i:1}
      if [[ $common != *$c* && $other1 == *$c* && $other2 == *$c* ]]
      then
        common=$c
      fi
    ((i++))
  done

  LC_CTYPE=C printf -v asciiVal "%d" "'${common~~}"
  if [ $asciiVal -gt 96 ]
  then
    sum2=$(($sum2+asciiVal-70))
  else
    sum2=$(($sum2+asciiVal-64))
  fi
done < input
echo $sum2
