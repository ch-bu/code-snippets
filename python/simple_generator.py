def first_generator():
    yield "Haus";
    yield "Baum";
    yield "Maus"

my_generator = first_generator()

for y in first_generator():
    print(y)

for i in range(4):
    print(my_generator.next())
