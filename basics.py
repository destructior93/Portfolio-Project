# some basic things to do that i remember of

#strings, variables, lists

even_number = 1
just_another_string = "Yes this is a string"
anotherlist = [1,2,3,4,5,]

print(even_number)
print(just_another_string)
print(anotherlist[2])

#if else statments, for & while loops

if even_number > 1:
    print("This number is larger than one")
else:
    print ("This number is equal or lower than one")

#{'HP': ,'MANA': ,'BASICATK': ,'MAGICATK': ,'CRIT': ,'PHYDEF': ,'MAGICDEF': ,'RANGE': ,'MOVESPD': }

warr_stats_dict = {'HP': 110, 'MANA': 40, 'BASICATK': 20, 'MAGICATK': 0, 'CRIT': 15, 'PHYDEF': 25, 'MAGICDEF': 15, 'RANGE': 1, 'MOVESPD': 4}
mage_stats_dict = {'HP': 60,'MANA': 90,'BASICATK': 10,'MAGICATK': 20,'CRIT': 10,'PHYDEF': 15,'MAGICDEF': 25,'RANGE': 3,'MOVESPD': 4}
archer_stats_dict = {'HP': 90,'MANA': 60,'BASICATK': 25,'MAGICATK': 5,'CRIT': 20,'PHYDEF': 20,'MAGICDEF': 20,'RANGE': 4,'MOVESPD': 5}
paladinstatsdict = {'HP': 100,'MANA': 50,'BASICATK': 15,'MAGICATK': 5,'CRIT': 5,'PHYDEF': 30,'MAGICDEF': 20,'RANGE': 2,'MOVESPD': 3}

for key, value in paladinstatsdict.items():
    print("Paladin Stats ",key, '->',value)

###

# nested loop

hotdrinks = ["tea", "coffee", "hot chocolate"]
milks = ["Cowmilk", "Oatmilk", "Soymilk"]

for one in hotdrinks:
    for two in milks:
        print(one, 'with', two)

# while loop with break

a = 3
b = 6
while b > a:
    a += 1
    if a == 6:
        print ("a is no longer less than b")
        break
    print (a,"not yet, must iterate loop again")


# functions

# basic function

def pepe_the_frog(number, power):
    print("Pepe the frog.")
    print(number**power)

pepe_the_frog(3,3)

# arbitrary function

args_tuple = (3,6,7)

def number_args(*number):
    print(number[0]*number[1])

number_args(*args_tuple)

def number_kwargs(**number):
    print('My first number is: ' + number['integer'] + " " + 'My other number is: ' + number['integer2'])

number_kwargs(integer = '65', integer2 = '32')