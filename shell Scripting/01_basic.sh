#!/bin/bash

 a=0
 name="sumit"
 age=20
 
 echo "MY name is $name and age is $age"
 
 
 #1. Declaring Arrays

# Method 1: Space-separated values

fruits=("apple" "banana" "cherry")
#
Method 2: Assign individual indexes

fruits[0]="apple"
fruits[1]="banana"
fruits[2]="cherry"

# 2. Access Elements

echo ${fruits[0]}   # apple
echo ${fruits[1]}   # banana

# 3. All Elements

echo ${fruits[@]}     # apple banana cherry
echo ${fruits[*]}     # apple banana cherry

#4. Array Length

echo ${#fruits[@]}    # 3

#key value

declare -A arr

arr=([name]="sumit" [age]=20 [city]="mfp")

#----------------------------------------------------------------------------------------------------

#string operation


#!/bin/bash

# String Declaration
str="DevOps is powerful"
echo "Original: $str"

# String Length
echo "Length: ${#str}"

# Substring Extraction
echo "Substring (0-6): ${str:0:6}"
echo "Substring (7-end): ${str:7}"

# String Replacement
echo "Replace first 'is': ${str/is/was}"
echo "Replace all 'o' with 'O': ${str//o/O}"

# Concatenation
str1="Dev"
str2="Ops"
concat="$str1$str2"
echo "Concatenated: $concat"

# Contains Substring
if [[ "$str" == *"power"* ]]; then
  echo "Substring 'power' found!"
else
  echo "Substring 'power' not found!"
fi

# Convert to Upper and Lower Case
echo "Uppercase: $(echo "$str" | tr '[:lower:]' '[:upper:]')"
echo "Lowercase: $(echo "$str" | tr '[:upper:]' '[:lower:]')"

# Remove Whitespaces
echo "No Spaces: ${str// /}"

# Split String by Delimiter
data="prod:stage:dev"
IFS=':' read -r env1 env2 env3 <<< "$data"
echo "Split: $env1 | $env2 | $env3"

#upper case and lower case

echo "uppercase is ${str^^}"
echo "lowercase is ${str,,}"

#---------------------------------------------------------------------------------------------------

#input

#!/bin/bash

# Basic input

read -p "Enter your name: " name
echo "Hello, $name!"

# Input with hidden text (like password)
read -sp "Enter your password: " password
echo -e "\nPassword received."

# Multiple inputs in one line
read -p "Enter your age and city: " age city
echo "Age: $age, City: $city"

# Array input
read -p "Enter your top 3 DevOps skills (space-separated): " -a skills
echo "Skills: ${skills[0]}, ${skills[1]}, ${skills[2]}"

# Input with default value
read -p "Enter your role [DevOps]: " role
role=${role:-DevOps}
echo "Role: $role"

#-------------------------------------------------------------------------------------------------

#arithmetic

#!/bin/bash

# Declare variables
a=15
b=4
x=5.7
y=3.1

echo " Integer Arithmetic (a=$a, b=$b)"
echo "Addition: $((a + b))"
echo "Subtraction: $((a - b))"
echo "Multiplication: $((a * b))"
echo "Division: $((a / b))"
echo "Modulus: $((a % b))"
echo "Exponentiation: $((a ** b))"

echo -e "\n Using 'let'"
let sum=a+b
echo "Sum (let): $sum"

echo -e "\n Using 'expr'"
sum_expr=$(expr $a + $b)
echo "Sum (expr): $sum_expr"

echo -e "\n Floating Point Arithmetic (x=$x, y=$y)"
float_sum=$(echo "$x + $y" | bc -l)
float_div=$(echo "$x / $y" | bc -l)
echo "Float Sum: $float_sum"
echo "Float Division: $float_div"

#---------------------------------------------------------------------------------------------------

#conditional 

#!/bin/bash

# 1. Numeric Comparison
read -p "Enter a number: " num

if [ $num -gt 0 ]; then
  echo " $num is Positive"
elif [ $num -lt 0 ]; then
  echo "❌ $num is Negative"
else
  echo " Number is Zero"
fi

# 2. String Comparison
read -p "Enter environment (dev/stage/prod): " env
if [ "$env" == "prod" ]; then
  echo "Deploying to Production"
else
  echo "Safe Deployment in $env"
fi

# 3. File Existence
file="test.txt"
if [ -f "$file" ]; then
  echo " File '$file' exists"
else
  echo "❌ File '$file' does not exist"
fi

# 4. Logical AND
age=20
city="Delhi"
if [ $age -ge 18 ] && [ "$city" == "Delhi" ]; then
  echo " Eligible in Delhi"
else
  echo "Not eligible in Delhi"
fi
 
#-----------------------------------------------------------------------------------------------------

#loops 


#!/bin/bash

# For loop (range)
echo "For loop (1 to 5)"
for i in {1..5}; do
  echo "Count: $i"
done

# For loop (C-style)
echo -e "\nFor loop (C-style)"
for ((i = 1; i <= 5; i++)); do
  echo "C-style Count: $i"
done

# While loop
echo -e "\nWhile loop (1 to 5)"
count=1
while [ $count -le 5 ]; do
  echo "While Count: $count"
  ((count++))
done

# Until loop
echo -e "\nUntil loop (1 to 5)"
count=1
until [ $count -gt 5 ]; do
  echo "Until Count: $count"
  ((count++))
done

# For loop over array
echo -e "\nFor loop over array"
names=("DevOps" "Linux" "Docker")
for name in "${names[@]}"; do
  echo "Tool: $name"
done

# Indexed array loop
echo -e "\nIndexed array loop"
for i in "${!names[@]}"; do
  echo "Index $i = ${names[$i]}"
done

#--------------------------------------------------------------------------------------------

# All function 

#!/bin/bash

# 1. Basic Function
welcome() {
  echo "Welcome to Shell Scripting!"
}

# 2. Function with Parameters
greet() {
  echo "Hello, $1! You're learning $2."
}

# 3. Function with Return (using echo)
add() {
  echo $(( $1 + $2 ))
}

# 4. Function with Return (using return — integer only)
multiply() {
  local result=$(( $1 * $2 ))
  return $result
}

# 5. Function with Local Variable (scope demo)
show_scope() {
  local secret="This is private"
  echo "Inside function: $secret"
}

# ==== Calling All Functions ====

# Basic function
welcome

# With parameters
greet "Sumit" "DevOps"

# Return using echo
sum=$(add 10 15)
echo "Sum from add(): $sum"

# Return using return (limited to 0–255)
multiply 5 4
echo "Return value from multiply(): $?"  # not reliable for large values

# Scope demo
show_scope
echo "Outside function: $secret"  # Won't work, $secret is local


#----------------------------------------------------------------------------------------------------

#connection check 

// ping -c 1 www.google.com
 

read -p "which site i want to check?" site

ping -c 1 $site

if [ $? -eq 0 ] 
then 
	echo "successfully connected to $site"
else
	echo "unable to connect $site"
fi

#----------------------------------------------------------------------------------------------------

#basename directioaryname path name 

#!/bin/bash

read -p "Enter a file or directory path: " path

# Get the base name
base=$(basename "$path")

# Get the directory name
dir=$(dirname "$path")

# Get the absolute (real) path
abs=$(realpath "$path")

echo "Basename     : $base"
echo "Directory    : $dir"
echo "Real Path    : $abs"


 #Enter a file or directory path: /home/sumit/project/file.txt
 
#output
 
#Basename     : file.txt
#Directory    : /home/sumit/project
#Real Path    : /home/sumit/project/file.txt


#----------------------------------------------------------------------------------------------------

#bash variable 

#!/bin/bash

# 1. Regular variable
name="Sumit"
age=20

# 2. User input variable
read -p "Enter your city: " city

# 3. Environment variable
export COURSE="DevOps"

# 4. Command substitution
today=$(date)

# 5. Default value (parameter expansion)
echo "Hello, ${username:-Guest}!"

# 6. Array variable
tools=("Git" "Docker" "Kubernetes")

# 7. Output all
echo "My name is $name"
echo "Age: $age"
echo "City: $city"
echo "Course: $COURSE"
echo "Today is: $today"
echo "First tool: ${tools[0]}"
echo "All tools: ${tools[@]}"

# 8. Check if a variable is empty

unset emptyVar
if [ -z "$emptyVar" ]; then
  echo "emptyVar is unset or empty"
fi

