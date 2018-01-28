simple_list_comprehension = [[x, x*2] for x in range(4)]

print(simple_list_comprehension)

# The first for loop is the outer loop
# The second for loop is the inner loop
nested_list_comprehension = [y for x in range(4) for y in [x, x*2]]

result = []

for x in range(4):
    for y in [x, x*2, x*3]:
        result.append(y)

print(result)
print(nested_list_comprehension)
