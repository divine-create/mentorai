-- AI Academy — Seed starter_code for existing coding questions
--
-- Adds starter code templates to the 14 coding questions across Python
-- modules so that when a learner opens them in the coding environment
-- from the assessment page, the editor is pre-populated.
--
-- Uses $$...$$ dollar-quoted strings so the Python source can contain
-- single quotes, double quotes, brackets, backslashes, and other characters
-- that would otherwise need tedious escaping inside a SQL string literal.

-- Module 1 — Python Fundamentals
UPDATE questions SET starter_code = $$a = 10
b = 20

# Write your code here to swap a and b
# After your code, a should be 20 and b should be 10
$$
WHERE prompt LIKE '%swaps the values of a and b%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$# Convert Celsius to Fahrenheit
celsius = float(input())

# Write your code here
fahrenheit = (celsius * 9/5) + 32
print(round(fahrenheit, 1))
$$
WHERE prompt LIKE '%Celsius from input%' AND starter_code IS NULL;

-- Module 2 — Control Flow
UPDATE questions SET starter_code = $$# FizzBuzz
n = int(input())

# Write your code here
$$
WHERE prompt LIKE '%Fizz%Buzz%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$# Print the first 10 Fibonacci numbers
$$
WHERE prompt LIKE '%first 10 Fibonacci%' AND starter_code IS NULL;

-- Module 3 — Functions
UPDATE questions SET starter_code = $$def is_palindrome(s):
    # Write your code here
    pass


print(is_palindrome("Racecar"))
print(is_palindrome("hello"))
print(is_palindrome(""))
$$
WHERE prompt LIKE '%is_palindrome%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$def factorial(n):
    # Write your recursive code here
    pass


print(factorial(5))
print(factorial(0))
print(factorial(3))
$$
WHERE prompt LIKE '%recursive function factorial%' AND starter_code IS NULL;

-- Module 4 — Data Structures
UPDATE questions SET starter_code = $$# Use a list comprehension to create evens from 1 to 20
evens = [x for x in range(1, 21) if x % 2 == 0]
print(evens)
$$
WHERE prompt LIKE '%list comprehension%even numbers from 1 to 20%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$def count_words(text):
    # Write your code here
    pass


print(count_words("the cat and the dog"))
$$
WHERE prompt LIKE '%count_words%' AND starter_code IS NULL;

-- Module 5 — OOP
UPDATE questions SET starter_code = $$class BankAccount:
    def __init__(self, owner, balance=0):
        # Write your code here
        pass

    def deposit(self, amount):
        # Write your code here
        pass

    def withdraw(self, amount):
        # Write your code here
        pass

    def __str__(self):
        # Write your code here
        pass


# Test it
acc = BankAccount("Alice", 100)
acc.deposit(50)
acc.withdraw(30)
print(acc)
$$
WHERE prompt LIKE '%BankAccount%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height


class Square(Rectangle):
    def __init__(self, side):
        # Write your code here
        pass


# Test it
rect = Rectangle(4, 5)
print(f"Rectangle area: {rect.area()}")
sq = Square(4)
print(f"Square area: {sq.area()}")
$$
WHERE prompt LIKE '%Square that inherits Rectangle%' AND starter_code IS NULL;

-- Module 6 — File Handling & Exceptions
UPDATE questions SET starter_code = $$# Count lines in "data.txt"
# In this environment, create the file first
with open("data.txt", "w") as f:
    f.write("line 1\nline 2\nline 3\n")

# Now write your code to count the lines
$$
WHERE prompt LIKE '%counts the lines%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$def safe_divide(a, b):
    # Write your code here
    pass


print(safe_divide(10, 2))
print(safe_divide(10, 0))
print(safe_divide(10, "a"))
$$
WHERE prompt LIKE '%safe_divide%' AND starter_code IS NULL;

-- Module 7 — Working with APIs
UPDATE questions SET starter_code = $$import json


def parse_users(json_str):
    # Write your code here
    pass


print(parse_users('[{"name": "Alice"}, {"name": "Bob"}]'))
$$
WHERE prompt LIKE '%parse_users%' AND starter_code IS NULL;

UPDATE questions SET starter_code = $$# Assume requests is imported
# Note: This won't work in the browser sandbox (no network)
# but practising the logic is still valuable


def fetch_data(url):
    # Write your code here
    pass
$$
WHERE prompt LIKE '%fetch_data%' AND starter_code IS NULL;
