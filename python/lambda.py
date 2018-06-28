zero = lambda f: lambda x: x

one = lambda f: lambda x: f(x)

two = lambda f: lambda x: f(f(x))

three = lambda f: lambda x: f(f(f(x)))

to_int = lambda n: n(lambda i: i + 1)(0)

print(to_int(three))
