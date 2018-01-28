def add_suffix(func):
    def decorator_wrapper(*args):
        words_with_suffix = []

        for arg in args:
            words_with_suffix.append(arg + "_suff")

        return func(*words_with_suffix)

    return decorator_wrapper


@add_suffix
def array_to_string(*args):
    my_list = []

    for arg in args:
        my_list.append(arg)

    return my_list

print(array_to_string("bier", "haus", "Mensch"))
