#!/bin/bash

#variable example
#name="Ruben"

#user input example
#read name

#print statement with a variable being printed as well
#echo "My name is, $name"

#can echo linux commands using a $(linux command)
#echo "The current directory is: $(pwd)"

#echo "The contents of this directory are: $(ls)"

#this is how we comment out blocks of code : 'code'
#If statement example
: '

#here we are defining a variable named age with the value of 14
age=14

#then we print the var value
echo "Age is $age"

#if loop in bash check if the variable age is greater of equal to 18
#if so we print out a message to console
if [ $age -ge 18 ]; then
    echo "You are an adult"
#if its not greater another message prints
else
    echo "You are not an adult"
fi
'

#reading a digit from user then using it in for loop
: ' 
#we use -r to read a digit
read -r count
echo $count

#for loop in shell scripts have do at the end just prints the numbers
for ((i=0; i < count; i++)); do 
    echo "Number: $i"
done
'

#user input used to itterate in a while loop 
#use -r to read a number
: '
start=1
read -r count
echo "You entered $count"

#needs a space inside the while loop or will get an error
while [ "$start" -le "$count" ]; do
    echo "Number: $start"
    ((start++))
done
'

#Defineing a function that prints something so like a void function
: '
myFunction(){
    echo "Hello World"
}

myFunction
'

#method where arguments are passed in and an operation is done on them and then returned
: '
#method to add numbers and it gets 2 arguements passed in
addNumbers(){
    # define variables using local so they can only be accessed only in this function
    # $1 corresponds to the first arguement and $2 and corresponds to the second arguemment
    local num1=$1
    local num2=$2

    #the addition of num1 and num2 are stored in sum
    local sum=$((num1+num2))

    #sum is echoed and getting captured into result outside of this function
    echo $sum
}

# the sum of the function is stored inside result to be printed later
result=$(addNumbers 434 235)

echo "The sum equals: $result"
'
#Store what ls returns into a var then print it
files=$(ls)
echo $files

#file holds the name of our file
#use ./ to specfiy this directory
file="./sample.txt"

#while there are still lines to read from the file the loop keeps going and prints to the console
while IFS= read -r line
do
    echo "$line"
done < "$file"
