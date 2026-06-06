-- MentorAI v1.0 — Seed concepts & questions for all 8 Python modules
--
-- This migration seeds:
--   • concepts — the sub-topics taught within each module
--   • questions — assessment items of type multiple_choice, short_answer,
--                 coding, and explanation, spread across foundational,
--                 applied, and advanced difficulty levels.
--
-- The mastery engine requires at least 8-12 questions per module to produce
-- meaningful composite scores (40% final assessment, 30% coding unaided,
-- 20% explanation, 10% in-session).

-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 1 — Python Fundamentals  (module_id = 1)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (1, 1, 'Variables & Assignment',    'Creating variables, naming rules, dynamic typing',      1),
  (2, 1, 'Data Types',                'int, float, str, bool, type(), conversion',             2),
  (3, 1, 'Operators & Expressions',   'Arithmetic, comparison, logical operators, precedence', 3),
  (4, 1, 'Input & Output',            'print(), input(), f-strings',                           4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(1, 2, 'multiple_choice', 'foundational',
  'Which of the following is NOT a valid Python data type?',
  '[{"label":"A","text":"int"},{"label":"B","text":"float"},{"label":"C","text":"char"},{"label":"D","text":"bool"}]',
  'char', NULL),

(1, 1, 'multiple_choice', 'foundational',
  'What is the value of x after this code?\n\nx = 5\nx = x + 3',
  '[{"label":"A","text":"5"},{"label":"B","text":"8"},{"label":"C","text":"3"},{"label":"D","text":"53"}]',
  '8', NULL),

(1, 3, 'multiple_choice', 'foundational',
  'What does 10 % 3 evaluate to?',
  '[{"label":"A","text":"3"},{"label":"B","text":"3.33"},{"label":"C","text":"1"},{"label":"D","text":"0"}]',
  '1', NULL),

(1, 2, 'multiple_choice', 'applied',
  'What is the result of: bool(0), bool("False"), bool([])?',
  '[{"label":"A","text":"True, True, True"},{"label":"B","text":"False, True, False"},{"label":"C","text":"False, False, False"},{"label":"D","text":"True, False, True"}]',
  'False, True, False', NULL),

(1, 4, 'short_answer', 'foundational',
  'Write a single print() statement that outputs: Hello, Alice! You are 25 years old.\nUse an f-string with name = "Alice" and age = 25.',
  NULL,
  'print(f"Hello, {name}! You are {age} years old.")', NULL),

(1, 3, 'short_answer', 'applied',
  'Explain in one sentence the difference between == and = in Python.',
  NULL,
  'The == operator compares two values for equality, while = assigns a value to a variable.', NULL),

(1, 1, 'coding', 'applied',
  'Write code that swaps the values of a and b without using a third variable.\n\na = 10\nb = 20\n\n# After your code, a should be 20 and b should be 10',
  NULL, NULL,
  '[{"input":"","expected_output":""}]'),

(1, 3, 'coding', 'advanced',
  'Write a program that reads Celsius from input, converts to Fahrenheit, and prints it rounded to 1 decimal place.\n\nFormula: F = (C * 9/5) + 32\n\nInput: 0\nOutput: 32.0',
  NULL, NULL,
  '[{"input":"0","expected_output":"32.0"},{"input":"100","expected_output":"212.0"},{"input":"-40","expected_output":"-40.0"}]'),

(1, 2, 'explanation', 'applied',
  'Explain in 2-3 sentences why Python is called a "dynamically typed" language. Give an example showing how a variable can change type.',
  NULL, NULL, NULL),

(1, 4, 'explanation', 'advanced',
  'What is the difference between print() and return in Python? Explain where each is used and what happens to the value afterwards.',
  NULL, NULL, NULL);

-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 2 — Control Flow  (module_id = 2)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (5,  2, 'Conditional Statements',  'if, elif, else, nested conditions',  1),
  (6,  2, 'For Loops',               'Iteration over sequences, range()',  2),
  (7,  2, 'While Loops',             'Condition-controlled loops',        3),
  (8,  2, 'Flow Modifiers',          'break, continue, pass, else on loops', 4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(2, 5, 'multiple_choice', 'foundational',
  'What does this print?\n\nx = 7\nif x > 10:\n    print("big")\nelif x > 5:\n    print("medium")\nelse:\n    print("small")',
  '[{"label":"A","text":"big"},{"label":"B","text":"medium"},{"label":"C","text":"small"},{"label":"D","text":"big\\nmedium"}]',
  'medium', NULL),

(2, 6, 'multiple_choice', 'foundational',
  'How many times does this print "hello"?\n\nfor i in range(3):\n    print("hello")',
  '[{"label":"A","text":"2"},{"label":"B","text":"3"},{"label":"C","text":"4"},{"label":"D","text":"1"}]',
  '3', NULL),

(2, 7, 'multiple_choice', 'applied',
  'What does this print?\n\nx = 10\nwhile x > 0:\n    x -= 3\nprint(x)',
  '[{"label":"A","text":"0"},{"label":"B","text":"-2"},{"label":"C","text":"1"},{"label":"D","text":"-1"}]',
  '-2', NULL),

(2, 8, 'short_answer', 'foundational',
  'What does the break statement do inside a loop? Answer in one sentence.',
  NULL,
  'It immediately exits the loop, skipping any remaining iterations.', NULL),

(2, 5, 'short_answer', 'applied',
  'Write a Python expression using a ternary conditional that returns "even" if num is even and "odd" otherwise.',
  NULL,
  '"even" if num % 2 == 0 else "odd"', NULL),

(2, 5, 'coding', 'applied',
  'Write a program that reads an integer from input and prints "Fizz" if divisible by 3, "Buzz" if divisible by 5, "FizzBuzz" if both, else the number.\n\nInput: 15\nOutput: FizzBuzz',
  NULL, NULL,
  '[{"input":"15","expected_output":"FizzBuzz"},{"input":"9","expected_output":"Fizz"},{"input":"10","expected_output":"Buzz"},{"input":"7","expected_output":"7"}]'),

(2, 6, 'coding', 'advanced',
  'Write a program that prints the first 10 Fibonacci numbers (0, 1, 1, 2, 3, 5, 8, 13, 21, 34), one per line.',
  NULL, NULL,
  '[{"input":"","expected_output":"0\\n1\\n1\\n2\\n3\\n5\\n8\\n13\\n21\\n34"}]'),

(2, 7, 'explanation', 'applied',
  'Explain the difference between a for loop and a while loop. Give an example of when a while loop is more appropriate.',
  NULL, NULL, NULL),

(2, 8, 'explanation', 'advanced',
  'Explain what the else clause on a for loop does in Python. When does it execute and when does it not?',
  NULL, NULL, NULL);


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 3 — Functions  (module_id = 3)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (9,  3, 'Defining Functions',    'def, parameters, return values, docstrings',  1),
  (10, 3, 'Scope & Arguments',     'Local vs global scope, default args, *args, **kwargs', 2),
  (11, 3, 'Recursion',             'Base case, recursive calls, stack depth',     3)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(3, 9, 'multiple_choice', 'foundational',
  'What is the output?\n\ndef greet(name):\n    return f"Hi {name}"\n\nprint(greet("Alex"))',
  '[{"label":"A","text":"Hi Alex"},{"label":"B","text":"greet(Alex)"},{"label":"C","text":"Hi name"},{"label":"D","text":"Error"}]',
  'Hi Alex', NULL),

(3, 10, 'multiple_choice', 'foundational',
  'What does this print?\n\nx = 5\ndef change():\n    x = 10\nchange()\nprint(x)',
  '[{"label":"A","text":"10"},{"label":"B","text":"5"},{"label":"C","text":"Error"},{"label":"D","text":"None"}]',
  '5', NULL),

(3, 9, 'multiple_choice', 'applied',
  'What does add(5) return?\n\ndef add(a, b=2):\n    return a + b',
  '[{"label":"A","text":"5"},{"label":"B","text":"7"},{"label":"C","text":"2"},{"label":"D","text":"Error"}]',
  '7', NULL),

(3, 10, 'short_answer', 'applied',
  'Write a function multiply_all(*args) that returns the product of all arguments. Return 1 if no arguments.',
  NULL,
  'def multiply_all(*args):\n    product = 1\n    for n in args:\n        product *= n\n    return product', NULL),

(3, 9, 'coding', 'applied',
  'Write a function is_palindrome(s) that returns True if string s is a palindrome (ignoring case), False otherwise.\n\nis_palindrome("Racecar") -> True\nis_palindrome("hello") -> False',
  NULL, NULL,
  '[{"input":"Racecar","expected_output":"True"},{"input":"hello","expected_output":"False"},{"input":"","expected_output":"True"}]'),

(3, 11, 'coding', 'advanced',
  'Write a recursive function factorial(n) that returns n! (n factorial). Use recursion, not a loop.',
  NULL, NULL,
  '[{"input":"5","expected_output":"120"},{"input":"0","expected_output":"1"},{"input":"3","expected_output":"6"}]'),

(3, 11, 'explanation', 'advanced',
  'Explain what a "base case" is in recursion and why every recursive function needs one. What happens without a base case?',
  NULL, NULL, NULL),

(3, 10, 'explanation', 'applied',
  'Explain the difference between local and global variables in Python. Show how the global keyword works with a short example.',
  NULL, NULL, NULL);


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 4 — Data Structures  (module_id = 4)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (12, 4, 'Lists',                 'Creating, indexing, slicing, list methods',  1),
  (13, 4, 'Tuples & Dictionaries', 'Immutable tuples, key-value dicts, dict methods', 2),
  (14, 4, 'Sets',                  'Set creation, union, intersection, difference', 3),
  (15, 4, 'List Comprehensions',   'Basic comprehensions, conditionals, nested', 4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(4, 12, 'multiple_choice', 'foundational',
  'What is my_list[-1]?\n\nmy_list = [10, 20, 30, 40]',
  '[{"label":"A","text":"10"},{"label":"B","text":"30"},{"label":"C","text":"40"},{"label":"D","text":"Error"}]',
  '40', NULL),

(4, 13, 'multiple_choice', 'foundational',
  'Which of these creates a dictionary?',
  '[{"label":"A","text":"[1, 2, 3]"},{"label":"B","text":"{\"a\": 1, \"b\": 2}"},{"label":"C","text":"(1, 2, 3)"},{"label":"D","text":"{1, 2, 3}"}]',
  '{"a": 1, "b": 2}', NULL),

(4, 14, 'multiple_choice', 'applied',
  'What is the output?\n\nA = {1, 2, 3}\nB = {2, 3, 4}\nprint(A & B)',
  '[{"label":"A","text":"{1, 2, 3, 4}"},{"label":"B","text":"{2, 3}"},{"label":"C","text":"{1, 4}"},{"label":"D","text":"{1, 2, 3, 2, 3, 4}"}]',
  '{2, 3}', NULL),

(4, 15, 'multiple_choice', 'applied',
  'What does this comprehension produce?\n\n[x**2 for x in range(5) if x % 2 == 0]',
  '[{"label":"A","text":"[0, 1, 4, 9, 16]"},{"label":"B","text":"[0, 4, 16]"},{"label":"C","text":"[1, 9]"},{"label":"D","text":"[0, 2, 4]"}]',
  '[0, 4, 16]', NULL),

(4, 12, 'short_answer', 'foundational',
  'Write an expression that returns the last three elements of a list named data (assume data has at least 3 elements).',
  NULL,
  'data[-3:]', NULL),

(4, 13, 'short_answer', 'applied',
  'What is the key difference between a list and a tuple in Python? Answer in one sentence.',
  NULL,
  'A list is mutable (can be changed after creation), while a tuple is immutable (cannot be changed).', NULL),

(4, 15, 'coding', 'applied',
  'Use a list comprehension to create a list of all even numbers from 1 to 20 (inclusive). Store in a variable called evens.',
  NULL, NULL,
  '[{"input":"","expected_output":"[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]"}]'),

(4, 13, 'coding', 'advanced',
  'Write count_words(text) that returns a dict counting word occurrences.\n\ncount_words("the cat and the dog") -> {"the": 2, "cat": 1, "and": 1, "dog": 1}',
  NULL, NULL,
  '[{"input":"the cat and the dog","expected_output":"the:2 cat:1 and:1 dog:1"}]'),

(4, 14, 'explanation', 'applied',
  'Explain the difference between a set and a list. When would you choose a set over a list?',
  NULL, NULL, NULL);



-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 5 — OOP  (module_id = 5)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (16, 5, 'Classes & Instances',  'class, __init__, self, attributes, methods', 1),
  (17, 5, 'Inheritance',          'Parent/child classes, super(), method overriding', 2),
  (18, 5, 'Encapsulation',        'Private attributes, @property, name mangling', 3)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(5, 16, 'multiple_choice', 'foundational',
  'What method is automatically called when a new object is created?',
  '[{"label":"A","text":"__init__"},{"label":"B","text":"__new__"},{"label":"C","text":"__str__"},{"label":"D","text":"init"}]',
  '__init__', NULL),

(5, 16, 'multiple_choice', 'foundational',
  'What does self refer to inside a Python class method?',
  '[{"label":"A","text":"The class itself"},{"label":"B","text":"The current instance of the class"},{"label":"C","text":"A global variable"},{"label":"D","text":"It is optional, so nothing"}]',
  'The current instance of the class', NULL),

(5, 17, 'multiple_choice', 'applied',
  'What does Dog().speak() return?\n\nclass Animal:\n    def speak(self):\n        return "..."\n\nclass Dog(Animal):\n    def speak(self):\n        return "Woof"',
  '[{"label":"A","text":"\"...\""},{"label":"B","text":"\"Woof\""},{"label":"C","text":"Error"},{"label":"D","text":"None"}]',
  '"Woof"', NULL),

(5, 18, 'short_answer', 'applied',
  'In one sentence, what does the @property decorator do in Python?',
  NULL,
  'It allows a method to be accessed like an attribute, enabling computed or read-only properties with getter/setter logic.', NULL),

(5, 16, 'coding', 'applied',
  'Define a class BankAccount with:\n- __init__(self, owner, balance=0)\n- deposit(amount) adds to balance\n- withdraw(amount) subtracts if funds sufficient else prints "Insufficient funds"\n- __str__ returns "Account owned by {owner}: ${balance}"',
  NULL, NULL,
  '[{"input":"","expected_output":""}]'),

(5, 17, 'coding', 'advanced',
  'Define a class Rectangle with width, height, and area(). Then define Square that inherits Rectangle and overrides __init__ to take only side.',
  NULL, NULL,
  '[{"input":"","expected_output":""}]'),

(5, 17, 'explanation', 'applied',
  'Explain what inheritance is in OOP and why it is useful. Use Vehicle and Car as an example.',
  NULL, NULL, NULL),

(5, 18, 'explanation', 'advanced',
  'Explain encapsulation in Python. How do you indicate a "private" attribute and how does name mangling (__attr) work?',
  NULL, NULL, NULL);


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 6 — File Handling & Exceptions  (module_id = 6)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (19, 6, 'File I/O',           'open(), read(), write(), with statement, modes', 1),
  (20, 6, 'Exception Handling', 'try, except, else, finally, raising exceptions', 2),
  (21, 6, 'Custom Exceptions',  'Extending Exception class, raising custom errors', 3)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(6, 19, 'multiple_choice', 'foundational',
  'Which mode opens a file for writing (overwriting existing content)?',
  '[{"label":"A","text":"\"r\""},{"label":"B","text":"\"w\""},{"label":"C","text":"\"a\""},{"label":"D","text":"\"rw\""}]',
  '"w"', NULL),

(6, 20, 'multiple_choice', 'foundational',
  'What does this print?\n\ntry:\n    x = 10 / 0\nexcept ZeroDivisionError:\n    print("Oops")\nelse:\n    print("OK")',
  '[{"label":"A","text":"OK"},{"label":"B","text":"Oops"},{"label":"C","text":"Oops\\nOK"},{"label":"D","text":"Error"}]',
  'Oops', NULL),

(6, 20, 'multiple_choice', 'applied',
  'What does this print?\n\ntry:\n    print("A")\n    raise ValueError("bad")\nfinally:\n    print("B")',
  '[{"label":"A","text":"A"},{"label":"B","text":"A\\nB  (then ValueError raised)"},{"label":"C","text":"B"},{"label":"D","text":"A\\nB"}]',
  'A\nB  (then ValueError raised)', NULL),

(6, 19, 'short_answer', 'applied',
  'Why is the "with" statement recommended when working with files? Answer in one sentence.',
  NULL,
  'It automatically closes the file when the block exits, even if an exception occurs.', NULL),

(6, 19, 'coding', 'applied',
  'Write a program that reads "data.txt", counts the lines, and prints the count. Use a with statement.',
  NULL, NULL,
  '[{"input":"","expected_output":""}]'),

(6, 20, 'coding', 'advanced',
  'Write safe_divide(a, b) that returns a / b. Handle ZeroDivisionError and TypeError. Return None on error.',
  NULL, NULL,
  '[{"input":"10,2","expected_output":"5.0"},{"input":"10,0","expected_output":"None"}]'),

(6, 21, 'explanation', 'advanced',
  'How do you create a custom exception class in Python? Show syntax and explain why custom exceptions are useful.',
  NULL, NULL, NULL);



-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 7 — Working with APIs  (module_id = 7)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (22, 7, 'HTTP Requests',        'GET, POST, status codes, requests library', 1),
  (23, 7, 'JSON Handling',        'json.loads(), json.dumps(), working with JSON data', 2),
  (24, 7, 'REST API Design',      'Endpoints, resources, CRUD operations', 3),
  (25, 7, 'Authentication',       'API keys, tokens, basic auth, headers', 4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(7, 22, 'multiple_choice', 'foundational',
  'Which HTTP method is typically used to retrieve data from a REST API?',
  '[{"label":"A","text":"POST"},{"label":"B","text":"GET"},{"label":"C","text":"DELETE"},{"label":"D","text":"PUT"}]',
  'GET', NULL),

(7, 23, 'multiple_choice', 'foundational',
  'Which Python function converts a JSON string into a Python dictionary?',
  '[{"label":"A","text":"json.dumps()"},{"label":"B","text":"json.loads()"},{"label":"C","text":"json.parse()"},{"label":"D","text":"json.stringify()"}]',
  'json.loads()', NULL),

(7, 22, 'multiple_choice', 'applied',
  'What does a 404 status code mean when calling an API?',
  '[{"label":"A","text":"Server error"},{"label":"B","text":"Resource not found"},{"label":"C","text":"Unauthorized"},{"label":"D","text":"Success"}]',
  'Resource not found', NULL),

(7, 25, 'short_answer', 'applied',
  'In one sentence, what is an API key and where is it typically placed in an HTTP request?',
  NULL,
  'An API key is a unique identifier that authenticates the client, typically sent in the Authorization header or as a query parameter.', NULL),

(7, 23, 'coding', 'applied',
  'Write parse_users(json_str) that takes a JSON string and returns a list of names. Example input: ''[{"name": "Alice"}, {"name": "Bob"}]'' -> ["Alice", "Bob"]',
  NULL, NULL,
  '[]'::jsonb),

(7, 22, 'coding', 'advanced',
  'Write fetch_data(url) that:\n1. Sends a GET request\n2. Returns JSON as dict if status 200\n3. Returns None otherwise\n4. Returns "Error" on network exception\n\nAssume requests is imported.',
  NULL, NULL,
  '[{"input":"","expected_output":""}]'),

(7, 24, 'explanation', 'applied',
  'Explain what a RESTful API is and its key design principles. Name at least three HTTP methods and their purposes.',
  NULL, NULL, NULL);


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 8 — Capstone Project  (module_id = 8)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
VALUES
  (26, 8, 'Project Planning',    'Requirements, milestones, MVP scope', 1),
  (27, 8, 'Application Design',  'Architecture, modules, data flow, testing', 2)
ON CONFLICT (id) DO NOTHING;

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases) VALUES

(8, 26, 'multiple_choice', 'foundational',
  'What should you define FIRST when starting a programming project?',
  '[{"label":"A","text":"Write all the code"},{"label":"B","text":"Define requirements and scope"},{"label":"C","text":"Choose a database"},{"label":"D","text":"Design the UI"}]',
  'Define requirements and scope', NULL),

(8, 27, 'multiple_choice', 'applied',
  'What is the main benefit of breaking a large program into smaller functions/modules?',
  '[{"label":"A","text":"It runs faster"},{"label":"B","text":"It uses less memory"},{"label":"C","text":"Improves readability, testability, and reusability"},{"label":"D","text":"Fewer imports needed"}]',
  'Improves readability, testability, and reusability', NULL),

(8, 26, 'short_answer', 'applied',
  'What is an MVP and why is it important? Answer in 2 sentences.',
  NULL,
  'An MVP is the simplest version of a product with core functionality. It allows early testing and feedback before building non-essential features.', NULL),

(8, 27, 'explanation', 'applied',
  'Describe the capstone project you want to build. Include:\n- What problem it solves\n- Which Python concepts from previous modules it uses\n- At least 3 features you plan to implement',
  NULL, NULL, NULL),

(8, 27, 'explanation', 'advanced',
  'Outline a testing strategy for your capstone project. What types of tests would you write and how would you ensure code reliability?',
  NULL, NULL, NULL);

