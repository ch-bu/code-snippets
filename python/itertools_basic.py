from itertools import count, cycle, repeat

##############
# count
#############

# Creates a generator that yields number
# of a given step
my_count = count(4, 15)

for i in my_count:
    print(i)

    if i > 100:
        break

##############
# cycle
##############

my_cycle = cycle(["No", "I", "won\'t"])

circles = 0
for element in my_cycle:
    print(element)
    circles += 1
    if circles > 10:
        break

############
# repeat
############

repeater = repeat(8)

print(repeater.next())
print(repeater.next())

############
# accumulate
############
