'''Simple BMI Calculator'''

#Defining Variables

weight = int(input("Enter your weight in kg: "))
height = int(input("Enter your height in cm: "))
age = int(input("Enter your age: "))

#converting meters to CM

heightm = (height / 100)

#calculating and rounding BMI to 2 decimals

BMI = (weight / heightm**2)
rounded_BMI = round(BMI, 2)

#conditional output based on bmi ranges for adults

if rounded_BMI <= 18.5:
    print("Your age is " + str(age) + ", and your BMI is " +str(rounded_BMI) + "%. You are underweight.")
elif rounded_BMI <= 24.9:
    print(("Your age is " + str(age) + ", and your BMI is " +str(rounded_BMI) + "%. You have healthy weight."))
elif rounded_BMI <= 29.9:
    print(("Your age is " + str(age) + ", and your BMI is " +str(rounded_BMI) + "%. You are overweight."))
elif rounded_BMI <= 39.9:
    print(("Your age is " + str(age) + ", and your BMI is " +str(rounded_BMI) + "%. You are obese."))
elif rounded_BMI <= 40:
    print("Your age is " + str(age) + ", and your BMI is " +str(rounded_BMI) + "%. You are severly obese.")
else:
    print("Invalid inputs!")