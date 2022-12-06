import argparse
import functools


def compare(item1, item2):
    while True:
        try:
            res = int(input(f'1 for "{item2}". -1 for "{item1}". 0 if equal: '))
            assert res in (-1, 0, 1), 'Input must be -1, 0 or 1'
            return res
        except (AssertionError, ValueError):
            print('Invalid option, please enter one of the following: -1, 0 or -1')


parser = argparse.ArgumentParser( description='Sort input file lines based on user input/preferences.')
parser.add_argument('filename', help='Input file, where each line is a entry to sort.')
filename = parser.parse_args().filename

with open(filename, 'r') as file:
    list = file.read().splitlines()
    list.sort(key=functools.cmp_to_key(compare))
    print('\n\nOutput:\n')
    print('\n'.join(list))
