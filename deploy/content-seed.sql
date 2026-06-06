--
-- PostgreSQL database dump
--

\restrict hi9uduG4x8ewj9oqRmJt4FRdFmv0ZDa70oljR8Dpn5yLa2SDlzn3Tha0flx48SA

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.14 (Debian 16.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (9, 'python-native', 'Python full course', 'A comprehensive zero-to-competent Python course built for The AI Academy — every lesson runs in the in-browser coding environment, with hands-on exercises, quizzes, and generated visuals.', '🐍', 6, true, 'code', '{"inSession": 0.1, "explanation": 0.2, "practiceType": "coding", "finalAssessment": 0.4, "practiceUnaided": 0.3}', NULL);
INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (1, 'python', 'Python Development', 'Learn Python from fundamentals to building real projects.', '🐍', 1, false, 'code', '{"inSession": 0.1, "explanation": 0.2, "practiceType": "coding", "finalAssessment": 0.4, "practiceUnaided": 0.3}', NULL);
INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (2, 'mathematics', 'Mathematics', 'Build intuition for the math behind code — from arithmetic to linear algebra.', '➗', 2, false, 'problem', '{"inSession": 0.1, "explanation": 0.2, "practiceType": "math_problem", "finalAssessment": 0.4, "practiceUnaided": 0.3}', NULL);
INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (3, 'html-css', 'Web Development: HTML & CSS', 'Build and style real web pages — from HTML structure to responsive CSS layouts.', '🌐', 3, false, 'web', '{"inSession": 0.25, "explanation": 0.25, "practiceType": "none", "finalAssessment": 0.5, "practiceUnaided": 0.0}', NULL);
INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (7, 'pratical-python', 'Pratical Python', NULL, '📘', 4, false, 'code', '{"inSession": 0.1, "explanation": 0.2, "practiceType": "coding", "finalAssessment": 0.4, "practiceUnaided": 0.3}', NULL);
INSERT INTO public.subjects (id, slug, name, description, icon, order_index, is_available, practice_kind, mastery_weights, teach_model) VALUES (8, 'python-crash-course', 'Python Crash Course', 'A hands-on introduction to Python — from the basics through real-world projects.', '🐍', 5, false, 'code', '{"inSession": 0.1, "explanation": 0.2, "practiceType": "coding", "finalAssessment": 0.4, "practiceUnaided": 0.3}', NULL);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.books (id, title, subject_id, uploaded_by, status, num_chunks, error, created_at, course_status, course_error, num_modules, num_questions, license, source_url) VALUES (3, 'Python Crash Course', 8, 'b927cde5-e1f7-4f53-9b55-2c37a60a291b', 'ready', 490, NULL, '2026-06-04 16:09:18.099072+00', 'built', NULL, 25, 125, NULL, NULL);


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (1, 'python-fundamentals', 'Python Fundamentals', 'Variables, data types, operators, I/O', 1, 4, 6, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (2, 'control-flow', 'Control Flow', 'if/else, loops (for, while), break/continue', 2, 3, 5, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (3, 'functions', 'Functions', 'Defining functions, scope, return values, recursion basics', 3, 4, 6, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (4, 'data-structures', 'Data Structures', 'Lists, tuples, dicts, sets, list comprehension', 4, 5, 7, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (5, 'oop', 'Object-Oriented Programming', 'Classes, instances, inheritance, encapsulation', 5, 6, 8, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (6, 'file-handling', 'File Handling & Exceptions', 'Reading/writing files, try/except, custom exceptions', 6, 3, 4, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (7, 'working-with-apis', 'Working with APIs', 'HTTP requests, JSON, REST APIs, authentication basics', 7, 4, 6, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (8, 'capstone', 'Capstone Project', 'Learner-chosen project applying all modules; AI-guided', 8, 8, 12, 1, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (17, 'numbers-operations', 'Numbers & Operations', 'Arithmetic, fractions, decimals, percentages, ratios', 1, 3, 5, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (18, 'algebra-basics', 'Algebra Fundamentals', 'Variables, expressions, equations, inequalities', 2, 4, 6, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (19, 'linear-equations', 'Linear Equations & Graphs', 'Slope, intercepts, graphing lines, systems of equations', 3, 4, 6, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (20, 'polynomials', 'Polynomials & Factoring', 'Exponents, polynomial operations, factoring techniques', 4, 4, 6, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (21, 'quadratics', 'Quadratic Equations', 'Quadratic formula, completing the square, discriminant', 5, 4, 6, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (22, 'functions-relations', 'Functions & Relations', 'Notation, domain/range, transformations, inverse functions', 6, 5, 7, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (23, 'geometry-trig', 'Geometry & Trigonometry', 'Angles, triangles, Pythagorean theorem, trig ratios', 7, 5, 7, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (24, 'stats-probability', 'Statistics & Probability', 'Mean/median/mode, probability, data display, events', 8, 4, 6, 2, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (33, 'html-foundations', 'HTML Foundations', 'What HTML is, document structure, elements and attributes', 1, 2, 4, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (34, 'html-text-media', 'Text, Links & Images', 'Formatting text, hyperlinks, and embedding images', 2, 2, 4, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (35, 'html-structure', 'Lists, Tables & Semantic HTML', 'Lists, tables, and semantic structural elements', 3, 3, 5, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (36, 'html-forms', 'Forms & Input', 'Forms, input types, labels, and accessibility', 4, 3, 5, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (37, 'css-foundations', 'CSS Foundations', 'What CSS is, how to add it, syntax and basic selectors', 5, 3, 5, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (38, 'css-selectors', 'Selectors, Specificity & Cascade', 'Combinators, pseudo-classes/elements, specificity, the cascade', 6, 4, 6, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (39, 'css-box-model', 'The Box Model', 'Content, padding, border, margin, box-sizing and display', 7, 3, 5, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (40, 'css-colors-typography', 'Colors, Backgrounds & Typography', 'Color formats, backgrounds, fonts and text styling', 8, 3, 5, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (41, 'css-flexbox-grid', 'Layout: Flexbox & Grid', 'Modern layout with Flexbox and CSS Grid', 9, 4, 6, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (42, 'css-responsive-advanced', 'Responsive Design & Capstone', 'Responsive units, media queries, transitions, animations', 10, 5, 7, 3, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (67, 'b3-m21-installation-and-troubleshooting', 'Installation and Troubleshooting', 'When Windows doesn’t recognize the python command, it will either open the Microsoft Store because it thinks Python isn’t installed, or you’ll get a message suc', 21, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (69, 'b3-m23-getting-help', 'Getting Help', 'Make your answers as specific as possible.', 23, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (71, 'b3-m25-troubleshooting-deployments', 'Troubleshooting Deployments', 'Understanding Deployments When you’re trying to troubleshoot a particular deployment attempt, it’s helpful to have a clear understanding of how a typical deployment works.', 25, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (47, 'b3-m1-getting-started', 'Getting Started', 'Python Versions Every programming language evolves as new ideas and technologies emerge, and the developers of Python have continually made the language more versatile and powerful.', 1, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (48, 'b3-m2-variables-and-simple-data-types', 'Variables and Simple Data Types', 'When you run the file hello_world.py, the ending .py indicates that the file is a Python program.', 2, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (49, 'b3-m3-introducing-lists', 'Introducing Lists', 'a list usually contains more than one element, it’s a good idea to make the name of your list plural, such as letters, digits, or names.', 3, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (50, 'b3-m4-working-with-lists', 'Working with Lists', 'Or perhaps you’ll want to display each headline from a list of articles on a website.', 4, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (51, 'b3-m5-if-statements', 'if Statements', 'A Simple Example The following example shows how if tests let you respond to special situations correctly.', 5, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (52, 'b3-m6-dictionaries', 'Dictionaries', 'A Simple Dictionary Consider a game featuring aliens that can have different colors and point values.', 6, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (53, 'b3-m7-user-input-and-while-loops', 'User Input and while Loops', 'program can work with that information.', 7, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (54, 'b3-m8-functions', 'Functions', 'Defining a Function Here’s a simple function named greet_user() that prints a greeting: greeter.py def greet_user(): """Display a simple greeting.""" print("Hel', 8, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (55, 'b3-m9-classes', 'Classes', 'less code.', 9, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (56, 'b3-m10-files-and-exceptions', 'Files and Exceptions', 'innocent mistakes or from malicious attempts to break your programs.', 10, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (57, 'b3-m11-testing-your-code', 'Testing Your Code', 'You’ll learn to build a series of tests and check that each set of inputs results in the output you want.', 11, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (58, 'b3-m12-a-ship-that-fires-bullets', 'A Ship That Fires Bullets', 'Making games is an ideal way to have fun while learning a language.', 12, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (59, 'b3-m13-aliens', 'Aliens!', 'Reviewing the Project When you’re beginning a new phase of development on a large project, it’s always a good idea to revisit your plan and clarify what you wan', 13, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (60, 'b3-m14-scoring', 'Scoring', 'Adding the Play Button In this section, we’ll add a Play button that appears before a game begins and reappears when the game ends so the player can play again.', 14, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (61, 'b3-m15-generating-data', 'Generating Data', 'have to be numbers; with the basics you learned in the first part of this book, you can analyze non-numerical data as well.', 15, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (62, 'b3-m16-downloading-data', 'Downloading Data', 'By the end of this chapter, you’ll be prepared to work with various types of datasets in different formats, and you’ll have a deeper understanding of how to build complex visualizations.', 16, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (63, 'b3-m17-working-with-apis', 'Working with APIs', 'easily processed format, such as JSON or CSV.', 17, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (64, 'b3-m18-getting-started-with-django', 'Getting Started with Django', 'you’ll refine the Learning Log project, and then deploy it to a live server so you (and everyone else in the world) can use it.', 18, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (65, 'b3-m19-user-accounts', 'User Accounts', 'Allowing Users to Enter Data Before we build an authentication system for creating accounts, we’ll first add some pages that allow users to enter their own data.', 19, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (66, 'b3-m20-styling-and-deploying-an-app', 'Styling and Deploying an App', 'When you’re finished with Learning Log, you’ll be able to develop simple web applications, give them a professional look and feel, and deploy them to a live server.', 20, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (68, 'b3-m22-text-editors-and-ides', 'Text Editors and IDEs', 'also be overwhelming as a beginner and difficult to troubleshoot when you aren’t sure why your code isn’t working in the IDE.', 22, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (70, 'b3-m24-using-git-for-version-control', 'Using Git for Version Control', 'Installing Git Git runs on all operating systems, but there are different approaches to installing it on each system.', 24, 1, 2, 8, 3, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (72, 'pyn-your-first-program-how-code-runs-here', 'Your first program & how code runs here', 'Welcome to your first Python module! Here, you''ll learn how to write and run simple Python code in our interactive environment, understand basic program output, and get acquainted with how our sandbox executes your code.', 1, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (73, 'pyn-variables-data-types', 'Variables & data types', 'Learn how to store and label data using variables, understand Python''s core data types, and perform basic type conversions.', 2, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (74, 'pyn-strings-in-depth', 'Strings in depth', 'Dive deeper into Python strings, learning how to access parts of them, modify their appearance, and work with multi-line text and special characters.', 3, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (75, 'pyn-numbers-arithmetic', 'Numbers & arithmetic', 'This module introduces you to Python''s numerical types and arithmetic operators, allowing you to perform calculations and manipulate numbers in your code.', 4, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (76, 'pyn-lists', 'Lists', 'This module introduces lists, Python''s versatile ordered collection type. You''ll learn how to create, access, and modify lists to store and manage multiple pieces of data.', 5, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (77, 'pyn-looping-over-data', 'Looping over data', 'This module introduces how to repeat actions over collections of data using ''for'' loops, a fundamental concept for processing lists, strings, and other sequences in Python.', 6, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (78, 'pyn-tuples-immutability', 'Tuples & immutability', 'This module introduces tuples, an immutable sequence type in Python, and explores their key characteristics, including how to create them, their immutability, and the powerful technique of tuple unpacking.', 7, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (79, 'pyn-dictionaries', 'Dictionaries', 'Learn how to use dictionaries in Python to store data as key-value pairs, allowing for efficient data retrieval and organization.', 8, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (80, 'pyn-nested-data-structures', 'Nested data structures', 'This module explores how to use nested data structures like lists of dictionaries or dictionaries of lists to model more complex, real-world data relationships in Python.', 9, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (81, 'pyn-conditionals-boolean-logic', 'Conditionals & boolean logic', 'This module introduces conditional statements and boolean logic, empowering your Python programs to make decisions and execute different code paths based on various conditions.', 10, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (82, 'pyn-while-loops-program-flow', 'while loops & program flow', 'This module introduces ''while'' loops, a fundamental control flow structure for repeating code blocks as long as a condition remains true. You''ll learn how to manage loop execution and prevent common pitfalls.', 11, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (83, 'pyn-processing-data-loops-conditionals', 'Processing data (loops + conditionals)', 'This module teaches you how to combine loops and conditionals to process and analyze data, covering techniques like filtering, mapping, and aggregating information.', 12, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (84, 'pyn-defining-functions', 'Defining functions', 'This module introduces how to define and use functions in Python to organize code into reusable blocks, improving readability and maintainability.', 13, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (85, 'pyn-arguments-in-depth', 'Arguments in depth', 'This module explores advanced ways to define and call Python functions, allowing for more flexible and powerful interfaces using positional arguments, keyword arguments, default values, and variable argument lists.', 14, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (86, 'pyn-modules-organizing-code', 'Modules & organizing code', 'Learn how to organize your Python code into reusable modules, access the Python Standard Library, and improve code readability and maintainability.', 15, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (87, 'pyn-classes-objects', 'Classes & objects', 'In this module, you''ll learn how to create your own custom data types using classes, allowing you to bundle data and the functions that operate on that data into a single, organized unit.', 16, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (88, 'pyn-inheritance-composition', 'Inheritance & composition', 'Learn how to reuse and extend code in Python using inheritance and composition, two fundamental principles of object-oriented programming for building flexible and maintainable systems.', 17, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (89, 'pyn-modeling-with-classes', 'Modeling with classes', 'Learn to design small object models by creating multiple cooperating classes, understanding string representations, and managing collections of instances.', 18, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (90, 'pyn-files-exceptions-json', 'Files & exceptions (+ JSON)', 'Learn how to store and retrieve data using files, handle unexpected errors gracefully with exceptions, and work with JSON data in Python.', 19, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (91, 'pyn-testing-your-code', 'Testing your code', 'This module introduces the fundamental concepts of testing your Python code to ensure its correctness and reliability. You''ll learn how to write automated tests to verify your code''s behavior.', 20, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (92, 'pyn-capstone-a-data-analysis-visualization', 'Capstone A: Data analysis & visualization', 'In this capstone, you''ll apply your Python skills to load and analyze a dataset, then visualize your findings using Matplotlib to create informative charts.', 21, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (93, 'pyn-capstone-b-a-text-based-logic-game', 'Capstone B: A text-based logic game', 'In this capstone, you''ll apply your knowledge of Python to build a text-based logic game, integrating concepts like game state, loops, conditionals, and classes into a single program.', 22, 1, 2, 9, NULL, true);
INSERT INTO public.modules (id, slug, title, description, order_index, estimated_hours_min, estimated_hours_max, subject_id, book_id, published) VALUES (94, 'pyn-capstone-c-simulation-generative-art', 'Capstone C: Simulation & generative art', 'In this capstone module, you''ll apply your Python skills to model real-world processes using simulation techniques and visualize the results, including creating generative art.', 23, 1, 2, 9, NULL, true);


--
-- Data for Name: concepts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (1, 1, 'Variables & Assignment', 'Creating variables, naming rules, dynamic typing', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (2, 1, 'Data Types', 'int, float, str, bool, type(), conversion', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (3, 1, 'Operators & Expressions', 'Arithmetic, comparison, logical operators, precedence', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (4, 1, 'Input & Output', 'print(), input(), f-strings', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (5, 2, 'Conditional Statements', 'if, elif, else, nested conditions', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (6, 2, 'For Loops', 'Iteration over sequences, range()', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (7, 2, 'While Loops', 'Condition-controlled loops', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (8, 2, 'Flow Modifiers', 'break, continue, pass, else on loops', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (9, 3, 'Defining Functions', 'def, parameters, return values, docstrings', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (10, 3, 'Scope & Arguments', 'Local vs global scope, default args, *args, **kwargs', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (11, 3, 'Recursion', 'Base case, recursive calls, stack depth', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (12, 4, 'Lists', 'Creating, indexing, slicing, list methods', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (13, 4, 'Tuples & Dictionaries', 'Immutable tuples, key-value dicts, dict methods', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (14, 4, 'Sets', 'Set creation, union, intersection, difference', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (15, 4, 'List Comprehensions', 'Basic comprehensions, conditionals, nested', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (16, 5, 'Classes & Instances', 'class, __init__, self, attributes, methods', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (17, 5, 'Inheritance', 'Parent/child classes, super(), method overriding', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (18, 5, 'Encapsulation', 'Private attributes, @property, name mangling', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (19, 6, 'File I/O', 'open(), read(), write(), with statement, modes', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (20, 6, 'Exception Handling', 'try, except, else, finally, raising exceptions', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (21, 6, 'Custom Exceptions', 'Extending Exception class, raising custom errors', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (22, 7, 'HTTP Requests', 'GET, POST, status codes, requests library', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (23, 7, 'JSON Handling', 'json.loads(), json.dumps(), working with JSON data', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (24, 7, 'REST API Design', 'Endpoints, resources, CRUD operations', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (25, 7, 'Authentication', 'API keys, tokens, basic auth, headers', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (26, 8, 'Project Planning', 'Requirements, milestones, MVP scope', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (27, 8, 'Application Design', 'Architecture, modules, data flow, testing', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (28, 17, 'Arithmetic Fundamentals', 'Basic operations with integers, order of operations, number properties', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (29, 17, 'Fractions & Decimals', 'Converting between fractions and decimals, operations with fractions', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (30, 17, 'Ratios & Proportions', 'Comparing quantities, proportional relationships, unit rates', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (31, 17, 'Percentages', 'Percentage calculations, increases and decreases, real-world applications', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (32, 18, 'Variables & Expressions', 'Understanding variables, writing algebraic expressions, translating words to math', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (33, 18, 'Simplifying Expressions', 'Combining like terms, distributive property, simplifying', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (34, 18, 'Solving Equations', 'One-step and multi-step equations, isolating the variable', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (35, 18, 'Inequalities', 'Solving and graphing inequalities, compound inequalities', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (36, 19, 'Slope & Rate of Change', 'Calculating slope from points and equations, steepness and direction', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (37, 19, 'Y-Intercept & X-Intercept', 'Identifying intercepts from equations and graphs, meaning of intercepts', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (38, 19, 'Graphing Lines', 'Plotting lines from slope-intercept, standard, and point-slope form', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (39, 19, 'Systems of Equations', 'Solving systems by substitution, elimination, and graphical method', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (40, 20, 'Exponents & Powers', 'Laws of exponents, zero and negative exponents, scientific notation', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (41, 20, 'Polynomial Operations', 'Adding, subtracting, multiplying polynomials, degree and leading coefficient', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (42, 20, 'Factoring Basics', 'Greatest common factor, factoring by grouping, factoring trinomials', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (43, 20, 'Special Factoring Patterns', 'Difference of squares, perfect square trinomials, sum/difference of cubes', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (44, 21, 'Standard Form & Vertex Form', 'ax² + bx + c form, a(x-h)² + k form, converting between forms', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (45, 21, 'Factoring Quadratics', 'Factoring trinomials, finding roots by factoring, zero product property', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (46, 21, 'Quadratic Formula', 'Deriving and applying x = (-b ± sqrt(b²-4ac)) / 2a, solving any quadratic', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (47, 21, 'The Discriminant', 'Using b² - 4ac to determine number and type of solutions', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (48, 22, 'Function Notation & Evaluation', 'f(x) notation, evaluating functions, input/output tables', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (49, 22, 'Domain & Range', 'Identifying valid inputs and outputs, interval notation', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (50, 22, 'Function Transformations', 'Shifts, reflections, stretches, and compressions of function graphs', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (51, 22, 'Inverse Functions', 'Finding and verifying inverses, horizontal line test, notation', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (52, 23, 'Angles & Lines', 'Types of angles, parallel and perpendicular lines, angle relationships', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (53, 23, 'Triangles & Pythagorean Theorem', 'Triangle classification, Pythagorean theorem, special right triangles', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (54, 23, 'Trigonometric Ratios', 'Sine, cosine, tangent definitions and applications in right triangles', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (55, 23, 'Area & Perimeter', 'Area and perimeter formulas for triangles, rectangles, circles, composites', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (56, 24, 'Measures of Central Tendency', 'Mean, median, mode, weighted averages, choosing the best measure', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (57, 24, 'Data Display & Interpretation', 'Bar charts, histograms, box plots, scatter plots, reading data', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (58, 24, 'Basic Probability', 'Probability as fraction, decimal, percentage; experimental vs theoretical', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (59, 24, 'Combined Events', 'Independent and dependent events, addition rule, multiplication rule', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (60, 33, 'What HTML Is', 'The role of HTML; elements, tags and attributes', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (61, 33, 'Document Structure', 'DOCTYPE, html, head and body', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (62, 33, 'Headings & Paragraphs', 'h1-h6, paragraphs and line breaks', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (63, 33, 'Attributes & Comments', 'Global attributes and HTML comments', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (64, 34, 'Text Formatting', 'strong, em, b, i, mark and small', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (65, 34, 'Hyperlinks', 'The a element, href, target, relative vs absolute URLs', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (66, 34, 'Images', 'The img element, src, alt and dimensions', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (67, 34, 'Inline vs Block', 'Inline and block element categories', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (68, 35, 'Lists', 'Unordered, ordered and description lists', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (69, 35, 'Tables', 'table, tr, th, td and table sections', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (70, 35, 'Semantic Elements', 'header, nav, main, section, article, aside, footer', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (71, 35, 'Div, Span & Grouping', 'Generic containers and document outline', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (72, 36, 'The Form Element', 'form, action and method', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (73, 36, 'Input Types', 'text, email, password, number, checkbox, radio', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (74, 36, 'Labels & Accessibility', 'label, for, fieldset and legend', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (75, 36, 'Selects, Textareas, Buttons', 'select, option, textarea, button and validation', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (76, 37, 'What CSS Is & How to Add It', 'Inline, internal and external CSS', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (77, 37, 'CSS Syntax', 'Selectors, properties, values and declaration blocks', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (78, 37, 'Basic Selectors', 'Type, class and id selectors', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (79, 37, 'Colors & Units Intro', 'Basic color values and length units', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (80, 38, 'Combinators', 'Descendant, child and sibling combinators', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (81, 38, 'Pseudo-classes', 'hover, focus, nth-child and friends', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (82, 38, 'Pseudo-elements', 'before, after and first-line', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (83, 38, 'Specificity & the Cascade', 'How conflicting rules and inheritance resolve', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (84, 39, 'Content, Padding, Border, Margin', 'The four layers of every box', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (85, 39, 'box-sizing', 'content-box vs border-box', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (86, 39, 'Display & Visibility', 'block, inline, inline-block, none', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (87, 39, 'Sizing & Overflow', 'width, height and overflow', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (88, 40, 'Color Formats', 'Named, hex, rgb/rgba and hsl', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (89, 40, 'Backgrounds', 'background-color, image, position and size', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (90, 40, 'Fonts', 'font-family, web fonts, size and weight', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (91, 40, 'Text Styling', 'Alignment, decoration, spacing and line-height', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (92, 41, 'Flex Container', 'display:flex, direction and wrap', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (93, 41, 'Flex Alignment', 'justify-content, align-items and gap', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (94, 41, 'Grid Basics', 'display:grid and template tracks', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (95, 41, 'Grid Placement', 'Areas, spanning and gaps', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (96, 42, 'Responsive Units & Viewport', 'Percent, em/rem, vw/vh and the viewport meta', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (97, 42, 'Media Queries', 'Breakpoints and mobile-first design', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (98, 42, 'Transitions & Transforms', 'Smooth state changes and transforms', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (99, 42, 'Animations & Capstone', 'Keyframe animations; building a full page', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (104, 47, 'Getting Started', 'Python Versions Every programming language evolves as new ideas and technologies emerge, and the developers of Python have continually made the language more versatile and powerful.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (105, 48, 'Variables and Simple Data Types', 'When you run the file hello_world.py, the ending .py indicates that the file is a Python program.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (106, 49, 'Introducing Lists', 'a list usually contains more than one element, it’s a good idea to make the name of your list plural, such as letters, digits, or names.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (107, 50, 'Working with Lists', 'Or perhaps you’ll want to display each headline from a list of articles on a website.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (108, 51, 'if Statements', 'A Simple Example The following example shows how if tests let you respond to special situations correctly.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (109, 52, 'Dictionaries', 'A Simple Dictionary Consider a game featuring aliens that can have different colors and point values.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (110, 53, 'User Input and while Loops', 'program can work with that information.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (111, 54, 'Functions', 'Defining a Function Here’s a simple function named greet_user() that prints a greeting: greeter.py def greet_user(): """Display a simple greeting.""" print("Hel', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (112, 55, 'Classes', 'less code.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (113, 56, 'Files and Exceptions', 'innocent mistakes or from malicious attempts to break your programs.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (114, 57, 'Testing Your Code', 'You’ll learn to build a series of tests and check that each set of inputs results in the output you want.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (115, 58, 'A Ship That Fires Bullets', 'Making games is an ideal way to have fun while learning a language.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (116, 59, 'Aliens!', 'Reviewing the Project When you’re beginning a new phase of development on a large project, it’s always a good idea to revisit your plan and clarify what you wan', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (117, 60, 'Scoring', 'Adding the Play Button In this section, we’ll add a Play button that appears before a game begins and reappears when the game ends so the player can play again.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (118, 61, 'Generating Data', 'have to be numbers; with the basics you learned in the first part of this book, you can analyze non-numerical data as well.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (119, 62, 'Downloading Data', 'By the end of this chapter, you’ll be prepared to work with various types of datasets in different formats, and you’ll have a deeper understanding of how to build complex visualizations.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (120, 63, 'Working with APIs', 'easily processed format, such as JSON or CSV.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (121, 64, 'Getting Started with Django', 'you’ll refine the Learning Log project, and then deploy it to a live server so you (and everyone else in the world) can use it.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (122, 65, 'User Accounts', 'Allowing Users to Enter Data Before we build an authentication system for creating accounts, we’ll first add some pages that allow users to enter their own data.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (123, 66, 'Styling and Deploying an App', 'When you’re finished with Learning Log, you’ll be able to develop simple web applications, give them a professional look and feel, and deploy them to a live server.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (124, 67, 'Installation and Troubleshooting', 'When Windows doesn’t recognize the python command, it will either open the Microsoft Store because it thinks Python isn’t installed, or you’ll get a message suc', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (125, 68, 'Text Editors and IDEs', 'also be overwhelming as a beginner and difficult to troubleshoot when you aren’t sure why your code isn’t working in the IDE.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (126, 69, 'Getting Help', 'Make your answers as specific as possible.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (127, 70, 'Using Git for Version Control', 'Installing Git Git runs on all operating systems, but there are different approaches to installing it on each system.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (128, 71, 'Troubleshooting Deployments', 'Understanding Deployments When you’re trying to troubleshoot a particular deployment attempt, it’s helpful to have a clear understanding of how a typical deployment works.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (129, 72, 'The print() Function', 'Learn how to use the fundamental print() function to display messages and values in the output console.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (130, 72, 'Running Code & The Editor Loop', 'Understand the process of writing code in the editor and executing it to see immediate results in the output area.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (131, 72, 'Comments in Python', 'Discover how to add comments to your code to make it more readable and explain its purpose without affecting execution.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (132, 72, 'Syntax Errors', 'Identify common syntax errors that prevent your Python code from running correctly and learn how to fix them.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (133, 72, 'Non-Interactive Execution', 'Grasp the concept that your code runs once without user interaction, requiring you to use hardcoded values instead of input().', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (134, 73, 'Variable Assignment & Naming', 'Variables are used to store data. We''ll cover how to assign values to variables and the rules for naming them effectively.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (135, 73, 'Core Data Types: int, float, str, bool', 'Explore Python''s fundamental data types: integers (int), floating-point numbers (float), strings (str), and booleans (bool).', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (136, 73, 'Checking Data Types with type()', 'Discover how to use the built-in type() function to determine the data type of any variable or value.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (137, 73, 'Formatted String Literals (f-strings)', 'Learn to embed expressions inside string literals using f-strings for easy and readable string formatting.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (138, 73, 'Type Conversion Functions', 'Understand how to convert data from one type to another using functions like int(), float(), and str().', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (139, 74, 'String Indexing and Slicing', 'Access individual characters or extract substrings using numerical indices and slicing notation.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (140, 74, 'Common String Methods', 'Learn to use built-in methods like ''upper()'', ''lower()'', ''strip()'', ''replace()'', ''split()'', and ''join()'' to transform strings.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (141, 74, 'String Operators and Functions', 'Discover how to check for substring presence with ''in'' and find string length with ''len()''.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (142, 74, 'Multi-line Strings and Escape Sequences', 'Understand how to create strings spanning multiple lines and use escape sequences for special characters.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (143, 75, 'Basic Arithmetic Operators', 'Learn about the fundamental operators like addition (+), subtraction (-), multiplication (*), and division (/) for performing calculations.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (144, 75, 'Integer Division and Modulo', 'Explore integer division (//) for whole number results and the modulo operator (%) to find the remainder of a division.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (145, 75, 'Operator Precedence and Exponentiation', 'Understand the order in which operations are performed (precedence) and how to calculate powers using the exponentiation operator (**).', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (146, 75, 'Integers, Floats, and Numeric Literals', 'Differentiate between integer (whole number) and float (decimal number) types, and learn how to write various numeric values in Python.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (147, 75, 'Built-in Numeric Functions', 'Discover useful built-in functions like abs() for absolute value, round() for rounding, and min()/max() for finding the smallest/largest numbers.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (148, 76, 'List Literals', 'Learn to create lists using square brackets and comma-separated values, and understand what makes them ordered and mutable.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (149, 76, 'Indexing and Slicing', 'Access individual elements using positive and negative indices, and extract sub-sequences using slicing with start, stop, and step values.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (150, 76, 'List Methods for Modification', 'Discover common list methods like append(), insert(), remove(), and pop() to add, delete, and rearrange elements within a list.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (151, 76, 'Sorting and Reversing Lists', 'Explore how to sort lists in place with sort() or create a new sorted list with sorted(), and reverse the order of elements using reverse().', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (152, 76, 'List Length and Copying', 'Determine the number of elements in a list using len() and understand the difference between modifying a list and creating a separate copy.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (153, 77, 'Introduction to ''for'' Loops', 'Learn the basic syntax of ''for'' loops to iterate over elements in sequences like lists and strings.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (154, 77, 'Looping with ''range()''', 'Discover how to use the ''range()'' function to generate sequences of numbers, useful for iterating a specific number of times or accessing elements by index.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (155, 77, 'Indentation and Code Blocks', 'Understand the critical role of indentation in Python to define code blocks that belong to a loop or other control structures.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (156, 77, 'The Accumulator Pattern', 'Explore the accumulator pattern, where a variable is initialized before a loop and updated iteratively to build a result, such as a sum or a new list.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (157, 77, 'Introduction to List Comprehensions', 'Get a first look at list comprehensions, a concise way to create new lists based on existing sequences using a single line of code.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (158, 78, 'Tuple Literals and Creation', 'Learn how to define tuples using parentheses and commas, and understand their basic structure as ordered collections of items.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (159, 78, 'Immutability of Tuples', 'Discover what ''immutable'' means in the context of tuples and how it differentiates them from lists, preventing modification after creation.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (160, 78, 'Tuple Unpacking', 'Master the technique of assigning elements of a tuple to multiple variables simultaneously, a process known as tuple unpacking.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (161, 78, 'When to Use Tuples', 'Understand the practical scenarios where tuples are a more suitable choice than lists, especially for fixed collections of related data.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (162, 78, 'Returning Multiple Values from Functions', 'Explore how functions can implicitly return multiple values as a tuple, which can then be conveniently unpacked by the caller.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (163, 79, 'Dictionary Literals and Basic Operations', 'Understand how to create dictionaries using curly braces, access values by key, and add, update, or delete key-value pairs.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (164, 79, 'Dictionary Methods: .get(), .keys(), .values(), .items()', 'Explore useful dictionary methods for safely retrieving values, and for getting views of all keys, values, or key-value pairs.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (165, 79, 'Iterating and Membership Testing', 'Learn how to loop through dictionaries and check for the presence of a key using the ''in'' operator.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (166, 79, 'Counting Patterns with Dictionaries', 'Discover how dictionaries can be used to efficiently count the occurrences of items in a collection.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (167, 80, 'Lists of Dictionaries', 'Learn how to represent collections of structured items, where each item is a dictionary containing related key-value pairs.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (168, 80, 'Dictionaries of Lists', 'Understand how to use dictionaries where values are lists, useful for grouping multiple items under a single key.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (169, 80, 'Nested Indexing and Access', 'Master the syntax for accessing specific elements within deeply nested data structures using a combination of square brackets and keys.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (170, 80, 'Iterating Nested Structures', 'Discover effective ways to loop through and process data stored in nested lists and dictionaries.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (171, 80, 'Choosing Data Shapes', 'Learn to decide whether a list of dictionaries, a dictionary of lists, or another nested structure best fits a given data modeling problem.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (172, 81, 'if, elif, and else Statements', 'Learn how to use ''if'', ''elif'' (else if), and ''else'' keywords to control the flow of your program based on whether certain conditions are true or false.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (173, 81, 'Comparison Operators', 'Understand how to compare values using operators like ''=='', ''!='', ''<'', ''>'', ''<='', and ''>='' to form conditions for your conditional statements.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (174, 81, 'Boolean Operators (and, or, not)', 'Discover how to combine multiple conditions or negate a condition using ''and'', ''or'', and ''not'' to create more complex logical expressions.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (175, 81, 'Truthiness and Falsiness', 'Explore the concept of ''truthiness'' in Python, where various data types and values can be evaluated as true or false in a boolean context, even if they are not explicitly ''True'' or ''False''.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (176, 81, 'Conditional Expressions (Ternary Operator)', 'Learn about the concise conditional expression (often called a ternary operator) for assigning values based on a condition in a single line.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (177, 82, 'Introduction to while Loops', 'Understand the basic syntax and purpose of a ''while'' loop for repeating code based on a condition.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (178, 82, 'Loop Variables and Termination', 'Learn how to use and update variables within a ''while'' loop to control its execution and ensure it eventually stops.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (179, 82, 'break and continue Statements', 'Explore ''break'' to exit a loop prematurely and ''continue'' to skip the rest of the current iteration and move to the next.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (180, 82, 'Avoiding Infinite Loops', 'Identify common causes of infinite loops and strategies to prevent them, ensuring your programs terminate correctly.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (181, 82, 'Simulating User Input', 'Discover how to use a predefined list to simulate user input within a ''while'' loop, which is useful for testing and scenarios where direct input() is not available.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (182, 83, 'Filtering Data with Conditionals', 'Learn how to use ''if'' statements inside loops to select specific items from a collection based on certain criteria.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (183, 83, 'Mapping Data with Transformations', 'Discover how to iterate through data and apply transformations to each item, creating new data based on the original values.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (184, 83, 'Aggregating Data for Summaries', 'Understand how to accumulate information from a collection using loops to calculate sums, counts, averages, or other summary statistics.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (185, 83, 'Guard Clauses for Robust Logic', 'Explore the use of guard clauses (early exits or checks) to handle edge cases and improve the readability and robustness of your conditional logic.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (186, 83, 'Nested Loops for Complex Processing', 'Learn how to use loops within loops to process multi-dimensional data structures or perform operations that require comparing every item with every other item.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (187, 84, 'Defining Functions with ''def''', 'Learn the basic syntax for creating a function using the ''def'' keyword, a function name, parentheses, and a colon.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (188, 84, 'Function Parameters and Arguments', 'Understand how to define parameters within a function''s signature and pass arguments to them when calling the function.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (189, 84, 'Returning Values vs. Printing', 'Differentiate between a function returning a value using ''return'' and simply displaying output using ''print()'', and when to use each.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (190, 84, 'Calling Functions', 'Discover how to execute a defined function by calling its name followed by parentheses, passing any necessary arguments.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (191, 84, 'Docstrings for Documentation', 'Learn to write docstrings to explain what a function does, its parameters, and what it returns, making code easier to understand.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (192, 85, 'Positional and Keyword Arguments', 'Understand the difference between passing arguments by their position and by explicitly naming the parameter they correspond to.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (193, 85, 'Default Argument Values', 'Learn how to provide default values for function parameters, making them optional when calling the function.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (194, 85, 'Variable Positional Arguments (*args)', 'Discover how to define functions that can accept an arbitrary number of positional arguments using *args.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (195, 85, 'Variable Keyword Arguments (**kwargs)', 'Explore how to define functions that can accept an arbitrary number of keyword arguments using **kwargs.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (196, 85, 'The Mutable Default Argument Gotcha', 'Identify and understand the common pitfall of using mutable objects (like lists or dictionaries) as default argument values.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (197, 86, 'The Standard Library', 'Discover Python''s built-in modules that provide a rich set of tools for common programming tasks, from mathematics to data handling.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (198, 86, 'Importing Modules', 'Understand how to bring external modules or specific parts of them into your current script using the ''import'' and ''from...import'' statements.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (199, 86, 'Module Aliasing', 'Learn how to use the ''as'' keyword to create shorter, more convenient names (aliases) for imported modules or their contents.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (200, 86, 'Common Standard Library Modules', 'Explore practical examples of frequently used modules like ''math'' for mathematical operations, ''random'' for generating random numbers, and ''datetime'' for working with dates and times.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (201, 86, 'Organizing Code with Functions', 'Reinforce the importance of functions in structuring larger programs, making them modular, reusable, and easier to debug.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (202, 87, 'Defining Classes and Objects', 'Understand what a class is as a blueprint and an object (instance) is as a concrete realization of that blueprint.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (203, 87, 'The __init__ Method and Attributes', 'Learn how the special `__init__` method is used to initialize an object''s state and define its attributes (data).', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (204, 87, 'Instance Methods and ''self''', 'Discover how to define methods (functions) within a class that operate on an object''s data, and the role of the `self` parameter.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (205, 87, 'Creating and Interacting with Instances', 'Practice creating multiple objects from a single class and accessing or modifying their attributes and calling their methods.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (206, 88, 'Subclassing and Inheritance', 'Understand how to create new classes (subclasses) that inherit attributes and methods from existing classes (superclasses), promoting code reuse and establishing ''is-a'' relationships.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (207, 88, 'super().__init__() and Method Overriding', 'Learn to properly initialize superclass components in a subclass using super().__init__() and how to customize inherited method behavior through method overriding.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (208, 88, 'Composition', 'Explore composition, an alternative to inheritance where a class contains instances of other classes as attributes, fostering ''has-a'' relationships and greater flexibility.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (209, 88, 'Inheritance vs. Composition', 'Differentiate between inheritance and composition, understanding their respective strengths and weaknesses to choose the appropriate design pattern for different scenarios.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (210, 89, 'Multiple Cooperating Classes', 'Understand how to design and implement multiple classes that work together to model a system or solve a problem.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (211, 89, '__str__ and __repr__ Methods', 'Learn the purpose and implementation of the __str__ and __repr__ special methods for providing user-friendly and unambiguous string representations of objects.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (212, 89, 'Encapsulation and Data Hiding', 'Explore the principle of encapsulation, using private attributes and public methods to control access to an object''s internal state.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (213, 89, 'Classes Managing Collections', 'Discover how to design a class whose primary responsibility is to manage a collection of instances of another class.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (214, 90, 'Pyodide''s In-Memory Filesystem', 'Understand how Pyodide provides a temporary, in-memory filesystem for file operations within the browser environment.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (215, 90, 'Reading and Writing Text Files', 'Master the ''open()'' function and the ''with'' statement for safely reading from and writing to text files.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (216, 90, 'Handling Exceptions with try/except', 'Learn to anticipate and manage errors using ''try'', ''except'', ''else'', and ''finally'' blocks to make your code more robust.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (217, 90, 'Understanding Exception Types', 'Explore common built-in exception types and how to catch specific errors for more precise error handling.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (218, 90, 'Working with JSON Data', 'Discover how to serialize Python objects to JSON strings (''json.dumps'') and deserialize JSON strings back to Python objects (''json.loads'').', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (219, 91, 'Introduction to Assertions', 'Understand the ''assert'' statement in Python and how it''s used to check if a condition is true, raising an AssertionError if false.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (220, 91, 'unittest Module Basics', 'Learn the basics of Python''s built-in ''unittest'' module, including test cases, test methods, and running tests.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (221, 91, 'Writing Effective Test Cases', 'Discover how to design and implement test cases that cover different scenarios, including typical inputs, edge cases, and error conditions.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (222, 91, 'Test-Driven Development (TDD)', 'Explore the concept of Test-Driven Development, where tests are written before the code they are meant to validate.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (223, 91, 'Interpreting Test Failures', 'Learn how to read and understand the output from failing tests to quickly identify and debug issues in your code.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (224, 92, 'Loading In-Lesson Data', 'Learn how to access and prepare pre-loaded datasets provided within the learning environment for analysis.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (225, 92, 'Calculating Summary Statistics', 'Understand how to compute basic descriptive statistics (like mean, median, min, max) to gain insights from your data.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (226, 92, 'Matplotlib Basics: Line, Bar, and Scatter Plots', 'Explore the fundamental Matplotlib functions to create different types of plots suitable for various data relationships.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (227, 92, 'Customizing Plots: Labels and Titles', 'Discover how to add meaningful labels to axes and a descriptive title to your plots for clarity and better communication.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (228, 92, 'Interpreting Visualized Data', 'Develop the skill of drawing conclusions and identifying patterns by critically examining the charts you generate.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (229, 93, 'Game State Management', 'Understanding how to represent and update the current status of a game, including player position, inventory, and other dynamic elements.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (230, 93, 'Game Loop and Turn Logic', 'Implementing a loop that processes game turns, often driven by a sequence of predefined actions or events, and updating the game state accordingly.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (231, 93, 'Win/Loss Conditions', 'Defining and checking criteria that determine when the game ends, either in a victory or a defeat for the player.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (232, 93, 'Object-Oriented Game Design', 'Using classes to structure game elements, such as a ''Game'' class to encapsulate game logic and state, or ''Player'' and ''Item'' classes.', 4);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (233, 93, 'Introducing Randomness', 'Incorporating random elements to add variability and replayability to the game, such as random events or item placements.', 5);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (234, 94, 'Monte Carlo Simulation Basics', 'Learn the fundamental idea behind Monte Carlo simulations: using random sampling to obtain numerical results for problems that might be too complex to solve analytically.', 1);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (235, 94, 'Generating Randomness', 'Explore Python''s `random` module to generate various types of random numbers and sequences, essential for simulating unpredictable events.', 2);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (236, 94, 'Accumulating Simulation Results', 'Understand how to run multiple trials in a simulation, collect and store the outcomes, and then analyze the aggregated data to draw conclusions.', 3);
INSERT INTO public.concepts (id, module_id, title, description, order_index) VALUES (237, 94, 'Visualizing Simulations with Matplotlib', 'Use Matplotlib to create plots and visualizations of your simulation results, making complex data understandable and revealing patterns, including generative art.', 4);


--
-- Data for Name: concept_briefs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('0ff2873f-dee0-4f95-bda5-64b707354fc6', 236, '["Simulation often requires running multiple trials to observe typical outcomes and variations.", "To analyze simulation results, you need to systematically collect and store data from each trial.", "Lists are a common and flexible Python data structure for accumulating trial results.", "After collecting data, aggregation (e.g., calculating averages, counts, distributions) helps in drawing conclusions.", "Ensure your simulation loop correctly appends the relevant outcome of each trial to your results accumulator."]', 'Let''s say we''re simulating a coin flip. Instead of just one flip, we want to simulate 10 trials, where each trial consists of 5 coin flips, and we want to record the number of heads in each trial.

python
import random

def simulate_flips(num_flips):
    heads = 0
    for _ in range(num_flips):
        if random.random() < 0.5: # 50% chance for heads
            heads += 1
    return heads

results = [] # Initialize an empty list to store outcomes
num_trials = 10
flips_per_trial = 5

for trial in range(num_trials):
    heads_in_trial = simulate_flips(flips_per_trial)
    results.append(heads_in_trial) # Accumulate the result of each trial

print(f"Results from {num_trials} trials (heads in {flips_per_trial} flips per trial): {results}")

# Analyzing aggregated data (e.g., average heads)
# Note: This specific example might produce slightly different random numbers each run due to random.random()
# However, for teaching accumulation, the structure is key. When assessing, we''ll use deterministic examples.


In this example, `results` is our accumulator. Each time we run `simulate_flips`, its outcome (the number of heads) is added to this list. Finally, we can print or further process this `results` list.', 'A common misconception is to only store the *final* outcome of the last trial, or to overwrite the previous trial''s results instead of accumulating them. Learners might re-initialize their results container (e.g., `results = []`) inside the simulation loop, effectively losing all previous data. The accumulator *must* be initialized *before* the loop that runs the trials.', 'Imagine a simple simulation where a ''dice roll'' always produces a fixed number (for determinism). Simulate 3 trials. In each trial, ''roll'' the dice twice and add the two ''rolls'' together. Store the sum of each trial''s two ''rolls'' in a list called `trial_sums`. Print `trial_sums` at the end.

Assume the ''dice roll'' function `fixed_roll()` always returns 3. (In a real simulation, this would be random, but for this exercise, we keep it fixed to ensure deterministic output.)', 'gemini-flash', '2026-06-06 14:40:10.780425+00', '2026-06-06 15:07:36.119482+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('95a1cece-0dff-462a-9c7d-7f356562e007', 234, '["Monte Carlo simulations use random sampling to approximate numerical results for problems that are difficult to solve analytically.", "The core idea is to perform a large number of random trials or experiments.", "By observing the outcomes of these random trials, we can estimate probabilities, areas, or other numerical values.", "The accuracy of a Monte Carlo simulation generally increases with the number of random trials.", "It''s particularly useful when direct calculation is impossible or computationally prohibitive due to complexity."]', 'Imagine we want to estimate the probability of rolling a sum greater than 7 with two standard six-sided dice without listing all 36 possibilities. A Monte Carlo approach would involve: 1. Randomly ''rolling'' the first die (generating a random integer from 1 to 6). 2. Randomly ''rolling'' the second die. 3. Summing their results. 4. Repeating this process thousands or millions of times. 5. Counting how many times the sum was greater than 7. 6. Dividing that count by the total number of trials to get an approximation of the probability. We''re using random sampling to solve a probability problem.', 'A common misconception is that Monte Carlo simulations produce exact answers. They produce approximations. The ''randomness'' involved means that each run might yield a slightly different result, but with enough trials, these results converge towards the true value.', 'Describe a scenario where you could use a Monte Carlo simulation to estimate the average waiting time in a queue if you knew the average service time and arrival rate, but not the exact arrival/service distribution. Focus on how randomness would be introduced.', 'gemini-flash', '2026-06-06 14:40:10.780425+00', '2026-06-06 15:07:36.119482+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('ad6a08ee-053f-4bd3-91a2-162c0a3ac3c5', 237, '["Matplotlib is a powerful library for creating static, animated, and interactive visualizations in Python.", "Common plot types for simulation results include line plots (for time series or trends), scatter plots (for relationships between variables), and histograms (for distributions).", "The `pyplot` module (aliased as `plt`) is typically used for plotting, with functions like `plt.plot()`, `plt.scatter()`, `plt.hist()`, `plt.xlabel()`, `plt.ylabel()`, `plt.title()`, and `plt.show()`.", "Generative art often uses mathematical functions or simulation outputs as data inputs for plotting, exploring visual patterns derived from algorithms.", "Saving figures using `plt.savefig()` is crucial for capturing results, especially in non-interactive environments."]', 'Let''s say we simulated the position of a particle moving randomly over 100 steps. We have two lists: `x_positions` and `y_positions`. To visualize its path, we can use a line plot. We''ll also add labels and a title.

python
import matplotlib.pyplot as plt
import random

# Simulate random walk data (simplified)
num_steps = 100
x_positions = [0]
y_positions = [0]

for _ in range(num_steps):
    x_positions.append(x_positions[-1] + random.uniform(-1, 1))
    y_positions.append(y_positions[-1] + random.uniform(-1, 1))

# Create the plot
plt.figure(figsize=(8, 6))
plt.plot(x_positions, y_positions, linestyle=''-'', marker=''o'', markersize=2, label=''Particle Path'')

# Add labels and title
plt.xlabel(''X Position'')
plt.ylabel(''Y Position'')
plt.title(''2D Random Walk Simulation'')
plt.grid(True)
plt.legend()

# Save the plot (important for non-interactive environments or sharing)
plt.savefig(''random_walk.png'')
# In a typical interactive environment, you''d use plt.show() here.
# For this course''s specific setup, we focus on saving files or deterministic output.
print(''Plot saved to random_walk.png'')', 'Learners often forget to call `plt.show()` in interactive Python environments or `plt.savefig()` when running scripts. Without `plt.show()`, the plot window won''t appear, and without `plt.savefig()`, there will be no output file. For the specific environment of this course (Pyodide runner without interactive display), `plt.savefig()` is the critical step to produce an artifact, or focusing on deterministic print outputs if plots themselves can''t be rendered/saved in a universally accessible way within the grading system.', 'Generate 100 random numbers between 0 and 1. Plot their distribution using a histogram. Label the x-axis ''Value'', the y-axis ''Frequency'', and title the plot ''Distribution of Random Numbers''. Ensure the plot is saved to ''random_distribution.png''.', 'gemini-flash', '2026-06-06 14:40:10.780425+00', '2026-06-06 15:07:36.119482+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('1f2dff55-0b9a-4c71-9aaf-0c9dd2e7d02e', 129, '["The `print()` function is a fundamental built-in Python function used to display output on the console.", "To use `print()`, you place what you want to display inside its parentheses `()`. For example: `print(''Hello, world!'')`.", "Text (strings) must be enclosed in single quotes `''''` or double quotes `\"\"` when passed to `print()`.", "Numbers can be printed directly without quotes: `print(123)`.", "`print()` can display the values of variables: `message = ''Python''; print(message)`.", "By default, `print()` adds a newline character at the end of the output, moving the cursor to the next line for subsequent prints."]', 'Let''s say we want to tell our computer to display ''Welcome to Python!'' on the screen. We would write `print(''Welcome to Python!'')`. When this code runs, the text ''Welcome to Python!'' will appear in the output console. If we then write `print(2023)`, the number 2023 will appear on the next line.', 'A common misconception is forgetting to put quotes around text when printing, leading to a `NameError` because Python thinks the text is a variable name. For example, `print(Hello)` will cause an error, whereas `print(''Hello'')` will work correctly.', 'Write a Python program that uses the `print()` function to display your favorite color on one line and your favorite number on the next line.', 'gemini-flash', '2026-06-06 14:53:01.799644+00', '2026-06-06 14:53:01.799644+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('786bde11-5aae-43eb-88d6-72019251186d', 130, '["The ''Editor'' is where you write your Python code.", "The ''Output Area'' (or Console) is where the results of your code, like text from `print()`, are displayed.", "To run your code, you typically click a ''Run'' button or similar control provided by the environment.", "When you run code, the Python interpreter reads and executes your instructions from top to bottom.", "The ''Editor Loop'' describes the cycle: Write code -> Run code -> Observe output -> Repeat (if needed).", "Understanding this loop is fundamental for debugging and iteratively building programs."]', 'Let''s say you want to greet someone. You''d type `print(''Hello, Python Learner!'')` in the editor. After clicking ''Run'', the output area will show ''Hello, Python Learner!''. If you then decide to add a second greeting, you''d add `print(''Welcome to the course!'')` below it, run again, and see both messages in the output.', 'Learners often expect changes in the editor to automatically appear in the output. Emphasize that the ''Run'' action is crucial to execute the *latest* version of their code.', 'Write a program that prints your favorite color, then on a new line, prints your favorite animal. Run it and check the output.', 'gemini-flash', '2026-06-06 14:53:01.799644+00', '2026-06-06 14:53:01.799644+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('923035e1-c92f-4145-8699-cbfa0345b481', 131, '["Comments are notes within your code that explain what the code does.", "In Python, comments start with a hash symbol (`#`).", "Anything on a line after a `#` is ignored by the Python interpreter.", "Comments make your code easier to understand for yourself and others.", "They do not affect how your program runs or its output."]', 'Let''s say we have this line of code: `print(''Hello, Python!'')`. This line prints a greeting. If we wanted to add a comment to explain its purpose, we''d write: `print(''Hello, Python!'') # This line prints a welcome message`. When this code runs, ''Hello, Python!'' will be printed, and the comment will be completely ignored.', 'A common misconception is that comments are somehow executed or appear in the program''s output. Learners might think `# This is a comment` would cause ''This is a comment'' to be printed. It''s crucial to emphasize that comments are solely for human readers and are completely skipped by the computer.', 'Add a comment to the following line of code that explains what the `print()` function does.', 'gemini-flash', '2026-06-06 14:53:01.799644+00', '2026-06-06 14:53:01.799644+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('fc33a6e3-e1ed-41ca-9e34-9a2ad81e996f', 132, '["Syntax errors occur when your Python code violates the rules of the language''s structure.", "Python provides helpful error messages, often indicating the file, line number, and type of error.", "Common syntax errors include missing parentheses, mismatched quotes, incorrect indentation, and misspelled keywords.", "When a syntax error is encountered, Python stops execution immediately and reports the error.", "Carefully reading the error message is the first step to debugging a syntax error.", "Tools like code editors often highlight syntax errors as you type, helping to prevent them before running."]', 'Let''s look at a common syntax error. Imagine you want to print ''Hello, World!'' but accidentally type:

python
print(''Hello, World!)


When you run this, Python will give you a `SyntaxError: EOL while scanning string literal`. ''EOL'' stands for ''End Of Line''. This message tells you that Python reached the end of the line while it was still expecting something to complete the string literal. The fix is to add the missing closing single quote: `print(''Hello, World!'')`.', 'A common misconception is that syntax errors are always hard to find or cryptic. While some can be, Python''s error messages are generally quite informative. The key is to pay attention to the line number and the type of error provided, as these are strong clues.', 'Introduce a missing parenthesis in a print statement and observe the error message. Then, fix it. For example, change `print(''This is correct'')` to `print(''This is incorrect''` and run it. Observe the `SyntaxError`. Then correct it and run again.', 'gemini-flash', '2026-06-06 14:53:01.799644+00', '2026-06-06 14:53:01.799644+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f6ede40b-da92-42ea-b72c-7372ba34141c', 133, '["Python code in this course runs from start to finish without stopping to ask you for input.", "This is called ''non-interactive execution''. Your program runs once and then exits.", "To provide data to your program, you must ''hardcode'' it directly into your script.", "Hardcoding means assigning values to variables directly in your code, like `name = \"Alice\"` or `age = 30`.", "The `input()` function, which typically asks for user input, will return an empty string (`\"\"`) in this environment, making it unsuitable for providing initial data for your programs."]', 'Let''s say we want to print a personalized greeting. Since we can''t ask the user for their name, we hardcode it:

python
# Hardcode the name directly into the script
user_name = "Charlie"

# Now use this hardcoded name in our greeting
print("Hello, " + user_name + "! Welcome to the program.")


When this code runs, it will simply print `Hello, Charlie! Welcome to the program.` without any pause for user input.', 'A common mistake is trying to use `input()` expecting it to pause and wait for you to type something. In this course''s setup, `input()` will immediately return an empty string, leading to unexpected behavior if you rely on it for initial data.', 'Write a program that hardcodes two numbers, calculates their sum, and prints the result. For example, if you hardcode `num1 = 15` and `num2 = 7`, the output should be `The sum is: 22`.', 'gemini-flash', '2026-06-06 14:53:01.799644+00', '2026-06-06 14:53:01.799644+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('ef6704dd-1a90-43d3-b668-6a0133d6de62', 134, '["Variables are named containers used to store data in a program. Think of them as labels you attach to values.", "Assignment uses the `=` operator: `variable_name = value`. This associates the value on the right with the name on the left.", "Variable names must start with a letter (a-z, A-Z) or an underscore (`_`).", "Subsequent characters can be letters, numbers (0-9), or underscores.", "Variable names are case-sensitive (`myVar` is different from `myvar`).", "Choose descriptive variable names that indicate their purpose (e.g., `user_age` instead of `x`). Avoid Python keywords."]', 'Let''s assign the number 10 to a variable called `num_apples`. 

python
num_apples = 10
print(num_apples)  # Output: 10

# We can reassign it
num_apples = 15
print(num_apples) # Output: 15

# Let''s try another one with a string
welcome_message = "Hello, Python!"
print(welcome_message) # Output: Hello, Python!


Notice how the `print()` function displays the *value* stored in the variable, not its name.', 'A common misconception is that the `=` operator means ''equals'' in a mathematical sense. In programming, `=` means ''assign the value on the right to the variable on the left''. It''s an assignment operator, not an equality comparison (which is `==`). So `x = x + 1` is perfectly valid and means ''take the current value of x, add 1 to it, and then store that new result back into x''.', 'Create a variable named `city_name` and assign your favorite city''s name to it (as text). Then, create another variable named `population` and assign an approximate population number to it. Finally, print both variables on separate lines.', 'gemini-flash', '2026-06-06 14:53:33.608063+00', '2026-06-06 14:53:33.608063+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('54d6f990-2117-4c09-8a46-0d38b5ebadba', 135, '["Python has several built-in fundamental data types to store different kinds of information.", "Integers (`int`) represent whole numbers (e.g., 5, -100). They can be positive, negative, or zero, and have no decimal part.", "Floating-point numbers (`float`) represent real numbers, including those with decimal parts (e.g., 3.14, -0.5, 2.0).", "Strings (`str`) represent sequences of characters (text). They are enclosed in single quotes (''...'') or double quotes (\"...\").", "Booleans (`bool`) represent truth values: `True` or `False`. They are often the result of comparison operations."]', 'Let''s look at some examples:

python
# Integer (int)
age = 30

# Floating-point number (float)
price = 19.99

# String (str)
name = "Alice"
message = ''Hello, world!''

# Boolean (bool)
is_student = True
has_discount = False

print(age)         # Output: 30
print(price)       # Output: 19.99
print(name)        # Output: Alice
print(is_student)  # Output: True', 'A common misconception is treating numbers within quotes as numeric types. For example, ''123'' is a string, not an integer or a float, even though it looks like a number. Python treats it as text, and you can''t perform mathematical operations directly on it without conversion.', 'Declare a variable called `city` and assign it your favorite city''s name (a string). Then, declare a variable called `population_million` and assign it a floating-point number representing that city''s population in millions (e.g., 3.4 for 3.4 million). Finally, declare a boolean variable `is_capital` and set it to `True` or `False` depending on whether your chosen city is a capital. Print the value of each variable.', 'gemini-flash', '2026-06-06 14:53:33.608063+00', '2026-06-06 14:53:33.608063+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('7e7da808-b6da-4eef-afa0-0a6db9025b37', 136, '["The `type()` function is a built-in Python function used to determine the data type of a variable or value.", "It takes a single argument (the variable or value) and returns the type object.", "The output of `type()` will look like `<class ''int''>`, `<class ''float''>`, `<class ''str''>`, or `<class ''bool''>` for the core data types.", "Understanding data types is crucial for predicting how Python will behave during operations and for debugging."]', 'Let''s say we have a variable `age = 30`. To find its type, we would use `type(age)`. The output in the console would be `<class ''int''>`. If we had `name = "Alice"`, then `type(name)` would yield `<class ''str''>`.', 'Learners often expect `type()` to return a simple string like ''int'' or ''str''. Emphasize that it returns a ''type object'' which includes the `<class ''...''>` syntax, indicating that these are class definitions in Python.', 'Declare a variable named `pi_value` and assign it the floating-point value `3.14159`. Then, use the `type()` function to print its data type to the console.', 'gemini-flash', '2026-06-06 14:53:33.608063+00', '2026-06-06 14:53:33.608063+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('848fe7f5-bdd9-4fda-be13-99c22e433157', 137, '["f-strings (formatted string literals) provide a concise and readable way to embed expressions inside string literals.", "To create an f-string, prefix the string literal with the letter ''f'' or ''F''.", "Expressions are embedded within curly braces `{}` directly inside the string.", "Any valid Python expression, including variables, function calls, and arithmetic operations, can be placed inside the curly braces.", "f-strings offer a cleaner and often more performant alternative to older string formatting methods like `+` concatenation or `.format()`."]', 'Let''s say we have a variable `name = "Alice"` and `age = 30`. To print ''Hello, Alice! You are 30 years old.'', we can use an f-string:
python
name = "Alice"
age = 30
greeting = f"Hello, {name}! You are {age} years old."
print(greeting)

Here, `name` and `age` are directly evaluated and inserted into the string.', 'A common mistake is forgetting the `f` prefix. Without it, the curly braces and their contents are treated as literal characters, not as placeholders for expressions. For example, `print("Hello, {name}!")` would literally print ''Hello, {name}!'' instead of ''Hello, Alice!''.', 'Create variables `product_name` and `price`. Use an f-string to print a message like ''The product X costs $Y.'', replacing X and Y with your variable values.', 'gemini-flash', '2026-06-06 14:53:33.608063+00', '2026-06-06 14:53:33.608063+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('5f8c033b-9014-4671-baab-9719f1def1cc', 138, '["Type conversion functions allow you to change the data type of a variable or value.", "The `int()` function converts a value to an integer. It can convert floats (by truncating decimals) and strings (if they represent valid integers).", "The `float()` function converts a value to a floating-point number. It can convert integers and strings (if they represent valid numbers).", "The `str()` function converts a value to a string. It can convert numbers, booleans, and other data types into their string representation.", "Attempting to convert an incompatible type (e.g., ''hello'' to `int()`) will result in a `ValueError`."]', 'Let''s say we have a string representing a number, like `price_str = "19.99"`. If we want to perform mathematical operations, we need to convert it to a float. We use `price_float = float(price_str)`. Now, `price_float` is `19.99` (a float), not `"19.99"` (a string). We can also go the other way, `quantity = 5`, and convert it to a string for display: `quantity_str = str(quantity)`, making `quantity_str` equal to `"5"`.', 'A common misconception is that `int()` rounds numbers. It doesn''t; it truncates the decimal part. For example, `int(3.99)` results in `3`, not `4`. Similarly, `int("3.99")` will raise a `ValueError` because `"3.99"` is not a valid integer string, it requires `float()` first.', 'Try converting the float `25.75` into an integer and then back into a string. Print the type of each result to observe the changes.', 'gemini-flash', '2026-06-06 14:53:33.608063+00', '2026-06-06 14:53:33.608063+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('4b7f0b52-d9c2-4614-abc7-85037fe2c239', 139, '["Strings are ordered sequences of characters, meaning each character has a specific position.", "**Indexing** allows you to access individual characters using square brackets `[]` and their numerical position (index).", "Indexes start at 0 for the first character (left-to-right).", "Negative indexing allows access from the end of the string, with -1 being the last character.", "**Slicing** extracts a portion (substring) of a string using `[start:end]` or `[start:end:step]` notation.", "Slices are *exclusive* of the `end` index, meaning the character at the `end` index is not included. The `step` specifies how many characters to jump."]', 'Let''s work with the string `s = ''Python''`.

- Accessing the first character: `s[0]`  will give `''P''`.
- Accessing the last character: `s[5]` or `s[-1]` will both give `''n''`.
- Slicing ''Py'': `s[0:2]` will give `''Py''` (index 2 is excluded).
- Slicing ''thon'': `s[2:6]` or `s[2:]` will give `''thon''`.
- Slicing ''ytho'' (excluding first and last): `s[1:-1]` will give `''ytho''`.
- Slicing with a step (every other character): `s[::2]` will give `''Pto''`.', 'A common mistake is thinking that the `end` index in a slice `[start:end]` is inclusive. Remember, the slice extracts characters *up to, but not including*, the character at the `end` index. So, `s[0:3]` gives you characters at index 0, 1, and 2, but not 3.', 'Given the string `language = ''JavaScript''`, how would you extract the substring `''Java''` using slicing? How would you get the character ''S'' using a positive index and then using a negative index?', 'gemini-flash', '2026-06-06 14:54:03.034616+00', '2026-06-06 14:54:03.034616+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('adf13ad2-b955-463f-86ad-460f9fa306bf', 140, '["Strings in Python are immutable, meaning string methods return new strings rather than modifying the original.", "''.upper()'' and ''.lower()'' convert a string to all uppercase or all lowercase respectively.", "''.strip()'' removes leading and trailing whitespace (or specified characters) from a string. ''.lstrip()'' and ''.rstrip()'' remove only from the left or right.", "''.replace(old, new)'' substitutes all occurrences of a substring ''old'' with ''new''.", "''.split(delimiter)'' breaks a string into a list of substrings based on a specified delimiter. If no delimiter is given, it splits by whitespace.", "''.join(iterable)'' concatenates elements of an iterable (like a list of strings) into a single string, using the string on which it''s called as the separator."]', 'Let''s say we have the string `message = "  Hello World!  "`.

1. Convert to uppercase: `upper_message = message.upper()` would result in `"  HELLO WORLD!  "`.
2. Remove whitespace: `cleaned_message = message.strip()` would result in `"Hello World!"`.
3. Replace ''World'' with ''Python'': `replaced_message = cleaned_message.replace("World", "Python")` would result in `"Hello Python!"`.
4. Split into words: `words = replaced_message.split(" ")` would result in `[''Hello'', ''Python!'']`.
5. Join with a hyphen: `joined_string = "-".join(words)` would result in `"Hello-Python!"`.', 'A common misconception is that string methods modify the original string in place. Because strings are immutable, methods like `upper()` or `strip()` always return a *new* string with the transformation applied. You must assign the result to a variable (either the original or a new one) to keep the changes.', 'Given the string `data = "  apple, orange, banana  "`, use string methods to transform it into the string `"APPLE | ORANGE | BANANA"`. Print the final result.', 'gemini-flash', '2026-06-06 14:54:03.034616+00', '2026-06-06 14:54:03.034616+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('ba717e3c-3212-43b8-a17a-c64fab4f6ae4', 141, '["The `in` operator checks if a substring exists within a string, returning `True` or `False`.", "The `not in` operator checks if a substring does NOT exist within a string, returning `True` or `False`.", "The `len()` function returns the number of characters in a string (its length).", "String concatenation uses the `+` operator to join two or more strings together.", "String repetition uses the `*` operator to create a new string by repeating an existing string a specified number of times."]', 'Let''s say we have `text = ''Hello, Python!''`. 
To check if ''Python'' is in `text`: `print(''Python'' in text)` which outputs `True`.
To find the length of `text`: `print(len(text))` which outputs `14`.
To concatenate strings: `greeting = ''Hi'' + '', world!''` results in `''Hi, world!''`.
To repeat a string: `stars = ''*'' * 5` results in `''*****''`.', 'Learners often confuse `len()` with a string method. Remind them `len()` is a built-in Python function that works on many data types (like lists, tuples) not just strings, whereas methods like `.upper()` or `.find()` are specific to string objects and are called using dot notation (e.g., `my_string.upper()`).', 'Write code to check if the word ''banana'' is present in the string ''apple, orange, banana, grape''. Then, calculate the length of the string ''Python is fun!''. Finally, create a string that says ''HaHaHa'' by repeating ''Ha'' three times.', 'gemini-flash', '2026-06-06 14:54:03.034616+00', '2026-06-06 14:54:03.034616+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('de9630cc-00bc-4467-97d4-a2c4ad227d2f', 142, '["Multi-line strings can be created using triple quotes ('''''' or \"\"\"). This allows strings to span across several lines in your code.", "Triple-quoted strings preserve whitespace, including newlines, exactly as typed.", "Escape sequences are special character combinations within a string that represent non-printable characters or characters that are difficult to type directly.", "The backslash (`\\`) is used to introduce an escape sequence. Common examples include `\\n` for a newline, `\\t` for a tab, `\\''` for a single quote, and `\\\"` for a double quote.", "Raw strings, prefixed with `r` or `R` (e.g., `r''C:\\Users\\New''`), treat backslashes as literal characters, preventing them from being interpreted as escape sequence initiators. This is especially useful for file paths or regular expressions."]', 'Let''s say we want to print a small poem and a file path. Without multi-line strings or escape sequences, it''s cumbersome.

python
# Using escape sequences for newlines and quotes
poem_str_escaped = "Twinkle, twinkle, little star.\nHow I wonder what you are!\nUp above the world so high,\nLike a diamond in the sky."
print(poem_str_escaped)

# Using multi-line string for the same poem
poem_str_multiline = ''''''Twinkle, twinkle, little star.
How I wonder what you are!
Up above the world so high,
Like a diamond in the sky.''''''
print(poem_str_multiline)

# Demonstrating a raw string for a file path
file_path = r''C:\Program Files\My App\data.txt''
print(file_path)

# What if we didn''t use a raw string for the path and accidentally created an escape sequence?
# path_error = ''C:\Users\new_folder'' # \n would be interpreted as a newline!
# print(path_error) # This would print ''C:\Users
ew_folder'' with ''ew_folder'' on a new line

# To avoid issues without raw strings, you''d need double backslashes:
path_correct_manual = ''C:\\Users\\new_folder''
print(path_correct_manual)


**Output of the example:**

Twinkle, twinkle, little star.
How I wonder what you are!
Up above the world so high,
Like a diamond in the sky.
Twinkle, twinkle, little star.
How I wonder what you are!
Up above the world so high,
Like a diamond in the sky.
C:\Program Files\My App\data.txt
C:\Users\new_folder', 'A common misconception is that `\` always acts as an escape character. While true within regular strings, in raw strings (prefixed with `r`), `\` loses its special escape meaning and is treated as a literal backslash. For example, `print(r''\n'')` will output `\n`, not a newline character.', 'Create a multi-line string that represents a short conversation. Ensure that one of the speaker''s lines contains an apostrophe (`''`) that is not the string delimiter, and another line uses a tab character for indentation. Finally, print the entire conversation.', 'gemini-flash', '2026-06-06 14:54:03.034616+00', '2026-06-06 14:54:03.034616+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('d9c19041-1ce7-4720-b714-3119e0c42fdd', 143, '["Python provides fundamental arithmetic operators for basic mathematical calculations.", "The addition operator `+` performs summation.", "The subtraction operator `-` performs difference.", "The multiplication operator `*` performs product.", "The division operator `/` performs true division, always resulting in a float.", "These operators can be used with both literal numbers and variables storing numeric values."]', 'Let''s calculate the total cost of 3 apples at $0.75 each and 2 bananas at $0.50 each.

python
apples_price = 0.75
bananas_price = 0.50
num_apples = 3
num_bananas = 2

total_apples_cost = apples_price * num_apples
total_bananas_cost = bananas_price * num_bananas

total_cost = total_apples_cost + total_bananas_cost
print(total_cost)


Output: `3.25`', 'A common mistake is assuming that `/` division with two integers will always result in an integer. In Python 3, `/` always performs ''true division'', meaning it returns a float, even if the result is a whole number (e.g., `10 / 2` results in `5.0`).', 'Calculate the average temperature from three daily readings: 25.5, 27.0, and 26.5 degrees Celsius. Print the result.', 'gemini-flash', '2026-06-06 14:54:42.8503+00', '2026-06-06 14:54:42.8503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('b665c956-175e-4706-a272-ac8f9dba6051', 144, '["Integer division (//) performs division and discards the fractional part, always resulting in an integer.", "The result of integer division is floored, meaning it rounds down to the nearest whole number.", "The modulo operator (%) returns the remainder of a division operation.", "For positive numbers, `a % n` will always be a number between `0` and `n-1` (inclusive).", "The sign of the result of the modulo operator (`a % b`) is the same as the sign of the divisor (`b`).", "These operators are useful for tasks like checking even/odd numbers, distributing items, or converting units."]', 'Let''s look at `17 // 5` and `17 % 5`.

`17 // 5`: 17 divided by 5 is 3 with a remainder of 2. Integer division ignores the remainder, so `17 // 5` evaluates to `3`.

`17 % 5`: This gives us the remainder. So, `17 % 5` evaluates to `2`.

Consider negative numbers: `-17 // 5` and `-17 % 5`.

`-17 // 5`: When dividing -17 by 5, the true result is -3.4. Integer division floors this, meaning it rounds down to the nearest whole number, which is `-4`.

`-17 % 5`: The remainder is calculated such that `a == (a // b) * b + (a % b)`. For `-17 // 5 = -4`, we have `(-4 * 5) = -20`. To get from -20 to -17, we need to add `3`. So, `-17 % 5` evaluates to `3`.', 'A common misconception is that integer division (//) always truncates towards zero. While true for positive numbers, for negative numbers, it ''floors'' the result, meaning it rounds down to the next smallest integer. For example, `-7 // 2` is `-4`, not `-3`.', NULL, 'gemini-flash', '2026-06-06 14:54:42.8503+00', '2026-06-06 14:54:42.8503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('5a7cb70a-66e6-4565-88a9-c8bbd8582a80', 145, '["Operator precedence dictates the order in which operations are evaluated in an expression (PEMDAS/BODMAS applies).", "Parentheses `()` can be used to override the default operator precedence and force certain operations to be evaluated first.", "The exponentiation operator is `**`, used to calculate powers (e.g., `2 ** 3` means 2 raised to the power of 3).", "Exponentiation `**` has higher precedence than multiplication `*`, division `/`, integer division `//`, modulo `%`, addition `+`, and subtraction `-`.", "When operators have the same precedence (e.g., `*` and `/`), they are typically evaluated from left to right, except for exponentiation which is evaluated from right to left (though this is less common in complex expressions)."]', 'Let''s evaluate `5 + 2 * 3 ** 2 - 10 / 2`. 
1. Exponentiation first: `3 ** 2` is `9`. So, `5 + 2 * 9 - 10 / 2`.
2. Multiplication and Division (from left to right): `2 * 9` is `18`. `10 / 2` is `5.0`. So, `5 + 18 - 5.0`.
3. Addition and Subtraction (from left to right): `5 + 18` is `23`. `23 - 5.0` is `18.0`.
Therefore, `5 + 2 * 3 ** 2 - 10 / 2` evaluates to `18.0`.', 'Learners often forget that `**` has very high precedence, sometimes even higher than they might expect, leading to incorrect calculations like `2 * 3 ** 2` being evaluated as `(2 * 3) ** 2` (which is 36) instead of `2 * (3 ** 2)` (which is 18). It''s crucial to remember that `**` binds tightly to its operands.', 'Calculate the value of the expression `10 - 2 ** 3 + 6 / 2` without using Python. Then, verify your answer in the interpreter.', 'gemini-flash', '2026-06-06 14:54:42.8503+00', '2026-06-06 14:54:42.8503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('eef8d1cf-029d-4949-97ec-ab8adbb80a45', 146, '["Python has two main numeric types: `int` for whole numbers and `float` for numbers with decimal points.", "Integers (e.g., `5`, `-10`, `0`) are stored precisely, without any fractional part.", "Floats (e.g., `3.14`, `-0.5`, `2.0`) always include a decimal point, even if the fractional part is zero. They are represented using floating-point arithmetic, which can sometimes lead to tiny precision issues for very specific calculations.", "Numeric literals are the ways we write numbers directly in our code. Integers are written as sequences of digits (e.g., `123`). Floats are written with a decimal point (e.g., `123.0`, `0.5`).", "You can explicitly convert between types using `int()` and `float()` functions. `int(3.14)` truncates to `3`, while `float(5)` becomes `5.0`."]', 'Let''s look at some examples and their types:

python
# Integer literals
num1 = 10
num2 = -5
num3 = 0
print(f"Value: {num1}, Type: {type(num1)}")
print(f"Value: {num2}, Type: {type(num2)}")
print(f"Value: {num3}, Type: {type(num3)}")

# Float literals
num4 = 3.14
num5 = -0.01
num6 = 2.0  # Even though it''s a whole number, the .0 makes it a float
print(f"Value: {num4}, Type: {type(num4)}")
print(f"Value: {num5}, Type: {type(num5)}")
print(f"Value: {num6}, Type: {type(num6)}")

# Type conversion
int_from_float = int(7.89)
float_from_int = float(100)
print(f"Integer from float: {int_from_float}, Type: {type(int_from_float)}")
print(f"Float from integer: {float_from_int}, Type: {type(float_from_int)}")


Output:

Value: 10, Type: <class ''int''>
Value: -5, Type: <class ''int''>
Value: 0, Type: <class ''int''>
Value: 3.14, Type: <class ''float''>
Value: -0.01, Type: <class ''float''>
Value: 2.0, Type: <class ''float''>
Integer from float: 7, Type: <class ''int''>
Float from integer: 100.0, Type: <class ''float''>', 'A common misconception is that `2.0` is an integer because it represents a whole number. However, in Python, any number written with a decimal point (e.g., `2.0`, `10.`, `.5`) is automatically interpreted as a `float`, even if its fractional part is zero. The presence of the decimal point is the key differentiator in its literal representation.', 'Write down five different numeric literals: two integers and three floats. For each, indicate what its Python type (`int` or `float`) would be.', 'gemini-flash', '2026-06-06 14:54:42.8503+00', '2026-06-06 14:54:42.8503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('32117183-8d59-4c62-8738-e8e6b5887f7c', 147, '["Python provides several built-in functions to perform common operations on numbers without needing to import external modules.", "`abs(x)` returns the absolute value of a number `x` (its distance from zero).", "`round(x)` rounds a floating-point number `x` to the nearest integer. `round(x, n)` rounds to `n` decimal places. Python''s `round()` uses ''round half to even'' for ties (e.g., `round(2.5)` is 2, `round(3.5)` is 4).", "`min(arg1, arg2, ...)` returns the smallest item among the given arguments. It can also take a single iterable.", "`max(arg1, arg2, ...)` returns the largest item among the given arguments. It can also take a single iterable."]', 'Let''s see how these functions work with some examples:

python
# Absolute value
print(f"Absolute value of -10: {abs(-10)}")
print(f"Absolute value of 5.7: {abs(5.7)}")

# Rounding
print(f"Round 4.2 to nearest integer: {round(4.2)}")
print(f"Round 4.8 to nearest integer: {round(4.8)}")
print(f"Round 3.14159 to 2 decimal places: {round(3.14159, 2)}")
print(f"Round 2.5: {round(2.5)} (rounds to nearest even)")
print(f"Round 3.5: {round(3.5)} (rounds to nearest even)")

# Minimum and Maximum
print(f"Minimum of 10, 20, 5: {min(10, 20, 5)}")
print(f"Maximum of 10.5, 9.2, 11.0: {max(10.5, 9.2, 11.0)}")
print(f"Minimum in a list [5, 1, 8, 2]: {min([5, 1, 8, 2])}")


Output:

Absolute value of -10: 10
Absolute value of 5.7: 5.7
Round 4.2 to nearest integer: 4
Round 4.8 to nearest integer: 5
Round 3.14159 to 2 decimal places: 3.14
Round 2.5: 2 (rounds to nearest even)
Round 3.5: 4 (rounds to nearest even)
Minimum of 10, 20, 5: 5
Maximum of 10.5, 9.2, 11.0: 11.0
Minimum in a list [5, 1, 8, 2]: 1', 'A common misconception with `round()` is that it always rounds `.5` up. Python''s `round()` function by default implements ''round half to even'' (also known as ''bankers'' rounding) for values exactly halfway between two integers. For example, `round(2.5)` is `2`, and `round(3.5)` is `4`. If you need standard ''round half up'' behavior, you might need to implement it yourself or use functions from the `math` module (e.g., `math.ceil` or `math.floor` combined with an offset).', 'Calculate the difference between the maximum and minimum values in a given set of numbers, then round the result to one decimal place if it''s a float. Print the final rounded result.', 'gemini-flash', '2026-06-06 14:54:42.8503+00', '2026-06-06 14:54:42.8503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('11014379-bfb9-411a-957d-24866598544a', 148, '["Lists in Python are ordered collections of items.", "List literals are created by enclosing a comma-separated sequence of items within square brackets `[]`.", "Lists can contain items of different data types (e.g., numbers, strings, booleans, even other lists).", "Lists are ''mutable'', meaning their contents can be changed after they are created.", "The order of items in a list is preserved, making them ''ordered'' data structures."]', 'Let''s create a list to store information about a student: `student_info = [''Alice'', 20, 3.75, True]`. Here, ''Alice'' is a string, 20 is an integer, 3.75 is a float, and True is a boolean. All are enclosed in square brackets and separated by commas, making it a list literal. We can then print it: `print(student_info)` which would output `[''Alice'', 20, 3.75, True]`.', 'A common misconception is confusing lists with other sequence types like strings or tuples, especially regarding mutability. While strings are also ordered sequences, they are immutable (cannot be changed after creation), whereas lists are mutable. Learners might incorrectly assume `my_list = [1, 2, 3]` behaves the same as `my_string = ''123''` when trying to modify individual elements.', 'Create a list named `my_shopping_list` containing at least three different items you need to buy. Ensure at least one item is a string and another is a number. Print your list.', 'gemini-flash', '2026-06-06 14:55:17.972579+00', '2026-06-06 14:55:17.972579+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('626eb286-35d8-4746-b503-434b82e238f3', 149, '["Lists are ordered sequences, meaning the position of each element matters.", "**Indexing** allows you to access individual elements in a list using their position (index).", "Positive indices start from 0 for the first element, 1 for the second, and so on.", "Negative indices start from -1 for the last element, -2 for the second to last, etc.", "**Slicing** allows you to extract sub-sequences (parts) of a list.", "Slicing uses the syntax `list[start:stop:step]`. `start` is inclusive, `stop` is exclusive. `step` determines the increment. All are optional."]', 'Let''s say we have a list of fruits: `fruits = [''apple'', ''banana'', ''cherry'', ''date'', ''elderberry'']`
- Accessing the first element: `fruits[0]`  (Output: `''apple''`)
- Accessing the last element using a negative index: `fruits[-1]` (Output: `''elderberry''`)
- Slicing from the second to fourth element (inclusive of 2nd, exclusive of 5th): `fruits[1:4]` (Output: `[''banana'', ''cherry'', ''date'']`)
- Slicing all elements from the beginning up to ''date'': `fruits[:4]` (Output: `[''apple'', ''banana'', ''cherry'', ''date'']`)
- Slicing every other element: `fruits[::2]` (Output: `[''apple'', ''cherry'', ''elderberry'']`)
- Reversing the list using slicing: `fruits[::-1]` (Output: `[''elderberry'', ''date'', ''cherry'', ''banana'', ''apple'']`)', 'A common mistake is thinking that the `stop` index in slicing is inclusive, like the `start` index. It''s crucial to remember that `stop` is exclusive, meaning the element at the `stop` index itself is *not* included in the slice.', 'Given a list `numbers = [10, 20, 30, 40, 50, 60, 70]`, print the element ''40'' using a positive index, then print the element ''60'' using a negative index. Finally, print a slice containing `[30, 40, 50]`.', 'gemini-flash', '2026-06-06 14:55:17.972579+00', '2026-06-06 14:55:17.972579+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('962dc7a9-ca07-4b8e-8288-9e607ab85934', 150, '["Lists are mutable, meaning their contents can be changed after creation.", "The `append()` method adds an element to the very end of a list.", "The `insert(index, element)` method adds an element at a specified position.", "The `remove(element)` method removes the first occurrence of a specified element.", "The `pop(index)` method removes and returns the element at a specified index (or the last element if no index is given)."]', 'Let''s start with a list of fruits: `fruits = [''apple'', ''banana'', ''cherry'']`

1.  **Adding with `append()`:** We want to add ''date'' to the end. `fruits.append(''date'')`. Now `fruits` is `[''apple'', ''banana'', ''cherry'', ''date'']`.

2.  **Inserting with `insert()`:** We want to add ''orange'' at the second position (index 1). `fruits.insert(1, ''orange'')`. Now `fruits` is `[''apple'', ''orange'', ''banana'', ''cherry'', ''date'']`.

3.  **Removing with `remove()`:** We want to remove ''cherry''. `fruits.remove(''cherry'')`. Now `fruits` is `[''apple'', ''orange'', ''banana'', ''date'']`.

4.  **Removing with `pop()`:** We want to remove the element at index 2 (which is ''banana''). `removed_fruit = fruits.pop(2)`. Now `fruits` is `[''apple'', ''orange'', ''date'']` and `removed_fruit` holds `''banana''`.', 'A common mistake is confusing `remove()` and `pop()`. `remove()` takes the *value* to be removed as an argument and removes its first occurrence. `pop()` takes the *index* of the element to be removed (and returns it). If the value passed to `remove()` is not in the list, it will raise a `ValueError`.', 'Given a list `groceries = [''milk'', ''bread'', ''eggs'']`:
1. Add ''cheese'' to the end of the list.
2. Insert ''yogurt'' at the beginning of the list.
3. Remove ''bread'' from the list.
4. Remove the last item from the list using `pop()` and store it in a variable called `last_item`.
Print the final `groceries` list and `last_item`.', 'gemini-flash', '2026-06-06 14:55:17.972579+00', '2026-06-06 14:55:17.972579+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f860e87b-422f-48d7-b494-9cfb497be45e', 151, '["Python provides two primary ways to sort lists: `list.sort()` and `sorted(list)`.", "`list.sort()` is a method that sorts the list ''in place'', meaning it modifies the original list and returns `None`.", "`sorted(list)` is a built-in function that returns a *new* sorted list, leaving the original list unchanged.", "Both `sort()` and `sorted()` sort in ascending order by default. You can use the `reverse=True` argument for descending order.", "To reverse the order of elements in a list ''in place'', use the `list.reverse()` method. It modifies the original list and returns `None`."]', 'Let''s say we have a list of numbers: `numbers = [5, 2, 8, 1, 9]`.

To sort it in place:
python
numbers.sort()
print(numbers) # Output: [1, 2, 5, 8, 9]


To get a new sorted list without changing the original:
python
original_numbers = [5, 2, 8, 1, 9]
sorted_copy = sorted(original_numbers)
print(sorted_copy)    # Output: [1, 2, 5, 8, 9]
print(original_numbers) # Output: [5, 2, 8, 1, 9] (unchanged)


To sort in descending order:
python
data = [5, 2, 8, 1, 9]
data.sort(reverse=True)
print(data) # Output: [9, 8, 5, 2, 1]


To reverse the list in place:
python
my_list = [1, 2, 3, 4, 5]
my_list.reverse()
print(my_list) # Output: [5, 4, 3, 2, 1]', 'A common misconception is that `list.sort()` returns the sorted list. It actually modifies the list in place and returns `None`. If you try `new_list = old_list.sort()`, `new_list` will be `None`, and `old_list` will be sorted.', 'Create a list of strings representing fruits. Sort the list alphabetically, then print it. Next, create a new list that is a sorted (alphabetical) copy of your original list, but in reverse (Z-A) order. Print both the original list (to show it''s unchanged) and the new reversed-sorted list.', 'gemini-flash', '2026-06-06 14:55:17.972579+00', '2026-06-06 14:55:17.972579+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('9bdcf913-52ef-4cdf-a91d-64d5adf9c9dc', 152, '["The `len()` function returns the number of items (elements) in a list.", "Assigning one list to another variable (e.g., `list_b = list_a`) creates a *reference* to the original list, not a new copy. Both variables point to the same list in memory.", "Modifying the list through one variable (e.g., `list_b.append(4)`) will affect the list referenced by the other variable (`list_a`).", "To create a true, independent copy of a list, use slicing `[:]` (e.g., `list_b = list_a[:]`) or the `list()` constructor (e.g., `list_b = list(list_a)`).", "A true copy means changes to one list do not affect the other."]', 'Let''s say we have `original_list = [1, 2, 3]`. 

First, for length: `print(len(original_list))` would output `3`.

Now for copying: 

Scenario 1: Reference (not a copy)
python
list_a = [10, 20, 30]
list_b = list_a # list_b now references the SAME list as list_a
list_b.append(40)
print(list_a) # Output: [10, 20, 30, 40]
print(list_b) # Output: [10, 20, 30, 40]

Notice how changing `list_b` also changed `list_a` because they refer to the same data.

Scenario 2: True Copy (using slicing)
python
list_c = [100, 200, 300]
list_d = list_c[:] # list_d is now a NEW, independent copy of list_c
list_d.append(400)
print(list_c) # Output: [100, 200, 300]
print(list_d) # Output: [100, 200, 300, 400]

Here, changing `list_d` does NOT affect `list_c` because `list_d` is a separate copy.', 'A common mistake is thinking that `new_list = old_list` creates a new, independent copy of `old_list`. In Python, this only creates a new variable name that points to the *same* list object in memory. Any modification through `new_list` will also be visible through `old_list`.', 'Given a list `items = [''apple'', ''banana'', ''cherry'']`:
1. Find its length.
2. Create a *reference* named `fruit_ref` to `items`.
3. Create an *independent copy* named `fruit_copy` of `items` using slicing.
4. Add ''date'' to `fruit_ref`.
5. Add ''elderberry'' to `fruit_copy`.
6. Print `items`, `fruit_ref`, and `fruit_copy` to observe the differences.', 'gemini-flash', '2026-06-06 14:55:17.972579+00', '2026-06-06 14:55:17.972579+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('e8c6c6e2-7f65-4e16-8d31-2dc61c376595', 153, '["A `for` loop is used to iterate over a sequence (like a list or a string) or other iterable objects.", "The basic syntax is `for item in sequence:`, followed by an indented block of code that executes for each `item`.", "In each iteration, the loop variable (`item` in the example) takes on the value of the next element in the sequence.", "Strings are sequences of characters, so you can loop through them character by character."]', 'Let''s say we have a list of fruits: `fruits = [''apple'', ''banana'', ''cherry'']`. We want to print each fruit''s name.

python
fruits = [''apple'', ''banana'', ''cherry'']
for fruit in fruits:
    print(fruit)


This code will output:
`apple`
`banana`
`cherry`

Similarly, for a string: `message = ''Hello''`

python
message = ''Hello''
for char in message:
    print(char)


This will output:
`H`
`e`
`l`
`l`
`o`', 'A common misconception is trying to access elements by index within a simple `for item in sequence:` loop, instead of directly using the `item` variable. For example, some might try `print(fruits[fruit])` which would cause an error because `fruit` is already the element itself, not its index.', 'Write a `for` loop that iterates over a list of numbers `[10, 20, 30, 40]` and prints each number multiplied by 2.', 'gemini-flash', '2026-06-06 14:55:51.785863+00', '2026-06-06 14:55:51.785863+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('9063490e-888d-4d43-8500-2b1803ee6753', 154, '["The `range()` function generates a sequence of numbers, which is very useful when you want to loop a specific number of times.", "`range(stop)` generates numbers from `0` up to, but not including, `stop`. For example, `range(5)` produces `0, 1, 2, 3, 4`.", "`range(start, stop)` generates numbers from `start` up to, but not including, `stop`. For example, `range(2, 7)` produces `2, 3, 4, 5, 6`.", "`range(start, stop, step)` generates numbers from `start` up to `stop` (not including `stop`), incrementing by `step`. For example, `range(1, 10, 2)` produces `1, 3, 5, 7, 9`.", "The `range()` function itself does not create a list of numbers in memory; it''s an ''iterable'' that yields numbers one by one as needed, making it memory-efficient.", "You can use `range()` directly within a `for` loop to control how many times the loop executes or to generate indices for accessing elements."]', 'Let''s say we want to print ''Hello'' 3 times using a for loop. Instead of creating a list like `[''a'', ''b'', ''c'']`, we can use `range(3)`.

python
for i in range(3):
    print(''Hello'')


This will print:

Hello
Hello
Hello


Now, if we want to print numbers from 1 to 5, we can do:

python
for num in range(1, 6):
    print(num)


This will print:

1
2
3
4
5', 'A common misconception is that `range()` includes the ''stop'' value. Remember, `range()` stops *before* reaching the ''stop'' value. So `range(5)` goes from `0` to `4`, not `0` to `5`.', 'Write a `for` loop that uses `range()` to print all even numbers from 2 up to, but not including, 10.', 'gemini-flash', '2026-06-06 14:55:51.785863+00', '2026-06-06 14:55:51.785863+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('24a33b1a-23e5-432f-a92b-6a42a38a6cbe', 155, '["Indentation in Python is not just for readability; it is syntactically meaningful and defines code blocks.", "A code block is a group of statements that logically belong together, such as the body of a `for` loop, an `if` statement, or a function.", "All lines within the same code block must be indented by the same amount (typically 4 spaces) relative to the statement that introduces the block.", "Incorrect indentation will lead to `IndentationError` or `SyntaxError`.", "The loop body (the statements executed repeatedly) is defined by its indentation level immediately following the `for` statement."]', 'Let''s look at a simple `for` loop. The lines indented under `for i in range(3):` are considered part of the loop''s body and will execute for each iteration.

python
print("Starting loop")
for i in range(3):
    print(f"  Inside loop, iteration {i}") # Indented
    print("  Still inside loop")       # Same indentation as above
print("Loop finished") # Not indented, so it executes after the loop completes


Output:

Starting loop
  Inside loop, iteration 0
  Still inside loop
  Inside loop, iteration 1
  Still inside loop
  Inside loop, iteration 2
  Still inside loop
Loop finished


Notice how ''Still inside loop'' is printed three times because it''s part of the indented block, while ''Loop finished'' is printed only once after the loop concludes.', 'A common misconception is that indentation is purely for aesthetics or readability, like braces `{}` in other languages. In Python, it''s a strict syntax rule. Mixing tabs and spaces can also cause `IndentationError`s, even if they visually appear correct.', 'Write a `for` loop that iterates three times. Inside the loop, print the current iteration number. After the loop, print a message indicating the loop has finished. Pay close attention to your indentation.', 'gemini-flash', '2026-06-06 14:55:51.785863+00', '2026-06-06 14:55:51.785863+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('9b70b5c9-e3da-4b1a-b786-4376467b3ca9', 156, '["The accumulator pattern involves initializing a variable (the ''accumulator'') outside a loop.", "Inside the loop, the accumulator''s value is updated iteratively based on the current item or iteration.", "This pattern is used to build a cumulative result, such as a sum, a product, a count, or a new list.", "The final value of the accumulator after the loop finishes is the desired result.", "Common initialization values depend on the operation: 0 for sum, 1 for product, empty list for collecting items."]', 'Let''s say we want to calculate the sum of all numbers in a list `numbers = [10, 20, 30]`. 

First, we initialize an accumulator variable, `total_sum = 0`, before the loop. This gives us a starting point.

Next, we iterate through the `numbers` list. In each iteration, we add the current number to `total_sum`.

- Iteration 1: `num` is 10. `total_sum` becomes `0 + 10 = 10`.
- Iteration 2: `num` is 20. `total_sum` becomes `10 + 20 = 30`.
- Iteration 3: `num` is 30. `total_sum` becomes `30 + 30 = 60`.

After the loop finishes, `total_sum` holds the final result: 60. This pattern allows us to ''accumulate'' the sum as we go.', 'A common mistake is to initialize the accumulator inside the loop. If `total_sum = 0` was inside the loop in the example, `total_sum` would be reset to 0 in each iteration, and the final result would just be the last number in the list (30), not the sum (60). The accumulator MUST be initialized *before* the loop.', 'Write a Python program that uses the accumulator pattern to count how many even numbers are in the list `data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`. Print the final count.', 'gemini-flash', '2026-06-06 14:55:51.785863+00', '2026-06-06 14:55:51.785863+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('87a055e2-ae1c-415b-8890-71423833f3ff', 157, '["List comprehensions provide a concise way to create new lists.", "They are a more readable and often more efficient alternative to `for` loops for list creation.", "The basic syntax is `[expression for item in iterable]`.", "An optional conditional `if` clause can be added: `[expression for item in iterable if condition]`."]', 'Let''s say we want to create a list of squares for numbers from 0 to 4. 

Using a `for` loop, we would write:
python
squares = []
for i in range(5):
    squares.append(i * i)
print(squares) # Output: [0, 1, 4, 9, 16]

With a list comprehension, it''s much shorter and clearer:
python
squares_comp = [i * i for i in range(5)]
print(squares_comp) # Output: [0, 1, 4, 9, 16]

Now, if we only wanted even squares:
python
even_squares_comp = [i * i for i in range(5) if i % 2 == 0]
print(even_squares_comp) # Output: [0, 4, 16]', 'Learners often think list comprehensions are only for simple transformations. They can be used for more complex logic as well, including conditional filtering, but the goal is conciseness. If the logic becomes too complex within a single line, a traditional `for` loop might be more readable.', 'Use a list comprehension to create a new list called `long_words` containing only words from an existing list `words` that have more than 5 characters. Print `long_words`.', 'gemini-flash', '2026-06-06 14:55:51.785863+00', '2026-06-06 14:55:51.785863+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8e843a3e-26be-46c8-94c8-90993e75fbb2', 158, '["Tuples are ordered collections of items, similar to lists.", "Tuple literals are defined using parentheses `()`.", "Items within a tuple are separated by commas `,`.", "A tuple can contain items of different data types (heterogeneous).", "An empty tuple is created with `()`, and a single-item tuple requires a trailing comma, e.g., `(item,)`."]', 'Let''s create a tuple named `my_info` that stores a person''s name, age, and whether they are a student. We can write this as `my_info = (''Alice'', 30, True)`. This tuple contains a string, an integer, and a boolean. To access an item, we use indexing, like `my_info[0]` which would give us ''Alice''.', 'A common mistake is forgetting the trailing comma when creating a tuple with a single item. For example, `(5)` is just the integer `5` enclosed in parentheses (a mathematical expression), not a tuple. To create a tuple containing just the integer `5`, you must write `(5,)`.', 'Create a tuple named `colors` containing the strings ''red'', ''green'', and ''blue''. Then, create another tuple named `single_number` containing only the integer 10.', 'gemini-flash', '2026-06-06 14:56:28.29955+00', '2026-06-06 14:56:28.29955+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('b962b3f0-fa7f-4fe1-a589-d1ca44290331', 159, '["Immutability means that once a tuple is created, its elements cannot be changed, added, or removed.", "This is a fundamental difference between tuples and lists, which are mutable.", "Attempts to modify a tuple (e.g., item assignment, appending) will result in a `TypeError`.", "While a tuple itself is immutable, if a tuple contains mutable objects (like lists), those mutable objects *can* still be changed.", "Immutability makes tuples suitable for data that should remain constant, like coordinates or database records."]', 'Let''s create a tuple `my_tuple = (10, 20, 30)`. If we try to change the first element `my_tuple[0] = 5`, Python will raise a `TypeError`. We can demonstrate this by trying to run the code and showing the error output. Then, contrast it with a list `my_list = [10, 20, 30]` where `my_list[0] = 5` works without error.', 'A common misconception is that if a tuple contains a mutable object (like a list), the contents of that mutable object also become immutable. For instance, if you have `t = (1, [2, 3])`, learners might think `t[1].append(4)` would fail. Emphasize that `t[1]` (the list object itself) cannot be *reassigned*, but the *contents* of the list at `t[1]` *can* be modified because the list itself is mutable.', 'Create a tuple `coordinates = (40.7128, -74.0060)`. Try to change its second element to `(-75.0000)` and observe the error. Then, explain in a comment why this error occurs.', 'gemini-flash', '2026-06-06 14:56:28.29955+00', '2026-06-06 14:56:28.29955+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('e650b693-77d3-4fe1-b4e1-a6e5c8961f20', 160, '["Tuple unpacking is the process of assigning elements of a tuple to multiple variables simultaneously.", "The number of variables on the left side of the assignment must exactly match the number of elements in the tuple on the right side.", "It provides a concise and readable way to extract data from tuples.", "Unpacking can be used with any iterable, not just tuples, but is most commonly associated with tuples due to their fixed size and immutability.", "The `*` operator (extended unpacking) can be used to capture multiple remaining elements into a list, but this is an advanced topic not covered here."]', 'Let''s say we have a tuple `coordinates = (10, 20)` representing x and y coordinates. Instead of accessing them as `coordinates[0]` and `coordinates[1]`, we can unpack them directly:

python
coordinates = (10, 20)
x, y = coordinates
print(f"X coordinate: {x}")
print(f"Y coordinate: {y}")


Output:

X coordinate: 10
Y coordinate: 20


Another example with different data types:

python
person_info = (''Alice'', 30, ''New York'')
name, age, city = person_info
print(f"Name: {name}, Age: {age}, City: {city}")


Output:

Name: Alice, Age: 30, City: New York', 'A common mistake is trying to unpack a tuple into a different number of variables than it contains. This will lead to a `ValueError: not enough values to unpack (expected X, got Y)` or `too many values to unpack (expected X)`.', 'Create a tuple `student_record` containing a student''s name (string), ID (integer), and GPA (float). Then, unpack these values into three separate variables named `student_name`, `student_id`, and `student_gpa` and print each one.', 'gemini-flash', '2026-06-06 14:56:28.29955+00', '2026-06-06 14:56:28.29955+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('6a7133ca-6dae-4286-8823-512edba42d97', 161, '["Tuples are preferred over lists when the collection of items is fixed and its contents should not change after creation (immutability).", "Use tuples for heterogeneous data that logically belongs together, like coordinates (x, y) or a database record (name, age, city).", "Tuples are more memory-efficient and slightly faster than lists for iteration and access, making them suitable for performance-critical scenarios with fixed data.", "Tuples can be used as dictionary keys because they are hashable (due to immutability), unlike lists.", "They ensure data integrity: once a tuple is created, its elements cannot be altered, preventing accidental modification."]', 'Let''s say you''re storing information about a student: their name, age, and grade point average. This is a fixed set of attributes that logically belong together and shouldn''t change its structure or accidentally have its individual components modified after creation. A tuple is perfect for this.

python
# Storing student data using a tuple
student_info = (''Alice'', 20, 3.85)

print(f"Student Name: {student_info[0]}")
print(f"Student Age: {student_info[1]}")
print(f"Student GPA: {student_info[2]}")

# Attempting to change an element would result in an error:
# student_info[1] = 21 # This would raise a TypeError

# Contrast with a list, where accidental changes are possible:
student_list = [''Bob'', 22, 3.5]
student_list[1] = 23 # This is allowed
print(f"Updated Student Age (list): {student_list[1]}")


Here, the tuple `student_info` guarantees that ''Alice'' will always be the name, 20 the age, and 3.85 the GPA for this particular record. If we used a list, there''s a risk of accidentally changing an element, which might not be desirable for a record that should be constant.', 'A common misconception is that if you need to store multiple items, a list is always the default choice. While lists are very flexible, they are best suited for collections where elements might be added, removed, or changed. Tuples, on the other hand, shine when the collection itself (its length and the meaning of its positions) is fixed and its elements should not change, acting more like a ''record'' or a ''fixed-size container''. Thinking about whether the collection represents ''a changeable sequence'' (list) or ''a fixed record/grouping'' (tuple) helps clarify which to use.', 'Imagine you''re developing a game and need to represent the immutable (x, y) coordinates of a game object on a 2D map. Create a tuple called `player_position` with the coordinates (15, 30). Then, print these coordinates in a formatted string like ''Player is at X: 15, Y: 30''. Try to modify the `x` coordinate and observe the error.', 'gemini-flash', '2026-06-06 14:56:28.29955+00', '2026-06-06 14:56:28.29955+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('142dba01-8af7-4b84-b38e-be24ec4506ae', 162, '["Functions in Python can return multiple values by simply listing them after the `return` keyword, separated by commas.", "When a function returns multiple values this way, Python implicitly packs these values into a tuple.", "The caller can then unpack these values directly into multiple variables, making the code clean and readable.", "This is a common and idiomatic Python pattern for functions that naturally produce several related results.", "Tuple immutability ensures that the collection of returned values remains unchanged after the function call."]', 'python
def get_stats(numbers):
    if not numbers:
        return 0, 0, 0  # Return default values for empty list
    total = sum(numbers)
    count = len(numbers)
    average = total / count
    return total, count, average

# Calling the function and unpacking the returned tuple
data = [10, 20, 30, 40]
total_sum, num_items, avg_value = get_stats(data)

print(f"Total: {total_sum}")
print(f"Count: {num_items}")
print(f"Average: {avg_value}")

# What happens if we try to modify a part of the ''returned tuple'' (conceptually)?
# avg_value = 100 # This works, but we are assigning a new value to the variable,
                 # not changing the tuple that was implicitly returned.
                 # The original tuple (total, count, average) is immutable.', 'Learners might think that functions return multiple *separate* variables that are somehow ''magically'' passed around. Clarify that it''s always a single object being returned (the tuple), and the unpacking syntax on the caller''s side handles assigning its elements to individual variables.', 'Write a function `calculate_dimensions(length, width)` that takes two numbers and returns their area and perimeter as a tuple. Then, call the function with `5` and `10`, unpack the results into `area` and `perimeter` variables, and print them.', 'gemini-flash', '2026-06-06 14:56:28.29955+00', '2026-06-06 14:56:28.29955+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('5a418906-ac06-43d5-9d85-bdd6b5d8fa71', 163, '["Dictionaries store data in key-value pairs, where each key is unique and maps to a specific value.", "Dictionary literals are created using curly braces `{}` with key-value pairs separated by colons (`:`) and pairs by commas (`,`). For example: `{''name'': ''Alice'', ''age'': 30}`.", "Values are accessed using their corresponding keys inside square brackets: `my_dict[key]`.", "New key-value pairs can be added to an existing dictionary by assigning a value to a new key: `my_dict[''new_key''] = ''new_value''`.", "Existing values can be updated by assigning a new value to an existing key: `my_dict[''existing_key''] = ''updated_value''`.", "Key-value pairs can be deleted using the `del` keyword followed by the dictionary and the key in square brackets: `del my_dict[key]`."]', 'Let''s create a dictionary for a student''s information, then access their name, update their age, and add their major.

python
student = {
    ''name'': ''Bob'',
    ''age'': 22,
    ''is_enrolled'': True
}

# Access a value
print(f"Student Name: {student[''name'']}")

# Update a value
student[''age''] = 23
print(f"Updated Age: {student[''age'']}")

# Add a new key-value pair
student[''major''] = ''Computer Science''
print(f"Student Major: {student[''major'']}")

# Delete a key-value pair
del student[''is_enrolled'']
print(student)


Output:

Student Name: Bob
Updated Age: 23
Student Major: Computer Science
{''name'': ''Bob'', ''age'': 23, ''major'': ''Computer Science''}', 'A common misconception is that dictionaries are ordered like lists. While Python 3.7+ maintains insertion order, you should not rely on this for older versions or if the order is critical for logic. Dictionaries are primarily for fast lookups by key, not ordered sequencing.', 'Create a dictionary named `inventory` to store the quantity of fruits. Initialize it with `apples: 10` and `bananas: 15`. Then, update the quantity of `apples` to `12` and add a new fruit `oranges` with a quantity of `8`. Finally, delete `bananas` from the inventory and print the final dictionary.', 'gemini-flash', '2026-06-06 14:56:57.517105+00', '2026-06-06 14:56:57.517105+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('bac23855-0d14-4538-9ebf-91f07135f2f0', 164, '["The `.get(key, default)` method safely retrieves a value for a given key. If the key is not found, it returns `None` by default, or a specified `default` value instead of raising a `KeyError`.", "The `.keys()` method returns a dictionary view object that displays a list of all the keys in the dictionary.", "The `.values()` method returns a dictionary view object that displays a list of all the values in the dictionary.", "The `.items()` method returns a dictionary view object that displays a list of a dictionary''s key-value tuple pairs.", "Dictionary view objects (`.keys()`, `.values()`, `.items()`) provide a dynamic view of the dictionary''s contents; changes to the dictionary are reflected in the views."]', 'Let''s say we have a dictionary `student_grades = {''Alice'': 95, ''Bob'': 88}`.

1.  **`get()` method:**
    -   `grade_alice = student_grades.get(''Alice'')`  # `grade_alice` is 95
    -   `grade_charlie = student_grades.get(''Charlie'')` # `grade_charlie` is `None`
    -   `grade_david = student_grades.get(''David'', 0)` # `grade_david` is 0
    -   Attempting `student_grades[''Charlie'']` would raise a `KeyError`.

2.  **`keys()` method:**
    -   `all_names = student_grades.keys()`  # `all_names` is `dict_keys([''Alice'', ''Bob''])`
    -   If `student_grades[''Charlie''] = 92` is added, `all_names` would then reflect `dict_keys([''Alice'', ''Bob'', ''Charlie''])`.

3.  **`values()` method:**
    -   `all_grades = student_grades.values()` # `all_grades` is `dict_values([95, 88])`

4.  **`items()` method:**
    -   `all_pairs = student_grades.items()` # `all_pairs` is `dict_items([(''Alice'', 95), (''Bob'', 88)])`', 'Learners often expect `.keys()`, `.values()`, and `.items()` to return actual lists. They return *view objects*. While these views can be iterated over like lists, and converted to lists (e.g., `list(my_dict.keys())`), they are not independent copies. If the original dictionary changes, the view objects reflect those changes dynamically. Emphasize that they are ''views'' and not ''copies''.', 'Create a dictionary `inventory = {''apples'': 50, ''bananas'': 20, ''oranges'': 30}`.
1.  Use `.get()` to retrieve the quantity of ''apples'' and store it in `apple_count`. If ''grapes'' are not found, return 0.
2.  Get a view of all item names using `.keys()` and store it in `item_names`.
3.  Get a view of all quantities using `.values()` and store it in `item_quantities`.
4.  Get a view of all item-quantity pairs using `.items()` and store it in `item_pairs`.', 'gemini-flash', '2026-06-06 14:56:57.517105+00', '2026-06-06 14:56:57.517105+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('3156277d-8dcf-4a80-a485-d626acc3bb56', 165, '["You can iterate over a dictionary''s keys directly using a `for` loop.", "The `.keys()` method explicitly returns a view object of the dictionary''s keys, which can also be iterated over.", "The `.values()` method returns a view object of the dictionary''s values, allowing iteration over values only.", "The `.items()` method returns a view object of key-value pairs as tuples, enabling iteration over both.", "The `in` operator efficiently checks if a key exists in a dictionary.", "The `not in` operator checks if a key does not exist in a dictionary."]', 'Let''s say we have a dictionary `student_grades = {''Alice'': 95, ''Bob'': 88, ''Charlie'': 92}`.

To iterate through keys:
python
for student in student_grades:
    print(f''{student} is a student.'')
# Output:
# Alice is a student.
# Bob is a student.
# Charlie is a student.


To iterate through values:
python
for grade in student_grades.values():
    print(f''A grade of {grade} was given.'')
# Output:
# A grade of 95 was given.
# A grade of 88 was given.
# A grade of 92 was given.


To iterate through key-value pairs:
python
for student, grade in student_grades.items():
    print(f''{student} got {grade}.'')
# Output:
# Alice got 95.
# Bob got 88.
# Charlie got 92.


To check for membership:
python
print(''Alice'' in student_grades) # Output: True
print(''David'' in student_grades) # Output: False
print(''Bob'' not in student_grades) # Output: False', 'A common misconception is that the `in` operator directly checks for the presence of a *value* in a dictionary. It only checks for *keys*. To check for a value, you would need to iterate through the dictionary''s values or use the `.values()` method with `in`.', 'Write a Python program that defines a dictionary `inventory = {''apples'': 50, ''bananas'': 20, ''oranges'': 30}`. Use a `for` loop to print each item''s name and its quantity. Then, use the `in` operator to check if ''grapes'' is in the inventory and print an appropriate message.', 'gemini-flash', '2026-06-06 14:56:57.517105+00', '2026-06-06 14:56:57.517105+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('dd968b9e-6866-4ad9-a241-2bbc65a8354a', 166, '["Dictionaries are ideal for counting occurrences because each unique item can be a key, and its count can be the associated value.", "To count, initialize an empty dictionary. Iterate through the collection (e.g., a list or string).", "For each item, check if it''s already a key in the dictionary. If yes, increment its value; if no, add it as a new key with a value of 1.", "The `get()` method with a default value (e.g., `dictionary.get(key, 0)`) is a concise way to handle both existing and new keys when counting."]', 'Let''s count the frequency of each fruit in a list: `fruits = [''apple'', ''banana'', ''apple'', ''orange'', ''banana'', ''apple'']`

1. Initialize `fruit_counts = {}`
2. Iterate through `fruits`:
   - ''apple'': `fruit_counts.get(''apple'', 0)` is 0. `fruit_counts[''apple''] = 0 + 1` -> `{''apple'': 1}`
   - ''banana'': `fruit_counts.get(''banana'', 0)` is 0. `fruit_counts[''banana''] = 0 + 1` -> `{''apple'': 1, ''banana'': 1}`
   - ''apple'': `fruit_counts.get(''apple'', 0)` is 1. `fruit_counts[''apple''] = 1 + 1` -> `{''apple'': 2, ''banana'': 1}`
   - ''orange'': `fruit_counts.get(''orange'', 0)` is 0. `fruit_counts[''orange''] = 0 + 1` -> `{''apple'': 2, ''banana'': 1, ''orange'': 1}`
   - ''banana'': `fruit_counts.get(''banana'', 0)` is 1. `fruit_counts[''banana''] = 1 + 1` -> `{''apple'': 2, ''banana'': 2, ''orange'': 1}`
   - ''apple'': `fruit_counts.get(''apple'', 0)` is 2. `fruit_counts[''apple''] = 2 + 1` -> `{''apple'': 3, ''banana'': 2, ''orange'': 1}`

Final `fruit_counts`: `{''apple'': 3, ''banana'': 2, ''orange'': 1}`', 'A common mistake is forgetting to initialize the count for a new item. Without `get(key, 0)` or an `if key in dictionary:` check, trying to access `dictionary[key] + 1` for a new key will raise a `KeyError`.', 'Write a Python snippet that counts the occurrences of each letter (case-sensitive) in the string `"Hello World"` and prints the resulting dictionary.', 'gemini-flash', '2026-06-06 14:56:57.517105+00', '2026-06-06 14:56:57.517105+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('d223c999-b2f6-4c0f-9649-94a5b6dc7ab0', 167, '["A list of dictionaries is a fundamental way to store collections of related, structured data in Python.", "Each dictionary within the list represents a single ''record'' or ''item'', with keys describing attributes and values holding their respective data.", "This structure is ideal for representing datasets where each entry has a consistent set of properties (e.g., a list of users, products, or sensor readings).", "You can create a list of dictionaries by enclosing individual dictionaries within square brackets `[]`.", "Individual dictionaries can be accessed by their index in the list, and then their values accessed using keys."]', 'Let''s say we want to store information about several books. Each book has a title, author, and publication year. We can represent this using a list of dictionaries:

python
books = [
    {
        ''title'': ''The Hitchhiker\''s Guide to the Galaxy'',
        ''author'': ''Douglas Adams'',
        ''year'': 1979
    },
    {
        ''title'': ''Pride and Prejudice'',
        ''author'': ''Jane Austen'',
        ''year'': 1813
    },
    {
        ''title'': ''1984'',
        ''author'': ''George Orwell'',
        ''year'': 1949
    }
]

# Accessing the title of the second book
print(books[1][''title''])

# Adding a new book
new_book = {
    ''title'': ''Brave New World'',
    ''author'': ''Aldous Huxley'',
    ''year'': 1932
}
books.append(new_book)

# Printing the updated list (optional, for demonstration)
# print(books)


Output of `print(books[1][''title''])` would be: `Pride and Prejudice`', 'A common misconception is thinking that all dictionaries in a list must have the exact same keys. While it''s best practice for consistency when representing structured data, Python technically allows dictionaries with different keys within the same list. Emphasize that for ''collections of structured items'', maintaining consistent keys across dictionaries in the list is crucial for predictable data access and processing.', 'Create a list named `students` where each element is a dictionary. Each dictionary should represent a student with the keys `''name''` (string), `''id''` (integer), and `''major''` (string). Add at least two student dictionaries to the list. Then, print the major of the first student in your list.', 'gemini-flash', '2026-06-06 14:57:40.230173+00', '2026-06-06 14:57:40.230173+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('7c51fb9b-7206-4443-8dc4-d9cb9c0091e0', 168, '["Dictionaries of Lists allow you to associate a single key with multiple related values, stored as a list.", "The keys in such dictionaries are unique, while the lists associated with them can contain any number of elements, including duplicates.", "You access the list associated with a key using standard dictionary key access (e.g., `my_dict[''key'']`).", "Once you have accessed the list, you can use all standard list operations (append, index, slice, iterate) on it.", "This structure is ideal for grouping data, such as all students in a class, all items in a category, or all orders by a customer."]', 'Let''s say we want to store different genres of movies and list some movies for each genre. 

python
movies_by_genre = {
    ''Action'': [''Die Hard'', ''The Dark Knight'', ''Inception''],
    ''Comedy'': [''Superbad'', ''Anchorman''],
    ''Sci-Fi'': [''Blade Runner 2049'', ''Dune'', ''Arrival'']
}

print(f"Action movies: {movies_by_genre[''Action'']}")

# Adding a new movie to an existing genre
movies_by_genre[''Comedy''].append(''Step Brothers'')
print(f"Updated Comedy movies: {movies_by_genre[''Comedy'']}")

# Adding a new genre with its movies
movies_by_genre[''Fantasy''] = [''Lord of the Rings'', ''Harry Potter'']
print(f"All genres: {list(movies_by_genre.keys())}")
print(f"Fantasy movies: {movies_by_genre[''Fantasy'']}")', 'A common mistake is trying to access individual elements within the list directly from the dictionary without first retrieving the list itself. For example, `movies_by_genre[''Action''][0]` is correct, but `movies_by_genre[''Action'', 0]` will raise a `KeyError` because `(''Action'', 0)` is not a key in the dictionary.', 'Create a dictionary called `team_members` where keys are team names (e.g., ''Alpha'', ''Beta'') and values are lists of member names (strings). Add at least two teams with 2-3 members each. Then, add a new member to an existing team and print the updated list for that team.', 'gemini-flash', '2026-06-06 14:57:40.230173+00', '2026-06-06 14:57:40.230173+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('67906206-13f5-411e-b4f4-8b946f640ceb', 169, '["Nested data structures combine lists and dictionaries, allowing for complex data organization.", "Accessing elements in nested structures requires chaining indexing operations using square brackets `[]`.", "For lists, use integer indices (e.g., `my_list[0]`); for dictionaries, use string/key indices (e.g., `my_dict[''key'']`).", "The order of indexing matters: each `[]` operation resolves one level deeper into the structure.", "You can mix and match list and dictionary indexing as needed to navigate the structure."]', 'Imagine we have a list of dictionaries, where each dictionary represents a city and contains information about its population and a list of landmarks.

python
cities_data = [
    {
        ''name'': ''Paris'',
        ''country'': ''France'',
        ''info'': {
            ''population'': 2141000,
            ''continent'': ''Europe''
        },
        ''landmarks'': [''Eiffel Tower'', ''Louvre Museum'']
    },
    {
        ''name'': ''Tokyo'',
        ''country'': ''Japan'',
        ''info'': {
            ''population'': 13960000,
            ''continent'': ''Asia''
        },
        ''landmarks'': [''Tokyo Skytree'', ''Shibuya Crossing'']
    }
]

# How do we access ''Louvre Museum''?
# 1. cities_data is a list, so we need an index for the first city (Paris).
#    cities_data[0]
# 2. This is now a dictionary. We want the ''landmarks'' key.
#    cities_data[0][''landmarks'']
# 3. This is a list. We want the second landmark (Louvre Museum).
#    cities_data[0][''landmarks''][1]

print(cities_data[0][''landmarks''][1]) # Output: Louvre Museum

# How do we access Tokyo''s population?
# 1. cities_data[1] (for Tokyo''s dictionary)
# 2. cities_data[1][''info''] (for the nested info dictionary)
# 3. cities_data[1][''info''][''population''] (for the population value)

print(cities_data[1][''info''][''population'']) # Output: 13960000', 'A common mistake is confusing list indices with dictionary keys, or applying them in the wrong order. For example, trying `cities_data[''Paris'']` when `cities_data` is a list, or `cities_data[0][1]` when `cities_data[0]` is a dictionary and `1` is not a valid key. Always trace the type of the element returned by the previous indexing step.', 'Given a dictionary `company_data` that holds information about departments and their employees, access the email address of the second employee in the ''Engineering'' department.

`company_data = {''HR'': [{''name'': ''Alice'', ''id'': ''H001''}, {''name'': ''Bob'', ''id'': ''H002''}], ''Engineering'': [{''name'': ''Charlie'', ''id'': ''E001'', ''email'': ''charlie@example.com''}, {''name'': ''Diana'', ''id'': ''E002'', ''email'': ''diana@example.com''}], ''Sales'': [{''name'': ''Eve'', ''id'': ''S001''}]}`', 'gemini-flash', '2026-06-06 14:57:40.230173+00', '2026-06-06 14:57:40.230173+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('fcf09653-b90d-4287-954a-5c2154ba4d8a', 170, '["Iterating nested data structures (lists within lists, dictionaries within dictionaries, or combinations) requires using nested loops.", "To iterate through a list of dictionaries, use an outer loop for the list and an inner loop to access dictionary items (e.g., `for item in my_list: for key, value in item.items():`).", "To iterate through a dictionary where values are lists, use an outer loop for dictionary items (keys and values) and an inner loop for the list elements (e.g., `for key, value_list in my_dict.items(): for element in value_list:`).", "When nesting deeper, simply add more loops. Keep track of the current level of nesting and the type of data at that level.", "List comprehensions and dictionary comprehensions can offer more concise ways to iterate and transform nested structures, especially for creating new nested structures."]', 'Let''s say we have `students = [{''name'': ''Alice'', ''grades'': [90, 85, 92]}, {''name'': ''Bob'', ''grades'': [78, 88]}]`. To print each student''s name and all their grades:

python
students = [
    {''name'': ''Alice'', ''grades'': [90, 85, 92]},
    {''name'': ''Bob'', ''grades'': [78, 88]}
]

for student in students: # Iterates through each dictionary in the list
    print(f"Student: {student[''name'']}")
    print("Grades:")
    for grade in student[''grades'']: # Iterates through the ''grades'' list within each dictionary
        print(f"  - {grade}")


Output:

Student: Alice
Grades:
  - 90
  - 85
  - 92
Student: Bob
Grades:
  - 78
  - 88', 'A common mistake is trying to access elements at a deeper level of nesting with only one loop, or forgetting to unpack dictionary items when needed. For example, `for student in students: print(student[''grades''][0])` would only print the *first* grade for each student, not all of them, and `for student in students: print(student)` would print the whole dictionary, not its individual components.', 'You have a dictionary representing departments, where each department has a list of employee names. Write code to print each department name, followed by each employee in that department.

Example data:
`company_employees = {''HR'': [''Sarah'', ''John''], ''Engineering'': [''Alice'', ''Bob'', ''Charlie''], ''Sales'': [''David'']}`', 'gemini-flash', '2026-06-06 14:57:40.230173+00', '2026-06-06 14:57:40.230173+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('86dcbade-ffa5-43b7-bd7b-9c3fdbb6756e', 171, '["Choosing the right nested data structure (list of dictionaries, dictionary of lists, etc.) depends on how you primarily want to access and organize your data.", "A ''list of dictionaries'' is ideal when your data consists of a collection of distinct items, each with several associated attributes, and you often iterate through all items.", "A ''dictionary of lists'' is better when you have distinct categories or keys, and each key maps to a collection of related values, making direct access by category efficient.", "Consider the ''primary key'' or the most frequent lookup method: if you look up by an item''s unique identifier, a dictionary (of dictionaries, or a dict where values are lists) might be best.", "If order matters or you primarily process all items sequentially, a list is often the outer structure.", "The goal is to structure data in a way that simplifies access, modification, and iteration for your specific use case, minimizing complexity."]', 'Imagine you are storing data about students. Each student has a ''name'', ''id'', and a list of ''courses''.

**Scenario 1: You often need to list all students or process them one by one.**
A `list of dictionaries` is suitable here:
python
students_data_list_of_dicts = [
    {"name": "Alice", "id": "s001", "courses": ["Math", "Physics"]},
    {"name": "Bob", "id": "s002", "courses": ["Chemistry", "Biology"]}
]
# Accessing: students_data_list_of_dicts[0]["name"]
# Iterating: for student in students_data_list_of_dicts:


**Scenario 2: You often need to quickly find a student by their ID.**
A `dictionary of dictionaries` (or dictionary where values are student objects/dicts) is better:
python
students_data_dict_of_dicts = {
    "s001": {"name": "Alice", "courses": ["Math", "Physics"]},
    "s002": {"name": "Bob", "courses": ["Chemistry", "Biology"]}
}
# Accessing: students_data_dict_of_dicts["s001"]["name"]
# Iterating: for student_id, student_info in students_data_dict_of_dicts.items():


**Scenario 3: You often need to get all students taking a particular course.**
This might lead to a `dictionary of lists` where keys are courses and values are lists of student IDs/names:
python
courses_to_students_dict_of_lists = {
    "Math": ["s001"],
    "Physics": ["s001"],
    "Chemistry": ["s002"],
    "Biology": ["s002"]
}
# Accessing: courses_to_students_dict_of_lists["Math"]

Each structure optimizes for a different primary access pattern.', 'A common misconception is that one structure is inherently ''better'' than another. The ''best'' structure is always contextual, depending on the most frequent operations (adding, deleting, searching, iterating, sorting) you will perform on the data.', 'Consider a scenario where you are tracking products in an inventory. Each product has a `product_id`, `name`, `category`, and `price`. You will frequently need to: 1) Display all products, and 2) Find a product quickly by its `product_id`.

Which single nested data structure would you choose to best support both of these common operations, and why? Describe the structure you would use (e.g., list of dictionaries, dictionary of lists, dictionary of dictionaries).', 'gemini-flash', '2026-06-06 14:57:40.230173+00', '2026-06-06 14:57:40.230173+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('1ec1a313-6302-4455-b9e6-d78bde39481b', 172, '["Conditional statements allow your program to make decisions and execute different blocks of code based on whether specific conditions are met.", "The `if` statement is the most basic, executing its indented block only if its condition is `True`.", "The `elif` (short for ''else if'') statement allows you to check additional conditions if the preceding `if` or `elif` conditions were `False`.", "The `else` statement acts as a catch-all, executing its indented block if none of the preceding `if` or `elif` conditions were `True`.", "Only one block of code within an `if`-`elif`-`else` structure will ever be executed: the first one whose condition evaluates to `True`, or the `else` block if all conditions are `False`."]', 'Let''s say we want to determine if a number is positive, negative, or zero.

python
number = 5

if number > 0:
    print("The number is positive.")
elif number < 0:
    print("The number is negative.")
else:
    print("The number is zero.")


If `number` is 5, `number > 0` is `True`, so "The number is positive." is printed. The `elif` and `else` blocks are skipped.

If `number` was -3, `number > 0` would be `False`. Then `number < 0` would be `True`, so "The number is negative." would be printed. The `else` block would be skipped.

If `number` was 0, `number > 0` would be `False`, and `number < 0` would also be `False`. Then the `else` block would execute, printing "The number is zero."', 'A common mistake is thinking that multiple `if` blocks will execute if their conditions are met, even if they are logically exclusive. Remember that `elif` and `else` are chained to a preceding `if`. If you use separate `if` statements, they are evaluated independently, and potentially multiple blocks could execute if their conditions are true.', 'Write a program that checks a variable `age` and prints different messages based on its value:
- If `age` is 18 or greater, print "You are an adult."
- If `age` is between 13 and 17 (inclusive), print "You are a teenager."
- Otherwise, print "You are a child."

Test with `age = 20`, `age = 15`, and `age = 7`.', 'gemini-flash', '2026-06-06 14:58:15.533176+00', '2026-06-06 14:58:15.533176+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('cee6b984-7f42-4330-bcc7-29595b708902', 173, '["Comparison operators evaluate two values and return a Boolean (True or False).", "Equality (==) checks if two values are the same; Inequality (!=) checks if they are different.", "Greater than (>), Less than (<), Greater than or equal to (>=), and Less than or equal to (<=) compare numerical order.", "Comparison operators are fundamental for creating conditions in `if`, `elif`, and `else` statements.", "The result of a comparison can be directly assigned to a variable or used in a conditional expression."]', 'Let''s say we have two variables: `temperature = 25` and `threshold = 20`. We want to know if `temperature` is greater than `threshold`. We would write `temperature > threshold`. Python evaluates this to `True` because 25 is indeed greater than 20. If we wrote `temperature == threshold`, it would evaluate to `False`.', 'A common mistake is confusing the assignment operator `=` with the equality comparison operator `==`. `=` is used to assign a value to a variable, while `==` is used to check if two values are equal. Using `=` in a conditional statement (e.g., `if x = 5:`) will often lead to a `SyntaxError` or unexpected behavior, as it''s an assignment, not a comparison.', 'Write a Python expression that checks if the variable `num_items` (assume it''s an integer) is less than or equal to 10. Print the boolean result.', 'gemini-flash', '2026-06-06 14:58:15.533176+00', '2026-06-06 14:58:15.533176+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8e6d654d-c7f5-4975-b61a-1d26dad317e0', 174, '["Boolean operators `and`, `or`, and `not` are used to combine or modify boolean expressions (which evaluate to `True` or `False`).", "`and`: Returns `True` if BOTH operands are `True`. Otherwise, it returns `False`.", "`or`: Returns `True` if AT LEAST ONE of the operands is `True`. It only returns `False` if BOTH operands are `False`.", "`not`: Unary operator that negates a boolean value. `not True` is `False`, and `not False` is `True`.", "These operators are crucial for building complex conditions in `if`, `elif`, and `else` statements.", "Operator precedence: `not` has the highest precedence, followed by `and`, then `or`. Parentheses `()` can be used to override precedence."]', 'Let''s say we want to check if a number `x` is between 10 and 20 (inclusive). We can use `and`:
python
x = 15
condition = (x >= 10) and (x <= 20)
print(condition) # Output: True

y = 5
condition2 = (y >= 10) and (y <= 20)
print(condition2) # Output: False

# Or, to check if a student passed either the midterm or the final:
midterm_score = 75
final_score = 60
passed_midterm = midterm_score >= 70
passed_final = final_score >= 60

overall_pass = passed_midterm or passed_final
print(f"Overall pass: {overall_pass}") # Output: Overall pass: True

# And to negate a condition:
is_raining = False
should_take_umbrella = not is_raining
print(f"Should take umbrella: {should_take_umbrella}") # Output: Should take umbrella: True', 'Learners often confuse the behavior of `and` and `or`. A common mistake is thinking `or` requires both to be true, or `and` requires only one to be true. Emphasize `and` is ''all true'' and `or` is ''at least one true''. Also, ensure they understand `not` operates on a single boolean expression.', 'Write a Python script that checks if a person is eligible to vote AND is older than 18, OR if they are an active military member (regardless of age). Print the result. Assume variables `age`, `is_citizen`, and `is_military` are already defined.', 'gemini-flash', '2026-06-06 14:58:15.533176+00', '2026-06-06 14:58:15.533176+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('4d84e0bb-3013-4094-8d21-9b4c5bcc7569', 187, '["Functions are reusable blocks of code that perform a specific task.", "You define a function in Python using the `def` keyword.", "After `def`, you provide a unique function name, followed by parentheses `()`, and then a colon `:`.", "The code belonging to the function must be indented (typically 4 spaces) below the `def` line.", "The parentheses `()` are crucial, even if the function doesn''t take any inputs yet."]', 'python
def greet_user():
    print("Hello there!")
    print("Welcome to the course.")


**Explanation:**
- `def` signals that we are defining a function.
- `greet_user` is the chosen name for our function. It should be descriptive.
- `()` indicate that this function currently takes no arguments.
- `:` marks the end of the function header.
- The two `print` statements are indented, meaning they are part of the `greet_user` function''s body.', 'A common mistake is forgetting the colon `:` at the end of the `def` line, or not indenting the function body. Python relies heavily on indentation to define code blocks.', 'Write a simple function called `display_message` that prints the text "This is my first Python function!" when it is run. Remember to use the `def` keyword, a function name, parentheses, and a colon, followed by an indented `print` statement.', 'gemini-flash', '2026-06-06 14:50:38.676467+00', '2026-06-06 15:00:09.124422+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('fece99ae-cb43-42ce-a434-48e943209022', 175, '["In Python, many values are inherently ''truthy'' or ''falsy'' when evaluated in a boolean context (e.g., within an `if` statement or with boolean operators), even if they are not explicitly `True` or `False`.", "Falsy values include: `None`, `False`, numeric zero (integers `0`, floats `0.0`), empty sequences (strings `''''`, lists `[]`, tuples `()`), empty mappings (dictionaries `{}`), and empty sets (`set()`).", "All other values are generally considered truthy. This includes non-empty strings, non-zero numbers, non-empty lists, etc.", "This behavior is crucial for writing concise and Pythonic conditional logic.", "You can explicitly check the boolean value of an object using the `bool()` function."]', 'Let''s see how different values are evaluated in a boolean context:

python
# Falsy examples
if 0:
    print(''0 is truthy'')
else:
    print(''0 is falsy'') # This will print

if '''':
    print(''Empty string is truthy'')
else:
    print(''Empty string is falsy'') # This will print

my_list = []
if my_list:
    print(''Empty list is truthy'')
else:
    print(''Empty list is falsy'') # This will print

# Truthy examples
if 10:
    print(''10 is truthy'') # This will print
else:
    print(''10 is falsy'')

if ''hello'':
    print(''Non-empty string is truthy'') # This will print
else:
    print(''Non-empty string is falsy'')

my_dict = {''key'': ''value''}
if my_dict:
    print(''Non-empty dictionary is truthy'') # This will print
else:
    print(''Non-empty dictionary is falsy'')', 'A common misconception is that only `True` and `False` are considered booleans, and other values need explicit conversion. While `bool()` can be used, Python automatically applies truthiness/falsiness rules in conditional statements, making explicit `bool()` calls often unnecessary and less Pythonic in `if` conditions. For example, `if my_list:` is preferred over `if bool(my_list):`.', 'Write a Python script that defines a variable `user_input_string` and assigns it an empty string. Then, using an `if/else` statement, print ''Input provided!'' if `user_input_string` is truthy, and ''No input.'' if it is falsy. After testing with an empty string, change `user_input_string` to a non-empty string like ''hello'' and observe the change in output.', 'gemini-flash', '2026-06-06 14:58:15.533176+00', '2026-06-06 14:58:15.533176+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('27fef6bc-58cd-4818-85c5-8afb3546b1dd', 176, '["Conditional expressions provide a concise way to assign a value to a variable based on a boolean condition, all in a single line.", "The syntax is `value_if_true if condition else value_if_false`.", "This is often referred to as the ''ternary operator'' because it takes three operands: the true value, the condition, and the false value.", "It''s a compact alternative to a full `if/else` statement when the goal is simply to return or assign one of two values.", "Use it for readability and brevity when the logic is straightforward; avoid nesting for complex conditions."]', 'Let''s say we want to determine if a person is old enough to vote. We could do it with a standard `if/else`:

python
age = 17
if age >= 18:
    can_vote = ''Yes''
else:
    can_vote = ''No''
print(can_vote) # Output: No


Using a conditional expression, we can achieve the same result in one line:

python
age = 17
can_vote = ''Yes'' if age >= 18 else ''No''
print(can_vote) # Output: No


Here, `''Yes''` is `value_if_true`, `age >= 18` is `condition`, and `''No''` is `value_if_false`.', 'A common misconception is trying to use conditional expressions for executing code blocks with side effects (like printing or complex assignments) rather than just returning a value. For example, `print(''Allowed'') if age >= 18 else print(''Denied'')` works but is generally considered less Pythonic and harder to read than a standard `if/else` for actions. Conditional expressions are best for *assigning* values.', 'Write a conditional expression that assigns ''Even'' to a variable `parity` if `number` is divisible by 2, otherwise assign ''Odd''. Assume `number` is already defined as an integer.', 'gemini-flash', '2026-06-06 14:58:15.533176+00', '2026-06-06 14:58:15.533176+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('67bc1b3f-0109-40ed-b08e-c0c562922b55', 177, '["A `while` loop repeatedly executes a block of code as long as a given condition is `True`.", "The condition is evaluated *before* each iteration of the loop. If it''s `False` initially, the loop body never runs.", "The basic syntax is `while condition:`, followed by an indented block of code (the loop body).", "It''s crucial for something *inside* the loop body to eventually make the condition `False`, otherwise the loop will run forever (an ''infinite loop'').", "Common uses include counting, accumulating values, or performing actions until a certain state is reached."]', 'Let''s say we want to print numbers from 1 to 3. We can use a `while` loop:
python
count = 1
while count <= 3:
    print(count)
    count = count + 1 # This line is critical to eventually make count <= 3 False
print("Loop finished.")

**Explanation:**
1. `count` starts at 1.
2. **Iteration 1:** `count <= 3` (1 <= 3) is `True`. Print 1. `count` becomes 2.
3. **Iteration 2:** `count <= 3` (2 <= 3) is `True`. Print 2. `count` becomes 3.
4. **Iteration 3:** `count <= 3` (3 <= 3) is `True`. Print 3. `count` becomes 4.
5. **Iteration 4:** `count <= 3` (4 <= 3) is `False`. The loop terminates.
6. `print("Loop finished.")` executes.', 'Learners often forget to update the variable(s) involved in the `while` loop''s condition inside the loop body. This leads to an infinite loop, where the condition never becomes `False` and the program keeps executing the loop indefinitely.', 'Write a `while` loop that prints the numbers from 5 down to 1, each on a new line. Make sure your loop eventually stops.', 'gemini-flash', '2026-06-06 14:58:57.734578+00', '2026-06-06 14:58:57.734578+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('85d31521-a43e-4c32-b50d-2dd193018d1e', 178, '["A ''while'' loop continues to execute as long as its condition is `True`.", "A ''loop variable'' is a variable whose value changes within the loop''s body.", "The loop variable is crucial for controlling how many times the loop runs and for eventually making the loop''s condition `False`.", "To terminate a ''while'' loop, the loop variable must be updated inside the loop in a way that eventually causes the loop''s condition to become `False`.", "Proper initialization of the loop variable before the loop starts is essential."]', 'Let''s track how many tasks are left. We''ll use a `tasks_remaining` variable. We start with 3 tasks. Inside the loop, we''ll ''complete'' one task by decreasing `tasks_remaining` by 1. The loop continues as long as `tasks_remaining` is greater than 0.

python
tasks_remaining = 3
print(f"Initial tasks: {tasks_remaining}")

while tasks_remaining > 0:
    print(f"Completing task {tasks_remaining}...")
    tasks_remaining = tasks_remaining - 1 # Update the loop variable
    print(f"Tasks left: {tasks_remaining}")

print("All tasks completed!")


Output:

Initial tasks: 3
Completing task 3...
Tasks left: 2
Completing task 2...
Tasks left: 1
Completing task 1...
Tasks left: 0
All tasks completed!


Notice how `tasks_remaining` changes each iteration, eventually reaching 0, which makes the condition `tasks_remaining > 0` `False` and stops the loop.', 'A common mistake is forgetting to update the loop variable inside the loop, or updating it incorrectly. This can lead to an ''infinite loop'' where the condition never becomes `False`, causing the program to run forever. Always double-check that your update logic will eventually satisfy the termination condition.', 'Write a `while` loop that counts down from a given `start_number` to 1, printing each number. Ensure the loop properly terminates.', 'gemini-flash', '2026-06-06 14:58:57.734578+00', '2026-06-06 14:58:57.734578+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('98edb6c7-7cda-4085-8202-14f95ce93ccb', 179, '["The `break` statement immediately terminates the current loop, transferring program control to the statement immediately following the loop.", "`break` is often used when a certain condition is met and further iterations are unnecessary or undesirable.", "The `continue` statement skips the rest of the code inside the current loop iteration and proceeds to the next iteration of the loop.", "`continue` is useful when you want to bypass certain parts of an iteration based on a condition without exiting the loop entirely.", "Both `break` and `continue` affect the flow of control within loops, but `break` exits the loop, while `continue` jumps to the next iteration."]', 'Let''s say we want to print numbers from 1 to 10, but stop if we encounter 5.

python
count = 1
while count <= 10:
    if count == 5:
        break
    print(count)
    count += 1
# Output:
# 1
# 2
# 3
# 4


Now, let''s say we want to print numbers from 1 to 10, but skip printing 5.

python
count = 0
while count < 10:
    count += 1
    if count == 5:
        continue
    print(count)
# Output:
# 1
# 2
# 3
# 4
# 6
# 7
# 8
# 9
# 10', 'A common misunderstanding is confusing `break` and `continue`. Learners might think `continue` exits the loop or that `break` just skips the current iteration. Emphasize that `break` is an ''exit'' command for the loop, while `continue` is a ''skip current and go to next'' command for the iteration.', 'Write a `while` loop that iterates from 1 to 7. Use a `continue` statement to skip printing the number 4. The loop should print all other numbers in the range.', 'gemini-flash', '2026-06-06 14:58:57.734578+00', '2026-06-06 14:58:57.734578+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('06885601-de63-4269-b63d-b8cb658948e8', 180, '["An infinite loop is a loop that never terminates because its termination condition is never met.", "Common causes include forgetting to update the loop control variable, incorrect update logic, or a condition that is always true.", "Always ensure there''s a clear path for the loop control variable to reach the state that makes the `while` condition `False`.", "Incrementing/decrementing loop variables correctly is crucial for numerical conditions.", "For boolean flags, ensure there''s code inside the loop that eventually sets the flag to `False`.", "Carefully analyze your loop''s condition and the code within the loop to predict its termination."]', 'Let''s look at a common mistake:
python
count = 0
while count < 3:
    print(f"Count is {count}")
    # Mistake: Forgetting to increment count
    # count += 1 # This line is missing, leading to an infinite loop

Here, `count` remains `0` forever, so `count < 3` is always `True`. To fix it, we add `count += 1` inside the loop:
python
count = 0
while count < 3:
    print(f"Count is {count}")
    count += 1 # Corrected: count will eventually become 3, terminating the loop
print("Loop finished.")', 'Learners often think that if there''s *any* change within the loop, it will eventually terminate. However, the change must specifically affect the loop''s *condition* in a way that leads to its eventual `False` evaluation. A loop that changes other variables but not the one controlling its `while` condition will still be infinite.', 'Identify the error in the following code snippet that would cause an infinite loop. Briefly explain why it''s infinite and how to fix it.
python
flag = True
while flag:
    print("Still looping...")
    data = input("Enter ''quit'' to stop: ") # Assume input() works here for explanation
    # Missing condition to change ''flag''', 'gemini-flash', '2026-06-06 14:58:57.734578+00', '2026-06-06 14:58:57.734578+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('c9692936-1fca-44d2-9d0f-b3df96fb7340', 181, '["In testing or non-interactive environments, direct `input()` calls are impractical.", "You can simulate user input by creating a list of predefined ''inputs''.", "Use an index or iterator to retrieve values from this list inside a `while` loop, mimicking successive user entries.", "Increment the index or advance the iterator after each ''input'' to simulate the next user action.", "This technique ensures deterministic program execution for testing and demonstration."]', 'Let''s say we want to simulate a user entering numbers until they type ''done''. Instead of `input()`, we''ll use a list.

python
# Simulate user inputs
simulated_inputs = [''5'', ''10'', ''done'']
input_index = 0

processed_data = []

while True:
    # Simulate getting input from the list
    current_input = simulated_inputs[input_index]
    input_index += 1 # Move to the next simulated input

    print(f"Simulating input: {current_input}")

    if current_input == ''done'':
        break
    else:
        try:
            processed_data.append(int(current_input))
        except ValueError:
            print(f"Invalid input: {current_input}")

print(f"Processed numbers: {processed_data}")


Output:

Simulating input: 5
Simulating input: 10
Simulating input: done
Processed numbers: [5, 10]

This example shows how `current_input` takes values from `simulated_inputs` sequentially, just as `input()` would get them from a user.', 'A common misconception is that simulating input requires complex mocking frameworks. For basic testing and demonstration, a simple list and index within a `while` loop is sufficient and often clearer than more advanced techniques.', 'Modify the `worked_example` to include an invalid input like ''hello'' before ''done''. Ensure the program correctly handles the `ValueError` and continues processing valid inputs. The simulated inputs should be `[''7'', ''hello'', ''3'', ''done'']`.', 'gemini-flash', '2026-06-06 14:58:57.734578+00', '2026-06-06 14:58:57.734578+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('6488af26-43e6-43d1-b7fe-0b385b541709', 182, '["Filtering data means selecting specific items from a collection based on whether they meet certain conditions.", "You achieve filtering by placing an `if` statement inside a loop (e.g., `for` loop).", "The `if` statement evaluates a condition for each item in the collection.", "If the condition is `True`, the item is processed further (e.g., added to a new list, printed).", "This pattern allows you to create new collections containing only the desired elements or perform actions only on specific elements."]', 'Let''s say you have a list of numbers: `numbers = [10, 5, 20, 15, 30, 8]`. You want to create a new list containing only numbers greater than 12.

python
numbers = [10, 5, 20, 15, 30, 8]
high_numbers = []

for number in numbers:
    if number > 12:
        high_numbers.append(number)

print(high_numbers)
# Expected output: [20, 15, 30]

Here, the `for` loop iterates through each `number`. The `if number > 12:` condition checks if the current number meets our criterion. If it does, `high_numbers.append(number)` adds it to our new filtered list.', 'A common mistake is trying to modify the list you are iterating over directly within the loop using methods like `remove()`. This can lead to unexpected behavior or skipped items, as the list''s length and indices change during iteration. Instead, always create a new list to store filtered items or iterate over a copy if modification is necessary (though creating a new list is generally preferred for filtering).', 'Given a list of words, `words = [''apple'', ''banana'', ''cat'', ''dog'', ''elephant'']`, write code to print only the words that have more than 4 letters.', 'gemini-flash', '2026-06-06 14:59:35.774898+00', '2026-06-06 14:59:35.774898+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('105cfe69-c121-409f-9dda-22803a7f102a', 183, '["Data mapping involves iterating through an existing sequence (like a list) and creating a new sequence where each element is a transformed version of the original.", "The primary tools for mapping are `for` loops, often combined with conditional logic to decide how to transform each item.", "List comprehensions provide a concise and Pythonic way to perform mapping operations, especially when creating new lists.", "Transformations can include arithmetic operations, string manipulations, type conversions, or calling functions on each item.", "The result of mapping is typically a new data structure (like a new list or tuple); the original data structure usually remains unchanged."]', 'Let''s say you have a list of prices as strings, and you want to convert them to floating-point numbers, and then add a 10% tax to each. 

python
price_strings = [''10.50'', ''25.00'', ''5.75'']
processed_prices = []

for price_str in price_strings:
    price_float = float(price_str) # Transformation 1: string to float
    taxed_price = price_float * 1.10 # Transformation 2: add 10% tax
    processed_prices.append(round(taxed_price, 2)) # Store the transformed value

print(f"Original price strings: {price_strings}")
print(f"Processed prices with tax: {processed_prices}")

# Using a list comprehension for the same task:
tax_rate = 0.10
processed_prices_comprehension = [round(float(price_str) * (1 + tax_rate), 2) for price_str in price_strings]
print(f"Processed prices (comprehension): {processed_prices_comprehension}")


Output:

Original price strings: [''10.50'', ''25.00'', ''5.75'']
Processed prices with tax: [11.55, 27.5, 6.32]
Processed prices (comprehension): [11.55, 27.5, 6.32]', 'A common misconception is modifying the original list while iterating over it for mapping purposes. This can lead to unexpected behavior (e.g., skipping elements or infinite loops). Instead, always create a *new* list (or other data structure) to store the mapped results.', 'Write a `for` loop that iterates through a list of names. For each name, convert it to uppercase and append `_USER` to the end. Store these transformed names in a new list called `transformed_names`.', 'gemini-flash', '2026-06-06 14:59:35.774898+00', '2026-06-06 14:59:35.774898+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f92a9969-3179-420c-b476-59cdb0db4535', 184, '["Aggregation involves iterating through a collection of data and using a variable (an ''accumulator'') to gather or summarize information.", "Common aggregation tasks include calculating sums, counts, averages, minimums, maximums, or concatenating strings.", "An accumulator variable must be initialized before the loop starts (e.g., `total = 0`, `count = 0`, `max_value = float(''-inf'')`).", "Inside the loop, the accumulator is updated with each item processed (e.g., `total += item`, `count += 1`).", "After the loop finishes, the final value of the accumulator represents the aggregated summary."]', 'Let''s say we have a list of daily temperatures: `temperatures = [25, 28, 22, 29, 27]`. We want to calculate the total sum of these temperatures and the average. 

python
temperatures = [25, 28, 22, 29, 27]

# Initialize accumulators
total_temp = 0
num_days = 0

# Loop through the temperatures to aggregate
for temp in temperatures:
    total_temp += temp  # Add current temperature to total
    num_days += 1      # Increment the count of days

# Calculate the average after the loop
if num_days > 0:
    average_temp = total_temp / num_days
    print(f"Total temperature: {total_temp}")
    print(f"Number of days: {num_days}")
    print(f"Average temperature: {average_temp:.2f}")
else:
    print("No temperatures to process.")


Output:

Total temperature: 131
Number of days: 5
Average temperature: 26.20', 'A common mistake is to initialize the accumulator inside the loop. If `total = 0` or `count = 0` is placed inside the `for` loop, it will be reset on each iteration, preventing correct aggregation. The accumulator must be initialized *once* before the loop begins.', 'Write a Python program that takes a list of numbers representing product prices and calculates their sum. Print the final sum.', 'gemini-flash', '2026-06-06 14:59:35.774898+00', '2026-06-06 14:59:35.774898+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('4bb40a48-e1a8-479b-a808-366bf15c36ab', 185, '["Guard clauses are conditional statements placed at the beginning of a function or block of code.", "Their primary purpose is to handle ''edge cases'' or ''invalid conditions'' early, preventing the main logic from executing unnecessarily.", "They improve readability by reducing nesting and making the ''happy path'' (main logic) clearer.", "Guard clauses contribute to more robust code by explicitly checking for and reacting to conditions that would otherwise lead to errors or unexpected behavior.", "A common pattern is to `return`, `continue`, or `break` immediately when a guard condition is met."]', 'Let''s say you have a function that calculates the square root of a number. You know that you cannot calculate the square root of a negative number. Without a guard clause, your function might look like this:

python
def calculate_square_root_no_guard(number):
    if number >= 0:
        return number ** 0.5
    else:
        return ''Error: Cannot calculate square root of a negative number.''

print(calculate_square_root_no_guard(9))
print(calculate_square_root_no_guard(-4))


Now, let''s refactor it with a guard clause:

python
def calculate_square_root_with_guard(number):
    if number < 0: # Guard clause: check for invalid input early
        return ''Error: Cannot calculate square root of a negative number.''
    
    # Main logic, only executed if the guard condition is not met
    return number ** 0.5

print(calculate_square_root_with_guard(9))
print(calculate_square_root_with_guard(-4))


Notice how the main logic (`return number ** 0.5`) is no longer indented within an `if` block, making it stand out more clearly. The guard handles the exception upfront.', 'A common misconception is that guard clauses are just another way to write an `if/else` statement and don''t offer any significant advantages. While they are `if` statements, their strategic placement at the beginning to *exit early* for invalid conditions significantly improves code structure, readability, and maintainability by isolating edge case handling from core logic.', 'Refactor a simple function `process_order(quantity, price)` that calculates the total cost. Add a guard clause to immediately return an error message if `quantity` is less than or equal to 0, or if `price` is less than or equal to 0. Otherwise, return `quantity * price`.', 'gemini-flash', '2026-06-06 14:59:35.774898+00', '2026-06-06 14:59:35.774898+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f1b66cf0-7d2e-4db3-ac19-bc2958ab1562', 186, '["Nested loops involve placing one loop inside another, often used for iterating over multi-dimensional data structures like lists of lists (matrices).", "The inner loop completes all its iterations for *each single* iteration of the outer loop.", "Common use cases include processing grid-like data, comparing every item in a collection to every other item, or generating combinations.", "Indentation is crucial in Python to define which loop an operation belongs to.", "Be mindful of performance: nested loops can lead to `O(n*m)` or `O(n^2)` complexity, meaning processing time grows quickly with input size."]', 'Let''s say you have a list of students, where each student has a list of their grades. You want to print each student''s name and then all their grades.

python
students_grades = [
    {''name'': ''Alice'', ''grades'': [90, 85, 92]},
    {''name'': ''Bob'', ''grades'': [78, 80, 75]},
    {''name'': ''Charlie'', ''grades'': [95, 88, 91]}
]

for student_info in students_grades:
    print(f"Student: {student_info[''name'']}")
    print("Grades:")
    for grade in student_info[''grades'']:
        print(f"  - {grade}")
    print("\n") # Add a blank line for readability


This output clearly shows each student''s name, and then each of their grades indented below. The outer loop iterates through each student dictionary, and for each student, the inner loop iterates through their list of grades.', 'A common misconception is that the inner loop somehow continues its state or progress across outer loop iterations. In reality, the inner loop restarts completely from its beginning for every single iteration of the outer loop. Its variables are re-initialized or re-evaluated based on the current outer loop''s context.', 'Write a Python script to print a multiplication table for numbers 1 through 3. Use nested loops to generate the table. The output should clearly show each multiplication fact (e.g., ''1 x 1 = 1'').', 'gemini-flash', '2026-06-06 14:59:35.774898+00', '2026-06-06 14:59:35.774898+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('a24df060-9c0e-4549-8af5-2742c7c96687', 188, '["Parameters are variables listed inside the parentheses in the function definition.", "Arguments are the values passed to the function when it is called.", "When a function is called, the arguments'' values are assigned to the corresponding parameters.", "You can define multiple parameters, separated by commas.", "The order of arguments matters when calling a function if not using keyword arguments (covered later)."]', 'Let''s define a function that greets a person. We want to be able to tell it *who* to greet. This ''who'' will be a parameter.

python
def greet(name):
    print(f"Hello, {name}!")

# Now let''s call it with an argument
greet("Alice") # ''Alice'' is the argument, assigned to the ''name'' parameter
greet("Bob")   # ''Bob'' is another argument


Here, `name` is the parameter. When `greet("Alice")` is called, the string `"Alice"` is the argument, and it gets assigned to the `name` parameter within the `greet` function''s scope.', 'A common misconception is confusing parameters and arguments. Remember: Parameters are placeholders in the function *definition*, while arguments are the actual *values* passed during a function *call*.', 'Define a function named `add_numbers` that takes two parameters, `num1` and `num2`. Inside the function, print the sum of these two numbers. Then, call the function with two different pairs of numbers.', 'gemini-flash', '2026-06-06 14:50:38.676467+00', '2026-06-06 15:00:09.124422+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('992a15fb-1904-4fbc-aac8-4dd562aa4c8c', 189, '["The `return` statement sends a value back from the function to the caller. This value can then be stored in a variable, used in an expression, or passed to another function.", "`print()` simply displays output to the console. It does not send any value back to the caller.", "Functions without an explicit `return` statement implicitly return `None`.", "Use `return` when you need the result of a function''s computation to be used elsewhere in your program.", "Use `print()` when you want to show information to the user or for debugging purposes, but don''t need the value programmatically.", "A function can have multiple `return` statements, but only the first one encountered will execute, ending the function''s execution."]', 'Let''s define two functions. One that calculates a sum and returns it, and another that calculates and prints it.

python
def calculate_sum_and_return(a, b):
    total = a + b
    return total

def calculate_sum_and_print(a, b):
    total = a + b
    print(f"The sum is: {total}")

# Using the returning function
result = calculate_sum_and_return(5, 3)
print(f"The returned sum is: {result * 2}") # We can use the returned value

# Using the printing function
calculate_sum_and_print(7, 2) # It prints directly
# print(f"The printed sum is: {calculate_sum_and_print(7, 2) * 2}") # This would error because it returns None


When `calculate_sum_and_return(5, 3)` is called, the value `8` is sent back and stored in `result`. We can then use `result` in further calculations like `result * 2`. 

When `calculate_sum_and_print(7, 2)` is called, `The sum is: 9` is displayed, but the function itself does not send any value back. If we tried to assign its output to a variable, that variable would hold `None`.', 'A common misconception is that `print(my_function())` means `my_function` is returning the printed value. In reality, `my_function()` executes, potentially prints something itself, and then whatever it *returns* (or `None` if it doesn''t return anything) is then passed to the outer `print()` function to be displayed. The internal `print()` and the external `print()` are separate actions.', 'Write a function `multiply_and_display(x, y)` that calculates the product of `x` and `y` and prints it to the console, but does not return any value. Then, write another function `multiply_and_get(x, y)` that calculates the product and *returns* it. Demonstrate that you can use the returned value from `multiply_and_get` in a further calculation, but not from `multiply_and_display`.', 'gemini-flash', '2026-06-06 14:50:38.676467+00', '2026-06-06 15:00:09.124422+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('e3ade12f-51cc-42b5-855e-1be20d7dd9ce', 190, '["To execute a defined function, you ''call'' it by writing its name followed by parentheses `()`.", "If a function requires arguments, these are passed inside the parentheses, separated by commas.", "The order of arguments typically matters and corresponds to the order of parameters in the function definition.", "Calling a function causes the code block defined within that function to run.", "Without calling a function, its code will not execute, even if it''s defined."]', 'Let''s define a simple function and then see how to call it:

python
def greet_user(name):
    print(f"Hello, {name}!")

greet_user("Alice")  # This is how you call the function
greet_user("Bob")    # Call it again with a different argument


Output:

Hello, Alice!
Hello, Bob!


Here, `greet_user("Alice")` executes the `greet_user` function, passing ''Alice'' as the `name` argument. The function then prints the personalized greeting.', 'Learners often define a function but forget to call it, or assume defining it automatically runs the code. Emphasize that definition (`def`) and execution (calling `()`) are two distinct steps.', 'Define a function named `display_sum` that takes two numbers as arguments and prints their sum. Then, call `display_sum` twice with different pairs of numbers.', 'gemini-flash', '2026-06-06 14:50:38.676467+00', '2026-06-06 15:00:09.124422+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('edb7ed20-d676-480f-8643-ef3853ce81e1', 191, '["Docstrings are multi-line string literals used to document Python modules, functions, classes, and methods.", "They are placed immediately after the `def` (or `class`) statement.", "Docstrings provide a concise summary of the function''s purpose, describe its parameters, and explain what it returns.", "Python''s built-in `help()` function and `__doc__` attribute can access docstrings programmatically.", "PEP 257 outlines conventions for writing good docstrings (e.g., one-line summary, then detailed description, parameters, returns)."]', 'python
def calculate_rectangle_area(length, width):
    """
    Calculates the area of a rectangle.

    Args:
        length (float): The length of the rectangle.
        width (float (or int)): The width of the rectangle.

    Returns:
        float: The calculated area of the rectangle.
    """
    return length * width

# Accessing the docstring
print(help(calculate_rectangle_area))
print(calculate_rectangle_area.__doc__)', 'Learners often confuse docstrings with regular comments (`#`). While both add explanations, docstrings are accessible at runtime and used by tools like `help()` and documentation generators, making them part of the function''s interface, not just internal notes.', 'Write a docstring for a simple function named `greet_user` that takes a `name` (string) as an argument and returns a greeting string like ''Hello, [name]!''.', 'gemini-flash', '2026-06-06 14:50:38.676467+00', '2026-06-06 15:00:09.124422+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('6382db0d-8be8-48ca-8bb8-5add9567fceb', 197, '["The Python Standard Library is a collection of pre-written modules that are included with every Python installation.", "These modules provide ready-to-use functionality for a wide range of common programming tasks, avoiding the need to write code from scratch.", "Examples of tasks covered include mathematical operations, file handling, date and time manipulation, networking, and working with data structures.", "Using the Standard Library significantly speeds up development and improves code reliability as these modules are well-tested and maintained.", "To use functionality from a standard library module, you typically need to import it into your Python script."]', 'Let''s say you need to calculate the square root of a number. Instead of writing your own square root function, Python''s `math` module in the Standard Library provides one.

python
import math

number = 25
square_root = math.sqrt(number)
print(f"The square root of {number} is {square_root}")


This code imports the `math` module, then uses its `sqrt()` function to find the square root.', 'A common misconception is that ''Standard Library'' modules are external packages that need to be installed separately. In reality, they are integral parts of the Python installation and are immediately available for use without any additional steps like `pip install`.', 'Identify two distinct advantages of using Python''s Standard Library instead of implementing common functionalities from scratch.', 'gemini-flash', '2026-06-06 15:01:36.354886+00', '2026-06-06 15:01:36.354886+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('12fb3636-5666-4701-b1b0-7a37fdeadfc3', 192, '["Python functions accept arguments, which are values passed into the function when it''s called.", "Positional arguments are matched to parameters based on their order in the function call. The first argument maps to the first parameter, the second to the second, and so on.", "Keyword arguments are matched to parameters by explicitly naming the parameter they correspond to, using the `parameter_name=value` syntax.", "When using both positional and keyword arguments, positional arguments must always come before keyword arguments in the function call.", "Keyword arguments enhance readability and flexibility, especially with functions having many parameters, as the order doesn''t matter for them (once positional arguments are handled)."]', 'Let''s define a function that describes a car:

python
def describe_car(make, model, year):
    return f"This is a {year} {make} {model}."

# Calling with positional arguments
car1 = describe_car("Toyota", "Camry", 2020)
print(f"Positional: {car1}")

# Calling with keyword arguments
car2 = describe_car(model="Accord", make="Honda", year=2022)
print(f"Keyword: {car2}")

# Calling with mixed arguments (positional first, then keyword)
car3 = describe_car("Ford", year=2023, model="Focus")
print(f"Mixed: {car3}")


Output:

Positional: This is a 2020 Toyota Camry.
Keyword: This is a 2022 Honda Accord.
Mixed: This is a 2023 Ford Focus.


Notice how in the keyword argument call, `model` was specified before `make`, but Python correctly matched them. In the mixed call, `"Ford"` filled `make` by position, and then `year` and `model` were filled by keyword.', 'A common misconception is that you can freely mix positional and keyword arguments in any order. While you can mix them, a strict rule is that all positional arguments *must* appear before any keyword arguments in the function call. Trying `describe_car(make="Tesla", "Model 3", 2024)` would result in a `SyntaxError` because the positional argument `"Model 3"` appears after a keyword argument.', 'Define a function `create_greeting(name, message)` that returns a greeting string. Call it once using only positional arguments and once using only keyword arguments, printing the result of both calls.', 'gemini-flash', '2026-06-06 15:00:57.77261+00', '2026-06-06 15:00:57.77261+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('c99698b8-0da4-4e69-a6b0-42f97743779a', 193, '["Default argument values allow you to provide a default for a function parameter. If a caller doesn''t provide a value for that parameter, the default is used.", "Parameters with default values become optional when calling the function.", "Default arguments must be defined after all non-default (required) arguments in the function signature.", "This improves function flexibility and readability by reducing the number of arguments required for common use cases.", "When a default argument is provided, you can still explicitly pass a value for it, overriding the default."]', 'Let''s define a function `greet` that takes a `name` and an optional `message`:

python
def greet(name, message="Hello"):
    print(f"{message}, {name}!")

# Calling with only required argument
greet("Alice")  # Output: Hello, Alice!

# Calling with both arguments, overriding the default
greet("Bob", "Hi") # Output: Hi, Bob!

# Using keyword arguments for clarity (though not strictly necessary here)
greet(name="Charlie", message="Greetings") # Output: Greetings, Charlie!', 'A common misconception is that default argument values can be placed anywhere in the function signature. They *must* come after all non-default arguments. Python will raise a `SyntaxError` if you try to put a non-default argument after a default argument.', 'Define a function `calculate_net_price(price, tax_rate=0.05)` that calculates the price of an item after tax. Call it once with only the price, and once providing both the price and a custom tax rate. Print both results.', 'gemini-flash', '2026-06-06 15:00:57.77261+00', '2026-06-06 15:00:57.77261+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('a556da85-f726-4599-8108-f0cbaaf03b19', 194, '["The `*args` syntax allows a function to accept an arbitrary number of positional arguments.", "Inside the function, `args` (or whatever name you choose after `*`) is treated as a tuple containing all the positional arguments passed after any explicitly defined ones.", "This is useful when you don''t know beforehand how many arguments a function might need to process.", "`*args` must come after any regular positional arguments and before `**kwargs` in a function signature.", "The `*` operator can also be used to unpack an iterable (like a list or tuple) into positional arguments when calling a function."]', 'Let''s create a function that calculates the sum of an unknown number of integers:

python
def calculate_sum(*numbers):
    total = 0
    for num in numbers:
        total += num
    print(f"The sum is: {total}")

calculate_sum(1, 2, 3) # Output: The sum is: 6
calculate_sum(10, 20, 30, 40, 50) # Output: The sum is: 150
calculate_sum() # Output: The sum is: 0


Here, `*numbers` captures all positional arguments into a tuple named `numbers`.', 'A common misconception is that `*args` collects keyword arguments. It exclusively collects *positional* arguments that are not assigned to other parameters. Keyword arguments are handled by `**kwargs`.', 'Create a function called `print_greetings` that accepts a `main_greeting` (a regular positional argument) and then an arbitrary number of `names` using `*args`. The function should print the `main_greeting` followed by a personalized greeting for each name. If no additional names are provided, it should just print the `main_greeting`.', 'gemini-flash', '2026-06-06 15:00:57.77261+00', '2026-06-06 15:00:57.77261+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f8fd9cc7-ca13-481e-90cf-073e402a6f09', 195, '["The `**kwargs` syntax allows a function to accept an arbitrary number of keyword arguments.", "Inside the function, `kwargs` is a dictionary where keys are the argument names (strings) and values are the argument values.", "This is useful when you don''t know in advance what keyword arguments might be passed to your function, or when you want to pass them directly to another function.", "The name `kwargs` is a convention; you can use any valid variable name prefixed with `**`.", "`**kwargs` should typically be the last parameter in a function definition, after positional and `*args` parameters."]', 'Let''s define a function that can accept various user details and print them. We''ll use `**kwargs` to handle the flexible details.

python
def display_user_profile(username, **details):
    print(f"Username: {username}")
    print("--- Additional Details ---")
    if not details:
        print("No additional details provided.")
    else:
        for key, value in details.items():
            print(f"{key.replace(''_'', '' '').title()}: {value}")

# Calling the function with different keyword arguments
display_user_profile("john_doe", age=30, city="New York")
print("\n")
display_user_profile("jane_smith", occupation="Engineer", email="jane@example.com", member_since="2020-01-15")
print("\n")
display_user_profile("guest_user")


**Output of the above code:**

Username: john_doe
--- Additional Details ---
Age: 30
City: New York

Username: jane_smith
--- Additional Details ---
Occupation: Engineer
Email: jane@example.com
Member Since: 2020-01-15

Username: guest_user
--- Additional Details ---
No additional details provided.


In this example, `age`, `city`, `occupation`, `email`, and `member_since` are all captured by `**details` as keyword arguments, which become entries in the `details` dictionary.', 'A common misconception is that `**kwargs` collects all arguments, including positional ones. In reality, `**kwargs` ONLY collects keyword arguments that are not explicitly defined as parameters in the function signature. Positional arguments and keyword arguments explicitly defined are handled separately.', 'Define a function named `configure_settings` that accepts a `setting_name` (positional argument) and then an arbitrary number of additional keyword arguments to configure that setting. Inside the function, print the `setting_name` and then iterate through the keyword arguments, printing each key-value pair. If no additional keyword arguments are provided, print a message indicating so.', 'gemini-flash', '2026-06-06 15:00:57.77261+00', '2026-06-06 15:00:57.77261+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('0cb34ed1-dd6c-4a06-bb02-ff479fd696b2', 196, '["Default argument values are evaluated ONCE when the function is defined, not every time the function is called.", "When a mutable object (like a list, dictionary, or set) is used as a default argument, all subsequent calls to the function share the SAME mutable object.", "Modifying this default mutable object inside the function will affect all future calls that don''t explicitly provide a value for that argument.", "This behavior often leads to unexpected side effects and bugs, as the default state is not reset for each call.", "The common solution is to use `None` as the default value and then assign the mutable object inside the function if the argument remains `None`."]', 'Let''s look at a function designed to collect items in a list. If we don''t pass a list, it should start a new one.  
python
def add_item(item, item_list=[]):
    item_list.append(item)
    return item_list

print(f"Call 1: {add_item(''apple'')}")
print(f"Call 2: {add_item(''banana'')}")
print(f"Call 3 with new list: {add_item(''orange'', [''fruit''])}")
print(f"Call 4: {add_item(''grape'')}")


Expected output if we didn''t have the gotcha: 

Call 1: [''apple'']
Call 2: [''banana'']
Call 3 with new list: [''fruit'', ''orange'']
Call 4: [''grape'']


Actual output due to the gotcha: 

Call 1: [''apple'']
Call 2: [''apple'', ''banana'']
Call 3 with new list: [''fruit'', ''orange'']
Call 4: [''apple'', ''banana'', ''grape'']


Notice how ''apple'' and ''banana'' persisted in the default list because the same list object was reused. This is the mutable default argument gotcha. 

To fix this, we should use `None` as the default and initialize the list inside the function:

python
def add_item_fixed(item, item_list=None):
    if item_list is None:
        item_list = []
    item_list.append(item)
    return item_list

print(f"Fixed Call 1: {add_item_fixed(''apple'')}")
print(f"Fixed Call 2: {add_item_fixed(''banana'')}")
print(f"Fixed Call 3 with new list: {add_item_fixed(''orange'', [''fruit''])}")
print(f"Fixed Call 4: {add_item_fixed(''grape'')}")


Output of the fixed version:

Fixed Call 1: [''apple'']
Fixed Call 2: [''banana'']
Fixed Call 3 with new list: [''fruit'', ''orange'']
Fixed Call 4: [''grape'']', 'A common misconception is that default arguments are re-evaluated or re-initialized every time the function is called. Learners often assume that if a default argument is `[]`, a fresh, empty list is created for each call where the argument is omitted. This is incorrect; the default `[]` list is created only once when the function is first defined, and subsequent calls without providing that argument will all refer to that same single list object.', 'Write a function `log_message(message, messages_history=[])` that takes a message and appends it to a history list. Demonstrate the mutable default argument gotcha by calling the function multiple times without providing `messages_history`, and observe how the history accumulates. Then, fix the function to avoid this gotcha and show the corrected behavior.', 'gemini-flash', '2026-06-06 15:00:57.77261+00', '2026-06-06 15:00:57.77261+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('1de16a5a-359b-4b92-b7d8-0d39a1070a52', 198, '["Modules are Python files containing code (functions, classes, variables) that can be reused in other Python scripts.", "The `import` statement is used to bring an entire module into the current namespace. You then access its contents using `module_name.item_name`.", "The `from ... import ...` statement allows you to import specific items (functions, variables, classes) directly from a module into the current namespace. You can then use them without the `module_name.` prefix.", "You can import multiple items from a module using commas: `from module_name import item1, item2, item3`.", "To import all items from a module directly into the current namespace, use `from module_name import *`. This is generally discouraged in larger projects as it can lead to naming conflicts and make code harder to read."]', 'Let''s say we have a file named `my_math.py` with the following content:
python
# my_math.py
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

PI = 3.14159


To use this module in another script, `main.py`:

**Method 1: Importing the whole module**
python
# main.py
import my_math

result_add = my_math.add(5, 3)
print(f"Addition: {result_add}")

print(f"Value of PI: {my_math.PI}")

Output:

Addition: 8
Value of PI: 3.14159


**Method 2: Importing specific items**
python
# main.py
from my_math import add, PI

result_add = add(10, 7)
print(f"Addition: {result_add}")

print(f"Value of PI: {PI}")

# subtract(8, 2) # This would cause a NameError because subtract was not imported

Output:

Addition: 17
Value of PI: 3.14159', 'A common misconception is that `import module_name` automatically makes all functions and variables from `module_name` available without the `module_name.` prefix. This is incorrect. Only `from module_name import item` (or `from module_name import *`) makes items directly available without the prefix. Using `import module_name` requires you to prefix items with `module_name.`.', 'Create a file named `greetings.py` with a function `say_hello(name)` that returns `f"Hello, {name}!"` and a variable `DEFAULT_GREETING = "Welcome!"`. Then, in a separate script, import both the `say_hello` function and the `DEFAULT_GREETING` variable using a single `from ... import ...` statement, and print their values.', 'gemini-flash', '2026-06-06 15:01:36.354886+00', '2026-06-06 15:01:36.354886+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('3f2ef053-3a91-4104-9187-bcd1207c04cc', 199, '["The `as` keyword allows you to create an alternative, shorter name (an alias) for a module when importing it.", "This is useful for modules with long or cumbersome names, or to avoid name clashes with existing variables or functions in your code.", "The syntax for aliasing a module is `import module_name as alias_name`.", "Once aliased, you must use the `alias_name` to refer to the module''s contents (e.g., `alias_name.function_name()`).", "You can also alias specific components (functions, classes, variables) imported from a module using `from module_name import original_name as alias_name`."]', 'Let''s say you want to use the `math` module, but you prefer to type `m` instead of `math` every time. You can do this:
python
import math as m

radius = 5
area = m.pi * (radius ** 2)
print(f"The area is: {area}")

Here, `math` is aliased to `m`. Now, to access `math.pi`, we use `m.pi`.', 'A common misconception is thinking that aliasing changes the original module''s name. It doesn''t. It merely creates a new, local name within your current script that points to the same module object. The original module name (e.g., `math`) becomes inaccessible directly if you only use `import math as m`.', 'Imagine you have a module named `long_and_complex_calculations` that contains a function `perform_heavy_math`. Import this module and alias it to `calc`. Then, call the `perform_heavy_math` function using its alias.

(Note: For this exercise, assume `long_and_complex_calculations` is available and has a `perform_heavy_math` function that prints ''Heavy math performed!''.)', 'gemini-flash', '2026-06-06 15:01:36.354886+00', '2026-06-06 15:01:36.354886+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('71311f0c-53ba-410f-ad9f-053da5bcf836', 200, '["The Python Standard Library includes numerous modules that provide pre-built functionalities, saving developers time and effort.", "The `math` module offers mathematical functions for common operations like square roots, trigonometric calculations, and constants like pi.", "The `random` module is used for generating pseudo-random numbers, useful for simulations, games, or selecting random elements.", "The `datetime` module provides classes for working with dates and times, allowing for creation, manipulation, and formatting of temporal data.", "To use a module''s functions or constants, you must import it first using the `import` statement."]', 'Let''s calculate the area of a circle with radius 5, generate a random integer between 1 and 10, and get the current date and time.

python
import math
import random
import datetime

# Using the math module
radius = 5
area = math.pi * (radius ** 2)
print(f"Area of a circle with radius {radius}: {area:.2f}")

# Using the random module
random_number = random.randint(1, 10) # Inclusive of 1 and 10
print(f"Random number between 1 and 10: {random_number}")

# Using the datetime module
current_time = datetime.datetime.now()
print(f"Current date and time: {current_time.strftime(''%Y-%m-%d %H:%M:%S'')}")


Output:

Area of a circle with radius 5: 78.54
Random number between 1 and 10: 7
Current date and time: 2023-10-27 10:30:00

(Note: The random number and current time will vary in actual execution.)', 'Learners often forget to `import` modules before trying to use their functions or constants, leading to `NameError`. Emphasize that `import` statements are crucial and typically placed at the top of the script.', 'Calculate the hypotenuse of a right-angled triangle with sides 3 and 4, then pick a random item from a list of colors: `[''red'', ''green'', ''blue'']`, and finally, determine the year from a specific date: `2024-07-15`.', 'gemini-flash', '2026-06-06 15:01:36.354886+00', '2026-06-06 15:01:36.354886+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('150cbf00-6b91-4522-905f-680f6bdc96df', 201, '["Functions encapsulate specific tasks, making code blocks independent and easier to understand.", "Modularization through functions breaks down large problems into smaller, manageable pieces.", "Functions promote reusability; a function defined once can be called multiple times, avoiding code duplication.", "Using functions simplifies debugging by isolating issues to smaller, well-defined code segments.", "Well-named functions improve code readability and maintainability for future development."]', 'Let''s say we need to calculate the area of a rectangle and then its perimeter multiple times. Instead of repeating the formulas, we can define functions for each:

python
def calculate_rectangle_area(length, width):
    return length * width

def calculate_rectangle_perimeter(length, width):
    return 2 * (length + width)

# Usage:
rect1_length = 5
rect1_width = 3
area1 = calculate_rectangle_area(rect1_length, rect1_width)
perimeter1 = calculate_rectangle_perimeter(rect1_length, rect1_width)
print(f"Rectangle 1 - Area: {area1}, Perimeter: {perimeter1}")

rect2_length = 10
rect2_width = 4
area2 = calculate_rectangle_area(rect2_length, rect2_width)
perimeter2 = calculate_rectangle_perimeter(rect2_length, rect2_width)
print(f"Rectangle 2 - Area: {area2}, Perimeter: {perimeter2}")


This example demonstrates how functions make the code cleaner, more organized, and prevents repeating the area and perimeter calculation logic.', 'A common misconception is that functions are only useful for very complex calculations. In reality, even small, frequently repeated logic or distinct steps in a process benefit from being encapsulated in a function to improve readability and maintainability.', 'Refactor the following code snippet by creating a function named `greet_user` that takes a `name` and a `time_of_day` as arguments, and returns a greeting string. Then, call this function twice with different inputs and print the results.

python
# Original code:
# user1_name = "Alice"
# print(f"Good morning, {user1_name}!")

# user2_name = "Bob"
# print(f"Good afternoon, {user2_name}!")', 'gemini-flash', '2026-06-06 15:01:36.354886+00', '2026-06-06 15:01:36.354886+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('fc324844-02e3-4a36-b293-8580b6d82902', 202, '["A class is a blueprint or a template for creating objects. It defines a set of attributes (data) and methods (functions) that the objects will have.", "Objects are instances of a class. When you create an object, you are creating a concrete entity based on the blueprint defined by the class.", "Think of a class like a cookie cutter: it defines the shape and characteristics of a cookie. An object is an actual cookie made using that cutter.", "In Python, classes are defined using the `class` keyword, followed by the class name and a colon. By convention, class names are in CamelCase.", "Objects are created by calling the class name as if it were a function, e.g., `my_object = MyClass()`."]', 'Let''s imagine we want to model different types of vehicles. We can define a `Vehicle` class. This class acts as a blueprint for any vehicle we might want to create.

python
class Vehicle:
    # For now, we''ll just use ''pass'' as a placeholder
    # We''ll add attributes and methods later in the course.
    pass

# Now, let''s create actual vehicles (objects) based on this blueprint.
car = Vehicle()  # ''car'' is an object (an instance) of the Vehicle class
bike = Vehicle() # ''bike'' is another object (an instance) of the Vehicle class

print(f"Type of car: {type(car)}")
print(f"Type of bike: {type(bike)}")
print(f"Are car and bike the same object? {car is bike}")


Output:

Type of car: <class ''__main__.Vehicle''>
Type of bike: <class ''__main__.Vehicle''>
Are car and bike the same object? False


This shows that `car` and `bike` are both instances of `Vehicle`, but they are distinct objects.', 'A common misconception is confusing the class itself with an object. A class is a definition, a category, or a type. An object is a specific, tangible entity belonging to that category. You don''t ''run'' a class; you create and interact with its objects.', 'Define a simple class called `Book`. For now, just use `pass` inside its definition. Then, create two distinct objects (instances) from your `Book` class: `book1` and `book2`. Print the type of each object to confirm they are instances of `Book`.', 'gemini-flash', '2026-06-06 15:02:10.125507+00', '2026-06-06 15:02:10.125507+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('e5cd093b-fc5c-4b9c-b8be-2378a381c097', 203, '["The `__init__` method is a special method (also called a constructor) in Python classes.", "It is automatically called whenever a new object (instance) of the class is created.", "Its primary purpose is to initialize the object''s state by assigning values to its attributes.", "Attributes are variables that belong to an object and store data specific to that object.", "The first parameter of `__init__` (and all instance methods) must be `self`, which refers to the instance being created.", "Inside `__init__`, we use `self.<attribute_name> = <value>` to create and set attributes for the new instance."]', 'Let''s define a `Dog` class. We want each `Dog` object to have a `name` and an `age`. The `__init__` method will take these as arguments and set them as attributes for the dog:

python
class Dog:
    def __init__(self, name, age):
        self.name = name  # Assigns the ''name'' parameter to the ''name'' attribute of the instance
        self.age = age    # Assigns the ''age'' parameter to the ''age'' attribute of the instance

# Creating a Dog object. This automatically calls __init__.
my_dog = Dog("Buddy", 3)

# Accessing the attributes of the ''my_dog'' object
print(f"My dog''s name is {my_dog.name} and he is {my_dog.age} years old.")
# Expected Output: My dog''s name is Buddy and he is 3 years old.', 'A common misconception is that `__init__` *creates* the object. In reality, the object is created just before `__init__` is called. `__init__`''s job is to *initialize* the already created object by setting up its initial state (its attributes). It''s like building an empty house, and then `__init__` comes in to furnish it and set up the utilities.', 'Define a class `Car` that has an `__init__` method. This method should accept `make`, `model`, and `year` as arguments and assign them as attributes to the `Car` object. Then, create an instance of `Car` with your favorite car''s details and print its `make` attribute.', 'gemini-flash', '2026-06-06 15:02:10.125507+00', '2026-06-06 15:02:10.125507+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('750ba78b-3305-485b-b74f-2c132b9c1bd0', 204, '["Instance methods are functions defined inside a class that operate on the data (attributes) of a specific instance of that class.", "The first parameter of any instance method in Python must be `self`.", "`self` is a convention (not a keyword) that refers to the instance of the class on which the method was called.", "Through `self`, an instance method can access and modify the instance''s attributes (`self.attribute_name`) and call other instance methods (`self.other_method()`).", "When an instance method is called (e.g., `my_object.method_name()`), Python automatically passes the `my_object` instance as the `self` argument to the method."]', 'Let''s define a `Dog` class with an `__init__` method to set its `name` and `breed` attributes. Then, we''ll add an instance method called `bark()` that prints a message including the dog''s name, and another method `describe()` that uses `self` to access both `name` and `breed`. Notice how `self` is used to refer to the specific dog object in each method.

python
class Dog:
    def __init__(self, name, breed):
        self.name = name
        self.breed = breed

    # Instance method using ''self'' to access ''name''
    def bark(self):
        print(f"{self.name} says Woof!")

    # Instance method using ''self'' to access ''name'' and ''breed''
    def describe(self):
        print(f"This is {self.name}, a {self.breed}.")

# Create an instance of Dog
my_dog = Dog("Buddy", "Golden Retriever")

# Call instance methods on ''my_dog''
my_dog.bark()
my_dog.describe()


**Output:**

Buddy says Woof!
This is Buddy, a Golden Retriever.', 'A common misconception is that `self` is a special keyword like `class` or `def`. While it''s critically important and universally used, `self` is merely a conventional name for the first parameter of an instance method. You *could* theoretically name it `this_instance` or `current_object`, but `self` is the universally accepted standard and deviation from it makes code unreadable and un-Pythonic.', 'Define a class `Book` with an `__init__` method that takes `title` and `author` as arguments and assigns them as instance attributes. Add an instance method `display_info()` that prints a string like ''Title: [title], Author: [author]'' using the `self` parameter to access the book''s attributes. Then, create an instance of `Book` and call its `display_info()` method.', 'gemini-flash', '2026-06-06 15:02:10.125507+00', '2026-06-06 15:02:10.125507+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('779df2e0-3510-4d5f-a20c-8741a3cf7f03', 205, '["Instances (objects) are created from a class using the class name followed by parentheses, e.g., `my_object = MyClass()`. Each instance is a distinct entity.", "Each instance has its own unique set of attribute values, even if they are created from the same class.", "You can access an instance''s attributes using dot notation: `instance_name.attribute_name`.", "You can modify an instance''s attributes using assignment: `instance_name.attribute_name = new_value`.", "You can call an instance''s methods using dot notation: `instance_name.method_name()`."]', 'Let''s define a simple `Dog` class and then create two `Dog` instances, each with its own name and age.

python
class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def bark(self):
        return f''{self.name} says Woof!''

# Creating instances
dog1 = Dog(''Buddy'', 3)
dog2 = Dog(''Lucy'', 5)

# Accessing attributes
print(f''{dog1.name} is {dog1.age} years old.'')
print(f''{dog2.name} is {dog2.age} years old.'')

# Modifying attributes
dog1.age = 4
print(f''Buddy is now {dog1.age} years old.'')

# Calling methods
print(dog1.bark())
print(dog2.bark())


Output:

Buddy is 3 years old.
Lucy is 5 years old.
Buddy is now 4 years old.
Buddy says Woof!
Lucy says Woof!


Notice how `dog1` and `dog2` maintain their distinct `name` and `age` values, and we can change `dog1`''s age without affecting `dog2`.', 'A common misconception is thinking that changing an attribute of one instance will affect all other instances of the same class. Emphasize that each instance has its own independent state (attribute values) stored in its own memory space.', 'Create a `Car` class with `make`, `model`, and `speed` attributes. Implement an `accelerate` method that increases the car''s speed by 10. Then, create two `Car` instances, set their initial speeds, and make one car accelerate. Print the details (make, model, and current speed) of both cars before and after the acceleration.', 'gemini-flash', '2026-06-06 15:02:10.125507+00', '2026-06-06 15:02:10.125507+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('4d77cb63-2ca5-4a4c-9c46-c9b777e52309', 206, '["Inheritance is a mechanism where a new class (subclass or child class) derives attributes and methods from an existing class (superclass or parent class).", "The subclass ''inherits'' all public and protected members of the superclass, meaning it can use them directly without needing to redefine them.", "Inheritance establishes an ''is-a'' relationship: a subclass ''is a'' type of its superclass (e.g., a `Dog` ''is an'' `Animal`).", "To define a subclass, you include the superclass name in parentheses after the subclass name in its declaration: `class Subclass(Superclass):`.", "Subclasses can add new attributes and methods, or they can override (redefine) existing methods inherited from the superclass to provide specialized behavior."]', 'Let''s define a `Vehicle` class with a `start_engine` method and a `Car` class that inherits from `Vehicle`.

python
class Vehicle:
    def __init__(self, brand):
        self.brand = brand

    def start_engine(self):
        return f"{self.brand}''s engine started."

class Car(Vehicle):
    def __init__(self, brand, model):
        # We''ll learn about super().__init__() later, but for now,
        # let''s explicitly set the brand attribute inherited from Vehicle.
        super().__init__(brand) # This calls Vehicle''s __init__
        self.model = model

    def drive(self):
        return f"Driving the {self.brand} {self.model}."

my_car = Car("Toyota", "Camry")
print(my_car.start_engine()) # Method inherited from Vehicle
print(my_car.drive())       # Method defined in Car
print(f"Brand: {my_car.brand}") # Attribute inherited from Vehicle
print(f"Model: {my_car.model}") # Attribute defined in Car


Expected Output:

Toyota''s engine started.
Driving the Toyota Camry.
Brand: Toyota
Model: Camry', 'A common misconception is that a subclass copies the superclass''s code. Instead, the subclass creates a link to the superclass, allowing it to access its members. Changes to the superclass (e.g., adding a new method) are automatically reflected in the subclass, demonstrating this dynamic linkage.', 'Create a `Shape` class with an `area` attribute (set to 0 initially) and a `get_info` method that returns ''This is a generic shape.''. Then, create a `Circle` subclass that inherits from `Shape` and has an additional `radius` attribute. The `Circle` class should print a message about its radius using `get_info`.', 'gemini-flash', '2026-06-06 15:02:57.920346+00', '2026-06-06 15:02:57.920346+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('5dddde93-4a44-4308-8fc6-fd6d7ab6e1c6', 207, '["When a subclass is initialized, its `__init__` method (if defined) is called, but the superclass''s `__init__` is NOT automatically called.", "The `super().__init__()` call explicitly invokes the `__init__` method of the parent class, ensuring that inherited attributes and setup are properly handled.", "Always call `super().__init__()` early in your subclass''s `__init__` method, usually as the first line, to ensure the parent part of the object is fully initialized before the child adds its own specifics.", "Method overriding is when a subclass provides its own implementation for a method that is already defined in its superclass, changing or extending its behavior.", "To override a method, simply define a method with the same name and signature (though Python doesn''t strictly enforce signature matching) in the subclass.", "You can still access the overridden superclass method from within the overriding method using `super().method_name()` if you want to extend its behavior rather than completely replace it."]', 'Let''s consider a `Vehicle` class and a `Car` subclass. `Vehicle` has `make` and `model`. `Car` adds `num_doors`. We need `super().__init__()` to handle `make` and `model` in the `Car`''s constructor. We''ll also override a `display_info` method to show specific `Car` details.

python
class Vehicle:
    def __init__(self, make, model):
        self.make = make
        self.model = model

    def display_info(self):
        return f"Vehicle: {self.make} {self.model}"

class Car(Vehicle):
    def __init__(self, make, model, num_doors):
        super().__init__(make, model) # Call to parent''s __init__
        self.num_doors = num_doors

    def display_info(self):
        # Override and extend parent''s method
        parent_info = super().display_info()
        return f"{parent_info}, Doors: {self.num_doors}"

my_car = Car("Toyota", "Camry", 4)
print(my_car.display_info())

Output: `Vehicle: Toyota Camry, Doors: 4`', 'A common misconception is that the superclass''s `__init__` method is automatically called when a subclass instance is created. This is NOT true in Python. You *must* explicitly call `super().__init__()` if you want the superclass''s initialization logic to run. Forgetting this can lead to `AttributeError` if the superclass initializes attributes that the subclass later tries to use.', 'Create a base class `Animal` with an `__init__` method that takes a `name` and sets `self.name`. Add a method `speak()` that returns `f''{self.name} makes a sound.''`. Then, create a subclass `Dog` that takes `name` and `breed` in its `__init__`. Ensure `Animal`''s `__init__` is called. Override the `speak()` method in `Dog` to return `f''{self.name} barks!''`. Instantiate a `Dog` and print its `speak()` output.', 'gemini-flash', '2026-06-06 15:02:57.920346+00', '2026-06-06 15:02:57.920346+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('40e36aac-568a-4e83-b451-26ea1d087602', 208, '["Composition is a design principle where a class contains instances of other classes as attributes.", "It represents a ''has-a'' relationship (e.g., a Car has an Engine, a Book has Pages).", "Unlike inheritance (''is-a'' relationship), composition allows for greater flexibility and avoids the ''diamond problem'' often associated with multiple inheritance.", "By delegating responsibilities to its component objects, a composite object can achieve complex behavior without tightly coupled hierarchies.", "Composition promotes loose coupling, making code easier to maintain, test, and reuse."]', 'Let''s consider a ''Book'' that ''has a'' ''Author'' and ''has many'' ''Pages''. Instead of inheriting from Author or Page, the Book class will contain instances of them.

python
class Author:
    def __init__(self, name, nationality):
        self.name = name
        self.nationality = nationality

    def get_details(self):
        return f"Author: {self.name} ({self.nationality})"

class Page:
    def __init__(self, page_number, content):
        self.page_number = page_number
        self.content = content

    def get_page_info(self):
        return f"Page {self.page_number}: {self.content[:30]}..."

class Book:
    def __init__(self, title, author_name, author_nationality, num_pages):
        self.title = title
        self.author = Author(author_name, author_nationality) # Book has an Author
        self.pages = [] # Book has many Pages
        for i in range(1, num_pages + 1):
            self.pages.append(Page(i, f"Content of page {i}"))

    def describe_book(self):
        author_info = self.author.get_details()
        first_page_info = self.pages[0].get_page_info() if self.pages else "No pages."
        return f"Book Title: {self.title}\n{author_info}\n{first_page_info}"

# Usage
my_book = Book("Python Mastery", "Alice Wonderland", "British", 250)
print(my_book.describe_book())


Output:

Book Title: Python Mastery
Author: Alice Wonderland (British)
Page 1: Content of page 1...', 'A common misconception is confusing composition with inheritance when a class ''uses'' another class. The key distinction is the ''has-a'' vs. ''is-a'' relationship. If a Dog ''is a'' Animal, that''s inheritance. If a Car ''has an'' Engine, that''s composition. Don''t use inheritance just to reuse code; composition often provides a more flexible and robust solution for code reuse by delegating responsibilities.', 'Refactor a simple `Car` class to use composition. Currently, the `Car` class might directly manage engine details. Your task is to create a separate `Engine` class and integrate it into `Car` using composition. The `Car` should ''have an'' `Engine` object.', 'gemini-flash', '2026-06-06 15:02:57.920346+00', '2026-06-06 15:02:57.920346+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('ef0cb3b9-eb76-4b18-9f77-30b708072d59', 209, '["Inheritance (is-a relationship): Establishes a hierarchical relationship where a subclass is a specialized version of its superclass, inheriting its attributes and methods. Favors code reuse through specialization.", "Composition (has-a relationship): Involves creating new classes that are composed of objects of other classes, delegating responsibilities to these constituent objects. Favors code reuse through collaboration.", "Strengths of Inheritance: Promotes code reuse (DRY), simplifies polymorphism (method overriding), and models clear ''is-a'' hierarchies.", "Weaknesses of Inheritance: Can lead to rigid designs (''tight coupling''), the ''diamond problem'' (multiple inheritance), and difficulty in changing behavior without affecting subclasses.", "Strengths of Composition: Provides flexibility (loose coupling), allows for runtime changes in behavior, promotes modularity, and avoids the complexities of deep inheritance hierarchies.", "Weaknesses of Composition: Can require more boilerplate code (delegation logic) and might be less intuitive for simple ''is-a'' relationships."]', 'Let''s consider building a `Car` and a `Truck`. 

**Inheritance Approach:** We could have a `Vehicle` base class with `start_engine()` and `stop_engine()` methods. `Car` and `Truck` would inherit from `Vehicle`. This works well if `Car` and `Truck` share many core ''vehicle'' behaviors.

python
class Vehicle:
    def start_engine(self):
        return ''Engine started.''
    def stop_engine(self):
        return ''Engine stopped.''

class Car(Vehicle):
    def drive(self):
        return ''Car is driving.''

class Truck(Vehicle):
    def haul(self):
        return ''Truck is hauling.''

my_car = Car()
print(my_car.start_engine()) # Output: Engine started.


**Composition Approach:** Imagine we want to add different types of engines (e.g., `ElectricEngine`, `GasolineEngine`) to a vehicle. 

python
class ElectricEngine:
    def start(self):
        return ''Electric engine purring to life.''
    def stop(self):
        return ''Electric engine powered down.''

class GasolineEngine:
    def start(self):
        return ''Gasoline engine igniting.''
    def stop(self):
        return ''Gasoline engine shutting off.''

class ModernVehicle:
    def __init__(self, engine):
        self.engine = engine # Vehicle ''has-a'' engine

    def start_vehicle(self):
        return self.engine.start()

    def stop_vehicle(self):
        return self.engine.stop()

my_electric_car = ModernVehicle(ElectricEngine())
print(my_electric_car.start_vehicle()) # Output: Electric engine purring to life.

my_gas_truck = ModernVehicle(GasolineEngine())
print(my_gas_truck.start_vehicle()) # Output: Gasoline engine igniting.


Here, `ModernVehicle` doesn''t inherit from an `Engine`. Instead, it ''has an'' `Engine` object, allowing us to easily swap engine types without changing the `ModernVehicle`''s inheritance hierarchy. This demonstrates how composition offers more flexibility for changing parts of an object''s behavior at runtime or during construction.', 'A common misconception is always defaulting to inheritance for code reuse. While inheritance provides reuse, it can create tight coupling. If you find yourself using inheritance just to reuse a few methods, or if the ''is-a'' relationship feels forced, composition is often a better choice. For example, a `Square` ''is-a'' `Rectangle`, but a `Car` does not ''is-a'' `Engine` – it ''has-an'' `Engine`.', 'Consider a `Robot` class. It needs to perform tasks like `walk()` and `talk()`. Instead of inheriting from a `Walker` and a `Talker` base class (which might lead to issues if `Robot` also needs to `fly()`), design the `Robot` class using composition for its locomotion and communication capabilities. You should have separate classes for `Legs` (for walking) and `Speaker` (for talking).', 'gemini-flash', '2026-06-06 15:02:57.920346+00', '2026-06-06 15:02:57.920346+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('88608d07-1bc9-4415-9ffa-359590b85a55', 210, '["Real-world systems are often too complex for a single class; they are better modeled by multiple, specialized classes working together.", "Cooperating classes interact by sending messages (calling methods) to each other, passing data as arguments, and returning values.", "Each class should have a clear, focused responsibility. This is known as the Single Responsibility Principle.", "Relationships between cooperating classes can be ''has-a'' (composition/aggregation) where one class contains instances of another, or ''uses-a'' where one class interacts with another without containing it.", "Designing cooperating classes involves identifying distinct entities, defining their responsibilities, and outlining their interactions."]', 'Let''s model a simple online ordering system. We can have a `Product` class, an `Order` class, and a `Customer` class. 

- `Product` will hold `name` and `price`.
- `Order` will contain a list of `Product` instances and calculate the `total_cost`.
- `Customer` will have a `name` and a list of `Order` instances.

python
class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price

class Order:
    def __init__(self, customer_name):
        self.customer_name = customer_name
        self.products = []

    def add_product(self, product):
        self.products.append(product)

    def get_total_cost(self):
        return sum(p.price for p in self.products)

class Customer:
    def __init__(self, name, email):
        self.name = name
        self.email = email
        self.orders = []

    def place_order(self, order):
        self.orders.append(order)
        print(f''{self.name} placed an order with total cost: ${order.get_total_cost():.2f}'')

# Example Usage
product1 = Product(''Laptop'', 1200.00)
product2 = Product(''Mouse'', 25.50)

customer1 = Customer(''Alice'', ''alice@example.com'')

order1 = Order(customer1.name)
order1.add_product(product1)
order1.add_product(product2)

customer1.place_order(order1)

product3 = Product(''Keyboard'', 75.00)
order2 = Order(customer1.name)
order2.add_product(product3)

customer1.place_order(order2)


Here, `Customer` cooperates with `Order` (by placing it) and `Order` cooperates with `Product` (by adding products and calculating total cost).', 'A common misconception is trying to put all related functionality into a single, monolithic class, leading to a ''God object''. For instance, trying to make the `Customer` class directly manage product details and order calculations. This makes the class hard to read, maintain, and reuse. Instead, break down responsibilities among specialized classes.', 'Extend the `Order` class from the example. Add a method `remove_product(self, product_name)` that removes a product from the order based on its name. Ensure that if the product is not found, a message indicating this is printed, otherwise print a confirmation. Then demonstrate its usage.', 'gemini-flash', '2026-06-06 15:03:36.683155+00', '2026-06-06 15:03:36.683155+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('26b58e7d-cad2-4071-8886-3a08d5f59309', 211, '["The `__str__` and `__repr__` methods are special methods (dunder methods) in Python classes that define how an object is represented as a string.", "`__str__` is intended to provide a human-readable, user-friendly representation of an object, typically used when `str()` is called or `print()` is used on an object.", "`__repr__` is intended to provide an unambiguous, developer-focused representation of an object, often one that could recreate the object. It''s used when `repr()` is called, or when an object is displayed in an interactive console.", "If `__str__` is not defined but `__repr__` is, `__str__` will fall back to using `__repr__`.", "If neither is defined, Python''s default representation is used (e.g., `<__main__.MyClass object at 0x...>`).", "A common convention for `__repr__` is to return a string that looks like a valid Python expression that could be used to recreate the object, e.g., `ClassName(arg1=value1, arg2=value2)`."]', 'Let''s define a simple `Book` class and see how `__str__` and `__repr__` work. Without them, printing a `Book` object gives a generic memory address. With `__str__`, we get a nice title and author. With `__repr__`, we get something that looks like the constructor call.

python
class Book:
    def __init__(self, title, author, year):
        self.title = title
        self.author = author
        self.year = year

    # Default __str__ and __repr__ behavior (before defining them):
    # book = Book(''1984'', ''George Orwell'', 1949)
    # print(book) # Output: <__main__.Book object at 0x...>
    # print(repr(book)) # Output: <__main__.Book object at 0x...>

    def __str__(self):
        return f"''{self.title}'' by {self.author} ({self.year})"

    def __repr__(self):
        return f"Book(title=''{self.title}'', author=''{self.author}'', year={self.year})"

book1 = Book(''The Hitchhiker''''s Guide to the Galaxy'', ''Douglas Adams'', 1979)
book2 = Book(''Pride and Prejudice'', ''Jane Austen'', 1813)

print(book1)
print(repr(book1))
print(str(book2))
print(f"Debug info: {book2!r}") # !r explicitly calls repr()
print(f"User view: {book2}")   # implicitly calls str()


Expected Output:

''The Hitchhiker''s Guide to the Galaxy'' by Douglas Adams (1979)
Book(title=''The Hitchhiker''''s Guide to the Galaxy'', author=''Douglas Adams'', year=1979)
''Pride and Prejudice'' by Jane Austen (1813)
Debug info: Book(title=''Pride and Prejudice'', author=''Jane Austen'', year=1813)
User view: ''Pride and Prejudice'' by Jane Austen (1813)', 'Learners often confuse `__str__` and `__repr__` or think they are interchangeable. The key distinction is their target audience: `__str__` for end-users, `__repr__` for developers. While `__str__` can fall back to `__repr__`, the reverse is not true, and it''s best practice to define both appropriately, especially for complex objects where the ''developer'' and ''user'' views differ significantly.', 'Define a class `Product` with attributes `name`, `price`, and `quantity`. Implement both `__str__` and `__repr__` methods. The `__str__` method should return a user-friendly string like "Banana (Qty: 5) - $1.20", and the `__repr__` method should return a developer-friendly string that could recreate the object, like "Product(name=''Banana'', price=1.20, quantity=5)".', 'gemini-flash', '2026-06-06 15:03:36.683155+00', '2026-06-06 15:03:36.683155+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8b9554a3-9582-44cd-9d97-a42c54719aec', 212, '["Encapsulation is the bundling of data (attributes) and methods that operate on the data within a single unit, i.e., a class.", "Data hiding is a core aspect of encapsulation, restricting direct access to some of an object''s components.", "In Python, private attributes are conventionally indicated by prefixing their names with a single underscore (`_attribute_name`) or double underscores (`__attribute_name`).", "Attributes prefixed with `_` are a ''weak internal use indicator'' - a convention for developers to treat them as private, but they can still be accessed directly.", "Attributes prefixed with `__` (double underscore) trigger name mangling, making them harder (but not impossible) to access directly from outside the class. This provides a stronger form of data hiding.", "Public methods (getters and setters) are provided to control how the internal state of an object can be read or modified, enforcing validation or specific business logic."]', 'Let''s create a `BankAccount` class. We want to store the `__balance` as a private attribute to prevent direct, unchecked modification. We''ll provide `get_balance()` and `deposit()` methods to interact with it safely.

python
class BankAccount:
    def __init__(self, initial_balance):
        if initial_balance < 0:
            raise ValueError("Initial balance cannot be negative")
        self.__balance = initial_balance  # Double underscore for stronger hiding

    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
        else:
            print("Deposit amount must be positive.")

    def get_balance(self):
        return self.__balance

# Usage
account = BankAccount(100)
print(f"Initial balance: {account.get_balance()}")
account.deposit(50)
print(f"Balance after deposit: {account.get_balance()}")

# Attempting direct access (will technically work for _balance, but not __balance as easily)
# print(account.__balance) # This will raise an AttributeError
# print(account._BankAccount__balance) # This would work, demonstrating mangling

# Attempting direct modification (undesirable)
# account.__balance = 1000 # This would create a NEW attribute, not modify the internal one', 'A common misconception is that Python''s ''private'' attributes (especially those with `__`) are truly private like in Java or C++, meaning they are strictly inaccessible. In Python, `__attribute` merely triggers name mangling (`_ClassName__attribute`), making it harder to access from outside, but not impossible. It''s more about convention and signaling intent to other developers.', 'Modify the `BankAccount` class to include a `withdraw` method. This method should take an `amount` as an argument. It should only allow a withdrawal if the `amount` is positive and does not result in a negative `__balance`. If the withdrawal is successful, return `True`; otherwise, print an error message and return `False`.', 'gemini-flash', '2026-06-06 15:03:36.683155+00', '2026-06-06 15:03:36.683155+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('056c961d-ee05-49b1-a87f-f8bbb2b652a4', 213, '["A ''collection managing class'' (or container class) is a class whose primary purpose is to hold, organize, and operate on instances of *other* classes.", "This design pattern promotes better organization and separation of concerns by centralizing collection-related logic (adding, removing, searching, iterating) within a dedicated class.", "It typically uses standard Python data structures (like lists, dictionaries, or sets) internally to store the managed objects.", "Methods in the managing class often delegate operations to the contained objects or perform aggregation/summary tasks.", "Iteration (using `__iter__` and `__next__` or simpler `__iter__` returning an iterator) is a common feature for collection managing classes, allowing direct looping over managed items.", "The `__len__` method is often implemented to provide a consistent way to get the number of items in the collection."]', 'Let''s say we have a `Book` class. Instead of managing a list of books directly in our main program, we can create a `Library` class. The `Library` class will hold `Book` objects. It can have methods like `add_book()`, `find_book_by_title()`, `list_all_books()`, and perhaps `__len__` to tell us how many books are in the library and `__iter__` to allow us to loop through its books directly.', 'Learners often try to put all logic (including individual item properties and behaviors) into the collection managing class, rather than delegating item-specific responsibilities to the individual item classes. For example, a `Library` class shouldn''t have a `book_title` attribute or a `get_book_author()` method if `Book` objects already have `title` and `author` attributes. The `Library` should interact with `Book` objects, not replace them.', 'Design a `Playlist` class that manages `Song` objects. The `Playlist` should allow adding new songs, listing all songs, and knowing its total duration. The `Song` class should have `title` and `duration` (in seconds) attributes.', 'gemini-flash', '2026-06-06 15:03:36.683155+00', '2026-06-06 15:03:36.683155+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('7b04d58c-c5ce-4f91-a2c0-61cbe1b123ea', 214, '["Pyodide runs Python in the browser, a JavaScript environment, which means it doesn''t have direct access to a traditional operating system''s filesystem.", "To enable file operations, Pyodide provides an ''in-memory filesystem'' (often referred to as a virtual filesystem or VFS). This VFS exists entirely within the browser''s memory and is temporary.", "Any files created or modified within this VFS are lost when the browser tab is closed or the Pyodide environment is reset.", "Standard Python file operations (e.g., `open()`, `read()`, `write()`) interact with this in-memory filesystem seamlessly, just as they would with a regular disk filesystem.", "Common directories like `/home/pyodide` are part of this virtual filesystem and can be used for storing temporary files."]', 'python
import os

# Check the current working directory in Pyodide''s VFS
print(f"Current directory: {os.getcwd()}")

# Create a file in the in-memory filesystem
file_path = "/home/pyodide/my_notes.txt"
with open(file_path, "w") as f:
    f.write("This is a test note.\n")
    f.write("It lives in Pyodide''s virtual filesystem.")

print(f"File ''{file_path}'' created.")

# Read the content back
with open(file_path, "r") as f:
    content = f.read()

print("Content of my_notes.txt:")
print(content)

# Demonstrate its temporary nature (though we can''t ''close tab'' in an example)
# Illustrate that it''s gone after a refresh/restart of the Pyodide kernel.
# For now, just confirming its existence within the current session.
print(f"List files in /home/pyodide: {os.listdir(''/home/pyodide'')}")

**Explanation:** This example demonstrates how standard Python file operations (`open`, `write`, `read`) work transparently with Pyodide''s in-memory filesystem. We create `my_notes.txt` in a common virtual directory (`/home/pyodide`), write to it, then read its content back, proving its existence within the current Pyodide session. The `os` module functions like `os.getcwd()` and `os.listdir()` also interact with this virtual filesystem.', 'Learners often mistakenly assume that files created using Pyodide''s `open()` function will persist across browser sessions or be accessible outside the browser environment (e.g., on the user''s actual hard drive). Emphasize that the in-memory filesystem is completely temporary and isolated to the current browser tab and Pyodide execution.', 'Write a Python script that creates a file named `report.txt` in the `/tmp` directory within Pyodide''s in-memory filesystem. The file should contain the single line: `Daily report generated.` Then, read the content of `report.txt` and print it to the console.', 'gemini-flash', '2026-06-06 15:04:17.161503+00', '2026-06-06 15:04:17.161503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('9ed95710-8aa3-4210-a4b4-6b77e3a30eba', 215, '["The `open()` function is used to interact with files. It takes the file path and a mode (e.g., ''r'' for read, ''w'' for write, ''a'' for append) as arguments.", "Always close files after you''re done with them using `file_object.close()` to free up system resources and ensure data integrity.", "The `with` statement (context manager) is the preferred way to handle files in Python. It automatically closes the file, even if errors occur.", "When reading, `read()` reads the entire file, `readline()` reads one line, and iterating over the file object reads line by line.", "When writing, `write()` writes a string to the file. Remember to explicitly add newline characters (`\\n`) for line breaks."]', 'python
# Writing to a file
with open(''my_data.txt'', ''w'') as file_object:
    file_object.write(''Hello, file world!\n'')
    file_object.write(''This is a second line.\n'')

# Reading from the same file
with open(''my_data.txt'', ''r'') as file_object:
    content = file_object.read()
    print(''File Content:\n'' + content)

# Appending to the file
with open(''my_data.txt'', ''a'') as file_object:
    file_object.write(''And this is an appended line.\n'')

# Reading again to see appended content
with open(''my_data.txt'', ''r'') as file_object:
    content_after_append = file_object.read()
    print(''\nContent After Append:\n'' + content_after_append)', 'A common misconception is forgetting to add newline characters (`\n`) when writing multiple lines to a file. Without them, all `write()` calls will place text on a single continuous line, making the file harder to read or parse line by line later.', 'Write a Python script that first creates a file named `greetings.txt` and writes three different greetings on separate lines. Then, read the content of `greetings.txt` line by line and print each line prefixed with ''Line: ''.', 'gemini-flash', '2026-06-06 15:04:17.161503+00', '2026-06-06 15:04:17.161503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('a5fde8e2-b1f4-46b5-b318-886eead86226', 216, '["The `try` block contains code that might raise an exception.", "The `except` block executes if an exception occurs within the `try` block. You can specify a particular exception type to catch.", "The `else` block (optional) executes only if the `try` block completes without any exceptions.", "The `finally` block (optional) always executes, regardless of whether an exception occurred or not. It''s often used for cleanup operations.", "Handling exceptions makes code more robust by preventing crashes and allowing for graceful error recovery.", "Without `try...except`, an unhandled exception will terminate the program."]', 'python
def divide_numbers(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        print("Error: Cannot divide by zero!")
        return None
    else:
        print(f"Division successful. Result: {result}")
        return result
    finally:
        print("Division attempt finished.")

print("--- Test Case 1 ---")
divide_numbers(10, 2) # Expected: Division successful. Result: 5.0\nDivision attempt finished.

print("\n--- Test Case 2 ---")
divide_numbers(10, 0) # Expected: Error: Cannot divide by zero!\nDivision attempt finished.', 'Learners often think `else` block executes when an exception is handled. Clarify that `else` runs ONLY if `try` succeeds without any exceptions. `finally` runs regardless of success or failure.', 'Write a Python function `safe_int_conversion(value)` that attempts to convert a given `value` to an integer. If the conversion is successful, it should print the integer and return it. If a `ValueError` occurs (e.g., if `value` is ''hello''), it should print ''Invalid input for integer conversion.'' and return `None`. Ensure that a final message ''Conversion attempt completed.'' is always printed.', 'gemini-flash', '2026-06-06 15:04:17.161503+00', '2026-06-06 15:04:17.161503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f793321e-b49c-471d-b8e3-48bf6c0825a3', 217, '["Python has a hierarchy of built-in exception types (e.g., `ValueError`, `TypeError`, `FileNotFoundError`, `ZeroDivisionError`).", "Specific exception types can be caught using `except ExceptionType:` to handle different errors distinctly.", "Catching specific exceptions improves code robustness and allows for tailored error messages or recovery actions.", "Multiple `except` blocks can be used, ordered from most specific to most general, to catch different exception types.", "The `as e` keyword can be used to capture the exception object, providing more details about the error."]', 'Let''s consider a function that performs division. We want to handle `ZeroDivisionError` specifically and `ValueError` if the inputs aren''t numbers. All other unexpected errors will be caught by a generic `Exception`.

python
def safe_divide(numerator, denominator):
    try:
        num = float(numerator)
        den = float(denominator)
        result = num / den
    except ZeroDivisionError:
        print("Error: Cannot divide by zero!")
        return None
    except ValueError:
        print("Error: Invalid input. Please provide numbers.")
        return None
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None
    else:
        return result

print(safe_divide(10, 2))      # Output: 5.0
print(safe_divide(10, 0))      # Output: Error: Cannot divide by zero!\nNone
print(safe_divide(''a'', 5))     # Output: Error: Invalid input. Please provide numbers.\nNone
print(safe_divide(10, ''b''))    # Output: Error: Invalid input. Please provide numbers.\nNone', 'A common misconception is to only use a generic `except Exception:` block. While this catches all errors, it masks the root cause of problems, making debugging harder and preventing specific error recovery. It''s best practice to catch specific exceptions where possible, falling back to a general `Exception` for truly unforeseen issues.', 'Write a function `process_list_element(data_list, index)` that attempts to access an element at a given `index` from `data_list` and convert it to an integer. Handle `IndexError` if the index is out of bounds and `ValueError` if the element cannot be converted to an integer. For any other unexpected error, print a generic message.', 'gemini-flash', '2026-06-06 15:04:17.161503+00', '2026-06-06 15:04:17.161503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('bb3c5526-eae9-473f-a1b8-e0cdb1d4e0fb', 218, '["JSON (JavaScript Object Notation) is a lightweight data-interchange format, commonly used for data transmission between a server and web application, or for configuration files.", "Python''s `json` module provides methods to work with JSON data.", "`json.dumps()` serializes a Python object (like dictionaries or lists) into a JSON formatted string.", "`json.loads()` deserializes a JSON formatted string back into a Python object.", "Not all Python types have direct JSON equivalents. For example, Python `set` objects cannot be directly serialized to JSON.", "JSON strings use double quotes for string values and keys, and do not allow trailing commas."]', 'Let''s say we have a Python dictionary representing user data:

python
import json

user_data = {
    "name": "Alice",
    "age": 30,
    "is_active": True,
    "hobbies": ["reading", "coding"],
    "address": {
        "street": "123 Main St",
        "city": "Anytown"
    }
}

# Serialize to JSON string
json_string = json.dumps(user_data, indent=4)
print(f"Serialized JSON:\n{json_string}")

# Deserialize back to Python object
desenialized_data = json.loads(json_string)
print(f"Deserialized Python object: {desenialized_data}")
print(f"Type of deserialized object: {type(desenialized_data)}")
print(f"Accessing a value: {desenialized_data[''name'']}")


Output:

Serialized JSON:
{
    "name": "Alice",
    "age": 30,
    "is_active": true,
    "hobbies": [
        "reading",
        "coding"
    ],
    "address": {
        "street": "123 Main St",
        "city": "Anytown"
    }
}
Deserialized Python object: {''name'': ''Alice'', ''age'': 30, ''is_active'': True, ''hobbies'': [''reading'', ''coding''], ''address'': {''street'': ''123 Main St'', ''city'': ''Anytown''}}
Type of deserialized object: <class ''dict''>
Accessing a value: Alice


Note the `indent=4` argument in `dumps()` for pretty-printing the JSON string, making it more readable. Boolean `True` becomes `true` in JSON, and `None` becomes `null`.', 'A common misconception is that `json.dumps()` writes directly to a file. It doesn''t. `json.dumps()` *returns a string*. To write JSON to a file, you would typically get the string from `json.dumps()` and then write that string to a file using file handling methods (e.g., `file.write()`). Similarly, `json.loads()` expects a JSON *string*, not a file object. For direct file operations, there are `json.dump()` and `json.load()` (without the ''s''). However, for this concept, we''re focusing on string serialization/deserialization.', 'Create a Python list of dictionaries, where each dictionary represents a book with ''title'', ''author'', and ''year'' keys. Serialize this list into a JSON string, then deserialize it back into a Python object. Print the original list, the JSON string, and the deserialized object to verify.', 'gemini-flash', '2026-06-06 15:04:17.161503+00', '2026-06-06 15:04:17.161503+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8c4d68f7-29c3-49bd-85af-d2da2fb73f8b', 219, '["The `assert` statement in Python is used to check if a condition is true.", "If the condition following `assert` is `True`, the program continues normally.", "If the condition is `False`, an `AssertionError` is raised, and the program execution stops.", "Assertions are primarily used for debugging and internal consistency checks, not for handling expected user errors or invalid input.", "An optional second argument can be provided to `assert` as a custom error message to display if the assertion fails."]', 'Let''s say we have a function that calculates the area of a rectangle. We might use an assertion to ensure that the provided width and height are positive numbers before performing the calculation.

python
def calculate_rectangle_area(width, height):
    assert width > 0, "Width must be positive"
    assert height > 0, "Height must be positive"
    return width * height

# This call will work fine
print(f"Area: {calculate_rectangle_area(5, 10)}")

# This call will raise an AssertionError
# calculate_rectangle_area(-2, 5)


When `calculate_rectangle_area(-2, 5)` is uncommented and run, it will output:


AssertionError: Width must be positive


This demonstrates how `assert` immediately stops execution and provides a helpful message when a critical condition for the function''s correct operation is not met.', 'A common misconception is using `assert` for validating user input or handling expected error conditions that are part of the program''s normal flow (e.g., a user entering invalid data). Assertions should only be used for conditions that ''should never happen'' if the code is working correctly. For expected errors, use `if/else` statements or raise specific exceptions like `ValueError` or `TypeError`.', 'Write a Python function `get_even_number(number)` that takes an integer `number` as input. Inside the function, use an `assert` statement to ensure that the `number` is even. If it''s not even, the assertion should fail with the message ''Number must be even''. If the number is even, the function should return the number multiplied by 2. Test your function with both an even and an odd number, observing the output.', 'gemini-flash', '2026-06-06 15:05:05.858366+00', '2026-06-06 15:05:05.858366+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f8d99796-2f4f-4461-b4bc-c3d9ddd1125d', 220, '["The `unittest` module is Python''s built-in framework for writing and running tests.", "Test cases are created by subclassing `unittest.TestCase`.", "Test methods within a `unittest.TestCase` class must start with `test_`.", "`unittest.TestCase` provides various assertion methods (e.g., `assertEqual`, `assertTrue`, `assertFalse`) to check conditions.", "Tests can be run by calling `unittest.main()` or using `python -m unittest` from the command line.", "The `setUp` and `tearDown` methods can be used for test setup and cleanup, respectively (though not covered in detail here)."]', 'python
import unittest

def add(a, b):
    return a + b

class TestAddition(unittest.TestCase):
    def test_positive_numbers(self):
        self.assertEqual(add(2, 3), 5)

    def test_negative_numbers(self):
        self.assertEqual(add(-1, -1), -2)

    def test_zero_with_positive(self):
        self.assertEqual(add(0, 5), 5)

if __name__ == ''__main__'':
    unittest.main()


This example demonstrates a basic `unittest.TestCase` with three test methods, each asserting a different scenario for an `add` function. Running this script directly will execute the tests and report the results.', 'Learners might think that simply defining a class and methods is enough for `unittest` to find and run tests. They need to understand that the class must inherit from `unittest.TestCase` and the methods must start with `test_` for the test runner to discover them.', 'Create a Python file named `test_calculator.py`. In this file, define a simple function `multiply(a, b)` that returns the product of `a` and `b`. Then, create a test case class `TestMultiplication` that subclasses `unittest.TestCase`. Add at least two test methods to `TestMultiplication`: one that tests multiplication of positive numbers and another that tests multiplication with zero. Use `self.assertEqual()` for your assertions. Finally, include the `if __name__ == ''__main__'': unittest.main()` block to run your tests.', 'gemini-flash', '2026-06-06 15:05:05.858366+00', '2026-06-06 15:05:05.858366+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f2cca4c5-c97f-4325-af64-5d3f63e618d6', 221, '["Effective test cases cover different scenarios: typical inputs, edge cases, and error conditions.", "Typical inputs (normal cases) verify the most common expected behavior of your code.", "Edge cases test boundaries and unusual but valid inputs, such as minimum/maximum values, empty collections, or single-element inputs.", "Error conditions (invalid inputs) verify that your code handles unexpected or incorrect data gracefully, often by raising appropriate exceptions or returning specific error indicators.", "Designing test cases involves anticipating how your function might be used and misused.", "A good suite of test cases provides high confidence in the correctness and robustness of your code."]', 'Let''s consider a function `calculate_discount(price, discount_percentage)`.

**Typical Input:** `calculate_discount(100, 10)` should return `90.0`.

**Edge Cases:**
*   `calculate_discount(0, 10)` (zero price): Should return `0.0`.
*   `calculate_discount(100, 0)` (zero discount): Should return `100.0`.
*   `calculate_discount(100, 100)` (full discount): Should return `0.0`.
*   `calculate_discount(100.50, 5.25)` (float values): Should return `95.21625` (or a rounded equivalent depending on specification).

**Error Conditions:**
*   `calculate_discount(100, -5)` (negative discount): Should ideally raise a `ValueError` or return an error.
*   `calculate_discount(100, 110)` (discount > 100%): Should ideally raise a `ValueError` or cap at 100% discount.
*   `calculate_discount(''abc'', 10)` (non-numeric price): Should ideally raise a `TypeError`.
*   `calculate_discount(100, ''xyz'')` (non-numeric discount): Should ideally raise a `TypeError`.', 'A common misconception is that testing only means checking if the code produces the correct output for a few ''happy path'' examples. This overlooks the critical importance of robustness and error handling, which are uncovered by edge cases and error conditions.', 'Consider a function `find_max(numbers)` that takes a list of numbers and returns the largest one. What are three distinct categories of test cases you would write for this function? Give an example input for each category.', 'gemini-flash', '2026-06-06 15:05:05.858366+00', '2026-06-06 15:05:05.858366+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('67c01938-67e6-421f-9c37-13dc5f8dcbcf', 222, '["Test-Driven Development (TDD) is a software development approach where tests are written *before* the actual code.", "TDD follows a ''Red-Green-Refactor'' cycle: ''Red'' (write a failing test), ''Green'' (write just enough code to make the test pass), and ''Refactor'' (improve the code without changing its behavior, ensuring tests still pass).", "The primary goal of TDD is to ensure code correctness and build confidence, but it also leads to cleaner design, better maintainability, and built-in regression protection.", "Tests in TDD should be small, focused, and test a single piece of functionality.", "Initially, the test will fail because the functionality doesn''t exist yet; this is expected and proves the test itself is valid."]', 'Let''s apply TDD to a simple function that calculates the area of a rectangle. 

1.  **Red (Write a failing test):**
    python
    import unittest

    class TestRectangle(unittest.TestCase):
        def test_area_positive_numbers(self):
            # Expect a Rectangle class or function ''area'' to exist
            # This test will fail initially because Rectangle doesn''t exist
            # or area method is not implemented.
            self.assertEqual(area(2, 3), 6)
    
    # if __name__ == ''__main__'':
    #     unittest.main()
    
    *Run this test. It will fail with an `NameError` because `area` is not defined.* 

2.  **Green (Write just enough code to make the test pass):**
    python
    # rectangle.py
    def area(length, width):
        return length * width
    
    # Then, re-run the test from step 1. It should now pass.
    
    *Now the test passes. We''ve written just enough code.*

3.  **Refactor (Improve code without breaking tests):**
    *For this simple function, there isn''t much to refactor immediately. But imagine if the `area` function was part of a larger `Rectangle` class. We might move `area` into the class, or optimize calculations. After refactoring, always re-run all tests to ensure nothing broke.* 
    
    *Example refactoring (though not strictly necessary here, just for illustration):*
    python
    # rectangle.py
    class Rectangle:
        def __init__(self, length, width):
            self.length = length
            self.width = width
        
        def calculate_area(self):
            return self.length * self.width

    # Update test_area_positive_numbers to use the class:
    # self.assertEqual(Rectangle(2, 3).calculate_area(), 6)
    
    *Then, write a new test for zero or negative dimensions, which would again be a Red phase.*', 'A common misconception is that TDD is primarily about testing. While testing is integral, TDD''s main benefit is actually in *design*. By forcing you to think about how to use a piece of code (i.e., how to test it) before you write it, TDD naturally leads to more modular, decoupled, and easier-to-use interfaces, improving the overall software design.', 'Consider a function `is_palindrome(text)` that checks if a string is a palindrome (reads the same forwards and backwards, ignoring case). Following the TDD ''Red'' step, write a `unittest` test method for `is_palindrome` that would initially fail, expecting the function to handle a simple palindrome like ''madam''.', 'gemini-flash', '2026-06-06 15:05:05.858366+00', '2026-06-06 15:05:05.858366+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8806ca6e-21b7-40ec-b666-7392dc66ae82', 223, '["Understand the structure of a test failure report (unittest framework).", "Identify key components: Test method name, traceback, assertion error type, and the actual vs. expected values.", "Trace the traceback to pinpoint the exact line of code causing the failure.", "Differentiate between AssertionError (expected vs. actual mismatch) and other exceptions (bugs in code)."]', 'Let''s say you have a function `add(a, b)` that is supposed to return `a + b`. You write a test case:

python
import unittest

def add(a, b):
    return a - b # Intentional bug

class TestAddFunction(unittest.TestCase):
    def test_positive_numbers(self):
        self.assertEqual(add(2, 3), 5)

if __name__ == ''__main__'':
    unittest.main(exit=False)


When you run this, you''ll see an output similar to this:


F
======================================================================
FAIL: test_positive_numbers (__main__.TestAddFunction.test_positive_numbers)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "<stdin>", line 10, in test_positive_numbers
    self.assertEqual(add(2, 3), 5)
AssertionError: 2 != 5

----------------------------------------------------------------------
Ran 1 test in 0.001s

FAILED (failures=1)


**Interpreting this:**
1.  `FAIL: test_positive_numbers`: Tells us which specific test method failed.
2.  `Traceback (most recent call last):`: This is crucial. It shows the call stack.
3.  `File "<stdin>", line 10, in test_positive_numbers`: Points to the line in the test method where the assertion failed. In this case, `self.assertEqual(add(2, 3), 5)`.
4.  `AssertionError: 2 != 5`: This is the type of error and the core message. It explicitly states that the `add(2, 3)` call returned `2`, but `5` was expected. This immediately tells us the function `add` is not producing the correct result for `2 + 3`.', 'A common misconception is that a long traceback always means the bug is deep within some complex library. Often, the *first* file in your project''s code mentioned in the traceback (after library calls) is the most relevant place to start looking, and the error message itself (e.g., `AssertionError: X != Y`) directly points to the discrepancy, not necessarily a complex logical error, but a simple incorrect return value.', 'Given a failing test report, identify the specific test method that failed, the line number where the assertion occurred, and the actual and expected values from the `AssertionError` message.', 'gemini-flash', '2026-06-06 15:05:05.858366+00', '2026-06-06 15:05:05.858366+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('99258df7-ea63-4bf6-8b9d-0cc07f2fb57e', 224, '["In-lesson data is pre-loaded into your Python environment, often as Pandas DataFrames or NumPy arrays, ready for immediate use.", "These datasets are typically stored in variables with descriptive names, making them easy to identify and access.", "The primary way to ''load'' this data is simply by referencing the pre-defined variable name.", "Before analysis, it''s crucial to understand the data''s structure using methods like `.head()`, `.info()`, or `.shape` to confirm it loaded correctly and to inspect its initial rows, data types, and dimensions."]', 'Let''s say a dataset of sales records is pre-loaded into a variable named `sales_data`. To inspect its first few rows, you would simply type `print(sales_data.head())`.

python
# Assume ''sales_data'' is a pre-loaded Pandas DataFrame
import pandas as pd
sales_data = pd.DataFrame({
    ''Date'': [''2023-01-01'', ''2023-01-01'', ''2023-01-02'', ''2023-01-02''],
    ''Product'': [''A'', ''B'', ''A'', ''C''],
    ''Quantity'': [10, 5, 12, 8],
    ''Price'': [100.0, 50.0, 105.0, 75.0]
})

print("First 3 rows of sales_data:")
print(sales_data.head(3))


Output:

First 3 rows of sales_data:
         Date Product  Quantity  Price
0  2023-01-01       A        10  100.0
1  2023-01-01       B         5   50.0
2  2023-01-02       A        12  105.0', 'A common misconception is that ''loading in-lesson data'' requires explicit file operations (like `pd.read_csv()` or `np.load()`). In this learning environment, the data is already in memory as a Python object, accessible by its variable name. No file reading is necessary.', 'Assume a dataset named `customer_demographics` (a Pandas DataFrame) is available. Print its first 5 rows and then its data types (using `.info()`).', 'gemini-flash', '2026-06-06 15:05:47.241746+00', '2026-06-06 15:05:47.241746+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('e89c3fc1-c855-447d-9017-dd1b43f748de', 225, '["Summary statistics provide a quick, quantitative overview of data distributions.", "The mean (average) is sensitive to outliers, while the median (middle value) is more robust.", "The minimum and maximum values define the data''s range.", "Python''s `statistics` module offers functions like `mean()`, `median()`, `min()`, and `max()` for these calculations.", "Pandas Series and DataFrames have built-in methods (`.mean()`, `.median()`, `.min()`, `.max()`, `.describe()`) for convenience."]', 'Let''s say we have a list of student scores: `scores = [85, 92, 78, 90, 88, 95, 75, 100, 80, 92, 10]`. 

To calculate the mean, median, min, and max using the `statistics` module:
python
import statistics

scores = [85, 92, 78, 90, 88, 95, 75, 100, 80, 92, 10]

mean_score = statistics.mean(scores)
median_score = statistics.median(scores)
min_score = min(scores) # min() and max() are built-in functions
max_score = max(scores)

print(f"Mean: {mean_score}")
print(f"Median: {median_score}")
print(f"Min: {min_score}")
print(f"Max: {max_score}")


If we had this data in a Pandas Series:
python
import pandas as pd

scores_series = pd.Series([85, 92, 78, 90, 88, 95, 75, 100, 80, 92, 10])

mean_series = scores_series.mean()
median_series = scores_series.median()
min_series = scores_series.min()
max_series = scores_series.max()

print(f"Series Mean: {mean_series}")
print(f"Series Median: {median_series}")
print(f"Series Min: {min_series}")
print(f"Series Max: {max_series}")', 'A common misconception is that the mean and median will always be very close. While often true for symmetrically distributed data, they can differ significantly when data is skewed or contains extreme outliers. The `worked_example` with the score `10` illustrates this, as the mean is pulled down more than the median.', 'Given a list of daily temperatures, calculate and print its mean, median, minimum, and maximum values. Use the `statistics` module where appropriate.', 'gemini-flash', '2026-06-06 15:05:47.241746+00', '2026-06-06 15:05:47.241746+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('b272adeb-8113-4bf8-bace-5794aa42ed7b', 226, '["Matplotlib is a powerful Python library for creating static, interactive, and animated visualizations.", "The `matplotlib.pyplot` module (often imported as `plt`) provides a MATLAB-like interface for plotting.", "Line plots (`plt.plot()`) are ideal for showing trends over continuous data, like time series.", "Bar plots (`plt.bar()`) are used to compare quantities across different categories or discrete groups.", "Scatter plots (`plt.scatter()`) display individual data points, useful for showing relationships or correlations between two numerical variables.", "All plot functions require numerical data. Basic plots only need lists or arrays of values for their axes."]', 'Let''s say we have monthly sales data and advertisement spending for a small business. We want to visualize sales trends over time and see if there''s a relationship between ad spending and sales.

python
import matplotlib.pyplot as plt

months = [''Jan'', ''Feb'', ''Mar'', ''Apr'', ''May'']
sales = [100, 120, 110, 130, 150]
ad_spend = [10, 12, 11, 14, 13]

# Line plot for sales over months
plt.figure(figsize=(6, 3)) # Optional: set figure size
plt.plot(months, sales, marker=''o'', linestyle=''-'', color=''blue'')
plt.title(''Monthly Sales Trend'')
plt.xlabel(''Month'')
plt.ylabel(''Sales ($)'')
plt.grid(True)
plt.show() # Display the plot

# Bar plot for ad spending per month
plt.figure(figsize=(6, 3))
plt.bar(months, ad_spend, color=''green'')
plt.title(''Monthly Ad Spending'')
plt.xlabel(''Month'')
plt.ylabel(''Ad Spending ($)'')
plt.show()

# Scatter plot for Ad Spending vs. Sales
plt.figure(figsize=(6, 3))
plt.scatter(ad_spend, sales, color=''red'', s=100) # s for marker size
plt.title(''Ad Spending vs. Sales'')
plt.xlabel(''Ad Spending ($)'')
plt.ylabel(''Sales ($)'')
plt.grid(True)
plt.show()


The `plt.show()` function is crucial to display the generated plot.', 'A common misconception is that `plt.plot()` can automatically handle all data types or guess the best plot type. While it''s versatile, `plt.plot()` is primarily for line plots and can draw markers. For categorical comparisons, `plt.bar()` is more appropriate, and for individual point relationships, `plt.scatter()` is explicit. Using the wrong plot type can lead to misinterpretations (e.g., using a line plot for truly discrete, unordered categories).', NULL, 'gemini-flash', '2026-06-06 15:05:47.241746+00', '2026-06-06 15:05:47.241746+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('f442a48b-b3df-4b31-801b-5bae79a8a602', 227, '["Labels and titles are crucial for making plots understandable and communicative.", "The `xlabel()` function sets the label for the x-axis.", "The `ylabel()` function sets the label for the y-axis.", "The `title()` function sets the main title for the plot.", "These functions are typically called on the `matplotlib.pyplot` module (often aliased as `plt`).", "Always call `plt.show()` after defining labels and titles to display them."]', 'Let''s say we have a simple scatter plot of ''Years of Experience'' vs. ''Salary (USD)''.

python
import matplotlib.pyplot as plt

experience = [1, 2, 3, 4, 5, 6, 7]
salary = [50000, 55000, 60000, 68000, 75000, 80000, 90000]

plt.scatter(experience, salary)

plt.xlabel(''Years of Experience'')
plt.ylabel(''Salary (USD)'')
plt.title(''Salary vs. Years of Experience'')

plt.show()


Here, `xlabel()` gives context to the horizontal axis, `ylabel()` to the vertical axis, and `title()` provides an overall description of the plot''s content.', 'A common mistake is forgetting to call `plt.show()` after setting labels and titles. If `plt.show()` is not called, the plot (including its customizations) will not be rendered or displayed, leading to confusion about why the labels aren''t appearing.', 'Create a simple bar chart comparing the ''Sales'' of three different ''Products''. Add an appropriate title, x-axis label, and y-axis label to the plot.', 'gemini-flash', '2026-06-06 15:05:47.241746+00', '2026-06-06 15:05:47.241746+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('a3258012-1db5-4081-ab3d-5ae8f05b49cd', 232, '["Object-Oriented Programming (OOP) in game design uses classes to model real-world (or game-world) entities, organizing code and making it more manageable.", "A ''Game'' class can encapsulate the overall state and logic of the game, including managing turns, tracking score, and orchestrating interactions between other objects.", "''Player'' classes represent the participant(s) in the game, holding attributes like health, inventory, and current location, and methods for actions like ''move'' or ''use_item''.", "''Item'' classes represent objects within the game world, defining their properties (e.g., name, description, effect) and potential actions (e.g., ''apply_effect'').", "Using classes promotes modularity, reusability, and easier debugging by separating concerns and clearly defining responsibilities for each game component."]', 'Let''s consider a simple text adventure where a player collects an item. Instead of just having variables for `player_health`, `item_name`, etc., we can define classes:

python
class Player:
    def __init__(self, name, health=100):
        self.name = name
        self.health = health
        self.inventory = []

    def take_item(self, item):
        self.inventory.append(item)
        print(f"{self.name} picked up {item.name}.")

class Item:
    def __init__(self, name, description):
        self.name = name
        self.description = description

class Game:
    def __init__(self, player_name):
        self.player = Player(player_name)
        self.game_items = []

    def start_game(self):
        print(f"Welcome, {self.player.name}!")
        sword = Item("Sword", "A rusty old sword.")
        self.game_items.append(sword)
        self.player.take_item(sword)
        print(f"Your inventory: {[item.name for item in self.player.inventory]}")

my_game = Game("Hero")
my_game.start_game()


This structure clearly separates player concerns from item concerns, and the Game class acts as an orchestrator.', 'A common misconception is that OOP is only useful for very large or complex games. In reality, even simple text-based games benefit significantly from the organization, readability, and maintainability that object-oriented design provides, especially as you add more features or content.', 'Define a simple `Room` class with attributes for `name` and `description`, and a method `enter()` that prints the room''s description. Then, create two `Room` objects and demonstrate entering one of them.', 'gemini-flash', '2026-06-06 15:06:59.098614+00', '2026-06-06 15:06:59.098614+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('97c245ae-54a1-42bd-883b-271be60bb4a8', 228, '["Visualizations are not just pretty pictures; they are tools for understanding data patterns and relationships.", "Always consider the axes, labels, and legends of a plot to understand what data is being presented.", "Look for trends (e.g., increasing, decreasing), outliers (data points far from others), and clusters (groups of similar data points).", "Correlations between variables can be suggested by scatter plots, but correlation does not imply causation.", "Formulate specific questions the visualization should answer, then interpret the data to find those answers."]', 'Let''s say you have a scatter plot showing ''Hours Studied'' on the x-axis and ''Exam Score'' on the y-axis.  If the points generally go upwards from left to right, we can interpret this as a positive correlation: typically, more hours studied are associated with higher exam scores. If there are points significantly below this trend line, these might be outliers warranting further investigation (e.g., perhaps the student was ill).', 'A common misconception is assuming that if two variables show a strong correlation in a visualization, one *causes* the other. For example, a plot might show that ice cream sales and shark attacks both increase in summer. While correlated, neither causes the other; both are influenced by a third variable (summer weather leading to more beachgoers). Always be cautious about inferring causation from correlation alone.', 'Given a bar chart showing ''Average Customer Spending'' for five different product categories, identify the product category with the highest average spending and the category with the lowest. Describe any significant differences or similarities you observe between the categories.', 'gemini-flash', '2026-06-06 15:05:47.241746+00', '2026-06-06 15:05:47.241746+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('8183442c-8777-46ba-9f33-2b137436ff20', 229, '["Game state refers to all the dynamic data that defines the current situation of a game at any given moment.", "Key elements of game state often include player position (coordinates), player inventory (items held), character stats (health, score), and the status of game world elements (doors open/closed, enemies present).", "Representing game state effectively usually involves data structures like dictionaries or custom classes to store related information.", "Updating game state means modifying these data structures in response to player actions or game events.", "A well-managed game state is crucial for tracking progress, saving/loading games, and ensuring consistent game behavior."]', 'Let''s design a simple game state for a text-based adventure where a player explores rooms, picks up items, and battles. We''ll use a dictionary to represent the `game_state`.

python
game_state = {
    "player_location": "forest_path",
    "inventory": [],
    "player_health": 100,
    "enemies_defeated": 0,
    "room_data": {
        "forest_path": {"description": "A winding path through a dense forest.", "items": ["rusty sword"]},
        "dark_cave": {"description": "A dark, damp cave.", "items": ["torch", "gold_coin"]}
    }
}

print(f"Initial location: {game_state[''player_location'']}")
print(f"Initial inventory: {game_state[''inventory'']}")

# Player moves to a new location
game_state["player_location"] = "dark_cave"

# Player picks up an item
item_to_pick_up = "torch"
if item_to_pick_up in game_state["room_data"]["dark_cave"]["items"]:
    game_state["inventory"].append(item_to_pick_up)
    game_state["room_data"]["dark_cave"]["items"].remove(item_to_pick_up)

print(f"\nCurrent location: {game_state[''player_location'']}")
print(f"Current inventory: {game_state[''inventory'']}")
print(f"Items left in dark_cave: {game_state[''room_data''][''dark_cave''][''items'']}")


This example shows how `player_location` and `inventory` are updated, and how `room_data` keeps track of items in each room, reflecting changes when an item is picked up. The `game_state` dictionary holds all these dynamic elements.', 'A common misconception is that ''game state'' only refers to the player''s immediate status (like health or position). However, game state encompasses ALL dynamic elements of the game world, including the status of NPCs, objects, doors, puzzles, and even global flags that track progression. Anything that can change and needs to be remembered is part of the game state.', 'Imagine a simple text adventure where the player can move between rooms and pick up a single key. Design a Python dictionary to represent the initial `game_state`. It should include:
1. The player''s current `location` (e.g., ''start_room'').
2. The player''s `inventory` (initially empty).
3. A dictionary `rooms` where each room key maps to another dictionary containing its `description` and a list of `items` it holds. Include at least two rooms: ''start_room'' with ''a rusty key'' and ''locked_door_room'' with no items.', 'gemini-flash', '2026-06-06 15:06:59.098614+00', '2026-06-06 15:06:59.098614+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('65c44ff2-63eb-4f94-859c-f4fbdbc651be', 230, '["A game loop is the central control structure of most games, continuously running to update the game state and present it to the player.", "Each iteration of the game loop is considered a ''turn'' or ''frame'', where specific actions and updates occur.", "Turn logic involves processing player actions, updating game elements (e.g., character positions, resource counts), and checking for significant events.", "The order of operations within a turn is crucial; typically, input processing, state updates, and then output/rendering happen sequentially.", "Termination conditions (e.g., win/loss) are often checked within or at the end of each turn to decide if the loop should continue."]', 'Let''s consider a simple text-based adventure game where the player can move ''north'', ''south'', ''east'', or ''west''.

python
def game_loop(current_location, actions_taken):
    print(f"You are in the {current_location}. Actions taken: {actions_taken}")

    # Simulate player input (in a real game, this would be actual input)
    # For this example, we''ll use a predefined sequence of ''moves''
    possible_moves = [''north'', ''east'', ''south'', ''west'']
    
    # This game will simulate 3 turns based on a fixed sequence.
    # In a real game, this might be based on player input or a fixed number of turns.
    turn_actions = [''move north'', ''move east'', ''check status'', ''move south'']
    
    turn_count = 0
    max_turns = len(turn_actions) # The loop runs for a predefined number of actions

    while turn_count < max_turns:
        print(f"\n--- Turn {turn_count + 1} ---")
        action = turn_actions[turn_count]
        print(f"Player chooses to: {action}")

        # Process turn logic based on the action
        if action.startswith(''move''):
            direction = action.split()[1]
            if direction in possible_moves:
                current_location = f"the {direction}ern part of the area"
                print(f"You moved {direction}.")
            else:
                print("Invalid move direction.")
        elif action == ''check status'':
            print("You are feeling adventurous.")
        else:
            print("Unknown action.")
        
        actions_taken.append(action)
        turn_count += 1

    print("\nGame simulation ended.")
    print(f"Final location: {current_location}. Total actions: {len(actions_taken)}")

# Initial game state
starting_location = "starting room"
history = []

game_loop(starting_location, history)


**Explanation:**
1.  `game_loop` is a function that contains the main game logic.
2.  `while turn_count < max_turns:` is the core of the game loop, which continues as long as `turn_count` is less than `max_turns` (our predefined limit for this simulation).
3.  Inside the loop, `action = turn_actions[turn_count]` simulates getting a player''s action for the current turn.
4.  `if action.startswith(''move''):` and other `elif` blocks handle the specific logic for each type of action, updating `current_location` or printing status messages.
5.  `actions_taken.append(action)` and `turn_count += 1` update the game state and prepare for the next turn.
6.  The loop eventually terminates when `turn_count` reaches `max_turns`, and a final message is printed.', 'A common misconception is that the game loop waits for user input indefinitely. While many interactive games pause for input, the loop itself is a continuous process. If no player input is available, the game still progresses (e.g., AI opponents move, environmental effects occur), or the loop might simply re-render the current state until input is received. In text-based games, processing a turn often involves an immediate response to a hardcoded action, a function call, or a predefined sequence, rather than a blocking `input()` call.', 'Modify the provided `process_turn` function. This function will be called repeatedly by a simple game loop. Your task is to implement the logic for two new actions: ''collect_item'' and ''use_item''.

- If the `action` is ''collect_item'', print ''You collected a mysterious item.''
- If the `action` is ''use_item'', print ''You used the mysterious item.''
- For any other action (like ''wait''), print ''You decide to '' followed by the action.', 'gemini-flash', '2026-06-06 15:06:59.098614+00', '2026-06-06 15:06:59.098614+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('0bf39ca2-69a3-4380-8957-5c642a35c2af', 231, '["Win/loss conditions define the criteria for ending the game, determining if the player succeeded or failed.", "These conditions are typically checked at the end of each game turn or after significant player actions.", "Winning conditions might involve achieving a specific goal (e.g., collecting all items, reaching a destination, defeating a boss).", "Losing conditions often involve depleting a crucial resource (e.g., health, time, lives) or failing to achieve a goal within constraints.", "Implementing these checks usually involves conditional statements (if/elif/else) based on the current `game_state` variables."]', 'Let''s say our game involves a player collecting 3 magic gems. The game ends when all gems are collected. If the player''s health drops to 0, they lose.

python
game_state = {
    ''player_health'': 100,
    ''gems_collected'': 0,
    ''total_gems'': 3
}

def check_game_over(state):
    if state[''gems_collected''] == state[''total_gems'']:
        return ''win''
    elif state[''player_health''] <= 0:
        return ''lose''
    else:
        return ''continue''

# Example usage:
print(f"Initial status: {check_game_over(game_state)}")

game_state[''gems_collected''] = 2
game_state[''player_health''] = 50
print(f"Mid-game status: {check_game_over(game_state)}")

game_state[''gems_collected''] = 3
print(f"After collecting all gems: {check_game_over(game_state)}")

game_state[''gems_collected''] = 1 # Reset for another scenario
game_state[''player_health''] = -5
print(f"After health drops: {check_game_over(game_state)}")


Output:

Initial status: continue
Mid-game status: continue
After collecting all gems: win
After health drops: lose', 'A common misconception is that win/loss conditions only need to be checked at the very end of the game logic. In text-based games, these checks are crucial at the end of *each turn* or after any action that could change the game state significantly (e.g., taking damage, collecting an item) to ensure immediate feedback and proper game termination.', 'Consider a simple text adventure where the player needs to find a ''hidden key'' and escape through the ''exit door''. If the player encounters a ''monster'' without having a ''sword'', they lose. Otherwise, if they find the key and reach the exit, they win. Write a function `check_game_end(player_inventory, player_location)` that returns ''win'', ''lose'', or ''continue'' based on these conditions.', 'gemini-flash', '2026-06-06 15:06:59.098614+00', '2026-06-06 15:06:59.098614+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('9cfbe02d-7290-4e63-a3b8-63000d27bbb5', 233, '["Randomness introduces unpredictability, enhancing game replayability and making outcomes less deterministic.", "The `random` module in Python provides functions for generating pseudo-random numbers and making random selections.", "`random.choice(sequence)` selects a random element from a non-empty sequence (like a list or tuple).", "`random.randint(a, b)` generates a random integer N such that `a <= N <= b`.", "`random.shuffle(list)` shuffles the items of a list in place, modifying the original list.", "For deterministic testing or reproducibility, `random.seed(value)` can be used to initialize the random number generator with a specific starting point."]', 'Imagine a game where a player encounters a random event. We can define a list of possible events and use `random.choice()` to pick one. For instance, `events = [''Find a health potion'', ''Encounter a weak enemy'', ''Lose 5 gold'']`. A function could then randomly select one: `current_event = random.choice(events)`. If we wanted a random gold amount lost, we could use `random.randint(1, 10)`.', 'A common misconception is that `random` module functions produce truly random numbers. They actually produce ''pseudo-random'' numbers, which are generated by an algorithm and appear random but are predictable if the initial ''seed'' is known. This is why `random.seed()` can make results repeatable for testing.', 'You are building a treasure chest system. When a player opens a chest, they can find one of three items: ''Sword'', ''Shield'', or ''Gold''. There''s also a 20% chance they find a ''Rare Gem''. Implement a function `open_treasure_chest()` that returns the item found. Use `random.choice()` for the common items and `random.random()` to determine if the rare gem is found.', 'gemini-flash', '2026-06-06 15:06:59.098614+00', '2026-06-06 15:06:59.098614+00');
INSERT INTO public.concept_briefs (id, concept_id, key_points, worked_example, misconception, exercise, model, created_at, updated_at) VALUES ('a69483e2-565a-4b45-88ed-53bde5133b95', 235, '["The `random` module in Python provides functions for generating pseudo-random numbers, which are essential for simulations.", "`random.random()` generates a floating-point number in the range [0.0, 1.0).", "`random.uniform(a, b)` generates a floating-point number in the range [a, b].", "`random.randint(a, b)` generates a random integer in the range [a, b] (inclusive).", "`random.choice(sequence)` selects a random element from a non-empty sequence (e.g., list, tuple).", "`random.seed(value)` initializes the pseudo-random number generator, making sequences of ''random'' numbers reproducible for testing and debugging."]', 'Let''s explore basic random number generation. We can simulate a coin flip, a dice roll, or pick a random item from a list.

python
import random

# Set a seed for reproducibility
random.seed(42)

# Generate a random float between 0.0 and 1.0
print(f"Random float (0.0-1.0): {random.random():.4f}")

# Generate a random float between 10.0 and 20.0
print(f"Random float (10.0-20.0): {random.uniform(10.0, 20.0):.4f}")

# Simulate a dice roll (1 to 6)
print(f"Dice roll: {random.randint(1, 6)}")

# Choose a random item from a list
outcomes = [''Heads'', ''Tails'']
print(f"Coin flip: {random.choice(outcomes)}")

# Demonstrating seed reproducibility
print("\n--- Reproducibility check ---")
random.seed(100)
print(f"First number with seed 100: {random.random():.4f}")
random.seed(100)
print(f"Second number with seed 100: {random.random():.4f}")


**Expected Output:**


Random float (0.0-1.0): 0.6394
Random float (10.0-20.0): 16.9141
Dice roll: 1
Coin flip: Heads

--- Reproducibility check ---
First number with seed 100: 0.8184
Second number with seed 100: 0.8184', 'A common misconception is that `random` module functions generate truly random numbers. They generate *pseudo-random* numbers, meaning they are produced by deterministic algorithms but appear random. This is usually sufficient for simulations, but important for cryptography where truly unpredictable numbers are needed.', 'Write a Python program that uses `random.seed(123)` at the beginning. Then, generate and print two random integers between 50 and 100 (inclusive), and finally, print a random choice from the list `[''Red'', ''Green'', ''Blue'', ''Yellow'']`.', 'gemini-flash', '2026-06-06 14:40:10.780425+00', '2026-06-06 15:07:36.119482+00');


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2546ded6-75ee-4926-ace6-58db7b7fbfdb', 17, 28, 'multiple_choice', 'foundational', 'What is the value of 7 × 8 + 3?', '[{"text": "56", "label": "A"}, {"text": "59", "label": "B"}, {"text": "61", "label": "C"}, {"text": "83", "label": "D"}]', '59', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6a2d4416-2044-4623-8065-2e51aa10ad05', 17, 29, 'multiple_choice', 'foundational', 'Which of the following is equal to 3/4?', '[{"text": "0.25", "label": "A"}, {"text": "0.50", "label": "B"}, {"text": "0.75", "label": "C"}, {"text": "1.33", "label": "D"}]', '0.75', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b4e52e2c-5627-46fc-be16-ac7f5724aad7', 17, 30, 'multiple_choice', 'applied', 'If 3/5 of a number is 24, what is the number?', '[{"text": "30", "label": "A"}, {"text": "36", "label": "B"}, {"text": "40", "label": "C"}, {"text": "45", "label": "D"}]', '40', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a977414f-7ab0-40d2-a788-fc34b44d49a3', 17, 31, 'multiple_choice', 'applied', 'What is 15% of 200?', '[{"text": "15", "label": "A"}, {"text": "25", "label": "B"}, {"text": "30", "label": "C"}, {"text": "35", "label": "D"}]', '30', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3b3c02d7-72e2-4b9d-8082-a3b8a3f7bbb8', 17, 29, 'short_answer', 'foundational', 'What is the sum of 1/3 and 1/6? Express as a simplified fraction.', NULL, '1/2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('845c169a-dd84-437d-942f-8932d37d28d9', 17, 29, 'short_answer', 'applied', 'Express 0.375 as a fraction in simplest form.', NULL, '3/8', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77c02992-427f-42a3-adc6-5e2841c8b0a5', 17, 29, 'short_answer', 'advanced', 'What is 2/3 divided by 4/5? Express as a simplified fraction.', NULL, '5/6', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d91160da-9071-4bd2-be1f-9af5b940baf0', 17, 28, 'explanation', 'foundational', 'Explain what the order of operations (PEMDAS/BODMAS) means and why it is important. Give an example.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3552cf16-4dcd-4e0f-9963-e4069f71becf', 17, 29, 'explanation', 'applied', 'Why do we need a common denominator to add or subtract fractions? Explain with an example.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('882840db-65a3-4e6b-b333-dcae3ab3d936', 17, 31, 'multiple_choice', 'advanced', 'A store offers 20% off a $75 item, then an additional 10% off the reduced price. What is the final price?', '[{"text": "$50.00", "label": "A"}, {"text": "$52.50", "label": "B"}, {"text": "$54.00", "label": "C"}, {"text": "$55.00", "label": "D"}]', '$54.00', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4af45645-8b90-4f70-bae4-eacca8fbdb34', 18, 34, 'multiple_choice', 'foundational', 'What is the value of x if 2x + 5 = 13?', '[{"text": "3", "label": "A"}, {"text": "4", "label": "B"}, {"text": "6", "label": "C"}, {"text": "9", "label": "D"}]', '4', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('890a281d-d254-4826-85d1-4fdb9b8c8cf5', 18, 32, 'multiple_choice', 'foundational', 'Which expression means "5 more than twice a number n"?', '[{"text": "5n + 2", "label": "A"}, {"text": "2n + 5", "label": "B"}, {"text": "2(n + 5)", "label": "C"}, {"text": "n + 10", "label": "D"}]', '2n + 5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('396aa99d-1f33-47d8-8899-20f436f08cff', 18, 33, 'multiple_choice', 'applied', 'Simplify: 3(x + 2) - x', '[{"text": "2x + 6", "label": "A"}, {"text": "3x + 6", "label": "B"}, {"text": "2x + 2", "label": "C"}, {"text": "4x + 6", "label": "D"}]', '2x + 6', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('13495b01-a9a9-4c12-b1cb-b8c31eb6fff9', 18, 34, 'multiple_choice', 'applied', 'Solve for x: 3x - 7 = 2x + 5', '[{"text": "x = 2", "label": "A"}, {"text": "x = 10", "label": "B"}, {"text": "x = 12", "label": "C"}, {"text": "x = -12", "label": "D"}]', 'x = 12', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7de295bc-256d-4a84-acbf-a3d192c33594', 18, 33, 'short_answer', 'foundational', 'Simplify: 4a + 3a - 2a', NULL, '5a', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77d12e41-51e5-43c0-b911-c393539d5c6a', 18, 34, 'short_answer', 'applied', 'Solve for x: 5(x - 3) = 2x + 9. Show your steps and give the final value of x.', NULL, 'x = 8', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('beaeb1f9-d5ab-4718-9c95-44cec4c10b57', 18, 34, 'short_answer', 'advanced', 'Solve for x: 2(x + 3) = 3(x - 1) + 5. What is x?', NULL, 'x = 4', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b2a0b07e-8ea4-4db0-a16f-655cee34abfe', 18, 32, 'explanation', 'foundational', 'What is a variable in algebra? What does it represent, and how is it different from a constant?', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ea0d44b3-0698-4d5e-a7a2-35d168739941', 18, 32, 'explanation', 'applied', 'Explain the difference between an algebraic expression and an equation. Provide one example of each.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9cd30514-87a5-4f4e-aeff-973cb2e7b79a', 18, 35, 'multiple_choice', 'advanced', 'For what value of k does 2x + k = 3x - 5 have the solution x = 7?', '[{"text": "k = -2", "label": "A"}, {"text": "k = 2", "label": "B"}, {"text": "k = 12", "label": "C"}, {"text": "k = -12", "label": "D"}]', 'k = 2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('66bda644-c67d-4567-a34e-da37ac8fae0b', 19, 36, 'multiple_choice', 'foundational', 'What is the slope of the line y = 3x + 2?', '[{"text": "2", "label": "A"}, {"text": "3", "label": "B"}, {"text": "5", "label": "C"}, {"text": "1/3", "label": "D"}]', '3', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('76da9278-fc9e-43aa-9030-b5db2b775536', 19, 37, 'multiple_choice', 'foundational', 'What is the y-intercept of the line y = -2x + 7?', '[{"text": "-2", "label": "A"}, {"text": "7", "label": "B"}, {"text": "5", "label": "C"}, {"text": "-7", "label": "D"}]', '7', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5b97ea4e-8452-4901-962b-089def38058d', 19, 36, 'multiple_choice', 'applied', 'What is the slope of the line passing through the points (1, 3) and (4, 9)?', '[{"text": "1", "label": "A"}, {"text": "2", "label": "B"}, {"text": "3", "label": "C"}, {"text": "6", "label": "D"}]', '2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('99cab2fd-824d-4471-9844-5f9c99b0a185', 19, 39, 'multiple_choice', 'applied', 'Solve the system: x + y = 10 and x - y = 4. What is the value of x?', '[{"text": "3", "label": "A"}, {"text": "5", "label": "B"}, {"text": "7", "label": "C"}, {"text": "8", "label": "D"}]', '7', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5a0cab16-b3df-41fb-982e-1173ed574d7c', 19, 36, 'short_answer', 'foundational', 'Write the equation of a line in slope-intercept form with slope 5 and y-intercept -3.', NULL, 'y = 5x - 3', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c8147f33-5b39-4dcc-b01b-060f36707d7e', 19, 37, 'short_answer', 'applied', 'What is the x-intercept of the line y = 2x - 8?', NULL, '4', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3f63763f-9e63-49f1-b00c-35d89ee66179', 19, 39, 'short_answer', 'advanced', 'Solve the system: 3x + 2y = 16 and x - y = 2. Give your answer as (x, y).', NULL, '(4, 2)', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1cd2f743-39b1-49b8-bbaf-33a7f9a21d82', 19, 36, 'explanation', 'foundational', 'What does the slope of a line represent geometrically? Explain positive, negative, zero, and undefined slope.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b6fcd976-d914-4b7d-9206-d133e2b7f341', 19, 39, 'explanation', 'applied', 'Explain what it means when two lines are parallel vs perpendicular in terms of their slopes.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4e2ef48a-e350-4331-baef-1ee3e5b812bd', 19, 36, 'multiple_choice', 'advanced', 'Which equation represents a line perpendicular to y = (2/3)x + 1?', '[{"text": "y = (2/3)x + 4", "label": "A"}, {"text": "y = (3/2)x + 4", "label": "B"}, {"text": "y = (-3/2)x + 4", "label": "C"}, {"text": "y = (-2/3)x + 4", "label": "D"}]', 'y = (-3/2)x + 4', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('356299c0-f108-4666-b2a9-6fc586c9f066', 20, 40, 'multiple_choice', 'foundational', 'What is x³ × x⁴?', '[{"text": "x⁷", "label": "A"}, {"text": "x¹²", "label": "B"}, {"text": "x⁴", "label": "C"}, {"text": "2x⁷", "label": "D"}]', 'x⁷', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a17e4524-8e33-4908-a16e-c8cfc7d71301', 20, 41, 'multiple_choice', 'foundational', 'What is the degree of the polynomial 3x⁴ - 2x² + 7?', '[{"text": "2", "label": "A"}, {"text": "3", "label": "B"}, {"text": "4", "label": "C"}, {"text": "7", "label": "D"}]', '4', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5edc07ea-b4fa-4a51-9fee-12d538b69645', 20, 42, 'multiple_choice', 'applied', 'Which is the factored form of x² - 9?', '[{"text": "(x - 3)²", "label": "A"}, {"text": "(x + 3)(x - 3)", "label": "B"}, {"text": "(x + 9)(x - 1)", "label": "C"}, {"text": "(x - 9)(x + 1)", "label": "D"}]', '(x + 3)(x - 3)', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d2c20093-47f7-4d33-a3f2-4efc28eab0c4', 20, 41, 'multiple_choice', 'applied', 'Expand: (x + 3)(x - 2)', '[{"text": "x² + x - 6", "label": "A"}, {"text": "x² + 5x - 6", "label": "B"}, {"text": "x² - x - 6", "label": "C"}, {"text": "x² + x + 6", "label": "D"}]', 'x² + x - 6', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ef8ec60b-6d2c-48a4-8c80-f2d9998f98b2', 20, 40, 'short_answer', 'foundational', 'Simplify: (2x³)²', NULL, '4x⁶', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('873efef3-8b5f-4ddc-9b07-4f16bb64f48b', 20, 42, 'short_answer', 'applied', 'Factor completely: 2x² + 7x + 3', NULL, '(2x + 1)(x + 3)', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('16a0a433-cb75-4f19-84d8-bc06d8a3f131', 20, 43, 'short_answer', 'advanced', 'Factor completely: x⁴ - 16', NULL, '(x² + 4)(x + 2)(x - 2)', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ac056b60-c27f-4487-be1c-08c68b5d22e0', 20, 40, 'explanation', 'foundational', 'State the zero exponent rule and explain why a⁰ = 1 for any nonzero value of a.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7bc87e1f-1d77-4f1b-9e89-dc440e393b4d', 20, 42, 'explanation', 'applied', 'Explain the steps you would use to factor the trinomial 3x² + 10x + 8. Show your reasoning.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0de4ff89-a300-4a40-9c26-a606016e65b0', 20, 43, 'multiple_choice', 'advanced', 'Which is the factored form of 4x² - 12x + 9?', '[{"text": "(2x - 3)(2x + 3)", "label": "A"}, {"text": "(2x - 3)²", "label": "B"}, {"text": "(2x + 3)²", "label": "C"}, {"text": "(4x - 3)²", "label": "D"}]', '(2x - 3)²', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ce1bc114-9c07-473f-acb2-bf1b659df8f1', 21, 45, 'multiple_choice', 'foundational', 'What are the solutions of x² - 5x + 6 = 0?', '[{"text": "x = 1 and x = 6", "label": "A"}, {"text": "x = 2 and x = 3", "label": "B"}, {"text": "x = -2 and x = -3", "label": "C"}, {"text": "x = -1 and x = 6", "label": "D"}]', 'x = 2 and x = 3', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('87a72327-3824-4fdb-a683-1c78d0554e2c', 21, 44, 'multiple_choice', 'foundational', 'In the equation y = ax² + bx + c, what shape does the graph form?', '[{"text": "Line", "label": "A"}, {"text": "Circle", "label": "B"}, {"text": "Parabola", "label": "C"}, {"text": "Hyperbola", "label": "D"}]', 'Parabola', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c634e187-c6df-4bfb-9bb8-88cab44a17f9', 21, 44, 'multiple_choice', 'applied', 'What is the vertex of the parabola y = (x - 3)² + 2?', '[{"text": "(-3, 2)", "label": "A"}, {"text": "(3, -2)", "label": "B"}, {"text": "(3, 2)", "label": "C"}, {"text": "(-3, -2)", "label": "D"}]', '(3, 2)', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('40e1f305-7da4-4bd8-9895-0b9eddabd79d', 21, 45, 'multiple_choice', 'applied', 'Solve by factoring: x² - 4x - 5 = 0', '[{"text": "x = 1 and x = -5", "label": "A"}, {"text": "x = -1 and x = 5", "label": "B"}, {"text": "x = 1 and x = 5", "label": "C"}, {"text": "x = -1 and x = -5", "label": "D"}]', 'x = -1 and x = 5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dc3bedde-a8c4-47f0-bff6-948f14dfd0ff', 21, 47, 'short_answer', 'foundational', 'What is the value of the discriminant for x² + 4x + 4 = 0?', NULL, '0', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('aed4af8f-153a-42c7-83c8-b4e70729f156', 21, 46, 'short_answer', 'applied', 'Use the quadratic formula to solve 2x² + 3x - 2 = 0. Give both solutions.', NULL, 'x = 1/2 and x = -2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('13f3c573-c72e-4780-aa19-165590cacc29', 21, 47, 'short_answer', 'advanced', 'For what values of k does x² + kx + 9 = 0 have exactly one real solution?', NULL, 'k = 6 or k = -6', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('284d2050-c547-4411-85d8-5bbda39dd17a', 21, 44, 'explanation', 'foundational', 'Explain what the vertex of a parabola represents. How does the value of a determine if the vertex is a maximum or minimum?', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('69e8b811-bbba-41ba-bb63-43636ebf88c8', 21, 47, 'explanation', 'applied', 'Under what conditions does a quadratic have two distinct real solutions, one real solution, or no real solutions? Relate to the discriminant.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f16801d3-e6af-45ba-a528-18f8a059f547', 21, 47, 'multiple_choice', 'advanced', 'The discriminant of a quadratic equation is -4. How many real solutions does it have?', '[{"text": "0", "label": "A"}, {"text": "1", "label": "B"}, {"text": "2", "label": "C"}, {"text": "Cannot be determined", "label": "D"}]', '0', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('18924bef-e4ad-4ac8-bee7-5916475da690', 22, 48, 'multiple_choice', 'foundational', 'If f(x) = 2x + 3, what is f(5)?', '[{"text": "10", "label": "A"}, {"text": "13", "label": "B"}, {"text": "15", "label": "C"}, {"text": "7", "label": "D"}]', '13', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ac15bd56-f9fe-4863-bf7f-3bd717cd4336', 22, 48, 'multiple_choice', 'foundational', 'Which of the following relations is NOT a function?', '[{"text": "{(1,2), (2,3), (3,4)}", "label": "A"}, {"text": "{(1,2), (1,3), (2,4)}", "label": "B"}, {"text": "{(0,1), (2,1), (4,1)}", "label": "C"}, {"text": "{(5,6), (7,8), (9,10)}", "label": "D"}]', '{(1,2), (1,3), (2,4)}', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6761875d-099a-47cb-859a-7962130077f0', 22, 49, 'multiple_choice', 'applied', 'What is the domain of f(x) = sqrt(x - 2)?', '[{"text": "All real numbers", "label": "A"}, {"text": "x > 2", "label": "B"}, {"text": "x >= 2", "label": "C"}, {"text": "x >= 0", "label": "D"}]', 'x >= 2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a75a4272-ecae-4065-a664-a1a772e5c724', 22, 50, 'multiple_choice', 'applied', 'If g(x) = x², what is g(x + 1)?', '[{"text": "x² + 1", "label": "A"}, {"text": "x² + 2x + 1", "label": "B"}, {"text": "(x + 1)² + 1", "label": "C"}, {"text": "x² + x + 1", "label": "D"}]', 'x² + 2x + 1', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ae83ce57-4c91-4e4b-b5d0-2105590051d5', 22, 48, 'short_answer', 'foundational', 'If f(x) = 3x - 1, find f(0) + f(2).', NULL, '5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9b4f47d6-06f8-4e57-a1bf-edb0d1ed1644', 22, 49, 'short_answer', 'applied', 'What is the range of f(x) = x² + 1? Express using inequality notation.', NULL, 'y >= 1', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e592c1b8-4d04-4488-8a6c-8cb23d235332', 22, 51, 'short_answer', 'advanced', 'If f(x) = 2x + 1, find the inverse function f-inverse(x).', NULL, 'f-inverse(x) = (x - 1)/2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2d5a6fb8-d9ad-4288-8c4b-e197a1f40538', 22, 48, 'explanation', 'foundational', 'Explain the difference between a relation and a function. Use the vertical line test in your explanation.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3eb9415d-ac33-40bc-b8cd-a4e917162b1c', 22, 50, 'explanation', 'applied', 'Describe how the graph of y = f(x) changes when replaced by y = f(x - 2) + 3. What do the -2 and +3 each do?', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2e4c604c-4b58-4cd7-a577-d4df864540d2', 22, 48, 'multiple_choice', 'advanced', 'If f(x) = 2x - 1, what is f(f(3))?', '[{"text": "5", "label": "A"}, {"text": "7", "label": "B"}, {"text": "9", "label": "C"}, {"text": "11", "label": "D"}]', '9', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a5ff1c34-887f-454f-9aa2-01b6988ae0d2', 23, 53, 'multiple_choice', 'foundational', 'What is the sum of the interior angles of a triangle?', '[{"text": "90 degrees", "label": "A"}, {"text": "180 degrees", "label": "B"}, {"text": "270 degrees", "label": "C"}, {"text": "360 degrees", "label": "D"}]', '180 degrees', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('36caae7e-96c3-4f98-9e59-a16bd2ec5eb3', 23, 53, 'multiple_choice', 'foundational', 'In a right triangle with legs of length 3 and 4, what is the hypotenuse?', '[{"text": "6", "label": "A"}, {"text": "7", "label": "B"}, {"text": "5", "label": "C"}, {"text": "25", "label": "D"}]', '5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4d7e4512-1cf2-4b76-8141-fd09e5336996', 23, 54, 'multiple_choice', 'applied', 'What is the value of sin(30 degrees)?', '[{"text": "sqrt(3)/2", "label": "A"}, {"text": "1/2", "label": "B"}, {"text": "sqrt(2)/2", "label": "C"}, {"text": "1", "label": "D"}]', '1/2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('96d90b01-8353-49aa-bf47-113ac4a199d1', 23, 52, 'multiple_choice', 'applied', 'A triangle has angles measuring 50 degrees and 70 degrees. What is the third angle?', '[{"text": "50 degrees", "label": "A"}, {"text": "55 degrees", "label": "B"}, {"text": "60 degrees", "label": "C"}, {"text": "65 degrees", "label": "D"}]', '60 degrees', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('09d95cca-9835-46f0-ba6d-5619e551ec9f', 23, 54, 'short_answer', 'foundational', 'What is the value of cos(60 degrees)?', NULL, '1/2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8b735fed-e893-4817-8388-9366b0e5bfd6', 23, 53, 'short_answer', 'applied', 'A right triangle has a hypotenuse of length 13 and one leg of length 5. What is the other leg?', NULL, '12', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('db0c1139-cacb-48bc-9a4e-712e2d6f8cc4', 23, 54, 'short_answer', 'advanced', 'In a right triangle, if tan(theta) = 3/4 and the hypotenuse is 10, what is sin(theta)?', NULL, '3/5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('317be50f-f6c9-4c11-a5ac-aa1659d0b8b7', 23, 53, 'explanation', 'foundational', 'State the Pythagorean theorem and provide a real-world example where you would use it.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1491c883-7298-400d-b654-a4a6c61d59bc', 23, 54, 'explanation', 'applied', 'What is the relationship between the sine and cosine of complementary angles? Explain why sin(theta) = cos(90 - theta).', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('04341b23-edf8-4c77-ab0f-89478283661f', 23, 55, 'multiple_choice', 'advanced', 'What is the area of a triangle with vertices at (0,0), (6,0), and (3,4)?', '[{"text": "6", "label": "A"}, {"text": "10", "label": "B"}, {"text": "12", "label": "C"}, {"text": "24", "label": "D"}]', '12', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('66ff1534-44bd-48db-9f00-76544a1c4abc', 24, 56, 'multiple_choice', 'foundational', 'What is the mean of the data set {4, 8, 6, 10, 12}?', '[{"text": "6", "label": "A"}, {"text": "8", "label": "B"}, {"text": "10", "label": "C"}, {"text": "40", "label": "D"}]', '8', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bdc4021f-020c-4d38-b5c5-4a32d0113079', 24, 56, 'multiple_choice', 'foundational', 'In the ordered data set {3, 5, 5, 7, 9}, what is the median?', '[{"text": "3", "label": "A"}, {"text": "5", "label": "B"}, {"text": "7", "label": "C"}, {"text": "9", "label": "D"}]', '5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('aa1f3180-8d36-4804-8f4d-2187f38a23ab', 24, 56, 'multiple_choice', 'applied', 'What is the mode of {2, 3, 3, 4, 5, 5, 5}?', '[{"text": "2", "label": "A"}, {"text": "3", "label": "B"}, {"text": "4", "label": "C"}, {"text": "5", "label": "D"}]', '5', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d8baa24e-a94e-4108-8f3d-80432acbe5c2', 24, 58, 'multiple_choice', 'applied', 'A fair six-sided die is rolled. What is the probability of rolling an even number?', '[{"text": "1/3", "label": "A"}, {"text": "1/2", "label": "B"}, {"text": "2/3", "label": "C"}, {"text": "1/6", "label": "D"}]', '1/2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('80e82bac-70ae-4669-b334-17baee872a55', 24, 56, 'short_answer', 'foundational', 'Find the mean of the data set {15, 20, 25, 30, 40}.', NULL, '26', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f106d906-4c05-4861-a7e7-26bc2a78bb37', 24, 57, 'short_answer', 'applied', 'The data set {12, 15, 18, 18, 21, 25, 30} has min 12 and max 30. What is the range?', NULL, '18', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('08ff64e4-acda-45ec-80fd-f2eb1680113b', 24, 59, 'short_answer', 'advanced', 'Two fair six-sided dice are rolled. What is the probability that the sum equals 7? Express as a simplified fraction.', NULL, '1/6', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8afdd3be-f9b9-4b30-8aee-ec52e4613406', 24, 56, 'explanation', 'foundational', 'Explain the difference between mean, median, and mode. Give an example where all three are the same and one where they differ.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0a3a27af-40ba-48ae-8678-958f21cd08c5', 24, 56, 'explanation', 'applied', 'In what situation would the median be a better measure of central tendency than the mean? Use an example with skewed data.', NULL, NULL, NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('be2e1fa1-ddd3-43b2-b40a-ea4b104521a5', 24, 59, 'multiple_choice', 'advanced', 'If P(A) = 0.4, P(B) = 0.5, and A and B are independent, what is P(A and B)?', '[{"text": "0.1", "label": "A"}, {"text": "0.2", "label": "B"}, {"text": "0.45", "label": "C"}, {"text": "0.9", "label": "D"}]', '0.2', NULL, '2026-06-01 21:36:19.880322+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('31b7cc6a-dd08-4270-a756-0ad56f8d407d', 75, 143, 'multiple_choice', 'foundational', 'Which Python operator is used for multiplication?', '[{"text": "+", "label": "A"}, {"text": "-", "label": "B"}, {"text": "*", "label": "C"}, {"text": "/", "label": "D"}]', '*', NULL, '2026-06-06 14:54:42.8503+00', 0.58082867, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('470dabe4-c7a0-4264-81df-7b0a5c41914e', 75, 143, 'short_answer', 'applied', 'What is the result of the Python expression `(15 - 3) / 2 + 5 * 2`?', NULL, '16.0', NULL, '2026-06-06 14:54:42.8503+00', 0.48897833, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5ccd9a92-48b0-48e1-a843-889cf93933a6', 75, 143, 'coding', 'applied', 'You have bought 5 pens at $1.20 each and 3 notebooks at $2.50 each. Calculate the total cost of your purchase and print it. Store the price of a pen in `pen_price` and the price of a notebook in `notebook_price`.', NULL, NULL, '[{"input": "", "expected_output": "13.5"}]', '2026-06-06 14:54:42.8503+00', 0.41262093, 'pen_price = 1.20
notebook_price = 2.50

# Calculate the total cost here
# total_cost = ...

# Print the total cost
# print(total_cost)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3604d845-b846-4a77-a897-7d9a14357639', 75, 144, 'multiple_choice', 'foundational', 'What is the result of the expression `25 // 4`?', '[{"text": "6.25", "label": "A"}, {"text": "6", "label": "B"}, {"text": "1", "label": "C"}, {"text": "25", "label": "D"}]', '6', NULL, '2026-06-06 14:54:42.8503+00', 0.4837031, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b55c40eb-cba9-4f84-aedc-154cbc4ba153', 75, 144, 'short_answer', 'applied', 'You have 37 cookies and want to distribute them equally among 5 friends. After giving each friend as many whole cookies as possible, how many cookies will be left over?', NULL, '2', NULL, '2026-06-06 14:54:42.8503+00', 0.21829917, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e0b32ef1-9a9d-4e5a-8527-0b8e9db3c4ab', 75, 144, 'coding', 'applied', 'Write a Python program that calculates and prints the integer division result and the remainder when 98 is divided by 7. Print each result on a new line.', NULL, NULL, '[{"input": "", "expected_output": "14\n0"}]', '2026-06-06 14:54:42.8503+00', 0.44442958, '# Calculate integer division result
# TODO: Assign the result of 98 // 7 to a variable and print it.

# Calculate remainder
# TODO: Assign the result of 98 % 7 to a variable and print it.');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4fa2aa79-6b45-4941-a8f5-c2adb6ae25f2', 75, 144, 'explanation', 'advanced', 'Explain the difference in behavior between standard division (`/`), integer division (`//`), and the modulo operator (`%`) when operating on both positive and negative numbers. Provide an example for each demonstrating their distinct results, especially concerning negative numbers.', NULL, 'Standard division (`/`) performs floating-point division, always returning a float. For example, `7 / 2` is `3.5` and `-7 / 2` is `-3.5`. 

Integer division (`//`) performs division and then ''floors'' the result, meaning it rounds down to the nearest whole integer. For positive numbers, this effectively truncates the decimal part (e.g., `7 // 2` is `3`). For negative numbers, it can be surprising: `-7 // 2` is `-4` (because -3.5 floored is -4), not -3.

The modulo operator (`%`) returns the remainder of the division. The sign of the result is always the same as the divisor. For example, `7 % 2` is `1` (because `7 = 3 * 2 + 1`). For negative numbers, `7 % -2` is `-1` and `-7 % 2` is `1`. This is because the relationship `a == (a // b) * b + (a % b)` must hold true. Since `-7 // 2` is `-4`, we have `-7 = (-4 * 2) + 1`, so `-7 % 2` is `1`.', NULL, '2026-06-06 14:54:42.8503+00', 0.86906785, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7ca2beb0-1b53-4693-aeff-6c596c808e1a', 75, 145, 'multiple_choice', 'foundational', 'What is the correct order of operations for the expression `3 + 4 * 2` in Python?', '[{"text": "Addition then Multiplication", "label": "A"}, {"text": "Multiplication then Addition", "label": "B"}, {"text": "Operations are performed from left to right, regardless of type", "label": "C"}, {"text": "The order depends on the specific Python version", "label": "D"}]', 'Multiplication then Addition', NULL, '2026-06-06 14:54:42.8503+00', 0.5779249, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e39ff237-624f-436f-ba68-43af001602e1', 50, 107, 'short_answer', 'applied', 'What specific Python feature should be used to make a list of the multiples of 3, from 3 to 30, and then print each number using a loop?', NULL, 'range() with a step argument and a for loop', NULL, '2026-06-04 16:12:21.264161+00', 0.59537154, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7358cae7-c4de-4b84-99a8-a00285259153', 52, 109, 'multiple_choice', 'foundational', 'How are key-value pairs separated within a dictionary in Python?', '[{"text": "By semicolons (;)", "label": "A"}, {"text": "By colons (:)", "label": "B"}, {"text": "By commas (,)", "label": "C"}, {"text": "By spaces ( )", "label": "D"}]', 'By commas (,)', NULL, '2026-06-04 16:12:30.200638+00', 0.6676414, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d2e347dd-2799-4e14-83c6-5e7c34379cc1', 52, 109, 'short_answer', 'applied', 'What is the output of the following code? `alien_0 = {''color'': ''green'', ''points'': 5}; new_points = alien_0[''points'']; print(f"You just earned {new_points} points!")`', NULL, 'You just earned 5 points!', NULL, '2026-06-04 16:12:30.324391+00', 0.682871, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9930bba9-e625-4c5d-89e3-5ec73d603815', 52, 109, 'multiple_choice', 'foundational', 'Which of the following can be a value in a Python dictionary?', '[{"text": "Only strings and numbers", "label": "A"}, {"text": "Only lists and other dictionaries", "label": "B"}, {"text": "Any object that you can create in Python", "label": "C"}, {"text": "Only integers", "label": "D"}]', 'Any object that you can create in Python', NULL, '2026-06-04 16:12:30.374586+00', 0.67183954, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2f64f289-b036-4675-9b3f-faf905a61a00', 52, 109, 'explanation', 'advanced', 'Explain how the `sorted()` function can be used with a dictionary''s keys() method to control the order of iteration, and provide an example of when this would be useful.', NULL, 'The `sorted()` function can be wrapped around `dictionary.keys()` (e.g., `for name in sorted(favorite_languages.keys()):`). This tells Python to get all the keys from the dictionary, sort them alphabetically (or numerically, depending on key type), and then iterate through the sorted keys. This is useful when you need to process or display information from a dictionary in a specific order, such as printing names in alphabetical order, rather than the order they were inserted into the dictionary.', NULL, '2026-06-04 16:12:30.501366+00', 0.66806096, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('861aaaa2-6fa4-4dc7-b49b-95ff8b584270', 52, 109, 'short_answer', 'applied', 'What is the primary purpose of using `dictionary.keys()` explicitly in a `for` loop if the loop would have the same output without it?', NULL, 'To make the code easier to read.', NULL, '2026-06-04 16:12:30.557515+00', 0.6410574, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8f70a9d0-2454-4640-a68e-55b4ccea1add', 54, 111, 'multiple_choice', 'foundational', 'What keyword is used to inform Python that you are defining a function?', '[{"text": "function", "label": "A"}, {"text": "define", "label": "B"}, {"text": "def", "label": "C"}, {"text": "create", "label": "D"}]', 'def', NULL, '2026-06-04 16:12:41.860803+00', 0.6872608, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c0ea1675-1d28-4b23-9f8c-ae07273a9049', 54, 111, 'short_answer', 'foundational', 'What is the term for a comment describing what a function does, typically enclosed in triple quotes?', NULL, 'docstring', NULL, '2026-06-04 16:12:41.981851+00', 0.40746891, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('99d951f7-8f92-421e-a437-ac814d04a1f6', 54, 111, 'multiple_choice', 'applied', 'What happens when you pass a list to a function and the function modifies that list?', '[{"text": "A copy of the list is modified, leaving the original unchanged.", "label": "A"}, {"text": "The function receives direct access to the list''s contents, and any changes made inside the function are permanent.", "label": "B"}, {"text": "The function can only read the list''s contents, not modify them.", "label": "C"}, {"text": "Python creates a new list with the modifications and returns it.", "label": "D"}]', 'The function receives direct access to the list''s contents, and any changes made inside the function are permanent.', NULL, '2026-06-04 16:12:42.035986+00', 0.47114074, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('572c0543-358e-45fd-9808-4fea3d6b9016', 54, 111, 'explanation', 'advanced', 'Explain two benefits of using functions in programming, as described in the lesson content.', NULL, 'A strong answer should mention: 1) Functions allow you to write code once and reuse it multiple times with a simple one-line call, making code more efficient. 2) Functions make programs easier to read by summarizing parts of the program, and easier to test/debug because each function has a specific job and can be tested individually.', NULL, '2026-06-04 16:12:42.105687+00', 0.7684381, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f94b4cac-0130-4a0f-b0fa-14ea01396867', 54, 111, 'multiple_choice', 'applied', 'Given the function definition `def greet_user(username):`, what would `username` be called in the context of this definition?', '[{"text": "an argument", "label": "A"}, {"text": "a parameter", "label": "B"}, {"text": "a variable call", "label": "C"}, {"text": "a function attribute", "label": "D"}]', 'a parameter', NULL, '2026-06-04 16:12:42.162805+00', 0.7016357, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9b325094-5f6a-4bb1-8e6f-e198625d1e0d', 56, 113, 'multiple_choice', 'foundational', 'What is the primary purpose of the `pathlib` module in Python when working with files?', '[{"text": "To perform complex mathematical calculations on file data.", "label": "A"}, {"text": "To encrypt and decrypt file contents for security.", "label": "B"}, {"text": "To make it easier to work with files and directories across different operating systems.", "label": "C"}, {"text": "To compress and decompress large files efficiently.", "label": "D"}]', 'To make it easier to work with files and directories across different operating systems.', NULL, '2026-06-04 16:12:53.52823+00', 0.57512146, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4e1a9149-bc89-4cc4-9996-4a38c89cb256', 56, 113, 'short_answer', 'applied', 'If you are trying to read a file named `my_data.txt` that does not exist in the same directory as your Python script, what specific exception will Python typically raise?', NULL, 'FileNotFoundError', NULL, '2026-06-04 16:12:53.62315+00', 0.66613764, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b7d5e7ca-663b-4ea9-9c02-ac4bd5a9109f', 56, 113, 'multiple_choice', 'foundational', 'When handling an exception using a `try-except` block, what part of the traceback is often the most important to look at first to identify the type of exception?', '[{"text": "The very beginning of the traceback, showing the file where the program started.", "label": "A"}, {"text": "The line of code that caused the error, indicated by `^^^^^^^`.", "label": "B"}, {"text": "The last line of the traceback, which states the type of exception raised.", "label": "C"}, {"text": "The lines showing code from libraries involved in the operation.", "label": "D"}]', 'The last line of the traceback, which states the type of exception raised.', NULL, '2026-06-04 16:12:53.67164+00', 0.51487255, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('771d3486-bddb-4ac0-9413-ef097edc3cd4', 56, 113, 'explanation', 'advanced', 'Explain why using an `encoding` argument with `read_text()` might be necessary, particularly when working with files not created on your current system.', NULL, 'The `encoding` argument for `read_text()` is necessary when the system''s default encoding does not match the encoding of the file being read. This mismatch is most likely to occur when a file was created on a different system with a different default text encoding, causing Python to misinterpret the file''s characters without the correct `encoding` specified.', NULL, '2026-06-04 16:12:53.74255+00', 0.5882509, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3f677a7d-5a12-4379-948e-94ceb1f7c1d4', 56, 113, 'short_answer', 'applied', 'After creating a `Path` object to represent a file, what method would you typically use to read the entire contents of that file into memory?', NULL, 'read_text()', NULL, '2026-06-04 16:12:53.781117+00', 0.59811944, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5b77636f-cb8a-464d-9df1-2538bd8c87ea', 66, 123, 'multiple_choice', 'foundational', 'What is the primary reason the lesson states styling was ignored until after functionality was implemented?', '[{"text": "Styling is less important than functionality.", "label": "A"}, {"text": "An app is only useful if it works.", "label": "B"}, {"text": "It''s easier to style a working app.", "label": "C"}, {"text": "Appearance is not critical for an app''s initial development.", "label": "D"}]', 'An app is only useful if it works.', NULL, '2026-06-04 16:13:49.300788+00', 0.24349669, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d3d6d61e-b6dd-4148-b5ae-b3a70ad82ed6', 75, 145, 'short_answer', 'applied', 'What is the result of the Python expression `10 / 2 ** 2 + 1`?', NULL, '3.5', NULL, '2026-06-06 14:54:42.8503+00', 0.4909634, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b9133cbe-cc7f-4b0f-b9c1-e5773272116d', 75, 145, 'coding', 'applied', 'The formula for the area of a trapezoid is `A = 0.5 * (a + b) * h`, where `a` and `b` are the lengths of the parallel sides, and `h` is the height. Calculate the area of a trapezoid with parallel sides of length `7` and `13`, and a height of `5`. Use parentheses to ensure correct operator precedence in your calculation. Print the final area.', NULL, NULL, '[{"input": "", "expected_output": "50.0"}]', '2026-06-06 14:54:42.8503+00', 0.19939405, '# Assign the values for a, b, and h
a = 7
b = 13
h = 5

# Calculate the area using the formula and print the result
# TODO: Write your calculation here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d0004670-6144-4790-a269-97ed404ea27a', 75, 145, 'explanation', 'advanced', 'Explain why `2 ** 2 ** 3` evaluates to `256` and not `64`. Which rule of operator precedence is at play here?', NULL, 'The expression `2 ** 2 ** 3` evaluates to `256` because the exponentiation operator `**` has right-to-left associativity. This means that when multiple exponentiation operators appear consecutively, they are evaluated from right to left. So, `2 ** 2 ** 3` is interpreted as `2 ** (2 ** 3)`. First, `2 ** 3` is calculated, which is `8`. Then, `2 ** 8` is calculated, which is `256`. If it were evaluated from left-to-right (like most other operators of the same precedence), it would be `(2 ** 2) ** 3`, which is `4 ** 3`, resulting in `64`.', NULL, '2026-06-06 14:54:42.8503+00', 0.7969575, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a283730f-332f-4f04-b74a-a5a163620830', 75, 146, 'multiple_choice', 'foundational', 'Which of the following Python numeric literals is an integer?', '[{"text": "3.14", "label": "A"}, {"text": "10.0", "label": "B"}, {"text": "-7", "label": "C"}, {"text": "0.5", "label": "D"}]', '-7', NULL, '2026-06-06 14:54:42.8503+00', 0.47751686, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('56ed0747-5330-4769-90c8-f0d093ec7aa5', 75, 146, 'short_answer', 'applied', 'What is the result of `int(15.99)`? Briefly explain why.', NULL, 'The result is `15`. The `int()` function truncates (cuts off) the decimal part of a float, it does not round.', NULL, '2026-06-06 14:54:42.8503+00', 0.4915438, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1392bd32-7ded-4635-9ee3-5a7a3845eb53', 75, 146, 'coding', 'applied', 'Declare a variable `integer_value` and assign it the integer `42`. Declare another variable `float_value` and assign it the float `123.45`. Then, print the type of each variable on a new line.', NULL, NULL, '[{"input": "", "expected_output": "<class ''int''>\n<class ''float''>"}]', '2026-06-06 14:54:42.8503+00', 0.6133895, '# Declare integer_value here
# Declare float_value here

# Print the types below
# print(type(integer_value))
# print(type(float_value))');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('096ded06-e533-44de-a14d-ae757a3b6dbe', 75, 147, 'multiple_choice', 'foundational', 'What will be the output of the following Python code?
`print(abs(-15) + round(4.7))`', '[{"text": "19.7", "label": "A"}, {"text": "19", "label": "B"}, {"text": "20", "label": "C"}, {"text": "-10.3", "label": "D"}]', '19', NULL, '2026-06-06 14:54:42.8503+00', 0.47277594, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('25fc14a4-3e1b-4033-87ae-f93b5c95c9db', 75, 147, 'short_answer', 'applied', 'If you have a list of temperatures `[22.5, 18.9, 25.1, 22.5, 23.0]`, what Python expression would you use to find the highest temperature in the list?', NULL, 'max([22.5, 18.9, 25.1, 22.5, 23.0])', NULL, '2026-06-06 14:54:42.8503+00', 0.43562844, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ed5cef3a-b663-43be-b768-69194a5c2efa', 75, 147, 'explanation', 'advanced', 'Explain the behavior of Python''s `round()` function when rounding numbers ending in `.5` (e.g., `2.5` or `3.5`). How does it differ from a common expectation, and why is this behavior sometimes preferred?', NULL, 'Python''s `round()` function uses ''round half to even'' (also known as ''bankers'' rounding). This means if a number is exactly halfway between two integers (e.g., 2.5, 3.5), it rounds to the nearest *even* integer. For example, `round(2.5)` is 2, and `round(3.5)` is 4. This differs from the common expectation of always rounding .5 up. This ''round half to even'' method is often preferred in statistical and financial calculations because it helps to reduce cumulative bias that can occur when consistently rounding .5 up (which would always push values further from zero).', NULL, '2026-06-06 14:54:42.8503+00', 0.45522106, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('677432ee-c3dc-48ce-9d6c-0a0b09efb76c', 75, 147, 'coding', 'applied', 'Given three numeric values, `num1`, `num2`, and `num3`, find the smallest of the three. Then, calculate the absolute difference between this smallest value and the largest of the three initial values. Finally, round this absolute difference to the nearest whole number and print the result.

For example:
If `num1 = 5.3`, `num2 = -2.1`, `num3 = 8.7`:
Smallest is -2.1.
Largest is 8.7.
Absolute difference: `abs(8.7 - (-2.1))` which is `abs(10.8)` or `10.8`.
Rounded result: `round(10.8)` which is `11`.', NULL, NULL, '[{"input": "", "expected_output": "11"}, {"input": "", "expected_output": "25"}]', '2026-06-06 14:54:42.8503+00', 0.6477575, 'num1 = 5.3
num2 = -2.1
num3 = 8.7

# TODO: Find the smallest of the three numbers.
# TODO: Find the largest of the three numbers.
# TODO: Calculate the absolute difference between the largest and smallest.
# TODO: Round the absolute difference to the nearest whole number and print it.
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1e2cec3f-c4f3-49e1-89b1-03d29eb31da5', 82, 178, 'multiple_choice', 'foundational', 'Which of the following is the primary purpose of a ''loop variable'' in a `while` loop?', '[{"text": "To store a constant value that never changes.", "label": "A"}, {"text": "To define the initial state of the loop.", "label": "B"}, {"text": "To control the loop''s execution and ensure its eventual termination.", "label": "C"}, {"text": "To hold the final result after the loop finishes.", "label": "D"}]', 'To control the loop''s execution and ensure its eventual termination.', NULL, '2026-06-06 14:58:57.734578+00', 0.56803674, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8cc0028a-c8ac-4fbe-9ca0-56e932712acf', 40, 88, 'multiple_choice', 'foundational', 'Which is the hex color code for white?', '[{"text": "#FFFFFF", "label": "A"}, {"text": "#000000", "label": "B"}, {"text": "rgb(0,0,0)", "label": "C"}, {"text": "white(255)", "label": "D"}]', '#FFFFFF', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f9152237-be6b-4aa5-9dc5-18fd3478f5dc', 40, 88, 'multiple_choice', 'applied', 'In rgba(0,0,0,0.5), what does the fourth value control?', '[{"text": "brightness", "label": "A"}, {"text": "alpha (opacity)", "label": "B"}, {"text": "hue angle", "label": "C"}, {"text": "saturation", "label": "D"}]', 'alpha (opacity)', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2d63d972-af2b-4ea6-b54c-10f6245059da', 40, 90, 'multiple_choice', 'foundational', 'Which property sets the typeface of text?', '[{"text": "font-style", "label": "A"}, {"text": "font-family", "label": "B"}, {"text": "text-font", "label": "C"}, {"text": "typeface", "label": "D"}]', 'font-family', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e8920978-2e65-48f4-ad6d-b154539ddd86', 40, 89, 'multiple_choice', 'applied', 'Which property sets an image as an element background?', '[{"text": "image", "label": "A"}, {"text": "background-image", "label": "B"}, {"text": "bg-src", "label": "C"}, {"text": "src", "label": "D"}]', 'background-image', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('50e6d67a-6569-42d9-a848-87ba8e140bab', 40, 91, 'short_answer', 'foundational', 'Which CSS property controls the vertical space between lines of text?', NULL, 'line-height', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3222f9ae-1ea9-445a-99a7-340b331dc7f9', 40, 88, 'explanation', 'applied', 'Explain the difference between hex, rgb() and hsl() color notations, and give one situation where hsl() is especially convenient.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('80ccff5d-0340-4c9d-b93f-75bde6046fd8', 41, 92, 'multiple_choice', 'foundational', 'Which declaration turns an element into a flex container?', '[{"text": "display: flexbox", "label": "A"}, {"text": "display: flex", "label": "B"}, {"text": "flex: on", "label": "C"}, {"text": "layout: flex", "label": "D"}]', 'display: flex', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ead4956c-ceac-4fdd-b5dc-61a1e4890bfd', 33, 60, 'multiple_choice', 'foundational', 'What does HTML stand for?', '[{"text": "HyperText Markup Language", "label": "A"}, {"text": "HighText Machine Language", "label": "B"}, {"text": "Hyperlinks and Text Markup Language", "label": "C"}, {"text": "Home Tool Markup Language", "label": "D"}]', 'HyperText Markup Language', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bfdd5b9e-b0c3-4bf9-8dad-e9f3d5f53561', 33, 61, 'multiple_choice', 'foundational', 'Which element contains the visible content of a web page?', '[{"text": "<head>", "label": "A"}, {"text": "<body>", "label": "B"}, {"text": "<title>", "label": "C"}, {"text": "<meta>", "label": "D"}]', '<body>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('763741cd-cd93-4691-b81c-e4f72b5824e2', 33, 61, 'multiple_choice', 'foundational', 'Which line tells the browser the document is HTML5?', '[{"text": "<html5>", "label": "A"}, {"text": "<!DOCTYPE html>", "label": "B"}, {"text": "<doctype html5>", "label": "C"}, {"text": "<meta charset=html>", "label": "D"}]', '<!DOCTYPE html>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9f3541a6-9c31-4cd7-ad3d-d085eb657ca3', 33, 62, 'multiple_choice', 'applied', 'How many levels of section headings does HTML provide?', '[{"text": "3", "label": "A"}, {"text": "5", "label": "B"}, {"text": "6", "label": "C"}, {"text": "10", "label": "D"}]', '6', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d81f109b-c368-4d47-a6c4-a84e3391d0dc', 33, 62, 'short_answer', 'foundational', 'Write the HTML tag for the largest (top-level) heading.', NULL, '<h1>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ae7d434d-8a69-4000-9fd1-1fa8a8f6f6e8', 33, 60, 'explanation', 'foundational', 'Explain the difference between an HTML element, a tag, and an attribute. Give an example of each.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('810b7b36-48af-4fa0-b178-725968946818', 34, 65, 'multiple_choice', 'foundational', 'Which element creates a hyperlink?', '[{"text": "<link>", "label": "A"}, {"text": "<a>", "label": "B"}, {"text": "<href>", "label": "C"}, {"text": "<nav>", "label": "D"}]', '<a>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c5591079-1a7a-440e-b982-9e13b6f4cabe', 34, 66, 'multiple_choice', 'foundational', 'Which attribute specifies the path to an image file?', '[{"text": "href", "label": "A"}, {"text": "src", "label": "B"}, {"text": "link", "label": "C"}, {"text": "path", "label": "D"}]', 'src', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('36c2555a-5055-4c48-a64b-21baa13f5659', 34, 65, 'multiple_choice', 'applied', 'Which attribute makes a link open in a new browser tab?', '[{"text": "rel=\"new\"", "label": "A"}, {"text": "target=\"_blank\"", "label": "B"}, {"text": "open=\"tab\"", "label": "C"}, {"text": "window=\"new\"", "label": "D"}]', 'target="_blank"', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('98a883db-9061-4888-a788-3a2e6705e517', 34, 64, 'short_answer', 'foundational', 'Which tag semantically marks text as strongly important (and renders bold by default)?', NULL, '<strong>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('17a17589-6780-4340-a584-5e4f5b04f06f', 34, 67, 'multiple_choice', 'applied', 'Which of these is an inline element by default?', '[{"text": "<div>", "label": "A"}, {"text": "<p>", "label": "B"}, {"text": "<span>", "label": "C"}, {"text": "<section>", "label": "D"}]', '<span>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0eed8f06-684f-4ad8-a6ed-7f9b377712da', 34, 65, 'explanation', 'applied', 'Explain the difference between an absolute URL and a relative URL in a link href, with an example of each.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('54a12c31-d69c-4099-96c1-e4eecaecca9b', 35, 68, 'multiple_choice', 'foundational', 'Which element creates an unordered (bulleted) list?', '[{"text": "<ol>", "label": "A"}, {"text": "<ul>", "label": "B"}, {"text": "<li>", "label": "C"}, {"text": "<list>", "label": "D"}]', '<ul>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ae58c93e-7a6c-495c-833b-4fbac09b106f', 35, 69, 'multiple_choice', 'foundational', 'Which element defines a row in a table?', '[{"text": "<td>", "label": "A"}, {"text": "<th>", "label": "B"}, {"text": "<tr>", "label": "C"}, {"text": "<row>", "label": "D"}]', '<tr>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('802b6bf0-07b2-46ac-a31f-e00052a380d5', 35, 70, 'multiple_choice', 'applied', 'Which semantic element best wraps the main site navigation links?', '[{"text": "<div>", "label": "A"}, {"text": "<nav>", "label": "B"}, {"text": "<menu>", "label": "C"}, {"text": "<header>", "label": "D"}]', '<nav>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2624c111-de7d-4480-9381-83e22091a57f', 35, 70, 'multiple_choice', 'applied', 'Which element represents a self-contained piece of content such as a blog post?', '[{"text": "<section>", "label": "A"}, {"text": "<article>", "label": "B"}, {"text": "<aside>", "label": "C"}, {"text": "<div>", "label": "D"}]', '<article>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f95f8a33-e718-4835-987e-2b6fd433bf8d', 35, 68, 'short_answer', 'applied', 'Which list element would you use for a numbered, ordered sequence of steps?', NULL, '<ol>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('39a00198-c806-4d4c-b34e-b49fd48571d2', 35, 70, 'explanation', 'applied', 'Why are semantic elements (header, nav, main, article) preferable to using <div> for everything? Give two reasons.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('18fdd8d7-45a3-47a5-9b4c-bc8114d1da83', 36, 72, 'multiple_choice', 'foundational', 'Which <form> attribute sets the URL the data is submitted to?', '[{"text": "method", "label": "A"}, {"text": "action", "label": "B"}, {"text": "src", "label": "C"}, {"text": "target", "label": "D"}]', 'action', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3832478b-41d6-4bc3-898d-5b0defea2df0', 36, 73, 'multiple_choice', 'foundational', 'Which input type masks the characters as they are typed?', '[{"text": "text", "label": "A"}, {"text": "password", "label": "B"}, {"text": "hidden", "label": "C"}, {"text": "number", "label": "D"}]', 'password', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('934414b8-f869-4110-b011-d53ae112b1b7', 36, 73, 'multiple_choice', 'applied', 'Which input type lets the user choose only ONE option from a group?', '[{"text": "checkbox", "label": "A"}, {"text": "radio", "label": "B"}, {"text": "select", "label": "C"}, {"text": "toggle", "label": "D"}]', 'radio', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9170168a-cee9-4812-bbe5-e4ce62005049', 36, 72, 'multiple_choice', 'applied', 'Which method should a login form use so the password is not exposed in the URL?', '[{"text": "GET", "label": "A"}, {"text": "POST", "label": "B"}, {"text": "SEND", "label": "C"}, {"text": "PUT", "label": "D"}]', 'POST', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bbf46e2c-4172-4ef5-be7b-771d4473f829', 36, 75, 'short_answer', 'applied', 'Which element creates a multi-line text input box?', NULL, '<textarea>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('70ca77e0-a9ea-4765-acdb-9e4b7bfb2f93', 36, 74, 'explanation', 'applied', 'Explain how associating a <label> with an <input> (via for and id) improves usability and accessibility.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('74352e0f-dcbf-4528-b6b9-737305e80fcc', 37, 76, 'multiple_choice', 'foundational', 'Which HTML element links an external stylesheet?', '[{"text": "<style>", "label": "A"}, {"text": "<css>", "label": "B"}, {"text": "<link>", "label": "C"}, {"text": "<script>", "label": "D"}]', '<link>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fa700335-524e-4989-8e87-ac4075585503', 37, 77, 'multiple_choice', 'foundational', 'In the rule  p { color: red; }  what is  color ?', '[{"text": "selector", "label": "A"}, {"text": "property", "label": "B"}, {"text": "value", "label": "C"}, {"text": "declaration", "label": "D"}]', 'property', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('68dffbfe-46a2-46d6-8321-e612d0fcde1c', 37, 78, 'multiple_choice', 'foundational', 'Which selector targets elements with the class name  box ?', '[{"text": "#box", "label": "A"}, {"text": ".box", "label": "B"}, {"text": "box", "label": "C"}, {"text": "*box", "label": "D"}]', '.box', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('97db97d6-3e44-4034-ae48-ab697aaf22a8', 37, 76, 'multiple_choice', 'applied', 'Which way of adding CSS is best for styling an entire multi-page site?', '[{"text": "inline style attribute", "label": "A"}, {"text": "internal <style> block", "label": "B"}, {"text": "external stylesheet", "label": "C"}, {"text": "it does not matter", "label": "D"}]', 'external stylesheet', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8c9a9234-8573-4663-af6b-318955541389', 37, 78, 'short_answer', 'foundational', 'Which single character begins a CSS id selector?', NULL, '#', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a3bf8032-31d2-4734-a0e1-2cc8632999cf', 37, 77, 'explanation', 'foundational', 'Describe the three parts of a CSS rule (selector, property, value) using a concrete example.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0af3212a-db16-48dc-9d43-af73908c9660', 38, 80, 'multiple_choice', 'foundational', 'What does the selector  div p  (with a space) match?', '[{"text": "a div directly inside a p", "label": "A"}, {"text": "all p elements inside a div", "label": "B"}, {"text": "div and p elements", "label": "C"}, {"text": "a p immediately after a div", "label": "D"}]', 'all p elements inside a div', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3022debf-8d0d-4a39-9c21-b235933f712c', 38, 81, 'multiple_choice', 'foundational', 'Which pseudo-class styles an element while the mouse is over it?', '[{"text": ":focus", "label": "A"}, {"text": ":hover", "label": "B"}, {"text": ":active", "label": "C"}, {"text": ":visited", "label": "D"}]', ':hover', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('42179eea-08bf-4ad8-af1a-5cc52eb321d6', 1, 2, 'multiple_choice', 'foundational', 'Which of the following is NOT a valid Python data type?', '[{"text": "int", "label": "A"}, {"text": "float", "label": "B"}, {"text": "char", "label": "C"}, {"text": "bool", "label": "D"}]', 'char', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('473cf03c-f038-4ef2-948c-be0eb43d843f', 1, 1, 'multiple_choice', 'foundational', 'What is the value of x after this code?\n\nx = 5\nx = x + 3', '[{"text": "5", "label": "A"}, {"text": "8", "label": "B"}, {"text": "3", "label": "C"}, {"text": "53", "label": "D"}]', '8', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fb7e0b20-0401-488f-99dc-59339e8c9ec8', 1, 3, 'multiple_choice', 'foundational', 'What does 10 % 3 evaluate to?', '[{"text": "3", "label": "A"}, {"text": "3.33", "label": "B"}, {"text": "1", "label": "C"}, {"text": "0", "label": "D"}]', '1', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('95112479-bbb4-4051-9a88-ad542187a166', 1, 2, 'multiple_choice', 'applied', 'What is the result of: bool(0), bool("False"), bool([])?', '[{"text": "True, True, True", "label": "A"}, {"text": "False, True, False", "label": "B"}, {"text": "False, False, False", "label": "C"}, {"text": "True, False, True", "label": "D"}]', 'False, True, False', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ec0d057f-6a7c-4268-bcb1-f697099eb8ba', 1, 4, 'short_answer', 'foundational', 'Write a single print() statement that outputs: Hello, Alice! You are 25 years old.\nUse an f-string with name = "Alice" and age = 25.', NULL, 'print(f"Hello, {name}! You are {age} years old.")', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cca43213-0d89-499f-a62e-7b7768bcad7c', 1, 3, 'short_answer', 'applied', 'Explain in one sentence the difference between == and = in Python.', NULL, 'The == operator compares two values for equality, while = assigns a value to a variable.', NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b0569052-3f5a-4385-a265-6d29178e445b', 76, 148, 'multiple_choice', 'foundational', 'Which of the following correctly creates a list literal in Python?', '[{"text": "my_list = (1, 2, 3)", "label": "A"}, {"text": "my_list = {1, 2, 3}", "label": "B"}, {"text": "my_list = [1, 2, 3]", "label": "C"}, {"text": "my_list = \"1, 2, 3\"", "label": "D"}]', 'my_list = [1, 2, 3]', NULL, '2026-06-06 14:55:17.972579+00', 0.64483464, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('512ddb16-dfda-49ba-8528-629fc00b40d4', 76, 148, 'short_answer', 'foundational', 'What are the two key characteristics of Python lists regarding their structure and changeability, as introduced with list literals?', NULL, 'Lists are ordered and mutable.', NULL, '2026-06-06 14:55:17.972579+00', 0.71113235, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3893d136-4818-45a6-bc70-36daaa12ad44', 1, 2, 'explanation', 'applied', 'Explain in 2-3 sentences why Python is called a "dynamically typed" language. Give an example showing how a variable can change type.', NULL, NULL, NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0168fbcc-c4aa-47d2-9b3e-6b9bbf8e878b', 1, 4, 'explanation', 'advanced', 'What is the difference between print() and return in Python? Explain where each is used and what happens to the value afterwards.', NULL, NULL, NULL, '2026-06-01 16:23:23.934873+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('94c37e3e-0d93-4f53-8f5a-254bf9ba5955', 2, 5, 'multiple_choice', 'foundational', 'What does this print?\n\nx = 7\nif x > 10:\n    print("big")\nelif x > 5:\n    print("medium")\nelse:\n    print("small")', '[{"text": "big", "label": "A"}, {"text": "medium", "label": "B"}, {"text": "small", "label": "C"}, {"text": "big\\nmedium", "label": "D"}]', 'medium', NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('61c8d98d-1783-4e3b-84e3-6597bc56870e', 2, 6, 'multiple_choice', 'foundational', 'How many times does this print "hello"?\n\nfor i in range(3):\n    print("hello")', '[{"text": "2", "label": "A"}, {"text": "3", "label": "B"}, {"text": "4", "label": "C"}, {"text": "1", "label": "D"}]', '3', NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b348a100-ab80-4f76-af95-ca510e96ce5c', 2, 7, 'multiple_choice', 'applied', 'What does this print?\n\nx = 10\nwhile x > 0:\n    x -= 3\nprint(x)', '[{"text": "0", "label": "A"}, {"text": "-2", "label": "B"}, {"text": "1", "label": "C"}, {"text": "-1", "label": "D"}]', '-2', NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d49db9b6-aecc-43d1-83a5-146b3cc26596', 2, 8, 'short_answer', 'foundational', 'What does the break statement do inside a loop? Answer in one sentence.', NULL, 'It immediately exits the loop, skipping any remaining iterations.', NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d8ea51a7-a2c6-47d4-8e7f-5907645d8938', 2, 5, 'short_answer', 'applied', 'Write a Python expression using a ternary conditional that returns "even" if num is even and "odd" otherwise.', NULL, '"even" if num % 2 == 0 else "odd"', NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('128b845e-781c-4adb-b18f-4945bac3a4ce', 76, 148, 'coding', 'applied', 'Create a list named `favorite_colors` that contains at least three different color names as strings. Then, create another list named `mixed_data_list` that contains at least one string, one integer, and one boolean value. Finally, print both lists.', NULL, NULL, '[{"input": "", "expected_output": "[''blue'', ''green'', ''red'']\n[''apple'', 10, True]"}, {"input": "", "expected_output": "[''yellow'', ''purple'', ''orange'', ''black'']\n[''hello'', 5, False, 3.14]"}]', '2026-06-06 14:55:17.972579+00', 0.34785503, '# Create your favorite_colors list here
# favorite_colors = 

# Create your mixed_data_list here
# mixed_data_list = 

# Print both lists below
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ea002716-7cfa-4b5c-a80b-6a2cbcc8938a', 2, 7, 'explanation', 'applied', 'Explain the difference between a for loop and a while loop. Give an example of when a while loop is more appropriate.', NULL, NULL, NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1f169195-6348-4529-ba65-27d30660ecf5', 2, 8, 'explanation', 'advanced', 'Explain what the else clause on a for loop does in Python. When does it execute and when does it not?', NULL, NULL, NULL, '2026-06-01 16:23:23.977752+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b31a7707-2b9b-4cef-9a88-d1eb64983e1a', 3, 9, 'multiple_choice', 'foundational', 'What is the output?\n\ndef greet(name):\n    return f"Hi {name}"\n\nprint(greet("Alex"))', '[{"text": "Hi Alex", "label": "A"}, {"text": "greet(Alex)", "label": "B"}, {"text": "Hi name", "label": "C"}, {"text": "Error", "label": "D"}]', 'Hi Alex', NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f1111b3b-bd0f-4212-9e71-a1ef3defb2da', 38, 82, 'multiple_choice', 'applied', 'Which pseudo-element inserts generated content AFTER an element?', '[{"text": "::before", "label": "A"}, {"text": "::after", "label": "B"}, {"text": "::first-line", "label": "C"}, {"text": "::marker", "label": "D"}]', '::after', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d55b8b37-3f94-4057-b12f-28b567b5be47', 3, 10, 'multiple_choice', 'foundational', 'What does this print?\n\nx = 5\ndef change():\n    x = 10\nchange()\nprint(x)', '[{"text": "10", "label": "A"}, {"text": "5", "label": "B"}, {"text": "Error", "label": "C"}, {"text": "None", "label": "D"}]', '5', NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e07d832e-2604-4795-ada7-1864268d7d3c', 3, 9, 'multiple_choice', 'applied', 'What does add(5) return?\n\ndef add(a, b=2):\n    return a + b', '[{"text": "5", "label": "A"}, {"text": "7", "label": "B"}, {"text": "2", "label": "C"}, {"text": "Error", "label": "D"}]', '7', NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d6a233b1-f15c-4df3-815b-df4ced09c9ca', 3, 10, 'short_answer', 'applied', 'Write a function multiply_all(*args) that returns the product of all arguments. Return 1 if no arguments.', NULL, 'def multiply_all(*args):\n    product = 1\n    for n in args:\n        product *= n\n    return product', NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8eb2c34c-fcf4-44aa-9ffc-7cfa7b1f2e76', 76, 149, 'multiple_choice', 'foundational', 'Given the list `colors = [''red'', ''green'', ''blue'', ''yellow'', ''purple'']`, what will `colors[3]` evaluate to?', '[{"text": "''red''", "label": "A"}, {"text": "''green''", "label": "B"}, {"text": "''blue''", "label": "C"}, {"text": "''yellow''", "label": "D"}]', '''yellow''', NULL, '2026-06-06 14:55:17.972579+00', 0.3287127, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('246ddeb9-f333-4d68-bdc6-1b5a7aa16180', 76, 149, 'short_answer', 'applied', 'What is the output of `[''a'', ''b'', ''c'', ''d'', ''e''][1:4]`?', NULL, '[''b'', ''c'', ''d'']', NULL, '2026-06-06 14:55:17.972579+00', 0.41699535, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3f6d6944-7e63-4a39-b436-2f93970a0e19', 3, 11, 'explanation', 'advanced', 'Explain what a "base case" is in recursion and why every recursive function needs one. What happens without a base case?', NULL, NULL, NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fb21625f-465e-464a-bacb-e6b189350f2c', 3, 10, 'explanation', 'applied', 'Explain the difference between local and global variables in Python. Show how the global keyword works with a short example.', NULL, NULL, NULL, '2026-06-01 16:23:24.001646+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('633784c2-c3c6-4ff9-b7d6-048fc5750d48', 4, 12, 'multiple_choice', 'foundational', 'What is my_list[-1]?\n\nmy_list = [10, 20, 30, 40]', '[{"text": "10", "label": "A"}, {"text": "30", "label": "B"}, {"text": "40", "label": "C"}, {"text": "Error", "label": "D"}]', '40', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e08a93b6-ebea-4668-b81d-19f957efb807', 4, 13, 'multiple_choice', 'foundational', 'Which of these creates a dictionary?', '[{"text": "[1, 2, 3]", "label": "A"}, {"text": "{\"a\": 1, \"b\": 2}", "label": "B"}, {"text": "(1, 2, 3)", "label": "C"}, {"text": "{1, 2, 3}", "label": "D"}]', '{"a": 1, "b": 2}', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('52880022-9ccf-4da3-b993-4ebf2c5ec672', 4, 14, 'multiple_choice', 'applied', 'What is the output?\n\nA = {1, 2, 3}\nB = {2, 3, 4}\nprint(A & B)', '[{"text": "{1, 2, 3, 4}", "label": "A"}, {"text": "{2, 3}", "label": "B"}, {"text": "{1, 4}", "label": "C"}, {"text": "{1, 2, 3, 2, 3, 4}", "label": "D"}]', '{2, 3}', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3cabf91a-4e6a-4418-8b55-9320b50e796f', 4, 15, 'multiple_choice', 'applied', 'What does this comprehension produce?\n\n[x**2 for x in range(5) if x % 2 == 0]', '[{"text": "[0, 1, 4, 9, 16]", "label": "A"}, {"text": "[0, 4, 16]", "label": "B"}, {"text": "[1, 9]", "label": "C"}, {"text": "[0, 2, 4]", "label": "D"}]', '[0, 4, 16]', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fa8716ae-b1e4-4dd2-9c16-8211c4dd9289', 4, 12, 'short_answer', 'foundational', 'Write an expression that returns the last three elements of a list named data (assume data has at least 3 elements).', NULL, 'data[-3:]', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4530c17b-faa2-4799-99a7-3a80c0af9a12', 4, 13, 'short_answer', 'applied', 'What is the key difference between a list and a tuple in Python? Answer in one sentence.', NULL, 'A list is mutable (can be changed after creation), while a tuple is immutable (cannot be changed).', NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a4137b89-78a0-4ac5-959d-8af734bafb61', 76, 149, 'explanation', 'advanced', 'Explain the difference in behavior between `my_list[0:3]` and `my_list[:3]` when `my_list` is a list. Why might both forms exist?', NULL, 'Both `my_list[0:3]` and `my_list[:3]` produce the same result: a slice of the list from the element at index 0 up to (but not including) the element at index 3. The `start` index is optional in slicing; if omitted, it defaults to the beginning of the list (index 0). Both forms exist for readability and convenience. `my_list[0:3]` explicitly states the starting point, which can be useful for clarity if the start index is a variable or comes from a calculation. `my_list[:3]` is a more concise way to express ''from the beginning up to index 3'', which is common and saves typing.', NULL, '2026-06-06 14:55:17.972579+00', 0.46213752, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b8094411-821d-4691-9e25-c3c626250b3f', 76, 149, 'coding', 'applied', 'Given the list `letters = [''A'', ''B'', ''C'', ''D'', ''E'', ''F'', ''G'', ''H'']`.

1. Print the element ''C'' using a positive index.
2. Print the element ''F'' using a negative index.
3. Print a slice containing `[''D'', ''E'', ''F'']`.
4. Print a slice containing `[''A'', ''C'', ''E'', ''G'']` (every other letter starting from the beginning).', NULL, NULL, '[{"input": "", "expected_output": "C\nF\n[''D'', ''E'', ''F'']\n[''A'', ''C'', ''E'', ''G'']"}]', '2026-06-06 14:55:17.972579+00', 0.48609856, 'letters = [''A'', ''B'', ''C'', ''D'', ''E'', ''F'', ''G'', ''H'']

# Your code here:
# 1. Print ''C''
# 2. Print ''F''
# 3. Print slice [''D'', ''E'', ''F'']
# 4. Print slice [''A'', ''C'', ''E'', ''G'']');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a0838dc6-f43e-45f8-b540-f855684858f7', 4, 14, 'explanation', 'applied', 'Explain the difference between a set and a list. When would you choose a set over a list?', NULL, NULL, NULL, '2026-06-01 16:23:24.029067+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b2730217-52b5-4c22-8c19-7f4b42133c07', 5, 16, 'multiple_choice', 'foundational', 'What method is automatically called when a new object is created?', '[{"text": "__init__", "label": "A"}, {"text": "__new__", "label": "B"}, {"text": "__str__", "label": "C"}, {"text": "init", "label": "D"}]', '__init__', NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('389997ad-177d-46cd-9166-c72a55784de3', 5, 16, 'multiple_choice', 'foundational', 'What does self refer to inside a Python class method?', '[{"text": "The class itself", "label": "A"}, {"text": "The current instance of the class", "label": "B"}, {"text": "A global variable", "label": "C"}, {"text": "It is optional, so nothing", "label": "D"}]', 'The current instance of the class', NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('74e31979-c73d-4574-bbbe-ac402fd90708', 5, 17, 'multiple_choice', 'applied', 'What does Dog().speak() return?\n\nclass Animal:\n    def speak(self):\n        return "..."\n\nclass Dog(Animal):\n    def speak(self):\n        return "Woof"', '[{"text": "\"...\"", "label": "A"}, {"text": "\"Woof\"", "label": "B"}, {"text": "Error", "label": "C"}, {"text": "None", "label": "D"}]', '"Woof"', NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('222ad583-5795-4289-b308-d87ea5ebc838', 5, 18, 'short_answer', 'applied', 'In one sentence, what does the @property decorator do in Python?', NULL, 'It allows a method to be accessed like an attribute, enabling computed or read-only properties with getter/setter logic.', NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('80985b71-7f53-4bd6-94db-9c00faafa7ab', 5, 17, 'explanation', 'applied', 'Explain what inheritance is in OOP and why it is useful. Use Vehicle and Car as an example.', NULL, NULL, NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('41f87ee4-0f62-4071-b043-5a40631e547f', 5, 18, 'explanation', 'advanced', 'Explain encapsulation in Python. How do you indicate a "private" attribute and how does name mangling (__attr) work?', NULL, NULL, NULL, '2026-06-01 16:23:24.062853+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9e158e89-d659-4575-84c2-851c23d13cfc', 6, 19, 'multiple_choice', 'foundational', 'Which mode opens a file for writing (overwriting existing content)?', '[{"text": "\"r\"", "label": "A"}, {"text": "\"w\"", "label": "B"}, {"text": "\"a\"", "label": "C"}, {"text": "\"rw\"", "label": "D"}]', '"w"', NULL, '2026-06-01 16:23:24.120256+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f5693414-cc77-491e-a5f6-31c5a5db8a43', 6, 20, 'multiple_choice', 'foundational', 'What does this print?\n\ntry:\n    x = 10 / 0\nexcept ZeroDivisionError:\n    print("Oops")\nelse:\n    print("OK")', '[{"text": "OK", "label": "A"}, {"text": "Oops", "label": "B"}, {"text": "Oops\\nOK", "label": "C"}, {"text": "Error", "label": "D"}]', 'Oops', NULL, '2026-06-01 16:23:24.120256+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d4243ec3-5348-4011-a56e-2cd12ee7ede4', 6, 20, 'multiple_choice', 'applied', 'What does this print?\n\ntry:\n    print("A")\n    raise ValueError("bad")\nfinally:\n    print("B")', '[{"text": "A", "label": "A"}, {"text": "A\\nB  (then ValueError raised)", "label": "B"}, {"text": "B", "label": "C"}, {"text": "A\\nB", "label": "D"}]', 'A\nB  (then ValueError raised)', NULL, '2026-06-01 16:23:24.120256+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('067ad5bd-ed1a-4762-a362-50f5b2e143a6', 6, 19, 'short_answer', 'applied', 'Why is the "with" statement recommended when working with files? Answer in one sentence.', NULL, 'It automatically closes the file when the block exits, even if an exception occurs.', NULL, '2026-06-01 16:23:24.120256+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8a6163a5-1b33-4944-a59f-7a8da9de7d91', 76, 150, 'multiple_choice', 'foundational', 'Which method is used to add an element to the very end of a list?', '[{"text": "insert(index, element)", "label": "A"}, {"text": "add(element)", "label": "B"}, {"text": "append(element)", "label": "C"}, {"text": "put(element)", "label": "D"}]', 'append(element)', NULL, '2026-06-06 14:55:17.972579+00', 0.38221452, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77d9dc01-f993-4932-8670-08243276ce5b', 76, 150, 'short_answer', 'applied', 'After executing the following code, what will be the content of `my_list`?

python
my_list = [''red'', ''green'', ''blue'']
my_list.insert(1, ''yellow'')
my_list.remove(''blue'')', NULL, '[''red'', ''yellow'', ''green'']', NULL, '2026-06-06 14:55:17.972579+00', 0.560576, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f14b3708-ca25-41af-8d57-97fdcff2ad4e', 6, 21, 'explanation', 'advanced', 'How do you create a custom exception class in Python? Show syntax and explain why custom exceptions are useful.', NULL, NULL, NULL, '2026-06-01 16:23:24.120256+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b412e4bd-a066-41fe-9e3a-710e9c22cce0', 7, 22, 'multiple_choice', 'foundational', 'Which HTTP method is typically used to retrieve data from a REST API?', '[{"text": "POST", "label": "A"}, {"text": "GET", "label": "B"}, {"text": "DELETE", "label": "C"}, {"text": "PUT", "label": "D"}]', 'GET', NULL, '2026-06-01 16:23:24.156576+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d4169396-2ceb-4690-ad1a-a186eca0c1ce', 7, 23, 'multiple_choice', 'foundational', 'Which Python function converts a JSON string into a Python dictionary?', '[{"text": "json.dumps()", "label": "A"}, {"text": "json.loads()", "label": "B"}, {"text": "json.parse()", "label": "C"}, {"text": "json.stringify()", "label": "D"}]', 'json.loads()', NULL, '2026-06-01 16:23:24.156576+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('864755a9-2009-48a8-b3fb-4ff2306d4685', 7, 22, 'multiple_choice', 'applied', 'What does a 404 status code mean when calling an API?', '[{"text": "Server error", "label": "A"}, {"text": "Resource not found", "label": "B"}, {"text": "Unauthorized", "label": "C"}, {"text": "Success", "label": "D"}]', 'Resource not found', NULL, '2026-06-01 16:23:24.156576+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('85ab7cd9-366a-4bd2-9211-6b411bd5f45d', 7, 25, 'short_answer', 'applied', 'In one sentence, what is an API key and where is it typically placed in an HTTP request?', NULL, 'An API key is a unique identifier that authenticates the client, typically sent in the Authorization header or as a query parameter.', NULL, '2026-06-01 16:23:24.156576+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('00998433-a835-43a9-922b-efdfcf34f142', 7, 24, 'explanation', 'applied', 'Explain what a RESTful API is and its key design principles. Name at least three HTTP methods and their purposes.', NULL, NULL, NULL, '2026-06-01 16:23:24.156576+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d76ba939-83e9-4a7b-bfaf-960263da278c', 8, 26, 'multiple_choice', 'foundational', 'What should you define FIRST when starting a programming project?', '[{"text": "Write all the code", "label": "A"}, {"text": "Define requirements and scope", "label": "B"}, {"text": "Choose a database", "label": "C"}, {"text": "Design the UI", "label": "D"}]', 'Define requirements and scope', NULL, '2026-06-01 16:23:24.181735+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('37c8275b-c365-46af-af8e-f4689a79daba', 8, 27, 'multiple_choice', 'applied', 'What is the main benefit of breaking a large program into smaller functions/modules?', '[{"text": "It runs faster", "label": "A"}, {"text": "It uses less memory", "label": "B"}, {"text": "Improves readability, testability, and reusability", "label": "C"}, {"text": "Fewer imports needed", "label": "D"}]', 'Improves readability, testability, and reusability', NULL, '2026-06-01 16:23:24.181735+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1104f3f9-28af-47c6-9d0d-c3fb0f016208', 8, 26, 'short_answer', 'applied', 'What is an MVP and why is it important? Answer in 2 sentences.', NULL, 'An MVP is the simplest version of a product with core functionality. It allows early testing and feedback before building non-essential features.', NULL, '2026-06-01 16:23:24.181735+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9eb950ee-3ddf-480c-a0cd-7b688c180f49', 8, 27, 'explanation', 'applied', 'Describe the capstone project you want to build. Include:\n- What problem it solves\n- Which Python concepts from previous modules it uses\n- At least 3 features you plan to implement', NULL, NULL, NULL, '2026-06-01 16:23:24.181735+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ca34566f-b748-4b17-b266-c4b3db5aebe7', 8, 27, 'explanation', 'advanced', 'Outline a testing strategy for your capstone project. What types of tests would you write and how would you ensure code reliability?', NULL, NULL, NULL, '2026-06-01 16:23:24.181735+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1effeb4c-3d59-4d8b-80b1-3058ee008f31', 38, 83, 'multiple_choice', 'advanced', 'Which selector has the HIGHEST specificity?', '[{"text": "a class like .btn", "label": "A"}, {"text": "an id like #btn", "label": "B"}, {"text": "a tag like button", "label": "C"}, {"text": "the universal selector *", "label": "D"}]', 'an id like #btn', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fe17318f-4081-4a5e-9282-78613199f178', 38, 80, 'short_answer', 'applied', 'Which combinator character selects only DIRECT children?', NULL, '>', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f03cd16e-4a0f-48dc-b3fa-8ba9e6e15ab3', 38, 83, 'explanation', 'advanced', 'Two rules target the same element with conflicting values. Explain how CSS decides which wins (mention specificity and source order).', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cc7a3491-9c68-43be-a1d5-c6af37dd69c5', 39, 84, 'multiple_choice', 'foundational', 'Which box-model layer is the space INSIDE the border, around the content?', '[{"text": "margin", "label": "A"}, {"text": "padding", "label": "B"}, {"text": "border", "label": "C"}, {"text": "outline", "label": "D"}]', 'padding', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c76d4e18-803e-4608-b24c-6c9ba087570e', 39, 84, 'multiple_choice', 'foundational', 'Which layer is the transparent space OUTSIDE the border, separating elements?', '[{"text": "padding", "label": "A"}, {"text": "margin", "label": "B"}, {"text": "border", "label": "C"}, {"text": "gap", "label": "D"}]', 'margin', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c94f9d54-3d91-4a67-99ea-1afedf21cc82', 39, 85, 'multiple_choice', 'applied', 'Which box-sizing value makes width include padding and border?', '[{"text": "content-box", "label": "A"}, {"text": "border-box", "label": "B"}, {"text": "padding-box", "label": "C"}, {"text": "full-box", "label": "D"}]', 'border-box', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fba0b025-0435-4281-894a-9f6a76502e9c', 39, 86, 'multiple_choice', 'applied', 'Which display value flows inline but still allows setting width and height?', '[{"text": "inline", "label": "A"}, {"text": "block", "label": "B"}, {"text": "inline-block", "label": "C"}, {"text": "flex", "label": "D"}]', 'inline-block', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f6bc09f3-e1cc-48a2-9c97-3f9691e99dcc', 39, 86, 'short_answer', 'foundational', 'Which display value hides an element and removes it from the layout entirely?', NULL, 'none', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9f5ea4bd-2057-4b4b-8f0c-592738dc8f4e', 39, 84, 'explanation', 'applied', 'Describe the four layers of the CSS box model from the inside out, and what each one controls.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('87c1d512-2a21-48d9-8132-d779adbdf361', 66, 123, 'short_answer', 'applied', 'After installing `django-bootstrap5`, where must it be added within the `settings.py` file for the project to recognize it?', NULL, '`INSTALLED_APPS`', NULL, '2026-06-04 16:13:49.259055+00', 0.53991956, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('71bd3eb3-cfa9-4338-b7f6-4c0633f3bc0c', 41, 93, 'multiple_choice', 'applied', 'In Flexbox, which property aligns items along the MAIN axis?', '[{"text": "align-items", "label": "A"}, {"text": "justify-content", "label": "B"}, {"text": "align-content", "label": "C"}, {"text": "place-items", "label": "D"}]', 'justify-content', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('57963a6b-32cd-470f-b41a-c74f43eb6716', 41, 93, 'multiple_choice', 'applied', 'In Flexbox, which property aligns items along the CROSS axis?', '[{"text": "justify-content", "label": "A"}, {"text": "align-items", "label": "B"}, {"text": "flex-wrap", "label": "C"}, {"text": "order", "label": "D"}]', 'align-items', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7cc7d436-db9e-4a1d-a0a1-7c31235d54cc', 41, 94, 'multiple_choice', 'applied', 'Which property defines the columns of a CSS grid?', '[{"text": "grid-columns", "label": "A"}, {"text": "grid-template-columns", "label": "B"}, {"text": "columns", "label": "C"}, {"text": "grid-cols", "label": "D"}]', 'grid-template-columns', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0cf855e5-f12a-4b13-81bc-81da3eb8b2a8', 41, 93, 'short_answer', 'applied', 'Which property adds space between flex or grid items?', NULL, 'gap', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6dfa9702-6be2-48f1-a250-d586df3f933b', 41, 92, 'explanation', 'applied', 'When would you choose Flexbox over CSS Grid, and vice versa? Give a one-line rule of thumb.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4fde4cb2-c12d-4a01-b2f4-6dfa3adfe0c8', 42, 97, 'multiple_choice', 'foundational', 'Which CSS at-rule applies styles based on the screen width?', '[{"text": "@screen", "label": "A"}, {"text": "@media", "label": "B"}, {"text": "@responsive", "label": "C"}, {"text": "@width", "label": "D"}]', '@media', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('23424fcf-e417-479f-9c8c-01a80a59f1b2', 42, 96, 'multiple_choice', 'applied', 'Which unit is relative to the ROOT element font size?', '[{"text": "px", "label": "A"}, {"text": "em", "label": "B"}, {"text": "rem", "label": "C"}, {"text": "vh", "label": "D"}]', 'rem', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4a8e5bfc-19e0-4ab2-ae16-24596b25a797', 42, 96, 'multiple_choice', 'applied', 'Which unit equals 1% of the viewport width?', '[{"text": "vw", "label": "A"}, {"text": "vh", "label": "B"}, {"text": "%", "label": "C"}, {"text": "em", "label": "D"}]', 'vw', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('51a26dd3-0f3b-4b6f-bb7b-a9170f2697e8', 42, 99, 'multiple_choice', 'applied', 'Which at-rule defines the steps of a CSS animation?', '[{"text": "@animation", "label": "A"}, {"text": "@keyframes", "label": "B"}, {"text": "@transition", "label": "C"}, {"text": "@motion", "label": "D"}]', '@keyframes', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1216509d-c97e-4b6c-b8a8-c2cd9f8e2c41', 42, 98, 'short_answer', 'applied', 'Which property animates a smooth change between states (for example on hover)?', NULL, 'transition', NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dc8a09f0-799b-4294-afb7-dd9bd87aa058', 42, 97, 'explanation', 'advanced', 'Explain what mobile-first responsive design means and how media queries support it.', NULL, NULL, NULL, '2026-06-03 12:59:54.600033+00', NULL, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('af426ddb-fec6-4371-b5d7-88932d094c9c', 76, 150, 'explanation', 'advanced', 'Explain the key difference between using `list.remove(item)` and `list.pop(index)` when modifying a list, and describe a scenario where each would be more appropriate.', NULL, 'The key difference is what argument they take and what they do. `list.remove(item)` takes the *value* of the item you want to remove. It removes the *first occurrence* of that item in the list. If the item is not found, it raises a `ValueError`. 
`list.pop(index)` takes the *index* of the item you want to remove. It removes the item at that specific index and *returns* the removed item. If no index is provided, it removes and returns the last item in the list.

**Scenario for `remove()`:** You have a list of tasks `[''email'', ''report'', ''meeting'', ''email'']` and you want to remove the ''report'' task, without caring about its position. `tasks.remove(''report'')` is appropriate.

**Scenario for `pop()`:** You have a list of print jobs `[''doc1'', ''doc2'', ''doc3'']` and you want to process and remove the oldest job (the first one). `current_job = print_jobs.pop(0)` is appropriate because you need the item''s value and its position is known.', NULL, '2026-06-06 14:55:17.972579+00', 0.75788164, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6891f3ac-4cbc-4e97-a880-6a5c83fb2db1', 76, 150, 'coding', 'applied', 'You are managing a playlist of songs. Initially, your playlist is `playlist = [''Song A'', ''Song B'', ''Song D'']`.

Perform the following modifications:
1. Add ''Song E'' to the end of the playlist.
2. Insert ''Song C'' between ''Song B'' and ''Song D'' (it should be at index 2).
3. Remove ''Song A'' from the playlist.
4. Remove the last song from the playlist using `pop()` and print the removed song.
Finally, print the modified `playlist`.', NULL, NULL, '[{"input": "", "expected_output": "Song E\n[''Song B'', ''Song C'', ''Song D'']"}]', '2026-06-06 14:55:17.972579+00', 0.5491039, 'playlist = [''Song A'', ''Song B'', ''Song D'']

# Your code goes here

');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bf24312d-ce5a-4700-baa4-4aa608cc03ca', 76, 151, 'multiple_choice', 'foundational', 'Which of the following methods modifies the original list in place and returns `None`?', '[{"text": "`sorted(my_list)`", "label": "A"}, {"text": "`my_list.sort()`", "label": "B"}, {"text": "`my_list.copy()`", "label": "C"}, {"text": "`my_list.append()`", "label": "D"}]', '`my_list.sort()`', NULL, '2026-06-06 14:55:17.972579+00', 0.6530761, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('496b0810-bf33-42ac-a3ca-0bf392b3893a', 76, 151, 'short_answer', 'applied', 'You have a list `temperatures = [25, 18, 32, 20]`. Write the Python code to create a *new* list `sorted_temps` that contains these temperatures sorted in descending order, without modifying the `temperatures` list itself.', NULL, 'sorted_temps = sorted(temperatures, reverse=True)', NULL, '2026-06-06 14:55:17.972579+00', 0.6061482, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('89e1b674-1177-4c63-aebb-ba6b6bcb69c2', 76, 151, 'coding', 'applied', 'You are given a list named `items`. Your task is to perform two operations:
1. Sort the `items` list in ascending order *in place*.
2. After sorting, reverse the `items` list *in place*.

Finally, print the modified `items` list.', NULL, NULL, '[{"input": "", "expected_output": "[''zebra'', ''kiwi'', ''grape'', ''banana'', ''apple'']"}]', '2026-06-06 14:55:17.972579+00', 0.67015797, 'items = ["apple", "zebra", "banana", "grape", "kiwi"]

# TODO: Sort the list in place


# TODO: Reverse the list in place


print(items)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dfc7829d-503c-4b75-81c9-9a06a5b405bf', 76, 152, 'multiple_choice', 'foundational', 'What does the `len()` function return when applied to a list?', '[{"text": "The largest element in the list.", "label": "A"}, {"text": "The number of elements in the list.", "label": "B"}, {"text": "The memory address of the list.", "label": "C"}, {"text": "Whether the list is empty or not.", "label": "D"}]', 'The number of elements in the list.', NULL, '2026-06-06 14:55:17.972579+00', 0.37624902, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('350797fa-503d-45e2-9632-5ea60be43c42', 76, 152, 'short_answer', 'applied', 'You have a list `original = [1, 2, 3]`. You then execute `another = original`. If you modify `another` by appending `4` (i.e., `another.append(4)`), what will the value of `original` be?', NULL, '[1, 2, 3, 4]', NULL, '2026-06-06 14:55:17.972579+00', 0.71751034, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fcedf05d-95b8-4e8e-aecb-d4a189b2efb9', 76, 152, 'explanation', 'advanced', 'Explain the practical difference between `list_a = [1, 2, 3]; list_b = list_a` and `list_a = [1, 2, 3]; list_c = list_a[:]`. Include what happens if you modify `list_b` vs. `list_c`.', NULL, 'When `list_b = list_a` is executed, `list_b` becomes a reference to the same list object that `list_a` points to. They both refer to the exact same list in memory. Therefore, if you modify `list_b` (e.g., `list_b.append(4)`), `list_a` will also reflect this change because it''s looking at the same underlying data.

When `list_c = list_a[:]` is executed, `list_c` is created as a *new*, independent copy of `list_a`''s elements. The `[:]` slice notation creates a shallow copy of the entire list. This means `list_c` is a separate list object in memory. If you modify `list_c` (e.g., `list_c.append(4)`), `list_a` will remain unchanged because `list_c` is an entirely different list.', NULL, '2026-06-06 14:55:17.972579+00', 0.82576036, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b13d41c0-7f14-4958-bd58-f2f2d73857d8', 47, 104, 'multiple_choice', 'foundational', 'Which Python version is the latest as of this writing, according to the information provided?', '[{"text": "Python 3.9", "label": "A"}, {"text": "Python 3.10.4", "label": "B"}, {"text": "Python 3.11", "label": "C"}, {"text": "Python 2.7", "label": "D"}]', 'Python 3.11', NULL, '2026-06-04 16:12:07.403825+00', 0.52161276, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1c23d3d9-e5c0-45be-a0cb-8658aaeb7cd2', 47, 104, 'short_answer', 'applied', 'What command should be entered in a terminal to check the installed Python version and start the Python interpreter?', NULL, 'python3', NULL, '2026-06-04 16:12:07.600657+00', 0.60833526, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('753b55cc-86dd-4973-8268-2a5d108cb348', 47, 104, 'multiple_choice', 'foundational', 'What do the three angle brackets (>>>) in a code listing signify?', '[{"text": "A comment in Python code", "label": "A"}, {"text": "The start of a new program file", "label": "B"}, {"text": "A Python prompt in a terminal session", "label": "C"}, {"text": "An error message from the interpreter", "label": "D"}]', 'A Python prompt in a terminal session', NULL, '2026-06-04 16:12:07.654641+00', 0.57527536, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('72af1524-7387-4138-bab2-a1dc17873959', 47, 104, 'explanation', 'advanced', 'Explain the purpose of the ''Hello World!'' program as described in the lesson.', NULL, 'The ''Hello World!'' program serves a very real purpose: if it runs correctly on your system, it confirms that your Python setup is working, meaning any other Python program you write should also work. It''s also a tradition in programming for good luck.', NULL, '2026-06-04 16:12:07.715023+00', 0.7917317, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cf17799d-aa30-4361-92d6-20ef71def90a', 47, 104, 'short_answer', 'applied', 'To run a Python program named ''hello_world.py'' from the ''python_work'' folder located on the ''Desktop'' in a terminal, what is the final command you would use after navigating to the correct directory?', NULL, 'python3 hello_world.py', NULL, '2026-06-04 16:12:07.769458+00', 0.74687964, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cb4288e1-68b5-4fd1-b3da-2a645a8516b0', 48, 105, 'multiple_choice', 'foundational', 'What does a variable connect to?', '[{"text": "A .py file extension", "label": "A"}, {"text": "A value, which is the information associated with that variable", "label": "B"}, {"text": "The Python interpreter", "label": "C"}, {"text": "Syntax highlighting", "label": "D"}]', 'A value, which is the information associated with that variable', NULL, '2026-06-04 16:12:11.255444+00', 0.3647705, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4df9a846-af84-44f6-b211-c58004157a76', 48, 105, 'short_answer', 'applied', 'What is the correct way to name a variable that needs to separate two words, like ''greeting'' and ''message''?', NULL, 'greeting_message', NULL, '2026-06-04 16:12:11.334004+00', 0.61585236, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e07d1ac2-bf1c-423b-8e9b-2f89416d7d3e', 48, 105, 'multiple_choice', 'foundational', 'Which of the following variable names is NOT allowed according to the rules for naming variables?', '[{"text": "message_1", "label": "A"}, {"text": "_message", "label": "B"}, {"text": "1_message", "label": "C"}, {"text": "message", "label": "D"}]', '1_message', NULL, '2026-06-04 16:12:11.380023+00', 0.5820757, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7ecd5648-e54b-477c-bb32-3710a49c0217', 48, 105, 'explanation', 'advanced', 'Explain what happens when you reassign a new value to an existing variable in a Python program.', NULL, 'When a new value is reassigned to an existing variable, Python updates its internal tracking so that the variable is now connected to the new value. The old value that was previously associated with the variable is no longer connected to it.', NULL, '2026-06-04 16:12:11.441051+00', 0.46884805, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fdd59c89-6e81-4d23-ba46-6ca5c14ee435', 48, 105, 'short_answer', 'applied', 'What method would you use to remove the prefix ''https://'' from the string ''https://nostarch.com''?', NULL, 'removeprefix(''https://'')', NULL, '2026-06-04 16:12:11.489276+00', 0.42653742, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('091777ab-2db5-452e-8010-71d0a3d6373a', 49, 106, 'multiple_choice', 'foundational', 'Which characters are used to indicate a list in Python?', '[{"text": "{}", "label": "A"}, {"text": "()", "label": "B"}, {"text": "[]", "label": "C"}, {"text": "''''", "label": "D"}]', '[]', NULL, '2026-06-04 16:12:14.712941+00', 0.6578392, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e0d92811-10b3-47a6-b568-c7e088e10c5c', 49, 106, 'short_answer', 'applied', 'What is the index of the second item in a Python list?', NULL, '1', NULL, '2026-06-04 16:12:14.789857+00', 0.6386759, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ec52423d-3f4e-4409-8419-764f8c7caaba', 49, 106, 'multiple_choice', 'foundational', 'Which method is used to remove an item from a list by its value?', '[{"text": "del", "label": "A"}, {"text": "pop()", "label": "B"}, {"text": "remove()", "label": "C"}, {"text": "delete_value()", "label": "D"}]', 'remove()', NULL, '2026-06-04 16:12:14.874118+00', 0.62963873, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d99c73e9-2b16-4253-b8f2-4e281ed4e45d', 49, 106, 'explanation', 'advanced', 'Explain the difference between using the ''del'' statement and the ''pop()'' method to remove an item from a list.', NULL, 'When using ''del'', the item is simply removed and not used further. When using ''pop()'', the item is removed from the list, but it can still be used or stored in a variable after removal. Therefore, ''del'' is for removing without needing the item, while ''pop()'' is for removing and then working with the item.', NULL, '2026-06-04 16:12:14.952836+00', 0.6004732, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('00f13fe7-46b5-48d6-8540-3c5519df261e', 49, 106, 'short_answer', 'applied', 'What value would be returned if you requested the item at index -1 from the list `[''honda'', ''yamaha'', ''suzuki'']`?', NULL, '''suzuki''', NULL, '2026-06-04 16:12:14.992801+00', 0.44157988, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('34289570-e589-4643-a3a8-3091dea288f2', 50, 107, 'multiple_choice', 'foundational', 'Which of the following is a primary benefit of using a for loop to process items in a list?', '[{"text": "It automatically sorts the list in ascending order.", "label": "A"}, {"text": "It eliminates the need to change code when the list''s length changes.", "label": "B"}, {"text": "It allows for direct modification of the original list items without copying.", "label": "C"}, {"text": "It always outputs the items in reverse order.", "label": "D"}]', 'It eliminates the need to change code when the list''s length changes.', NULL, '2026-06-04 16:12:20.923832+00', 0.4988641, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('405c244c-5374-4607-a600-aa290331d75e', 50, 107, 'short_answer', 'applied', 'In the example `for magician in magicians: print(magician)`, what does Python retrieve and associate with the variable `magician` during the second iteration of the loop?', NULL, '''david''', NULL, '2026-06-04 16:12:21.000161+00', 0.72329116, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2e6cd262-8dba-4d3c-b830-84836830aa9f', 50, 107, 'explanation', 'advanced', 'Explain how a list comprehension combines elements of a for loop and new element creation into a single line of code, using the example `squares = [value**2 for value in range(1, 11)]`.', NULL, 'A strong answer should explain that a list comprehension begins with defining the new list''s name and opening square brackets. Inside the brackets, it first specifies the expression for the values (e.g., `value**2`), which indicates how each new element is generated. This is followed immediately by a `for` loop (e.g., `for value in range(1, 11)`) that generates the values to feed into the expression. It notes that no colon is used for the `for` statement within the comprehension. The comprehension implicitly appends each new element produced by the expression and loop into the new list, effectively merging the iteration, calculation, and list creation steps.', NULL, '2026-06-04 16:12:21.146055+00', 0.6563504, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('83d20160-2143-4217-9e30-0be28293e62e', 50, 107, 'multiple_choice', 'foundational', 'When using a for loop, how many times is the set of steps within the loop repeated for a list with 100 items?', '[{"text": "Once, for the first item only.", "label": "A"}, {"text": "Ten times.", "label": "B"}, {"text": "One hundred times, once for each item.", "label": "C"}, {"text": "Zero times, if the list is already sorted.", "label": "D"}]', 'One hundred times, once for each item.', NULL, '2026-06-04 16:12:21.200852+00', 0.4513075, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('89f822fe-5973-40d0-9e09-86dd0969828c', 51, 108, 'multiple_choice', 'foundational', 'Which operator is used to check for equality between two values?', '[{"text": "=", "label": "A"}, {"text": "==", "label": "B"}, {"text": "!=", "label": "C"}, {"text": "<=", "label": "D"}]', '==', NULL, '2026-06-04 16:12:25.905683+00', 0.51815856, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ff2bef03-550e-42af-8172-f53919c94934', 51, 108, 'short_answer', 'applied', 'What is the output of the following code snippet? 

car = ''Audi''
if car.lower() == ''audi'':
    print(True)
else:
    print(False)', NULL, 'True', NULL, '2026-06-04 16:12:25.981834+00', 0.64013827, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('efbbb20b-fa51-49dd-9543-3a3102ba7a2c', 51, 108, 'explanation', 'advanced', 'Explain how the ''if-elif-else'' chain determines the final price in the admission cost example, particularly when an ''else'' block is omitted and replaced with a final ''elif'' statement (e.g., ''elif age >= 65:'').', NULL, 'In an ''if-elif-else'' chain, Python evaluates each condition sequentially. If an ''if'' or ''elif'' test is True, its corresponding code block is executed, and the rest of the chain is skipped. If an ''else'' block is omitted and replaced by a final ''elif'' statement (like ''elif age >= 65:''), this last ''elif'' statement will only be evaluated if all preceding ''if'' and ''elif'' conditions were False. This means the conditions in the chain effectively filter down to the final specific ''elif'' condition, ensuring that every block of code must pass a specific test to be executed, rather than falling into a general ''else'' case.', NULL, '2026-06-04 16:12:26.10561+00', 0.79869604, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e2d0c9f7-7617-43be-afd2-9eed569b49fc', 51, 108, 'multiple_choice', 'foundational', 'What happens if a conditional test in an ''if'' statement evaluates to False?', '[{"text": "Python executes the code following the ''if'' statement.", "label": "A"}, {"text": "Python ignores the code following the ''if'' statement.", "label": "B"}, {"text": "Python raises an error.", "label": "C"}, {"text": "Python always executes the ''else'' block, if present.", "label": "D"}]', 'Python ignores the code following the ''if'' statement.', NULL, '2026-06-04 16:12:26.147555+00', 0.6362007, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b934d8b9-41d3-494c-8e6a-5934b08069a9', 51, 108, 'short_answer', 'applied', 'Given the code:

car = ''Audi''
print(car == ''audi'')

What Boolean value will be printed, and why?', NULL, 'False, because testing for equality is case sensitive in Python, and ''Audi'' is not equal to ''audi''.', NULL, '2026-06-04 16:12:26.192063+00', 0.7542864, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('72851940-14b0-4011-be9f-102f4594c843', 53, 110, 'multiple_choice', 'foundational', 'What is the purpose of the `input()` function?', '[{"text": "To print a message to the console.", "label": "A"}, {"text": "To pause the program and wait for the user to enter text.", "label": "B"}, {"text": "To assign a value to a variable without user interaction.", "label": "C"}, {"text": "To display an error message if input is not provided.", "label": "D"}]', 'To pause the program and wait for the user to enter text.', NULL, '2026-06-04 16:12:37.086814+00', 0.5455381, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5fc855d5-ef9d-447a-ae84-65e427dde5c7', 53, 110, 'short_answer', 'applied', 'How would you modify the following `input()` prompt to add a space between the prompt and the user''s response: `name = input("Please enter your name:")`?', NULL, '`name = input("Please enter your name: ")`', NULL, '2026-06-04 16:12:37.258059+00', 0.5519248, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('127f5d89-9120-47cd-b6c6-4cb42eafa47c', 53, 110, 'explanation', 'advanced', 'Explain the concept of using a ''flag'' variable in a `while` loop to control its execution, as demonstrated with the `active` variable. How does it differ from placing the conditional test directly in the `while` statement?', NULL, 'A ''flag'' variable (like `active`) is a boolean variable (True/False) that monitors whether a program or loop should continue running. It''s set to True initially, and the `while` loop continues as long as this flag remains True. Inside the loop, specific conditions (e.g., user input ''quit'') can change the flag''s value to False, causing the loop to stop. This differs from placing the conditional test directly in the `while` statement because it allows for more complex logic for stopping the loop, especially when there are multiple conditions or events that could cause the program to cease. It makes the `while` statement itself simpler (`while active:`) and centralizes the stopping logic within the loop''s body, making it easier to add or modify conditions for termination without altering the `while` statement itself.', NULL, '2026-06-04 16:12:37.404643+00', 0.59214795, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('99a286b2-1d71-432d-bcff-fbce404cad79', 53, 110, 'multiple_choice', 'foundational', 'What happens immediately after a user presses ENTER when providing input for the `input()` function?', '[{"text": "The program terminates.", "label": "A"}, {"text": "The entered text is assigned to a variable.", "label": "B"}, {"text": "The `input()` function displays a confirmation message.", "label": "C"}, {"text": "The program asks for more input.", "label": "D"}]', 'The entered text is assigned to a variable.', NULL, '2026-06-04 16:12:37.532244+00', 0.5136334, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0fa7148d-389e-4dce-a19c-47c4cc1f7109', 53, 110, 'short_answer', 'applied', 'What is the purpose of the `break` statement when used inside a `while` loop?', NULL, 'To exit the `while` loop immediately, regardless of any conditional test.', NULL, '2026-06-04 16:12:37.714359+00', 0.53243643, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4df1d3fd-1286-45c6-9a33-f793df0eb924', 55, 112, 'multiple_choice', 'foundational', 'What is the primary purpose of the `__init__()` method in a class?', '[{"text": "To define new behaviors for the class.", "label": "A"}, {"text": "To initialize attributes for a new instance of the class.", "label": "B"}, {"text": "To print a statement describing the class.", "label": "C"}, {"text": "To simulate an action performed by an object.", "label": "D"}]', 'To initialize attributes for a new instance of the class.', NULL, '2026-06-04 16:12:48.272471+00', 0.5708581, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('80ba88b1-9f66-4577-bbf3-aaf20c5ed2cc', 55, 112, 'short_answer', 'applied', 'According to convention, how should class names be capitalized in Python?', NULL, 'Capitalized', NULL, '2026-06-04 16:12:48.344635+00', 0.51030093, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b7070dc7-bcb3-49ba-9df5-6a32807f36f4', 55, 112, 'multiple_choice', 'applied', 'When should an attribute or method be added to a parent class (like `Car`) rather than a child class (like `ElectricCar`)?', '[{"text": "Only when the attribute or method is specific to the electric car.", "label": "A"}, {"text": "When the attribute or method is unique to a single instance of the class.", "label": "B"}, {"text": "When the attribute or method could belong to any car, not just an electric car.", "label": "C"}, {"text": "When the child class needs to override the parent class''s behavior.", "label": "D"}]', 'When the attribute or method could belong to any car, not just an electric car.', NULL, '2026-06-04 16:12:48.397445+00', 0.635178, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('961797aa-ba88-4995-9498-b1226f4f427a', 55, 112, 'explanation', 'advanced', 'Explain the concept of ''composition'' in the context of classes, providing an example from the lesson content.', NULL, 'Composition is the approach of breaking a large class into smaller, collaborating classes. This happens when a class accumulates many attributes and methods that could logically form a separate class. For example, if the `ElectricCar` class starts to have many attributes and methods specific to its battery, those can be moved to a separate `Battery` class. Then, an instance of `Battery` can be used as an attribute within the `ElectricCar` class, keeping both classes simpler and more focused.', NULL, '2026-06-04 16:12:48.500129+00', 0.4782049, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c608f643-639b-4c94-a053-800f38ac1ec7', 55, 112, 'multiple_choice', 'foundational', 'Which of the following is a recommended styling convention for organizing code within a module?', '[{"text": "Using three blank lines between methods.", "label": "A"}, {"text": "Using one blank line between classes.", "label": "B"}, {"text": "Using two blank lines to separate classes.", "label": "C"}, {"text": "Placing import statements for modules you wrote before standard library modules.", "label": "D"}]', 'Using two blank lines to separate classes.', NULL, '2026-06-04 16:12:48.544434+00', 0.4935694, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('85446dde-3d78-4ab9-b6e7-8ba5bd21a47e', 57, 114, 'multiple_choice', 'foundational', 'What is the primary purpose of writing tests for your code?', '[{"text": "To ensure each set of inputs results in the desired output.", "label": "A"}, {"text": "To make your code run faster.", "label": "B"}, {"text": "To automatically fix bugs in your program.", "label": "C"}, {"text": "To allow third-party packages to be installed.", "label": "D"}]', 'To ensure each set of inputs results in the desired output.', NULL, '2026-06-04 16:12:57.761736+00', 0.4757375, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('877666d1-1454-493a-978e-125304275195', 57, 114, 'short_answer', 'applied', 'Which command would you use to update an already installed third-party package called ''requests'' using pip?', NULL, 'python -m pip install --upgrade requests', NULL, '2026-06-04 16:12:57.97126+00', 0.6110869, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9501c3b0-f435-4c70-b605-f9afe974546b', 57, 114, 'multiple_choice', 'foundational', 'What does a failing test indicate?', '[{"text": "The code is perfect and needs no further changes.", "label": "A"}, {"text": "There is an issue to resolve in the code.", "label": "B"}, {"text": "The test itself has an error and should be deleted.", "label": "C"}, {"text": "The third-party package is outdated.", "label": "D"}]', 'There is an issue to resolve in the code.', NULL, '2026-06-04 16:12:58.026119+00', 0.40207446, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d2dbb6fb-f4bc-448b-83d2-2c83571af45e', 57, 114, 'explanation', 'advanced', 'Explain the benefit of keeping many third-party packages out of the core Python standard library, even if they are popular and widely used.', NULL, 'Keeping third-party packages out of the standard library allows them to be developed and updated on a timeline independent of the core Python language itself. This often means they can be updated more frequently to address new features, bug fixes, and security concerns, evolving at a faster pace than if they were tied to Python’s development schedule.', NULL, '2026-06-04 16:12:58.119388+00', 0.6145437, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('edd32af5-2e42-40ea-9340-82c49e52273a', 57, 114, 'multiple_choice', 'applied', 'When installing pytest, the ''--user'' flag is used. What does this flag do?', '[{"text": "It installs pytest for only the current user.", "label": "A"}, {"text": "It installs pytest to the standard library.", "label": "B"}, {"text": "It automatically upgrades pytest if an older version is found.", "label": "C"}, {"text": "It collects all user-defined functions for testing.", "label": "D"}]', 'It installs pytest for only the current user.', NULL, '2026-06-04 16:12:58.177045+00', 0.3887354, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ed3a83c5-dfa3-4e85-95a1-98f61c7498d4', 59, 116, 'multiple_choice', 'foundational', 'What is the initial placement of each new alien on the screen?', '[{"text": "Near the bottom-right corner of the screen.", "label": "A"}, {"text": "In the center of the screen.", "label": "B"}, {"text": "Near the top-left corner of the screen, with spacing equal to its width and height.", "label": "C"}, {"text": "Randomly across the top of the screen.", "label": "D"}]', 'Near the top-left corner of the screen, with spacing equal to its width and height.', NULL, '2026-06-04 16:13:08.148435+00', 0.4894649, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('317d2e57-fd0f-405a-acd2-a5317cd2d7e3', 59, 116, 'short_answer', 'foundational', 'What method is called before updating each alien''s position to check if the fleet is at an edge?', NULL, '_check_fleet_edges()', NULL, '2026-06-04 16:13:08.209803+00', 0.72069323, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e21e10fa-7b2f-48a6-a5c0-54df2853722d', 59, 116, 'explanation', 'advanced', 'Explain the logic behind changing the fleet''s direction and vertical position when an alien reaches the edge of the screen. Why is the line that changes the fleet''s direction not part of the ''for'' loop that drops each alien?', NULL, 'When an alien reaches the edge, the entire fleet needs to drop down and reverse its horizontal movement. The `_check_fleet_edges()` method identifies if any alien has reached an edge. If so, `_change_fleet_direction()` is called. Inside `_change_fleet_direction()`, a loop iterates through all aliens to increase their `y` position by `fleet_drop_speed`, causing them to move down. The `fleet_direction` is then multiplied by -1 *after* the loop to change the horizontal direction for the *entire fleet* once, rather than changing it for each individual alien multiple times, which would lead to incorrect behavior.', NULL, '2026-06-04 16:13:08.317557+00', 0.69762295, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ff10f51a-a638-4b1f-a7bb-13036a857d7e', 59, 116, 'multiple_choice', 'applied', 'What happens when an alien hits the ship or reaches the ground?', '[{"text": "The game immediately ends.", "label": "A"}, {"text": "A new fleet is created, and the ship remains unaffected.", "label": "B"}, {"text": "The ship is destroyed, and a new fleet is created.", "label": "C"}, {"text": "The alien is destroyed, and the game continues.", "label": "D"}]', 'The ship is destroyed, and a new fleet is created.', NULL, '2026-06-04 16:13:08.366409+00', 0.45081067, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('abfceec7-ddc3-42d8-ab7d-2eec89cd822a', 59, 116, 'short_answer', 'foundational', 'What function is used to look for collisions between bullets and aliens?', NULL, 'sprite.groupcollide()', NULL, '2026-06-04 16:13:08.404062+00', 0.62196314, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e20ee4ca-48ec-4bbb-ad87-c87b957e527f', 76, 152, 'coding', 'applied', 'You are given a list `data_points`. Your task is to:
1. Print the current length of `data_points`.
2. Create an independent copy of `data_points` called `archived_data` using the slicing method.
3. Add the number `100` to the original `data_points` list.
4. Print the `data_points` list.
5. Print the `archived_data` list.', NULL, NULL, '[{"input": "", "expected_output": "3\n[10, 20, 30, 100]\n[10, 20, 30]"}]', '2026-06-06 14:55:17.972579+00', 0.49262905, 'data_points = [10, 20, 30]

# 1. Print the current length of data_points
# TODO: Add code here

# 2. Create an independent copy of data_points called archived_data
# TODO: Add code here

# 3. Add the number 100 to the original data_points list
# TODO: Add code here

# 4. Print the data_points list
# TODO: Add code here

# 5. Print the archived_data list
# TODO: Add code here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7fdf62c9-e117-4633-a55f-16009c96832c', 80, 171, 'coding', 'applied', 'You are given raw data representing monthly sales figures for different products. Each entry is a dictionary with a ''product_name'', ''month'', and ''sales_amount''. Your task is to transform this raw data into a nested structure that makes it easy to retrieve *all* sales amounts for a specific product, or *all* sales for a specific month. 

Create a `dictionary of dictionaries` where the outer keys are ''product_name''s, and the inner dictionaries have ''month''s as keys and ''sales_amount''s as values. For any given product-month combination, there will be only one sales amount.

Process the `raw_sales_data` and print the resulting `processed_sales` dictionary.', NULL, NULL, '[{"input": "", "expected_output": "{''Laptop'': {''Jan'': 1200, ''Feb'': 1500}, ''Mouse'': {''Jan'': 50, ''Feb'': 60}, ''Keyboard'': {''Jan'': 75}}"}]', '2026-06-06 14:57:40.230173+00', 0.4229923, 'raw_sales_data = [
    {"product_name": "Laptop", "month": "Jan", "sales_amount": 1200},
    {"product_name": "Mouse", "month": "Jan", "sales_amount": 50},
    {"product_name": "Laptop", "month": "Feb", "sales_amount": 1500},
    {"product_name": "Keyboard", "month": "Jan", "sales_amount": 75},
    {"product_name": "Mouse", "month": "Feb", "sales_amount": 60}
]

processed_sales = {}

# TODO: Implement the logic to transform raw_sales_data into processed_sales


print(processed_sales)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('251b9c0c-2dc9-4efc-888a-689f3bb0e4fe', 83, 182, 'multiple_choice', 'foundational', 'Which of the following best describes the purpose of using an `if` statement inside a loop for data processing?', '[{"text": "To run the loop a specific number of times.", "label": "A"}, {"text": "To skip elements that do not meet a certain condition.", "label": "B"}, {"text": "To repeat a block of code until a condition is false.", "label": "C"}, {"text": "To define a new function within the loop''s scope.", "label": "D"}]', 'To skip elements that do not meet a certain condition.', NULL, '2026-06-06 14:59:35.774898+00', 0.32896474, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cc19a98c-57e5-4e98-ac1e-0ec32cf4a19c', 58, 115, 'multiple_choice', 'foundational', 'What is the primary benefit of making games to learn a language?', '[{"text": "It is the fastest way to become a professional game developer.", "label": "A"}, {"text": "It makes it more likely you''ll publish a game for profit.", "label": "B"}, {"text": "It provides a deeply satisfying way to learn and understand game development.", "label": "C"}, {"text": "It removes the need for planning before writing code.", "label": "D"}]', 'It provides a deeply satisfying way to learn and understand game development.', NULL, '2026-06-04 16:13:02.629278+00', 0.31554133, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('09f48022-c14c-4a03-b19a-e61ea38fdf70', 58, 115, 'short_answer', 'foundational', 'What key is used to make the rocket ship fire bullets?', NULL, 'spacebar', NULL, '2026-06-04 16:13:02.673202+00', 0.43424052, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b5ca4f30-298c-4b46-8a42-39333399776b', 58, 115, 'multiple_choice', 'applied', 'Why are two separate ''if'' blocks used for ''self.moving_right'' and ''self.moving_left'' in the ''update()'' method instead of an ''elif'' for ''self.moving_left''?', '[{"text": "To prevent the ship from moving too fast.", "label": "A"}, {"text": "To ensure the ship always prioritizes moving right.", "label": "B"}, {"text": "To allow the ship to stand still if both keys are held, and provide more accurate movement when changing directions.", "label": "C"}, {"text": "To simplify the code for the ''update()'' method.", "label": "D"}]', 'To allow the ship to stand still if both keys are held, and provide more accurate movement when changing directions.', NULL, '2026-06-04 16:13:02.752495+00', 0.69106156, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f05ebdce-3717-4bea-ba3c-8a704e070fe1', 58, 115, 'explanation', 'advanced', 'Explain the purpose of refactoring code regularly in a game development project.', NULL, 'Refactoring code on a regular basis helps to clarify the code, make it more readable, and keep the main loops simple. This facilitates ongoing development by making it easier to add new features, understand the game''s logic at a glance, and maintain the project over time.', NULL, '2026-06-04 16:13:02.807567+00', 0.35796055, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d023f012-ab04-45c0-aca3-c6d7831c1541', 58, 115, 'short_answer', 'applied', 'If a new fleet of aliens appears after the player destroys all the previous aliens, what characteristic will be different about the new fleet compared to the old one?', NULL, 'The new fleet will move faster.', NULL, '2026-06-04 16:13:02.938764+00', 0.3952249, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('834ccf69-d529-4414-a5cf-85edf4daacc8', 60, 117, 'multiple_choice', 'foundational', 'Which module allows Pygame to render text to the screen?', '[{"text": "pygame.font", "label": "A"}, {"text": "pygame.display", "label": "B"}, {"text": "pygame.sprite", "label": "C"}, {"text": "pygame.rect", "label": "D"}]', 'pygame.font', NULL, '2026-06-04 16:13:12.74662+00', 0.6922729, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b8966db3-9ca6-4dc7-9621-8c7fc7d3b0a2', 60, 117, 'short_answer', 'applied', 'In the `_prep_msg()` method of the `Button` class, what is the purpose of the Boolean value passed to `font.render()`?', NULL, 'It turns antialiasing on or off.', NULL, '2026-06-04 16:13:12.822381+00', 0.4086907, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('63409702-853d-404e-99ab-ef4e192baf0c', 60, 117, 'multiple_choice', 'foundational', 'When is the `Scoreboard` instance created in the `AlienInvasion` game?', '[{"text": "In the `_update_screen()` method", "label": "A"}, {"text": "In the `_check_bullet_alien_collisions()` method", "label": "B"}, {"text": "In the `__init__()` method of `AlienInvasion`", "label": "C"}, {"text": "In the `show_score()` method", "label": "D"}]', 'In the `__init__()` method of `AlienInvasion`', NULL, '2026-06-04 16:13:12.865872+00', 0.6289163, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c2df4677-f76f-479f-bdec-b9612adf3f48', 60, 117, 'explanation', 'advanced', 'Explain how the game''s score is updated and displayed when an alien is shot down, detailing the methods involved and their sequence of execution.', NULL, 'When an alien is shot down, detected by a bullet-alien collision, the `_check_bullet_alien_collisions()` method is called. Inside this method, the player''s score (`self.stats.score`) is increased by the `self.settings.alien_points` value. Immediately after updating the score, `self.sb.prep_score()` is called. This method is responsible for re-rendering the score text into an image so it reflects the new score. Finally, in the game''s `_update_screen()` method, `self.sb.show_score()` is called to draw this updated score image onto the screen.', NULL, '2026-06-04 16:13:12.971139+00', 0.7574078, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('57267989-a9d6-4737-b46c-667b847fd7c6', 60, 117, 'short_answer', 'applied', 'What is the default font used by `pygame.font.SysFont()` when `None` is passed as the first argument?', NULL, 'The default font.', NULL, '2026-06-04 16:13:13.026535+00', 0.5142313, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7432693e-f0dc-4f97-ab9f-8454f419467a', 61, 118, 'multiple_choice', 'foundational', 'Which Python library is introduced for creating simple plots like line graphs and scatter plots?', '[{"text": "Plotly", "label": "A"}, {"text": "Matplotlib", "label": "B"}, {"text": "pytest", "label": "C"}, {"text": "json", "label": "D"}]', 'Matplotlib', NULL, '2026-06-04 16:13:23.80278+00', 0.68054914, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4d2caa36-26da-43ac-ae0a-5e34674b2791', 61, 118, 'short_answer', 'foundational', 'What command is used to install Matplotlib using pip?', NULL, 'python -m pip install --user matplotlib (or python3 -m pip install --user matplotlib)', NULL, '2026-06-04 16:13:23.893784+00', 0.4601671, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6ee27912-7dfa-4012-98a1-110c60bf935f', 61, 118, 'multiple_choice', 'applied', 'When plotting a random walk, what is the purpose of passing `edgecolors=''none''` to `ax.scatter()`?', '[{"text": "To make the points larger.", "label": "A"}, {"text": "To remove the black outline from each dot.", "label": "B"}, {"text": "To change the shape of the points.", "label": "C"}, {"text": "To make the points transparent.", "label": "D"}]', 'To remove the black outline from each dot.', NULL, '2026-06-04 16:13:23.938052+00', 0.5452963, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a1528afc-65ee-4c0f-a621-59bb79e54099', 61, 118, 'explanation', 'advanced', 'Explain how the starting and ending points of a random walk are emphasized in a visualization, including the code parameters used.', NULL, 'To emphasize the starting and ending points, they are plotted individually after the main series of points. The starting point (0, 0) is plotted in green using `c=''green''` and given a larger size using `s=100`. The ending point, accessed as `rw.x_values[-1]` and `rw.y_values[-1]`, is plotted in red using `c=''red''` and also given a larger size using `s=100`. The `edgecolors=''none''` parameter is used for these points as well to prevent outlines, ensuring they stand out clearly against the other points of the walk.', NULL, '2026-06-04 16:13:24.035819+00', 0.7089041, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('403b393f-f2e1-4988-9dbf-97e6db493e52', 61, 118, 'short_answer', 'applied', 'What module is used to process weather data stored in the CSV format?', NULL, 'csv', NULL, '2026-06-04 16:13:24.078961+00', 0.5156022, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d65e9e83-5208-4191-b34d-1207ba8d7fc5', 62, 119, 'multiple_choice', 'foundational', 'What is a simple way to store data in a text file using values separated by commas?', '[{"text": "XML File Format", "label": "A"}, {"text": "JSON File Format", "label": "B"}, {"text": "CSV File Format", "label": "C"}, {"text": "TXT File Format", "label": "D"}]', 'CSV File Format', NULL, '2026-06-04 16:13:27.755796+00', 0.577327, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0347ce27-d50c-4569-ac73-05302c732795', 62, 119, 'short_answer', 'applied', 'What specific Python module is used to parse lines in a CSV file and extract values?', NULL, 'csv', NULL, '2026-06-04 16:13:27.800608+00', 0.61606574, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1e3615d0-2dba-4e09-847b-3d3d57e15421', 62, 119, 'multiple_choice', 'foundational', 'Which of the following is true about CSV files?', '[{"text": "They are easy for humans to read but difficult for programs to process.", "label": "A"}, {"text": "They are tedious for humans to read but programs can process them quickly and accurately.", "label": "B"}, {"text": "They only store numerical data.", "label": "C"}, {"text": "They always contain the headers ''STATION'', ''NAME'', ''DATE'', ''TAVG'', ''TMAX'', ''TMIN''.", "label": "D"}]', 'They are tedious for humans to read but programs can process them quickly and accurately.', NULL, '2026-06-04 16:13:27.84529+00', 0.49658778, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7ad1da25-2391-4d7c-8898-8bab334814e8', 62, 119, 'explanation', 'advanced', 'Explain the purpose of using a ''reader object'' from the csv module and the ''next()'' function when processing a CSV file, specifically in the context of handling headers.', NULL, 'A reader object (created by `csv.reader()`) is used to parse each line of a CSV file. The `next()` function, when called on this reader object, returns the next line in the file. Calling `next()` once at the beginning is used to retrieve the first line, which typically contains the file headers. This allows the program to access and understand what kind of information each column of data represents, before processing the actual data rows.', NULL, '2026-06-04 16:13:27.960739+00', 0.55881315, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7470ee84-eec0-4160-a936-d178176ed767', 62, 119, 'short_answer', 'foundational', 'After reading a file and chaining the `splitlines()` method, what is assigned to the `lines` variable?', NULL, 'a list of all lines in the file', NULL, '2026-06-04 16:13:28.010736+00', 0.41069803, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eb8e8e68-ec03-43fd-b8ec-934e4175c17e', 77, 153, 'multiple_choice', 'foundational', 'Which of the following best describes the purpose of a `for` loop in Python?', '[{"text": "To define a new function.", "label": "A"}, {"text": "To execute a block of code repeatedly for each item in a sequence.", "label": "B"}, {"text": "To make a decision based on a condition.", "label": "C"}, {"text": "To create a new list from an existing one.", "label": "D"}]', 'To execute a block of code repeatedly for each item in a sequence.', NULL, '2026-06-06 14:55:51.785863+00', 0.63608843, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2762dbc9-4f32-4978-a4cc-6d58f61fd0d3', 77, 153, 'coding', 'applied', 'Write a Python program that uses a `for` loop to iterate through the given list of colors `[''red'', ''green'', ''blue'']` and print each color on a new line.', NULL, NULL, '[{"input": "", "expected_output": "red\ngreen\nblue"}]', '2026-06-06 14:55:51.785863+00', 0.5497759, 'colors = [''red'', ''green'', ''blue'']

# Your for loop here
# For example: for color in colors:
    # print(color)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9c15e2a2-3c86-4831-aebf-64a8faaa4f55', 77, 153, 'short_answer', 'foundational', 'If you have a string `word = ''Python''`, what will be the value of the loop variable `char` in the first iteration of `for char in word:`?', NULL, 'P', NULL, '2026-06-06 14:55:51.785863+00', 0.58607596, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('192d2007-e5a3-4469-bfc4-a2866d70666d', 77, 154, 'multiple_choice', 'foundational', 'What sequence of numbers does `range(4)` generate?', '[{"text": "0, 1, 2, 3", "label": "A"}, {"text": "1, 2, 3, 4", "label": "B"}, {"text": "0, 1, 2, 3, 4", "label": "C"}, {"text": "1, 2, 3", "label": "D"}]', '0, 1, 2, 3', NULL, '2026-06-06 14:55:51.785863+00', 0.53718436, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1de1864d-06d8-4771-808c-2bc80a63e3f8', 77, 154, 'short_answer', 'applied', 'If you want to loop from the number 5 up to (but not including) the number 12, what would be the correct `range()` function call?', NULL, 'range(5, 12)', NULL, '2026-06-06 14:55:51.785863+00', 0.54190665, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('48303952-8d84-4485-9bd5-40f66c376076', 77, 154, 'coding', 'applied', 'Your task is to print the first 5 multiples of 3. That is, print 3, 6, 9, 12, and 15, each on a new line. Use a `for` loop and the `range()` function with a ''step'' argument to achieve this.', NULL, NULL, '[{"input": "", "expected_output": "3\n6\n9\n12\n15\n"}]', '2026-06-06 14:55:51.785863+00', 0.60243833, '# Use a for loop with range() here
# For example, range(start, stop, step)

# Your code starts here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('36e107a6-2e93-4746-9d6a-e447c29e41f7', 77, 155, 'multiple_choice', 'foundational', 'What is the primary role of indentation in Python?', '[{"text": "To make code look pretty and more readable.", "label": "A"}, {"text": "To define code blocks and determine which statements belong together.", "label": "B"}, {"text": "To signify comments in the code.", "label": "C"}, {"text": "To separate different Python files.", "label": "D"}]', 'To define code blocks and determine which statements belong together.', NULL, '2026-06-06 14:55:51.785863+00', 0.73514384, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bea34101-c750-4b41-9f0b-134db9cb9c07', 77, 155, 'explanation', 'advanced', 'You are debugging a Python program and encounter an `IndentationError: expected an indented block`. Describe what this error means and provide at least two common scenarios that could cause it.', NULL, 'An `IndentationError: expected an indented block` means that Python was expecting a block of code to be indented (typically after a statement like `for`, `if`, `while`, or a function definition `def`), but it found no indented lines or found a line at an incorrect indentation level. 

Two common scenarios causing this error are:
1. **Missing Indentation:** A control flow statement (like a `for` loop or `if` statement) is followed immediately by a line that is *not* indented, leaving an empty block where Python expects content. For example:
   python
   for i in range(3):
   print(''Hello'') # This line is not indented
   
2. **Incorrect Indentation Level:** A line intended to be part of a block is either not indented enough, or indented too much, or its indentation doesn''t match the rest of the block. Python expects a consistent indentation level for all statements within the same block.
   python
   if True:
     print(''This is okay'')
    print(''This is an error'') # Incorrect indentation relative to the ''if'' block
   
Another scenario could be mixing tabs and spaces for indentation, which can sometimes look correct but Python interprets differently.', NULL, '2026-06-06 14:55:51.785863+00', 0.8182502, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('262ea363-1556-46f9-b744-41242f55b972', 77, 156, 'multiple_choice', 'foundational', 'What is the primary purpose of initializing an accumulator variable *before* a loop?', '[{"text": "To reset its value in each iteration of the loop.", "label": "A"}, {"text": "To provide a starting point for building a cumulative result.", "label": "B"}, {"text": "To make the loop run faster.", "label": "C"}, {"text": "To prevent infinite loops.", "label": "D"}]', 'To provide a starting point for building a cumulative result.', NULL, '2026-06-06 14:55:51.785863+00', 0.6611179, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('115e35bb-436e-4840-8649-ef2977989684', 77, 156, 'coding', 'applied', 'You are given a list of words. Use the accumulator pattern to create a new list containing only the words that have more than 4 letters. Print the resulting list.', NULL, NULL, '[{"input": "", "expected_output": "[''apple'', ''banana'', ''elephant'']"}]', '2026-06-06 14:55:51.785863+00', 0.17704254, 'words = [''apple'', ''banana'', ''cat'', ''dog'', ''elephant'', ''frog'']

# Initialize your accumulator here
long_words = []

# Loop through the words and accumulate
for word in words:
    # Add your condition and accumulation logic here
    # TODO: Check word length and add to long_words if > 4
    pass

print(long_words)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5a5ee6c9-60fe-4e8c-8b28-6f11101d7929', 77, 156, 'explanation', 'advanced', 'Explain why initializing an accumulator variable *inside* a loop would typically lead to incorrect results when trying to compute a sum, product, or collect items. Provide an example to illustrate your point.', NULL, 'Initializing an accumulator inside a loop means that the accumulator''s value would be reset to its initial state (e.g., 0 for a sum, 1 for a product, an empty list for collection) at the beginning of *each* iteration. This prevents the accumulation from happening across iterations. Instead of building up a total or collecting all relevant items, the accumulator would only reflect the contribution of the *last* iteration or the last item processed.

Example for sum:
`numbers = [1, 2, 3]`
`for num in numbers:`
`    current_sum = 0  # INCORRECT: accumulator initialized inside`
`    current_sum += num`
`print(current_sum)`

Output: `3` (only the last number, because `current_sum` was reset to 0 for 1 and 2, then became 3 for the last num). The correct sum is 6.

Example for collecting items:
`items = [''a'', ''b'', ''c'']`
`for item in items:`
`    collected_items = [] # INCORRECT: accumulator initialized inside`
`    collected_items.append(item)`
`print(collected_items)`

Output: `[''c'']` (only the last item, because `collected_items` was reset to `[]` for ''a'' and ''b'', then contained only ''c''). The correct collection should be `[''a'', ''b'', ''c'']`.', NULL, '2026-06-06 14:55:51.785863+00', 0.80625796, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('24f908bf-8c38-407f-b517-21555ff0ccc0', 63, 120, 'multiple_choice', 'foundational', 'Which of the following best describes the purpose of Git?', '[{"text": "To generate interactive visualizations of project data.", "label": "A"}, {"text": "To allow programmers to collaborate on coding projects and manage changes.", "label": "B"}, {"text": "To automatically download information about popular projects from external sites.", "label": "C"}, {"text": "To process data from an API call into a specific format like JSON.", "label": "D"}]', 'To allow programmers to collaborate on coding projects and manage changes.', NULL, '2026-06-04 16:13:32.971415+00', 0.53559405, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6cb8c595-5373-4878-9bc4-5861d30d41c5', 63, 120, 'short_answer', 'applied', 'In the GitHub API call `https://api.github.com/search/repositories?q=language:python+sort:stars`, what does `q=` signify?', NULL, 'It signals that a query is about to begin.', NULL, '2026-06-04 16:13:33.187633+00', 0.60878515, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9a18e05c-e738-4e92-ad55-42009ebfb21b', 63, 120, 'explanation', 'advanced', 'Explain how the `fig.update_layout()` method in Plotly is used to customize a chart.', NULL, 'The `fig.update_layout()` method is used to modify specific elements of a Plotly chart after the initial `px.bar()` call. It allows for adjustments such as setting the title font size or the font size for axis titles. Plotly uses a convention where aspects of a chart element are connected by underscores for consistent naming and modification patterns.', NULL, '2026-06-04 16:13:33.444045+00', 0.72768503, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('87bf135f-be4d-4e9c-9e2e-6db741efc72b', 63, 120, 'multiple_choice', 'foundational', 'What does a ''star'' on a GitHub project indicate?', '[{"text": "The project has an open bug report.", "label": "A"}, {"text": "The project is currently being developed.", "label": "B"}, {"text": "Users show support for the project and want to track it.", "label": "C"}, {"text": "The project is ready for production use.", "label": "D"}]', 'Users show support for the project and want to track it.', NULL, '2026-06-04 16:13:33.60713+00', 0.5869521, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b2c12077-1bfc-4b19-ae1e-875e7b365d01', 63, 120, 'short_answer', 'applied', 'What two pieces of information are explicitly stored in separate lists to create the initial bar chart of GitHub projects?', NULL, 'The name of each project (repo_names) and the number of stars (stars).', NULL, '2026-06-04 16:13:33.672454+00', 0.5441746, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ecf9af73-18ec-48b2-b3a6-1b761840d2ef', 64, 121, 'multiple_choice', 'foundational', 'What is the primary purpose of a virtual environment when setting up a Django project?', '[{"text": "To speed up the execution of the web application.", "label": "A"}, {"text": "To isolate project-specific Python packages from other projects.", "label": "B"}, {"text": "To provide a graphical user interface for Django development.", "label": "C"}, {"text": "To deploy the web application to a live server.", "label": "D"}]', 'To isolate project-specific Python packages from other projects.', NULL, '2026-06-04 16:13:39.703177+00', 0.60562164, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f5932c76-a7a8-4236-bca7-9a994f47260e', 64, 121, 'short_answer', 'applied', 'After creating a virtual environment named `ll_env` within the `learning_log` directory, what command should be used to activate it?', NULL, 'source ll_env/bin/activate', NULL, '2026-06-04 16:13:39.770353+00', 0.54342854, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('388e540e-1e35-4632-95de-f62ffc2b458a', 64, 121, 'explanation', 'advanced', 'Explain the benefit of using the Django shell for troubleshooting and data interaction, especially when compared to debugging within web page files.', NULL, 'The Django shell provides a simple, isolated environment to directly interact with your project''s data and models. This makes it easier to test data retrieval and manipulation logic. If code works as expected in the shell, it''s likely to work in the project files. Troubleshooting in the shell is more efficient because you''re directly testing data access without the additional complexity of web page rendering or server interaction that would be present when debugging within web page files.', NULL, '2026-06-04 16:13:39.849074+00', 0.55094606, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('302bb69f-d050-477f-a8eb-543bfff0f23f', 64, 121, 'multiple_choice', 'foundational', 'According to the provided content, what is the ''Learning Log'' web app designed to allow users to do?', '[{"text": "Manage their financial investments and track expenses.", "label": "A"}, {"text": "Log topics of interest and make journal entries about them.", "label": "B"}, {"text": "Create and share photo albums with friends and family.", "label": "C"}, {"text": "Develop and host personal websites without coding knowledge.", "label": "D"}]', 'Log topics of interest and make journal entries about them.', NULL, '2026-06-04 16:13:39.894293+00', 0.5600735, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bd1c38e0-2b71-416c-adaf-60ef56e2bc42', 64, 121, 'short_answer', 'applied', 'When accessing entries related to a specific topic through a foreign key relationship, what is the general syntax for doing so, assuming ''t'' is a topic object?', NULL, 't.entry_set.all()', NULL, '2026-06-04 16:13:39.946311+00', 0.44911194, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c49a060b-5859-4277-8459-36b616009ce0', 65, 122, 'multiple_choice', 'foundational', 'What is the primary purpose of Django''s ModelForm when building a form?', '[{"text": "To validate user information as the right kind of data and not malicious.", "label": "A"}, {"text": "To automatically build a form based on information from existing models.", "label": "B"}, {"text": "To process and save valid information to the appropriate place in the database.", "label": "C"}, {"text": "To define the URL for a new page and write a view function.", "label": "D"}]', 'To automatically build a form based on information from existing models.', NULL, '2026-06-04 16:13:43.620643+00', 0.5928485, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('49061cd5-1592-424c-b32b-7282e26fa5dc', 65, 122, 'short_answer', 'foundational', 'In Django''s authentication system, what attribute of the ''user'' object is checked to determine if a user is currently logged in?', NULL, 'is_authenticated', NULL, '2026-06-04 16:13:43.740806+00', 0.54435074, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1fff8068-122c-4225-8b32-b1aa74546b54', 65, 122, 'explanation', 'applied', 'Explain the two different situations the `new_topic()` view function needs to handle.', NULL, 'The `new_topic()` view function needs to handle initial requests for the new_topic page, in which case it should show a blank form. It also needs to handle the processing of any data submitted in the form, and after data from a submitted form is processed, it needs to redirect the user.', NULL, '2026-06-04 16:13:43.804753+00', 0.67222553, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ac94092c-248b-4834-90a6-27d1f7c19127', 65, 122, 'multiple_choice', 'applied', 'When is the `LOGIN_REDIRECT_URL` setting used in Django?', '[{"text": "To specify the URL for logging out of the application.", "label": "A"}, {"text": "To define the URL where a user creates a new account.", "label": "B"}, {"text": "To tell Django where to redirect a user after a successful login attempt.", "label": "C"}, {"text": "To display a greeting to authenticated users on every page.", "label": "D"}]', 'To tell Django where to redirect a user after a successful login attempt.', NULL, '2026-06-04 16:13:43.845596+00', 0.621738, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cdf35d12-b011-4dc7-8277-bfb9ab79eaa2', 65, 122, 'short_answer', 'advanced', 'What is the security risk associated with a user being able to add an entry to another user''s learning log by entering a URL with the ID of a topic belonging to another user, and how can this be prevented?', NULL, 'The risk is that a user can illegally add data to another user''s account. This can be prevented by checking that the current user owns the entry''s topic before saving the new entry.', NULL, '2026-06-04 16:13:43.912449+00', 0.5421757, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a8f8a273-115f-475e-bcd3-4916b5d81823', 66, 123, 'multiple_choice', 'foundational', 'Which command is used to install the `django-bootstrap5` app in an active virtual environment?', '[{"text": "`pip install django-bootstrap5`", "label": "A"}, {"text": "`python install django-bootstrap5`", "label": "B"}, {"text": "`npm install django-bootstrap5`", "label": "C"}, {"text": "`django-admin install django-bootstrap5`", "label": "D"}]', '`pip install django-bootstrap5`', NULL, '2026-06-04 16:13:49.161216+00', 0.50517577, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('47fb6c39-2a98-4212-8b4a-44c91eacd1d2', 66, 123, 'explanation', 'advanced', 'Explain the purpose of the `.platform.app.yaml` file in the context of deploying an application to Platform.sh, and describe what would happen if the file were saved without the leading dot.', NULL, 'The `.platform.app.yaml` file controls the overall deployment process for an application on Platform.sh. It specifies critical configurations such as the project name, Python version, relationships to other services (like databases), and commands to start the web server (e.g., using Gunicorn). If the file is saved without the leading dot (e.g., `platform.app.yaml` instead of `.platform.app.yaml`), Platform.sh will not find the file, and as a result, the project will not be deployed because the deployment platform relies on this specific filename for configuration.', NULL, '2026-06-04 16:13:49.397448+00', 0.66611063, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('023d8cfc-4742-40eb-86ae-9ca3803be1b6', 66, 123, 'multiple_choice', 'applied', 'When making a topic public in an extended Learning Log, which of the following is required for unauthenticated users to view the public topics?', '[{"text": "Creating a new `public` attribute in the `Topic` model and revising `views.py`.", "label": "A"}, {"text": "Deleting the `public` attribute from the `Topic` model.", "label": "B"}, {"text": "Setting `DEBUG = True` in `settings.py`.", "label": "C"}, {"text": "Removing all forms from the `new_topic` page.", "label": "D"}]', 'Creating a new `public` attribute in the `Topic` model and revising `views.py`.', NULL, '2026-06-04 16:13:49.449335+00', 0.5552246, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4003cf06-7d86-470d-94d9-ab48d063a66b', 68, 125, 'multiple_choice', 'foundational', 'Which of the following is NOT listed as a reason to recommend VS Code?', '[{"text": "It''s free and open source.", "label": "A"}, {"text": "It can be installed on all major operating systems.", "label": "B"}, {"text": "It has a steep learning curve for beginners.", "label": "C"}, {"text": "It finds installed Python versions and typically requires no configuration for first programs.", "label": "D"}]', 'It has a steep learning curve for beginners.', NULL, '2026-06-04 16:13:59.920457+00', 0.5653163, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('388a4700-8d3e-4e4f-a2e7-e16de18a5d09', 68, 125, 'short_answer', 'applied', 'When changing the `console` setting in `launch.json` from `integratedTerminal` to `internalConsole`, what type of Python function will NOT work in the Debug Console?', NULL, 'input()', NULL, '2026-06-04 16:14:00.026546+00', 0.5394992, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e3d13b62-49c1-4297-8d1e-7fbdc29f9ea4', 68, 125, 'explanation', 'advanced', 'Explain two ways in which the lines have blurred between traditional text editors and IDEs.', NULL, 'A strong answer should mention: 1. Most popular editors now include features that were previously exclusive to IDEs. 2. Most IDEs can be configured to operate in a lighter mode that is less distracting, while still allowing access to more advanced features when needed.', NULL, '2026-06-04 16:14:00.108854+00', 0.46368238, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6c5645a9-4370-46ba-a822-0b6c60ef8fca', 68, 125, 'multiple_choice', 'foundational', 'What is the primary function of pressing CTRL-/ (or ⌘-/) in VS Code after highlighting a block of code?', '[{"text": "To indent the selected code.", "label": "A"}, {"text": "To run the selected code.", "label": "B"}, {"text": "To temporarily disable the selected code by commenting it out.", "label": "C"}, {"text": "To delete the selected code.", "label": "D"}]', 'To temporarily disable the selected code by commenting it out.', NULL, '2026-06-04 16:14:00.157015+00', 0.55331725, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eb605a9e-dc05-4d4c-b92e-1457bf967c88', 68, 125, 'short_answer', 'applied', 'What is a key characteristic of Jupyter Notebooks that differentiates them from traditional text editors or IDEs, specifically regarding their structure?', NULL, 'They are primarily built of blocks, where each block is either a code block or a text block.', NULL, '2026-06-04 16:14:00.226543+00', 0.600423, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6c10a442-c376-40ac-beed-f6571a822a49', 70, 127, 'multiple_choice', 'foundational', 'How can you check if Git is already installed on your system?', '[{"text": "Issue the command `git --version` in a terminal window.", "label": "A"}, {"text": "Look for a ''Git'' folder in your Program Files directory.", "label": "B"}, {"text": "Check your system''s installed applications list.", "label": "C"}, {"text": "Run `git install check` from the command line.", "label": "D"}]', 'Issue the command `git --version` in a terminal window.', NULL, '2026-06-04 16:14:09.746148+00', 0.52741086, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('40ff1cfa-4177-44f1-9ed8-deb987e90c3c', 70, 127, 'short_answer', 'applied', 'What Git command is used to record a username globally for tracking changes?', NULL, 'git config --global user.name "username"', NULL, '2026-06-04 16:14:09.80501+00', 0.48273152, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('738b3d27-2c53-4227-855a-66ffaad377d4', 70, 127, 'multiple_choice', 'foundational', 'Which file is used to tell Git to ignore specific files or directories?', '[{"text": ".ignorefile", "label": "A"}, {"text": ".gitexclude", "label": "B"}, {"text": ".gitignore", "label": "C"}, {"text": "ignore.git", "label": "D"}]', '.gitignore', NULL, '2026-06-04 16:14:09.850488+00', 0.6205336, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('62fba223-c1fa-4501-b26d-a635890a470a', 70, 127, 'explanation', 'advanced', 'Explain the purpose of the `-a` flag when used with the `git commit` command, and what you should do if new files are created between commits.', NULL, 'The `-a` flag tells Git to add all modified files in the repository to the current commit. If new files are created between commits, you need to reissue the `git add .` command to include those new files in the repository before committing.', NULL, '2026-06-04 16:14:09.926905+00', 0.62253815, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2b0d8831-1003-481c-ab17-2ce17c85799f', 70, 127, 'short_answer', 'applied', 'After intentionally abandoning changes in a file using `git restore filename`, what would `git status` typically report?', NULL, 'On branch main nothing to commit, working tree clean', NULL, '2026-06-04 16:14:09.98144+00', 0.6947697, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8f27e1d6-d798-4fd3-9072-4c5b9164e0eb', 77, 157, 'multiple_choice', 'foundational', 'Which of the following is the most concise way to create a list of numbers from 0 to 9?', '[{"text": "numbers = [i for i in range(10)]", "label": "A"}, {"text": "numbers = []\nfor i in range(10):\n    numbers.add(i)", "label": "B"}, {"text": "numbers = range(10).tolist()", "label": "C"}, {"text": "numbers = new list(range(10))", "label": "D"}]', 'numbers = [i for i in range(10)]', NULL, '2026-06-06 14:55:51.785863+00', 0.52847534, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9a235e0c-3e9c-4c55-a08d-321f395fc388', 77, 157, 'short_answer', 'applied', 'What will be the output of the following list comprehension?
`result = [char.upper() for char in ''hello'' if char != ''l'']`', NULL, '[''H'', ''E'', ''O'']', NULL, '2026-06-06 14:55:51.785863+00', 0.46851316, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e579a796-410c-4dd4-a156-cb645bfcdfba', 77, 157, 'explanation', 'advanced', 'Explain two key advantages of using list comprehensions over traditional `for` loops when creating lists.', NULL, 'Two key advantages are:
1. Conciseness and Readability: List comprehensions allow you to create a list in a single, clear line of code, often making the intent of the code more obvious than a multi-line for loop.
2. Efficiency: In many cases, list comprehensions can be more performant than `for` loops for list creation because they are often optimized internally by Python.', NULL, '2026-06-06 14:55:51.785863+00', 0.63086945, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b4cc3783-b72d-4906-8706-99641fbb9ed6', 77, 157, 'coding', 'applied', 'You are given a list of `temperatures` (in Celsius). Use a list comprehension to create a new list called `freezing_temps` that contains only the temperatures that are 0 or below. Print `freezing_temps`.', NULL, NULL, '[{"input": "", "expected_output": "[-3, 0, -8]"}]', '2026-06-06 14:55:51.785863+00', 0.38281718, 'temperatures = [25, -3, 10, 0, 15, -8, 2]

# Your code here
# Create freezing_temps using a list comprehension


print(freezing_temps)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9617cd5f-2605-43e5-a9df-626c7386077e', 81, 172, 'multiple_choice', 'foundational', 'Which keyword is used to check an additional condition if the previous `if` or `elif` conditions were false?', '[{"text": "`else`", "label": "A"}, {"text": "`then`", "label": "B"}, {"text": "`elif`", "label": "C"}, {"text": "`except`", "label": "D"}]', '`elif`', NULL, '2026-06-06 14:58:15.533176+00', 0.61366326, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f564b5e2-02e7-49d7-8ce5-7a8c12a39067', 67, 124, 'multiple_choice', 'foundational', 'What is the simplest command to use in Windows to run the latest installed Python interpreter without making any system changes?', '[{"text": "py", "label": "A"}, {"text": "python", "label": "B"}, {"text": "python3", "label": "C"}, {"text": "cmd", "label": "D"}]', 'py', NULL, '2026-06-04 16:13:54.512493+00', 0.59213823, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('259eb3e4-7df3-4d95-8bf1-2211918931ba', 67, 124, 'short_answer', 'applied', 'On a Windows system, if the ''python'' command is not recognized, what common option might have been forgotten during the initial Python installation?', NULL, 'Add Python to PATH', NULL, '2026-06-04 16:13:54.682342+00', 0.6921594, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2b47c0b6-b824-4280-809b-a1265d59f567', 67, 124, 'explanation', 'advanced', 'Explain why it is generally recommended to avoid installing Apple''s version of Python on macOS, even if prompted to do so, and what the better alternative is.', NULL, 'It is recommended to avoid installing Apple''s version of Python because it is usually somewhat behind the latest official version. The better alternative is to close the pop-up prompting to install command line developer tools, and instead download and run the official Python installer from https://python.org. Even if the developer tools are installed, running the official installer will make the ''python3'' command point to the newer official version.', NULL, '2026-06-04 16:13:54.827177+00', 0.743285, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4be04370-1af6-4cca-afd4-1aa90ddada03', 67, 124, 'multiple_choice', 'foundational', 'Which of the following commands would you use in a terminal to check the specific version of Python that the ''python'' command is currently pointing to?', '[{"text": "python --version", "label": "A"}, {"text": "py -v", "label": "B"}, {"text": "check python version", "label": "C"}, {"text": "python version", "label": "D"}]', 'python --version', NULL, '2026-06-04 16:13:54.877563+00', 0.54260796, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a6ebc08b-b3dd-43c5-8b98-538210bdb27b', 67, 124, 'short_answer', 'applied', 'When installing a newer version of Python on an apt-based Linux system using the deadsnakes package, after adding the repository and updating, what is the next command to install Python 3.11?', NULL, 'sudo apt install python3.11', NULL, '2026-06-04 16:13:54.945215+00', 0.75412667, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2e68f51c-aeec-4b58-8682-5e2f9465d1e1', 69, 126, 'multiple_choice', 'foundational', 'Which of the following is NOT one of the initial questions to answer when seeking help, according to the ''Getting Help'' lesson?', '[{"text": "What are you trying to do?", "label": "A"}, {"text": "What have you tried already?", "label": "B"}, {"text": "What resources did you use to learn the information?", "label": "C"}, {"text": "What exact error messages are you receiving?", "label": "D"}]', 'What resources did you use to learn the information?', NULL, '2026-06-04 16:14:06.193449+00', 0.3089503, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('099865da-0123-4b83-8563-fdca15988f25', 69, 126, 'short_answer', 'applied', 'You are trying to install Python on a new Windows laptop. According to the lesson, what specific phrase might you search for online to find clear answers?', NULL, 'install python windows', NULL, '2026-06-04 16:14:06.257619+00', 0.5140483, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ef55d8fc-f74c-4d41-8689-b024d09c7010', 69, 126, 'explanation', 'advanced', 'Explain the concept of ''rubber duck debugging'' and how it can help you get unstuck.', NULL, 'Rubber duck debugging is when you clearly explain your situation to an inanimate object (like a rubber duck) and ask it a specific question. The act of verbalizing the problem and your attempted solutions often helps you identify what you''re missing or where the mistake lies, allowing you to solve the problem yourself without needing to ask others for help.', NULL, '2026-06-04 16:14:06.327595+00', 0.56900287, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a49c9331-e6c7-4509-95e3-9fca70631e90', 69, 126, 'multiple_choice', 'foundational', 'What is one of the key benefits of taking a break when you''ve been working on the same problem for a while?', '[{"text": "It helps you remember previous solutions more effectively.", "label": "A"}, {"text": "It encourages you to zero in on only one solution.", "label": "B"}, {"text": "It provides a fresh perspective on the problem.", "label": "C"}, {"text": "It makes the problem disappear entirely.", "label": "D"}]', 'It provides a fresh perspective on the problem.', NULL, '2026-06-04 16:14:06.379432+00', 0.47171444, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7a6598ba-e9ee-40ae-b020-c0ee749f3960', 69, 126, 'short_answer', 'applied', 'When asking for help on Stack Overflow, what type of code example are you encouraged to post?', NULL, 'The shortest example of the kind of issue you are facing', NULL, '2026-06-04 16:14:06.427247+00', 0.40012357, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('69daab0f-4b80-4f6d-a218-ea32f4881184', 71, 128, 'multiple_choice', 'foundational', 'Which of the following is NOT typically one of the steps involved in deploying a project to a remote server?', '[{"text": "Creating a virtual server on a physical machine.", "label": "A"}, {"text": "Establishing a connection between the local system and the remote server.", "label": "B"}, {"text": "Developing the project directly on the remote server.", "label": "C"}, {"text": "Identifying and installing project dependencies on the remote server.", "label": "D"}]', 'Developing the project directly on the remote server.', NULL, '2026-06-04 16:14:14.868046+00', 0.48197335, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('359f15cb-b300-4510-b79c-30f3000f82b5', 71, 128, 'short_answer', 'foundational', 'What is the primary resource mentioned for troubleshooting a deployment attempt?', NULL, 'The output generated during the attempted push.', NULL, '2026-06-04 16:14:14.9542+00', 0.6161397, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('db7d440c-d054-46e7-9a64-7e23ff9511d9', 71, 128, 'multiple_choice', 'applied', 'When troubleshooting log output during a deployment, what are the two main goals you should have?', '[{"text": "To understand every single line of code and error message.", "label": "A"}, {"text": "To identify deployment steps that worked and identify steps that didn''t.", "label": "B"}, {"text": "To determine the exact version of the operating system on the remote server.", "label": "C"}, {"text": "To find suggestions for other deployment platforms to use.", "label": "D"}]', 'To identify deployment steps that worked and identify steps that didn''t.', NULL, '2026-06-04 16:14:15.008937+00', 0.51025003, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5f0dc059-8149-4e4e-b7aa-36988102ec08', 71, 128, 'explanation', 'advanced', 'Explain two different approaches for integrating Linux-based toolsets into a Windows environment to facilitate deployment to a remote server, highlighting a key difference between them.', NULL, 'A strong answer should explain Windows Subsystem for Linux (WSL) as an environment that allows Linux to run directly on Windows, making CLI usage on Windows as easy as on Linux. It should also explain Git Bash as a terminal environment compatible with Bash that runs on Windows, noting that it might require using both Windows and Git Bash terminals for different steps and is less streamlined than WSL. The key difference is that WSL provides a full Linux environment, while Git Bash is a Bash-compatible terminal on Windows.', NULL, '2026-06-04 16:14:15.137947+00', 0.66119564, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ee7c385d-61b2-41bc-8c5e-e0e10b0df8ed', 71, 128, 'short_answer', 'foundational', 'What kind of operating system are most remote servers mentioned as typically being based on?', NULL, 'Linux-based systems (or Debian Linux).', NULL, '2026-06-04 16:14:15.187991+00', 0.35992002, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e36a6519-e509-4010-b2ed-f8839f0a23ca', 78, 158, 'multiple_choice', 'foundational', 'Which of the following correctly defines a tuple containing the numbers 1, 2, and 3?', '[{"text": "[1, 2, 3]", "label": "A"}, {"text": "{1, 2, 3}", "label": "B"}, {"text": "(1, 2, 3)", "label": "C"}, {"text": "1, 2, 3", "label": "D"}]', '(1, 2, 3)', NULL, '2026-06-06 14:56:28.29955+00', 0.5594572, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('be2b3f14-0671-4c09-81a3-66fb6a5332df', 78, 158, 'short_answer', 'applied', 'What is the correct way to define a tuple named `my_tuple` that contains only the string ''Python''?', NULL, 'my_tuple = (''Python'',)', NULL, '2026-06-06 14:56:28.29955+00', 0.64794755, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('46c25dc2-49c4-4202-9ab6-5b3f7f3d598b', 78, 158, 'coding', 'applied', 'Create two tuples:
1. `fruits`: containing the strings ''apple'', ''banana'', and ''cherry''.
2. `mix`: containing the integer 100, the float 3.14, and the string ''hello''.

Print both tuples, each on a new line.', NULL, NULL, '[{"input": "", "expected_output": "(''apple'', ''banana'', ''cherry'')\n(100, 3.14, ''hello'')"}]', '2026-06-06 14:56:28.29955+00', 0.4331619, '# Create the ''fruits'' tuple here

# Create the ''mix'' tuple here

# Print the tuples
# print(fruits)
# print(mix)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9b5e4ba5-dce6-4174-b9ef-d4662b5e8d65', 78, 159, 'multiple_choice', 'foundational', 'Which of the following operations will result in a `TypeError` when performed on a tuple `my_tuple = (1, 2, 3)`?', '[{"text": "Accessing an element: `print(my_tuple[0])`", "label": "A"}, {"text": "Reassigning an element: `my_tuple[1] = 5`", "label": "B"}, {"text": "Concatenating with another tuple: `my_tuple + (4, 5)`", "label": "C"}, {"text": "Checking length: `len(my_tuple)`", "label": "D"}]', 'Reassigning an element: `my_tuple[1] = 5`', NULL, '2026-06-06 14:56:28.29955+00', 0.6207937, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('95da6a46-3dfe-49a8-b65a-7291e16d83c3', 78, 159, 'explanation', 'advanced', 'Explain the concept of immutability in Python tuples. What does it mean for a tuple to be immutable, and how does this property distinguish tuples from lists? Provide an example of an operation that would demonstrate immutability.', NULL, 'Immutability means that once a tuple is created, its contents (elements) cannot be altered, added to, or removed. You cannot change an element at a specific index, nor can you add new elements or delete existing ones. This is a key distinction from lists, which are mutable, meaning their elements can be changed after creation.

For example, if you have a tuple `my_tuple = (10, 20, 30)`, attempting to change an element like `my_tuple[0] = 5` would raise a `TypeError`. In contrast, for a list `my_list = [10, 20, 30]`, `my_list[0] = 5` would successfully modify the list to `[5, 20, 30]`.', NULL, '2026-06-06 14:56:28.29955+00', 0.89118856, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d0865276-37d7-4a5e-b6a8-9ad4dadf8835', 78, 159, 'coding', 'applied', 'You are given a tuple `data_point` that contains a nested list. Your task is to try to modify an element within this nested list. Observe that this is possible, even though the tuple itself is immutable. Print the `data_point` before and after the modification attempt.

Specifically, modify the second element of the list nested within `data_point`.', NULL, NULL, '[{"input": "", "expected_output": "Original data_point: (''Experiment A'', [10, 20, 30], ''Passed'')\nModified data_point: (''Experiment A'', [10, 25, 30], ''Passed'')"}]', '2026-06-06 14:56:28.29955+00', 0.64134765, 'data_point = (''Experiment A'', [10, 20, 30], ''Passed'')

print(f"Original data_point: {data_point}")

# TODO: Modify the second element of the nested list (which is at index 1 of the tuple)
# For example, change 20 to 25


print(f"Modified data_point: {data_point}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('33deddc4-dafc-4822-b2d8-38694494ad68', 78, 160, 'multiple_choice', 'foundational', 'What is the primary purpose of tuple unpacking in Python?', '[{"text": "To change the elements of a tuple after it''s created.", "label": "A"}, {"text": "To assign individual elements of a tuple to separate variables in a single line.", "label": "B"}, {"text": "To convert a tuple into a list.", "label": "C"}, {"text": "To access tuple elements using index numbers only.", "label": "D"}]', 'To assign individual elements of a tuple to separate variables in a single line.', NULL, '2026-06-06 14:56:28.29955+00', 0.7729702, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c55c6a5c-a0d1-4ff3-88cb-7c5714380c1c', 78, 160, 'short_answer', 'applied', 'Given the tuple `colors = (''red'', ''green'', ''blue'')`, write a single line of Python code to unpack its elements into three variables named `primary1`, `primary2`, and `primary3`.', NULL, 'primary1, primary2, primary3 = colors', NULL, '2026-06-06 14:56:28.29955+00', 0.62590915, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('925a252c-9656-42f9-954a-442ba185da2f', 78, 160, 'coding', 'applied', 'You are given a tuple `product_details` that contains information about a product: its name, price, and quantity in stock. Your task is to unpack these three values into separate variables named `product_name`, `product_price`, and `product_quantity`. Finally, print the `product_name` and `product_quantity` on separate lines.', NULL, NULL, '[{"input": "", "expected_output": "Laptop\n15"}]', '2026-06-06 14:56:28.29955+00', 0.5202181, 'product_details = ("Laptop", 1200.50, 15)

# Your code here to unpack product_details

# Print product_name and product_quantity
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a021ab7e-0c56-4cf7-aa29-86125e73d1d4', 78, 161, 'multiple_choice', 'foundational', 'Which of the following scenarios is best suited for using a tuple?', '[{"text": "Storing a list of items that frequently need to be added or removed.", "label": "A"}, {"text": "Keeping track of a user''s shopping cart items that can change during a session.", "label": "B"}, {"text": "Representing a constant set of days in a week (e.g., ''Monday'', ''Tuesday'', ..., ''Sunday'').", "label": "C"}, {"text": "Managing a queue of tasks where tasks are processed and removed from the front.", "label": "D"}]', 'Representing a constant set of days in a week (e.g., ''Monday'', ''Tuesday'', ..., ''Sunday'').', NULL, '2026-06-06 14:56:28.29955+00', 0.39398718, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('219e3dd3-ef42-4a25-b754-42415838d7c3', 78, 161, 'short_answer', 'applied', 'You are building a system to store database records for books. Each record consists of a fixed set of fields: ''title'', ''author'', and ''publication_year''. If you want to ensure that these fields for a given book record cannot be accidentally modified once created, would you use a list or a tuple for each book record, and why?', NULL, 'You would use a tuple. Tuples are immutable, which means once a book record (e.g., (''The Great Gatsby'', ''F. Scott Fitzgerald'', 1925)) is created, its elements cannot be changed. This guarantees data integrity and prevents accidental modification, making it suitable for fixed records.', NULL, '2026-06-06 14:56:28.29955+00', 0.55411214, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('90b1b433-05b8-4a7a-9161-e5f0b6bb5809', 78, 161, 'coding', 'applied', 'You need to store the RGB color values (Red, Green, Blue) for a specific color, which are fixed integers between 0 and 255. Represent the color ''Turquoise'' with RGB values (64, 224, 208) using a tuple. Then, print the color name and its RGB values in the format: ''Color: Turquoise, RGB: (64, 224, 208)''.', NULL, NULL, '[{"input": "", "expected_output": "Color: Turquoise, RGB: (64, 224, 208)"}]', '2026-06-06 14:56:28.29955+00', 0.2699795, '# Define the color name
color_name = ''Turquoise''

# TODO: Create a tuple for the RGB values of Turquoise (64, 224, 208)
rgb_values = 

# TODO: Print the color name and its RGB values in the specified format');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1622854e-6928-4202-8580-67f4507a26b4', 78, 162, 'multiple_choice', 'foundational', 'What data type does Python implicitly use to return multiple values from a function?', '[{"text": "List", "label": "A"}, {"text": "Dictionary", "label": "B"}, {"text": "Tuple", "label": "C"}, {"text": "Set", "label": "D"}]', 'Tuple', NULL, '2026-06-06 14:56:28.29955+00', 0.6648205, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ac024c32-2360-4c7d-96a0-fc1adb063e31', 78, 162, 'coding', 'applied', 'Write a Python function called `get_min_max(numbers)` that takes a list of numbers as an argument. The function should return two values: the minimum number and the maximum number in the list. If the input list is empty, return `(None, None)`.

Then, call this function with the list `[8, 3, 12, 5, 9]` and unpack the returned values into `min_val` and `max_val`. Finally, print `min_val` and `max_val` on separate lines.', NULL, NULL, '[{"input": "", "expected_output": "3\n12"}]', '2026-06-06 14:56:28.29955+00', 0.35207146, 'def get_min_max(numbers):
    # TODO: Implement the function to return the minimum and maximum numbers
    # If the list is empty, return (None, None)
    pass

# Call the function and print the results
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b0527eec-dd43-46b7-af11-26523efe5497', 81, 172, 'coding', 'applied', 'Write a Python program that checks the value of a variable named `score`. If `score` is 90 or above, print ''Grade: A''. If `score` is between 80 and 89 (inclusive), print ''Grade: B''. Otherwise (for any score below 80), print ''Grade: C''.

Your program should define `score` at the beginning and then use `if`, `elif`, and `else` statements to determine and print the grade.', NULL, NULL, '[{"input": "", "expected_output": "Grade: B"}, {"input": "", "expected_output": "Grade: A"}]', '2026-06-06 14:58:15.533176+00', 0.4347526, 'score = 85  # You can change this value to test different cases

# Your code goes here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e04ed006-86a1-4683-ac4c-8397bddb8806', 81, 172, 'short_answer', 'applied', 'Consider the following Python code:

python
fruit = "banana"

if fruit == "apple":
    print("It''s red.")
elif fruit == "orange":
    print("It''s orange.")
elif fruit == "banana":
    print("It''s yellow.")
else:
    print("Unknown fruit.")


What will be the exact output when this code is executed?', NULL, 'It''s yellow.', NULL, '2026-06-06 14:58:15.533176+00', 0.5416546, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('de30316e-4d7d-43b8-a88f-1ae38a1356df', 78, 162, 'explanation', 'advanced', 'Explain why returning multiple values as a tuple, which is then unpacked, is a good design choice in Python, considering the immutability of tuples. What benefits does this pattern offer compared to, for instance, returning a mutable list or a custom object?', NULL, 'Returning multiple values as an immutable tuple provides several benefits. Firstly, it clearly signals that the collection of returned values is fixed and should not be modified by the caller. This prevents accidental side effects and makes the function''s contract clearer. Secondly, tuple unpacking provides a very concise and readable way to assign the returned values to individual variables, improving code clarity. Compared to a mutable list, tuples guarantee that the integrity of the returned data set is preserved. Compared to a custom object, tuples are lightweight and don''t require defining a new class for simple groupings of data, making them efficient for common scenarios where a function naturally yields a few related results.', NULL, '2026-06-06 14:56:28.29955+00', 0.6861164, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fa26e2aa-cb19-4a1a-9fcd-7eac57e00f54', 83, 182, 'coding', 'applied', 'You are given a list of temperatures in Celsius. Your task is to print only those temperatures that are 0 degrees Celsius or below (freezing or below). Each temperature should be printed on a new line.

Given temperatures: `[-5, 10, 0, 2, -10, 15]`', NULL, NULL, '[{"input": "", "expected_output": "-5\n0\n-10"}]', '2026-06-06 14:59:35.774898+00', 0.26698533, 'temperatures = [-5, 10, 0, 2, -10, 15]

# TODO: Write a loop and an if statement to print freezing temperatures or below

');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('514c9965-7d49-4b04-9bce-c23298bbbfc6', 79, 163, 'multiple_choice', 'foundational', 'Which of the following is the correct way to create a dictionary literal representing a person''s name as ''Alice'' and age as 30?', '[{"text": "person = [''name'': ''Alice'', ''age'': 30]", "label": "A"}, {"text": "person = (''name'': ''Alice'', ''age'': 30)", "label": "B"}, {"text": "person = {''name'': ''Alice'', ''age'': 30}", "label": "C"}, {"text": "person = name=''Alice'', age=30", "label": "D"}]', 'person = {''name'': ''Alice'', ''age'': 30}', NULL, '2026-06-06 14:56:57.517105+00', 0.46323454, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1cbfee6e-66c6-48f7-94b6-61063f476cee', 79, 163, 'short_answer', 'applied', 'You have a dictionary `my_settings = {''theme'': ''dark'', ''font_size'': 14}`. Write the Python code to change the `font_size` to `16`.', NULL, 'my_settings[''font_size''] = 16', NULL, '2026-06-06 14:56:57.517105+00', 0.2794626, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5fdd57a2-3df3-4892-ad20-08cfe2fad764', 79, 163, 'coding', 'applied', 'Create a dictionary named `car` with the keys ''make'' set to ''Toyota'' and ''model'' set to ''Camry''. Then, add a new key ''year'' with the value 2022. Finally, delete the ''make'' key-value pair from the dictionary and print the resulting `car` dictionary.', NULL, NULL, '[{"input": "", "expected_output": "{''model'': ''Camry'', ''year'': 2022}\n"}]', '2026-06-06 14:56:57.517105+00', 0.30611056, 'car = {
    # Your initial key-value pairs here
}

# Add ''year''

# Delete ''make''

print(car)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a49f78bb-3f6c-41d9-9fa6-efe480ea1f18', 1, 1, 'coding', 'applied', 'Write code that swaps the values of a and b without using a third variable.\n\na = 10\nb = 20\n\n# After your code, a should be 20 and b should be 10', NULL, NULL, '[{"input": "", "expected_output": ""}]', '2026-06-01 16:23:23.934873+00', NULL, 'a = 10
b = 20

# Write your code here to swap a and b
# After your code, a should be 20 and b should be 10
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8d24d67d-3756-4eeb-a800-91b529f94dcc', 1, 3, 'coding', 'advanced', 'Write a program that reads Celsius from input, converts to Fahrenheit, and prints it rounded to 1 decimal place.\n\nFormula: F = (C * 9/5) + 32\n\nInput: 0\nOutput: 32.0', NULL, NULL, '[{"input": "0", "expected_output": "32.0"}, {"input": "100", "expected_output": "212.0"}, {"input": "-40", "expected_output": "-40.0"}]', '2026-06-01 16:23:23.934873+00', NULL, '# Convert Celsius to Fahrenheit
celsius = float(input())

# Write your code here
fahrenheit = (celsius * 9/5) + 32
print(round(fahrenheit, 1))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e02c81cc-fab0-4e45-9e15-8041d77071bf', 2, 5, 'coding', 'applied', 'Write a program that reads an integer from input and prints "Fizz" if divisible by 3, "Buzz" if divisible by 5, "FizzBuzz" if both, else the number.\n\nInput: 15\nOutput: FizzBuzz', NULL, NULL, '[{"input": "15", "expected_output": "FizzBuzz"}, {"input": "9", "expected_output": "Fizz"}, {"input": "10", "expected_output": "Buzz"}, {"input": "7", "expected_output": "7"}]', '2026-06-01 16:23:23.977752+00', NULL, '# FizzBuzz
n = int(input())

# Write your code here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3abe83e3-c945-4ca7-b19e-3611753921de', 2, 6, 'coding', 'advanced', 'Write a program that prints the first 10 Fibonacci numbers (0, 1, 1, 2, 3, 5, 8, 13, 21, 34), one per line.', NULL, NULL, '[{"input": "", "expected_output": "0\\n1\\n1\\n2\\n3\\n5\\n8\\n13\\n21\\n34"}]', '2026-06-01 16:23:23.977752+00', NULL, '# Print the first 10 Fibonacci numbers
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('38e7c812-c61c-49ff-94ed-09cde9c51815', 3, 9, 'coding', 'applied', 'Write a function is_palindrome(s) that returns True if string s is a palindrome (ignoring case), False otherwise.\n\nis_palindrome("Racecar") -> True\nis_palindrome("hello") -> False', NULL, NULL, '[{"input": "Racecar", "expected_output": "True"}, {"input": "hello", "expected_output": "False"}, {"input": "", "expected_output": "True"}]', '2026-06-01 16:23:24.001646+00', NULL, 'def is_palindrome(s):
    # Write your code here
    pass


print(is_palindrome("Racecar"))
print(is_palindrome("hello"))
print(is_palindrome(""))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('30df1a86-25ff-4917-8e4e-9beb98199b2d', 3, 11, 'coding', 'advanced', 'Write a recursive function factorial(n) that returns n! (n factorial). Use recursion, not a loop.', NULL, NULL, '[{"input": "5", "expected_output": "120"}, {"input": "0", "expected_output": "1"}, {"input": "3", "expected_output": "6"}]', '2026-06-01 16:23:24.001646+00', NULL, 'def factorial(n):
    # Write your recursive code here
    pass


print(factorial(5))
print(factorial(0))
print(factorial(3))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6fe7e433-5591-4e47-9ecf-5793781fab21', 4, 15, 'coding', 'applied', 'Use a list comprehension to create a list of all even numbers from 1 to 20 (inclusive). Store in a variable called evens.', NULL, NULL, '[{"input": "", "expected_output": "[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]"}]', '2026-06-01 16:23:24.029067+00', NULL, '# Use a list comprehension to create evens from 1 to 20
evens = [x for x in range(1, 21) if x % 2 == 0]
print(evens)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('843ea9be-579a-4127-bdc1-3210ce88cf9a', 4, 13, 'coding', 'advanced', 'Write count_words(text) that returns a dict counting word occurrences.\n\ncount_words("the cat and the dog") -> {"the": 2, "cat": 1, "and": 1, "dog": 1}', NULL, NULL, '[{"input": "the cat and the dog", "expected_output": "the:2 cat:1 and:1 dog:1"}]', '2026-06-01 16:23:24.029067+00', NULL, 'def count_words(text):
    # Write your code here
    pass


print(count_words("the cat and the dog"))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('41b105be-5319-4513-bb82-09908e954aa6', 5, 16, 'coding', 'applied', 'Define a class BankAccount with:\n- __init__(self, owner, balance=0)\n- deposit(amount) adds to balance\n- withdraw(amount) subtracts if funds sufficient else prints "Insufficient funds"\n- __str__ returns "Account owned by {owner}: ${balance}"', NULL, NULL, '[{"input": "", "expected_output": ""}]', '2026-06-01 16:23:24.062853+00', NULL, 'class BankAccount:
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
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6e53180e-d7cb-461d-a695-03e07dbf036e', 5, 17, 'coding', 'advanced', 'Define a class Rectangle with width, height, and area(). Then define Square that inherits Rectangle and overrides __init__ to take only side.', NULL, NULL, '[{"input": "", "expected_output": ""}]', '2026-06-01 16:23:24.062853+00', NULL, 'class Rectangle:
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
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('96e072f2-8c12-41f6-9b56-ebc348aff00f', 6, 19, 'coding', 'applied', 'Write a program that reads "data.txt", counts the lines, and prints the count. Use a with statement.', NULL, NULL, '[{"input": "", "expected_output": ""}]', '2026-06-01 16:23:24.120256+00', NULL, '# Count lines in "data.txt"
# In this environment, create the file first
with open("data.txt", "w") as f:
    f.write("line 1\nline 2\nline 3\n")

# Now write your code to count the lines
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('78e5f754-6078-42e6-92e4-93484ffe4034', 6, 20, 'coding', 'advanced', 'Write safe_divide(a, b) that returns a / b. Handle ZeroDivisionError and TypeError. Return None on error.', NULL, NULL, '[{"input": "10,2", "expected_output": "5.0"}, {"input": "10,0", "expected_output": "None"}]', '2026-06-01 16:23:24.120256+00', NULL, 'def safe_divide(a, b):
    # Write your code here
    pass


print(safe_divide(10, 2))
print(safe_divide(10, 0))
print(safe_divide(10, "a"))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a0968e1b-9155-4d49-bc9b-3e9c9bc7a554', 79, 164, 'multiple_choice', 'foundational', 'Which dictionary method safely retrieves a value for a given key, returning `None` if the key is not found, instead of raising an error?', '[{"text": "`.fetch()`", "label": "A"}, {"text": "`.get()`", "label": "B"}, {"text": "`.find()`", "label": "C"}, {"text": "`.retrieve()`", "label": "D"}]', '`.get()`', NULL, '2026-06-06 14:56:57.517105+00', 0.47641778, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d36ce177-667a-48d8-a758-09ab42ba57eb', 7, 23, 'coding', 'applied', 'Write parse_users(json_str) that takes a JSON string and returns a list of names. Example input: ''[{"name": "Alice"}, {"name": "Bob"}]'' -> ["Alice", "Bob"]', NULL, NULL, '[]', '2026-06-01 16:23:24.156576+00', NULL, 'import json


def parse_users(json_str):
    # Write your code here
    pass


print(parse_users(''[{"name": "Alice"}, {"name": "Bob"}]''))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bdcdba4b-e001-4f85-bd2c-6b4a82ae5de8', 7, 22, 'coding', 'advanced', 'Write fetch_data(url) that:\n1. Sends a GET request\n2. Returns JSON as dict if status 200\n3. Returns None otherwise\n4. Returns "Error" on network exception\n\nAssume requests is imported.', NULL, NULL, '[{"input": "", "expected_output": ""}]', '2026-06-01 16:23:24.156576+00', NULL, '# Assume requests is imported
# Note: This won''t work in the browser sandbox (no network)
# but practising the logic is still valuable


def fetch_data(url):
    # Write your code here
    pass
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('be111093-259d-4bb2-a534-74325ac778f0', 79, 164, 'short_answer', 'applied', 'You have a dictionary `config = {''port'': 8080, ''timeout'': 30}`. You want to add a `debug_mode` key with a default value of `False` if it doesn''t already exist. Write the single line of Python code using a dictionary method that achieves this while also returning the `debug_mode` value.', NULL, 'config.setdefault(''debug_mode'', False)', NULL, '2026-06-06 14:56:57.517105+00', 0.32743645, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('85300256-f20b-4afe-a1f9-8af19e2b47ad', 79, 164, 'coding', 'applied', 'You are given a dictionary `student_scores`. Your task is to:
1. Use the `.get()` method to retrieve the score for ''Alice''. If ''Alice'' is not found, the default score should be `0`. Print this score.
2. Get a view of all the keys (student names) using `.keys()`. Convert this view into a list and print it.
3. Get a view of all the values (scores) using `.values()`. Convert this view into a list and print it.
4. Get a view of all key-value pairs using `.items()`. Convert this view into a list and print it.', NULL, NULL, '[{"input": "", "expected_output": "0\n[''Bob'', ''Charlie'', ''David'']\n[85, 92, 78]\n[(''Bob'', 85), (''Charlie'', 92), (''David'', 78)]\n"}]', '2026-06-06 14:56:57.517105+00', 0.705054, 'student_scores = {
    ''Bob'': 85,
    ''Charlie'': 92,
    ''David'': 78
}

# Your code here:
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b2db4d54-d3fc-4a5b-9d70-6969da7e834e', 79, 164, 'explanation', 'advanced', 'Explain the difference between iterating directly over a dictionary (e.g., `for key in my_dict:`) and iterating over `my_dict.items()`. Discuss when you might prefer one over the other.', NULL, 'Iterating directly over a dictionary (`for key in my_dict:`) iterates over its keys by default. This is equivalent to `for key in my_dict.keys():`. You would then need to access the value using `my_dict[key]` inside the loop.

Iterating over `my_dict.items()` (`for key, value in my_dict.items():`) iterates over the key-value pairs directly as tuples. This provides both the key and the value in each iteration, often making the code cleaner and more efficient if you need both. You would prefer `my_dict.items()` when you need access to both the key and its corresponding value in the loop. You might prefer iterating directly over keys when you only need the keys, or when you are performing an operation on keys that doesn''t immediately require their associated values.', NULL, '2026-06-06 14:56:57.517105+00', 0.5911626, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cdb96000-89c0-478e-9b9d-a2896741e785', 79, 165, 'multiple_choice', 'foundational', 'What does the following Python code print?
python
my_dict = {''a'': 1, ''b'': 2, ''c'': 3}
for key in my_dict:
    print(key, end='' '')', '[{"text": "a 1 b 2 c 3", "label": "A"}, {"text": "1 2 3", "label": "B"}, {"text": "a b c", "label": "C"}, {"text": "{''a'': 1} {''b'': 2} {''c'': 3}", "label": "D"}]', 'a b c', NULL, '2026-06-06 14:56:57.517105+00', 0.52741575, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('81ded809-5318-4047-b773-9675e6bdf93e', 79, 165, 'short_answer', 'applied', 'You have a dictionary `prices = {''apple'': 1.0, ''banana'': 0.5, ''cherry'': 2.0}`. Write a single line of Python code using the `in` operator to check if ''banana'' is a key in the `prices` dictionary and print `True` or `False`.', NULL, 'print(''banana'' in prices)', NULL, '2026-06-06 14:56:57.517105+00', 0.6136128, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('61fd6575-acb3-49d5-899d-1b98c6dce7b0', 79, 165, 'coding', 'applied', 'You are given a dictionary `stock = {''laptop'': 10, ''mouse'': 50, ''keyboard'': 25}`. Your task is to:
1. Iterate through the dictionary''s key-value pairs using the `.items()` method.
2. For each pair, print a message in the format: "Item: [key], Quantity: [value]".
3. After the loop, check if ''monitor'' is present as a key in the `stock` dictionary. Print `"Monitor is in stock."`, if it is, otherwise print `"Monitor is not in stock."`. Add ''monitor'' with a quantity of 15 to the `stock` dictionary if it was not present. (You do not need to print the updated dictionary.)', NULL, NULL, '[{"input": "", "expected_output": "Item: laptop, Quantity: 10\nItem: mouse, Quantity: 50\nItem: keyboard, Quantity: 25\nMonitor is not in stock.\n"}]', '2026-06-06 14:56:57.517105+00', 0.5436322, 'stock = {''laptop'': 10, ''mouse'': 50, ''keyboard'': 25}

# Your code goes here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d5b912eb-2df0-4683-a4e3-e1f64874bf8b', 79, 165, 'explanation', 'advanced', 'Explain the difference in usage and purpose between iterating directly over a dictionary (e.g., `for key in my_dict:`) versus iterating over `my_dict.values()`.', NULL, 'When you iterate directly over a dictionary (e.g., `for key in my_dict:`), the loop processes each *key* in the dictionary. This is the default behavior and is equivalent to `for key in my_dict.keys():`. You would use this when you primarily need to access or process the keys themselves, or if you plan to use the key to retrieve its corresponding value (e.g., `my_dict[key]`).

When you iterate over `my_dict.values()` (e.g., `for value in my_dict.values():`), the loop processes each *value* stored in the dictionary. You would use this when you are only interested in the values and do not need access to their associated keys. For example, if you wanted to sum all numerical values in a dictionary, iterating over `.values()` would be more direct.', NULL, '2026-06-06 14:56:57.517105+00', 0.68699956, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a487548f-7524-447b-b565-84c497715de5', 79, 166, 'multiple_choice', 'foundational', 'Which of the following is the most suitable data structure for efficiently counting the occurrences of unique items in a collection?', '[{"text": "List", "label": "A"}, {"text": "Tuple", "label": "B"}, {"text": "Dictionary", "label": "C"}, {"text": "Set", "label": "D"}]', 'Dictionary', NULL, '2026-06-06 14:56:57.517105+00', 0.51358384, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ed5fc06d-b0f2-49a3-b6cc-ce2b7a893ae6', 79, 166, 'short_answer', 'applied', 'You are counting words in a sentence and have a dictionary `word_counts = {''hello'': 1}`. If the next word you encounter is ''world'', what Python statement would correctly add ''world'' to the dictionary with a count of 1, without needing an `if` statement to check if ''world'' exists?', NULL, 'word_counts[''world''] = word_counts.get(''world'', 0) + 1', NULL, '2026-06-06 14:56:57.517105+00', 0.4566563, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7a15fd4b-cffb-429d-8c58-d4efd21eb805', 84, 187, 'multiple_choice', 'foundational', 'Which keyword is used to define a function in Python?', '[{"text": "function", "label": "A"}, {"text": "define", "label": "B"}, {"text": "def", "label": "C"}, {"text": "func", "label": "D"}]', 'def', NULL, '2026-06-06 15:00:09.124422+00', 0.63856727, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f494701c-2683-4fc4-8edd-c786225fff0c', 79, 166, 'coding', 'applied', 'Write a Python program that counts the frequency of each number in the given list `numbers`. Store the counts in a dictionary named `number_frequencies`. Finally, print the `number_frequencies` dictionary.

`numbers = [1, 2, 2, 3, 1, 4, 2, 3, 1, 5]`', NULL, NULL, '[{"input": "", "expected_output": "{1: 3, 2: 3, 3: 2, 4: 1, 5: 1}"}]', '2026-06-06 14:56:57.517105+00', 0.41076627, 'numbers = [1, 2, 2, 3, 1, 4, 2, 3, 1, 5]
number_frequencies = {}

# TODO: Iterate through the numbers list and populate number_frequencies

print(number_frequencies)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eaa2c568-fe47-4b68-ac22-c9ffcc6134ef', 81, 172, 'explanation', 'advanced', 'Explain why using a series of independent `if` statements might behave differently than an `if`-`elif`-`else` chain, even if the conditions appear similar. Provide a simple example to illustrate your explanation.', NULL, 'An `if`-`elif`-`else` chain guarantees that only *one* block of code will be executed: the first one whose condition evaluates to `True`, or the `else` block if all conditions are `False`. The evaluation stops after the first `True` condition.

In contrast, a series of independent `if` statements are all evaluated separately. If multiple `if` conditions happen to be `True`, their respective code blocks will *all* execute.

Example:

`if`-`elif`-`else` chain:
python
num = 10
if num > 5:
    print("Greater than 5")
elif num > 8:
    print("Greater than 8")
# Output: Greater than 5 (because the first true condition stops evaluation)


Independent `if` statements:
python
num = 10
if num > 5:
    print("Greater than 5")
if num > 8:
    print("Greater than 8")
# Output: 
# Greater than 5
# Greater than 8 (because both if statements are evaluated independently)', NULL, '2026-06-06 14:58:15.533176+00', 0.768134, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eec87e01-55d5-4fa0-ba2b-0aebeec20541', 81, 173, 'multiple_choice', 'foundational', 'Which Python operator is used to check if two values are NOT equal?', '[{"text": "=", "label": "A"}, {"text": "==", "label": "B"}, {"text": "!=", "label": "C"}, {"text": ">=", "label": "D"}]', '!=', NULL, '2026-06-06 14:58:15.533176+00', 0.6964039, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b257bc23-1a51-48d3-b4c8-a58786a3b28d', 81, 173, 'short_answer', 'applied', 'What Boolean value does the expression `7 * 2 == 14` evaluate to in Python?', NULL, 'True', NULL, '2026-06-06 14:58:15.533176+00', 0.56353456, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c98fd5f0-5dc7-4a2d-857e-3c08c257ab83', 81, 173, 'coding', 'applied', 'You are given two variables, `score` and `passing_score`. Your task is to use a comparison operator to determine if `score` is greater than or equal to `passing_score`. Assign the boolean result of this comparison to a variable called `has_passed` and then print the value of `has_passed`.', NULL, NULL, '[{"input": "", "expected_output": "True\n"}]', '2026-06-06 14:58:15.533176+00', 0.54527646, 'score = 85
passing_score = 70

# TODO: Compare score and passing_score, assign the result to has_passed
# Then, print has_passed
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bbc89b70-1b10-4828-a746-6b06abcaa45f', 81, 174, 'multiple_choice', 'foundational', 'What will be the output of the following Python code?
python
a = True
b = False
print(a and not b)', '[{"text": "True", "label": "A"}, {"text": "False", "label": "B"}, {"text": "Error", "label": "C"}, {"text": "None", "label": "D"}]', 'True', NULL, '2026-06-06 14:58:15.533176+00', 0.51066804, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('520e6950-ac1e-470c-9487-05411d9114f1', 81, 174, 'short_answer', 'applied', 'You are given two boolean variables: `has_coupon = True` and `is_member = False`. Write a single Python boolean expression using `and`, `or`, and/or `not` that evaluates to `True` if the customer either has a coupon OR is a member, but NOT both. Your answer should be only the expression.', NULL, '(has_coupon or is_member) and not (has_coupon and is_member)', NULL, '2026-06-06 14:58:15.533176+00', 0.47730958, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('28ee7d1a-f004-4b85-a51a-4f9908245dfc', 81, 174, 'coding', 'applied', 'You are building a login system. A user can log in if they have a valid username AND a correct password, OR if they are an administrator with a special override code. Assume the following variables are already defined:
- `is_valid_username` (boolean)
- `is_correct_password` (boolean)
- `is_admin` (boolean)
- `has_override_code` (boolean)

Write a Python expression that uses boolean operators (`and`, `or`, `not`) to determine if the `user_can_login`. Print the value of `user_can_login`.', NULL, NULL, '[{"input": "", "expected_output": "True"}]', '2026-06-06 14:58:15.533176+00', 0.46002764, 'is_valid_username = True
is_correct_password = False
is_admin = True
has_override_code = True

# TODO: Write your boolean expression for user_can_login below.
user_can_login = # Your expression here

print(user_can_login)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ae85b2d6-f14d-4160-b1cd-d98015aef8ae', 81, 175, 'multiple_choice', 'foundational', 'Which of the following values is considered ''falsy'' in Python?', '[{"text": "\"False\"", "label": "A"}, {"text": "1", "label": "B"}, {"text": "0.0", "label": "C"}, {"text": "[None]", "label": "D"}]', '0.0', NULL, '2026-06-06 14:58:15.533176+00', 0.54787296, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d4b404ec-2076-49da-b4ce-973f1da8a19c', 81, 175, 'short_answer', 'applied', 'You have a list `data = [1, 2, 3]`. If you use this list in an `if` statement, will the `if` block execute? Explain why, referencing the concept of truthiness.', NULL, 'Yes, the `if` block will execute. An empty list `[]` is falsy, but a non-empty list like `[1, 2, 3]` is considered truthy in Python''s boolean context. Therefore, `if data:` will evaluate as `True`.', NULL, '2026-06-06 14:58:15.533176+00', 0.6411178, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1517706b-22cb-4816-a24e-9e3178943c33', 81, 175, 'coding', 'applied', 'Write a program that defines a variable `score`. Assign it the value `0`. Then, using an `if/else` statement, print ''Score is positive!'' if `score` is truthy, and ''Score is zero or negative.'' if it is falsy. Your program should reflect the current value of `score` (0).', NULL, NULL, '[{"input": "", "expected_output": "Score is zero or negative.\n"}]', '2026-06-06 14:58:15.533176+00', 0.44522113, 'score = 0

# Your if/else statement here
# if ...:
#    print(...)
# else:
#    print(...)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e843788b-024c-4b82-a47e-bcf98d672130', 81, 176, 'multiple_choice', 'foundational', 'Which of the following correctly uses a conditional expression to assign `status` to ''Adult'' if `age` is 18 or greater, otherwise ''Minor''?', '[{"text": "`if age >= 18: status = ''Adult'' else: status = ''Minor''`", "label": "A"}, {"text": "`status = ''Adult'' if age >= 18 else ''Minor''`", "label": "B"}, {"text": "`status = (age >= 18) ? ''Adult'' : ''Minor''`", "label": "C"}, {"text": "`status = ''Adult'' if age >= 18 else ''Minor'' if age < 18`", "label": "D"}]', '`status = ''Adult'' if age >= 18 else ''Minor''`', NULL, '2026-06-06 14:58:15.533176+00', 0.55853206, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ba3b21c3-a364-4eb9-9603-3054884ce9b5', 81, 176, 'short_answer', 'applied', 'What is the output of the following Python code snippet?

python
x = 10
message = ''High'' if x > 5 else ''Low''
print(message)', NULL, 'High', NULL, '2026-06-06 14:58:15.533176+00', 0.44536722, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3be51804-cced-46c1-96a4-2712e9f86561', 81, 176, 'coding', 'applied', 'You are given a variable `temperature`. Write a conditional expression that assigns the string ''Wear a jacket'' to a variable named `advice` if `temperature` is less than 15, otherwise assign ''No jacket needed''. Finally, print the value of `advice`.', NULL, NULL, '[{"input": "", "expected_output": "Wear a jacket\n"}, {"input": "", "expected_output": "No jacket needed\n"}]', '2026-06-06 14:58:15.533176+00', 0.40646404, 'temperature = 12 # You can change this value to test

# Your conditional expression here:
# advice = ...

# Print the advice
# print(advice)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('30e04e56-251b-4ba3-a2bc-cd1191d15f2f', 84, 187, 'short_answer', 'applied', 'What symbol must immediately follow the parentheses `()` in a function definition header?', NULL, ':', NULL, '2026-06-06 15:00:09.124422+00', 0.37292966, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2c47dd93-ba15-4336-a04e-927859ac81c4', 80, 167, 'multiple_choice', 'foundational', 'Which of the following Python data structures best represents a collection of distinct items, where each item has multiple named attributes?', '[{"text": "A list of strings", "label": "A"}, {"text": "A dictionary of integers", "label": "B"}, {"text": "A list of dictionaries", "label": "C"}, {"text": "A set of tuples", "label": "D"}]', 'A list of dictionaries', NULL, '2026-06-06 14:57:40.230173+00', 0.6181859, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('481cf426-b72a-4578-a05c-12a8e405ec47', 80, 167, 'short_answer', 'applied', 'Given the following Python code:

python
products = [
    {''name'': ''Laptop'', ''price'': 1200, ''in_stock'': True},
    {''name'': ''Mouse'', ''price'': 25, ''in_stock'': False},
    {''name'': ''Keyboard'', ''price'': 75, ''in_stock'': True}
]

# Write Python code to retrieve and print the ''price'' of the third product.


What is the exact output of the code you would write?', NULL, '75', NULL, '2026-06-06 14:57:40.230173+00', 0.43306267, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d7bd4777-7251-4055-a7e4-a83e039fc9e9', 80, 167, 'coding', 'applied', 'You need to store information about several employees. Each employee has a `name` (string), `employee_id` (integer), and `department` (string). Create a list named `employees` that contains at least two employee dictionaries.

After creating the list, add a new employee dictionary to the `employees` list. This new employee should have:
- `name`: ''Alice''
- `employee_id`: 103
- `department`: ''HR''

Finally, print the entire `employees` list.', NULL, NULL, '[{"input": "", "expected_output": "[{''name'': ''John Doe'', ''employee_id'': 101, ''department'': ''Engineering''}, {''name'': ''Jane Smith'', ''employee_id'': 102, ''department'': ''Marketing''}, {''name'': ''Alice'', ''employee_id'': 103, ''department'': ''HR''}]"}]', '2026-06-06 14:57:40.230173+00', 0.4994347, '# Create the initial list of employees here
employees = [
    # Add your first employee dictionary here
    # Add your second employee dictionary here
]

# Create the new employee dictionary
new_employee = {
    ''name'': ''Alice'',
    ''employee_id'': 103,
    ''department'': ''HR''
}

# Add the new employee to the list
# TODO: Your code here to add new_employee to employees

# Print the updated employees list
# TODO: Your code here to print the list');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('04017768-2dc2-4116-bb4c-50d7f7b17481', 80, 168, 'multiple_choice', 'foundational', 'Which of the following best describes the structure of a ''Dictionary of Lists''?', '[{"text": "A dictionary where each key maps to a single string value.", "label": "A"}, {"text": "A dictionary where each key maps to a list of values.", "label": "B"}, {"text": "A list where each element is a dictionary.", "label": "C"}, {"text": "A dictionary where keys and values are both lists.", "label": "D"}]', 'A dictionary where each key maps to a list of values.', NULL, '2026-06-06 14:57:40.230173+00', 0.44250783, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('576c4d4f-248e-43e9-8f74-fded02d2e8a1', 80, 168, 'short_answer', 'applied', 'You have a dictionary `product_categories = {''Electronics'': [''Laptop'', ''Smartphone''], ''Books'': [''Novel'', ''Textbook'']}`. Write the Python code to add ''Tablet'' to the ''Electronics'' category.', NULL, 'product_categories[''Electronics''].append(''Tablet'')', NULL, '2026-06-06 14:57:40.230173+00', 0.6215797, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('29cdad62-5e0e-4353-9991-794f7c8fea22', 80, 169, 'multiple_choice', 'foundational', 'You have a list of dictionaries: `data = [{''id'': 1, ''values'': [10, 20]}, {''id'': 2, ''values'': [30, 40]}]`. Which code snippet correctly accesses the number `30`?', '[{"text": "`data[''values''][0]`", "label": "A"}, {"text": "`data[1][''values''][0]`", "label": "B"}, {"text": "`data[0][''values''][1]`", "label": "C"}, {"text": "`data[1][0][0]`", "label": "D"}]', '`data[1][''values''][0]`', NULL, '2026-06-06 14:57:40.230173+00', 0.6261434, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d6164250-f8a3-49bf-a1cd-5808acadf168', 80, 169, 'short_answer', 'applied', 'Given the following nested dictionary `inventory = {''fruits'': {''apples'': {''red'': 5, ''green'': 3}, ''bananas'': 10}, ''vegetables'': {''carrots'': 20}}`. Write the Python expression to retrieve the count of ''green'' apples.', NULL, 'inventory[''fruits''][''apples''][''green'']', NULL, '2026-06-06 14:57:40.230173+00', 0.5172926, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9ac4b515-c8a9-4b17-8945-d59e5d4d6b57', 80, 169, 'explanation', 'advanced', 'Explain why the order of square brackets `[]` matters when accessing elements in deeply nested data structures. Provide an example where changing the order would lead to an error or an incorrect result.', NULL, 'The order of square brackets matters because each `[]` operation resolves one level deeper into the data structure. You must specify the access method (list index or dictionary key) that is appropriate for the *current* data type at that level. For example, if you have `data = [{''item'': ''A''}, {''item'': ''B''}]`, `data[0]` first accesses the *first element* of the list (which is `{''item'': ''A''}`). Then, `[''item'']` accesses the value associated with the key ''item'' *within that dictionary*. So, `data[0][''item'']` yields ''A''.

If the order were changed to `data[''item''][0]`, it would cause an error. `data[''item'']` would attempt to use ''item'' as a key for the `data` list itself, which is not a dictionary, leading to a `TypeError` or `KeyError` (depending on the exact structure if `data` was mixed). Similarly, if `data` was a dictionary like `{''items'': [''A'', ''B'']}`, then `data[''items'']` would correctly yield the list `[''A'', ''B'']`, and then `[0]` would access the first element ''A''. Reversing it to `data[0][''items'']` would result in a `KeyError` because `0` is not a key in the outer dictionary, or a `TypeError` if `data[0]` was not a dictionary.', NULL, '2026-06-06 14:57:40.230173+00', 0.70892394, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('575d9066-aa4c-469a-8668-ca31f77588b4', 87, 202, 'multiple_choice', 'foundational', 'What is the primary purpose of a class in object-oriented programming?', '[{"text": "To store individual pieces of data.", "label": "A"}, {"text": "To define a blueprint for creating objects.", "label": "B"}, {"text": "To execute a sequence of instructions.", "label": "C"}, {"text": "To perform mathematical calculations.", "label": "D"}]', 'To define a blueprint for creating objects.', NULL, '2026-06-06 15:02:10.125507+00', 0.5567221, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('640d79e2-3c66-467f-af6a-9f9a15a90426', 87, 202, 'short_answer', 'applied', 'If `Dog` is a class, what do we call `my_dog` in the following Python code snippet: `my_dog = Dog()`?', NULL, 'An object (or an instance)', NULL, '2026-06-06 15:02:10.125507+00', 0.6061778, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d3486c6a-94e7-44a1-89ca-bbeb9c0c6d87', 87, 202, 'explanation', 'advanced', 'Explain the relationship between a class and an object using a real-world analogy. How does this analogy illustrate why you can have multiple objects from a single class?', NULL, 'A strong answer should use an analogy like a cookie cutter and cookies, a blueprint and houses, or a car design and actual cars. The class is the template (e.g., cookie cutter) which defines the characteristics, while objects are the individual concrete items created from that template (e.g., individual cookies). This analogy shows that many distinct objects can be made from the same single class blueprint, each being a separate entity even though they share the same fundamental design.', NULL, '2026-06-06 15:02:10.125507+00', 0.6077415, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5f07e252-57f7-43ee-a6ff-cc2186b9700b', 87, 202, 'coding', 'applied', 'Define a class named `Smartphone`. Inside the class, use the `pass` keyword as a placeholder. Then, create two separate objects (instances) from your `Smartphone` class: `my_phone` and `your_phone`.

Finally, print the type of `my_phone` and `your_phone` on separate lines.', NULL, NULL, '[{"input": "", "expected_output": "<class ''__main__.Smartphone''>\n<class ''__main__.Smartphone''>"}]', '2026-06-06 15:02:10.125507+00', 0.4095189, 'class Smartphone:
    # TODO: Add ''pass'' here

# TODO: Create two Smartphone objects: my_phone and your_phone

# TODO: Print the type of my_phone and your_phone');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('29ab5c47-7644-45ba-90d3-01bf22a61efa', 87, 203, 'multiple_choice', 'foundational', 'What is the primary purpose of the `__init__` method in a Python class?', '[{"text": "To define new methods for the class.", "label": "A"}, {"text": "To destroy an object when it''s no longer needed.", "label": "B"}, {"text": "To initialize a newly created object''s attributes.", "label": "C"}, {"text": "To create a new class definition.", "label": "D"}]', 'To initialize a newly created object''s attributes.', NULL, '2026-06-06 15:02:10.125507+00', 0.6683399, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a2c9b3a3-6d4e-45d6-aa34-7944e5abc406', 87, 203, 'short_answer', 'applied', 'When defining an `__init__` method, what is the required first parameter, and what does it represent?', NULL, 'The first parameter is `self`. It represents the instance of the class that is currently being created or operated upon.', NULL, '2026-06-06 15:02:10.125507+00', 0.57755244, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6eb88d1d-a4f0-4df5-b790-aeee5a4c1d59', 87, 203, 'coding', 'applied', 'You are building a system to manage books. Define a class named `Book` with an `__init__` method. This method should take `title` and `author` as arguments and assign them as attributes to the `Book` object. After defining the class, create an instance of `Book` for ''The Hitchhiker''s Guide to the Galaxy'' by ''Douglas Adams'', and then print the `title` attribute of your `Book` object.', NULL, NULL, '[{"input": "", "expected_output": "The Hitchhiker''s Guide to the Galaxy"}]', '2026-06-06 15:02:10.125507+00', 0.41735864, 'class Book:
    # TODO: Define the __init__ method here
    def __init__(self, title, author):
        # Assign title and author as attributes
        self.title = title
        self.author = author

# TODO: Create a Book object for ''The Hitchhiker''s Guide to the Galaxy'' by ''Douglas Adams''
my_book = Book("The Hitchhiker''s Guide to the Galaxy", "Douglas Adams")

# TODO: Print the title attribute of your my_book object
print(my_book.title)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c58fdb7c-beaa-41ff-88d3-654d9f4a9f4b', 87, 203, 'explanation', 'advanced', 'Explain the difference between a parameter passed to the `__init__` method (e.g., `name` in `def __init__(self, name):`) and an attribute of an object (e.g., `self.name`). How are they related during object initialization?', NULL, 'A parameter passed to the `__init__` method is a local variable that holds the value provided when an object is instantiated. It only exists within the scope of that `__init__` call. An attribute of an object, like `self.name`, is a variable that belongs to the specific object instance. It stores data specific to that object and persists as long as the object exists. They are related because inside `__init__`, parameters are typically used to initialize (assign values to) the object''s attributes, establishing the object''s initial state.', NULL, '2026-06-06 15:02:10.125507+00', 0.75576526, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eff16115-8469-4ec2-83ab-8b9a44224f92', 87, 204, 'multiple_choice', 'foundational', 'What is the primary purpose of the `self` parameter in an instance method?', '[{"text": "To indicate that the method is private.", "label": "A"}, {"text": "To refer to the class itself, not an instance.", "label": "B"}, {"text": "To refer to the specific instance of the class on which the method was called.", "label": "C"}, {"text": "It''s a placeholder for future arguments and has no immediate purpose.", "label": "D"}]', 'To refer to the specific instance of the class on which the method was called.', NULL, '2026-06-06 15:02:10.125507+00', 0.61553794, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('601aa680-a415-42c7-8c09-39b5f29934f0', 87, 204, 'short_answer', 'applied', 'Consider a class `Car` with an instance method `start_engine(self)`. If you have an instance `my_car = Car()`, how would you correctly call the `start_engine` method on `my_car`?', NULL, 'my_car.start_engine()', NULL, '2026-06-06 15:02:10.125507+00', 0.64672655, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b5603e8c-a55a-4948-8f6f-55c9c5f615f4', 87, 204, 'coding', 'applied', 'You are given a class `Robot` with an `__init__` method that takes a `name`. Add an instance method `greet(self)` to the `Robot` class. This method should print a greeting that includes the robot''s name, in the format: "Hello, I am [robot''s name]!".

Then, create an instance of `Robot` named ''Unit-734'' and call its `greet()` method.', NULL, NULL, '[{"input": "", "expected_output": "Hello, I am Unit-734!\n"}]', '2026-06-06 15:02:10.125507+00', 0.5158499, 'class Robot:
    def __init__(self, name):
        self.name = name

    # TODO: Add the ''greet'' instance method here


# Create a Robot instance and call its greet method
my_robot = Robot("Unit-734")
# TODO: Call the greet method on my_robot
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d7273d6b-3ff2-40cb-b588-15b37551b750', 87, 204, 'explanation', 'advanced', 'Explain why `self` is necessary in Python instance methods and how Python handles its passing when a method is called on an object.', NULL, 'The `self` parameter is necessary in Python instance methods because it provides a way for the method to access and operate on the specific instance''s attributes and other methods. Without `self`, a method wouldn''t know which object''s data it should be interacting with if multiple instances of the class exist.

When a method is called on an object (e.g., `my_object.method_name()`), Python automatically binds the `my_object` instance to the `self` parameter of the `method_name` function. The programmer does not explicitly pass `my_object` as an argument when calling the method; Python does this implicitly. This mechanism allows the method to refer to `self.attribute_name` to get or set data specific to `my_object`, and `self.another_method()` to call other methods belonging to the same instance.', NULL, '2026-06-06 15:02:10.125507+00', 0.807951, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9000085a-b168-4ae9-98bd-d27d53463300', 87, 205, 'multiple_choice', 'foundational', 'Which of the following is the correct way to create an instance of a class named `Bicycle` that takes `color` and `gears` as arguments?', '[{"text": "new Bicycle(''red'', 7)", "label": "A"}, {"text": "Bicycle.create(''red'', 7)", "label": "B"}, {"text": "Bicycle(''red'', 7)", "label": "C"}, {"text": "instance of Bicycle(''red'', 7)", "label": "D"}]', 'Bicycle(''red'', 7)', NULL, '2026-06-06 15:02:10.125507+00', 0.37448624, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77e6fe6d-03d1-4dec-82c6-c8221d141b16', 87, 205, 'short_answer', 'applied', 'You have a class `Book` with an attribute `title`. If you create two instances, `book1 = Book(''1984'')` and `book2 = Book(''Brave New World'')`, and then execute `book1.title = ''Animal Farm''`, what will be the value of `book2.title`?', NULL, '''Brave New World''', NULL, '2026-06-06 15:02:10.125507+00', 0.57478184, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9989164b-8781-45db-bddf-c58d8fe61a2c', 72, 129, 'multiple_choice', 'foundational', 'Which of the following correctly uses the `print()` function to display the word ''Python''?', '[{"text": "print Python", "label": "A"}, {"text": "print(''Python'')", "label": "B"}, {"text": "Print(''Python'')", "label": "C"}, {"text": "display(''Python'')", "label": "D"}]', 'print(''Python'')', NULL, '2026-06-06 14:53:01.799644+00', 0.7237548, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('df3fd9ff-ec62-4102-84d2-b1daf01ac6d9', 72, 129, 'coding', 'applied', 'Your task is to print the message ''Learning Python is fun!'' to the console. On a new line, print the number 101. Make sure the output exactly matches the expected result.', NULL, NULL, '[{"input": "", "expected_output": "Learning Python is fun!\n101\n"}]', '2026-06-06 14:53:01.799644+00', 0.5929246, '# Use the print() function below this line
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a94b1e16-70fc-4db7-b095-e519428deb4e', 72, 129, 'short_answer', 'foundational', 'What happens if you try to print text without enclosing it in quotes, for example, `print(Hello World)`?', NULL, 'It will cause an error, specifically a `NameError`, because Python will interpret ''Hello'' as an undefined variable name.', NULL, '2026-06-06 14:53:01.799644+00', 0.77794963, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d6b85d95-5c4d-44ff-a4c3-96dc056de0b9', 72, 129, 'explanation', 'advanced', 'Explain the primary purpose of the `print()` function in Python and describe how it handles displaying both text (strings) and numbers.', NULL, 'The primary purpose of the `print()` function is to display output (messages, values of variables, results of calculations, etc.) to the console, making it visible to the user. When displaying text (strings), the text must be enclosed within single quotes `''''` or double quotes `""`. For example, `print(''Hello'')`. When displaying numbers, they can be passed directly to the `print()` function without any quotes. For example, `print(123)`. By default, each call to `print()` outputs its content and then moves to a new line.', NULL, '2026-06-06 14:53:01.799644+00', 0.8755134, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('edade461-e92b-42ad-bc4d-a90b2f44ee7b', 72, 130, 'multiple_choice', 'foundational', 'After typing `print(''Hello'')` into the code editor, what is the *next* step required to see ''Hello'' displayed in the output area?', '[{"text": "The output appears automatically as you type.", "label": "A"}, {"text": "Save the file.", "label": "B"}, {"text": "Click the ''Run'' button (or equivalent).", "label": "C"}, {"text": "Restart the Python interpreter.", "label": "D"}]', 'Click the ''Run'' button (or equivalent).', NULL, '2026-06-06 14:53:01.799644+00', 0.66151834, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9c5817f0-f68b-45b2-95b7-41928fd3b318', 72, 130, 'short_answer', 'applied', 'You''ve written a Python program that calculates a value and prints it. If you change the calculation in your code, but the output still shows the old result, what crucial step have you likely forgotten to perform?', NULL, 'You likely forgot to run the code again after making the changes.', NULL, '2026-06-06 14:53:01.799644+00', 0.41534477, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4e89bdaf-67cd-4d18-b6cc-7762bf80a8dd', 72, 130, 'coding', 'applied', 'The editor currently contains code that prints a greeting. Modify the existing `print()` call and add another `print()` call so that the program first prints ''My favorite programming language is Python.'' and then, on a new line, prints ''This is fun!''', NULL, NULL, '[{"input": "", "expected_output": "My favorite programming language is Python.\nThis is fun!"}]', '2026-06-06 14:53:01.799644+00', 0.66862124, '# Start here!
print(''Hello world!'')
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b33a9f08-f6ad-4e0a-80e6-77563b88c3a3', 72, 131, 'multiple_choice', 'foundational', 'Which symbol is used to start a single-line comment in Python?', '[{"text": "//", "label": "A"}, {"text": "/*", "label": "B"}, {"text": "#", "label": "C"}, {"text": "--", "label": "D"}]', '#', NULL, '2026-06-06 14:53:01.799644+00', 0.6669977, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a615ee01-9e20-4a73-b109-e018cd1097db', 72, 131, 'short_answer', 'applied', 'Explain in one sentence why comments are useful in programming.', NULL, 'Comments make code more readable and easier to understand for humans by explaining its purpose or functionality.', NULL, '2026-06-06 14:53:01.799644+00', 0.61842316, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2cab91ab-6b5c-473b-9894-3bd2077362c7', 72, 131, 'coding', 'applied', 'The program below is supposed to print ''My first Python code!''. Add a single-line comment to the provided line of code that says ''Displaying a greeting.''. Make sure the program still prints the correct output.', NULL, NULL, '[{"input": "", "expected_output": "My first Python code!\n"}]', '2026-06-06 14:53:01.799644+00', 0.6300668, 'print(''My first Python code!'')');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b6f4dcc0-df4d-4a47-884a-5aae3cd0e0a4', 72, 132, 'multiple_choice', 'foundational', 'Which of the following best describes a ''SyntaxError'' in Python?', '[{"text": "An error that occurs when a program tries to access a non-existent variable.", "label": "A"}, {"text": "An error that happens when your code violates the grammatical rules of the Python language.", "label": "B"}, {"text": "An error caused by a program running too slowly.", "label": "C"}, {"text": "An error that occurs when a program produces an incorrect result, even if it runs.", "label": "D"}]', 'An error that happens when your code violates the grammatical rules of the Python language.', NULL, '2026-06-06 14:53:01.799644+00', 0.6791266, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('70405b69-51e2-4c30-9e92-95142999e5d5', 72, 132, 'short_answer', 'applied', 'You are trying to print the word ''Python'' but you wrote `print(''Python")`. What type of syntax error is this likely to cause, and why?', NULL, 'This is likely to cause a `SyntaxError: EOL while scanning string literal` or a similar error related to unmatched quotes. The reason is that the string starts with a single quote but ends with a double quote, so Python sees the single quote as unmatched and expects another single quote to close the string literal.', NULL, '2026-06-06 14:53:01.799644+00', 0.7335787, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('723ac00f-9686-4604-90c5-6c71f3746724', 72, 132, 'coding', 'applied', 'The following code has a syntax error. Your task is to fix it so that it correctly prints ''Hello, Python world!'' to the console.', NULL, NULL, '[{"input": "", "expected_output": "Hello, Python world!\n"}]', '2026-06-06 14:53:01.799644+00', 0.6319822, 'print(''Hello, Python world!;
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('742a3d35-93b3-4f1d-8fde-73af6e3e06d9', 72, 133, 'multiple_choice', 'foundational', 'In a non-interactive execution environment, how does a Python program typically get its initial data?', '[{"text": "It pauses and waits for the user to type it in.", "label": "A"}, {"text": "It reads data from an external file specified by the user at runtime.", "label": "B"}, {"text": "The data is hardcoded directly into the script.", "label": "C"}, {"text": "It automatically generates random data for processing.", "label": "D"}]', 'The data is hardcoded directly into the script.', NULL, '2026-06-06 14:53:01.799644+00', 0.6086849, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2ce42b48-ea56-44d0-9fd7-0ba1f6fc0c58', 72, 133, 'short_answer', 'applied', 'You want to create a Python program that calculates the area of a rectangle. In a non-interactive execution environment, if you need to use specific width (5) and height (10) values, how would you make these values available to your program without user intervention?', NULL, 'You would hardcode them as variable assignments, for example: `width = 5` and `height = 10`.', NULL, '2026-06-06 14:53:01.799644+00', 0.36679134, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('50b1c4a9-8db0-4e69-9b9f-940c6350b05d', 72, 133, 'explanation', 'advanced', 'Explain what ''non-interactive execution'' means in the context of running Python code in this course, and describe the primary method you should use to provide initial data to your programs.', NULL, 'Non-interactive execution means your Python code runs from beginning to end without stopping or prompting for user input. It executes all instructions sequentially and then terminates. The primary method to provide initial data to your programs in this environment is to ''hardcode'' it. This involves directly assigning values to variables within your script, like `variable_name = value`, rather than relying on functions like `input()` which would return an empty string.', NULL, '2026-06-06 14:53:01.799644+00', 0.76837295, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8b907283-44e6-4aa5-b3f4-a764a2ed6c49', 72, 133, 'coding', 'applied', 'Your task is to hardcode a specific temperature in Celsius, convert it to Fahrenheit, and print the result. The formula for converting Celsius to Fahrenheit is `F = C * 9/5 + 32`. Hardcode the Celsius temperature to be `25`.

Your program should output the temperature in Fahrenheit in the format: `Fahrenheit: XX.X` (replace `XX.X` with the calculated value).', NULL, NULL, '[{"input": "", "expected_output": "Fahrenheit: 77.0"}]', '2026-06-06 14:53:01.799644+00', 0.3150703, '# Hardcode the Celsius temperature here
celsius = 0 # TODO: Change this value

# Calculate Fahrenheit here
fahrenheit = 0 # TODO: Implement the conversion formula

# Print the result
# print(f"Fahrenheit: {fahrenheit}") # You can uncomment and use this or a similar print statement
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('89a1f466-90b5-418b-95fb-63aaa08d98e6', 73, 134, 'multiple_choice', 'foundational', 'Which of the following is a valid Python variable name?', '[{"text": "1st_name", "label": "A"}, {"text": "user-age", "label": "B"}, {"text": "first_name", "label": "C"}, {"text": "class", "label": "D"}]', 'first_name', NULL, '2026-06-06 14:53:33.608063+00', 0.5474437, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f82b4bd7-cd5e-4c43-96d0-a6fc1286c221', 73, 134, 'short_answer', 'applied', 'What is the primary purpose of the `=` operator when used with variables in Python?', NULL, 'The `=` operator is used for assignment, meaning it assigns the value on its right to the variable on its left.', NULL, '2026-06-06 14:53:33.608063+00', 0.57634753, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8b1040f6-47be-4e16-bd0b-ee7c6a3a7419', 73, 134, 'coding', 'applied', 'Create a variable called `product_price` and assign it the value `24.99`. Then, create another variable called `quantity` and assign it the value `2`. Finally, create a third variable named `total_cost` which stores the result of `product_price` multiplied by `quantity`. Print the value of `total_cost`.', NULL, NULL, '[{"input": "", "expected_output": "49.98"}]', '2026-06-06 14:53:33.608063+00', 0.36291188, '# Assign product_price and quantity below


# Calculate and print total_cost

');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ba28911e-ac46-43cc-bb99-4193cc918afe', 73, 135, 'multiple_choice', 'foundational', 'Which of the following Python data types is used to store whole numbers?', '[{"text": "float", "label": "A"}, {"text": "str", "label": "B"}, {"text": "int", "label": "C"}, {"text": "bool", "label": "D"}]', 'int', NULL, '2026-06-06 14:53:33.608063+00', 0.635135, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b26ddd12-00e0-4b98-98fc-fd4fef477f89', 73, 135, 'short_answer', 'applied', 'What data type would you use to store a person''s height in meters (e.g., 1.75)?', NULL, 'float', NULL, '2026-06-06 14:53:33.608063+00', 0.34236038, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bf1b627e-09b8-4c17-89c0-ff237e703b77', 73, 135, 'explanation', 'advanced', 'Explain the key difference between an `int` and a `float` data type in Python, and provide an example scenario where each would be most appropriate.', NULL, 'An `int` represents whole numbers without any decimal part (e.g., 5, -10). A `float` represents numbers that can have a fractional or decimal part (e.g., 3.14, 2.0). An `int` would be appropriate for counting discrete items like ''number of students in a class'', whereas a `float` would be appropriate for measurements like ''temperature'' or ''weight'' that can have decimal values.', NULL, '2026-06-06 14:53:33.608063+00', 0.7131389, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('04cb43e7-71c3-4daa-8430-e21766e0e3ae', 73, 135, 'coding', 'applied', 'Create three variables:
1. `product_name`: a string storing the name of a product (e.g., ''Laptop'').
2. `quantity`: an integer storing the number of items (e.g., 3).
3. `is_available`: a boolean indicating if the product is in stock (e.g., True).

Then, print the value of each variable on a new line.', NULL, NULL, '[{"input": "", "expected_output": "Keyboard\n5\nTrue"}]', '2026-06-06 14:53:33.608063+00', 0.29942954, '# Declare your variables here
# product_name = ...
# quantity = ...
# is_available = ...

# Print the values
# print(...)
# print(...)
# print(...)

product_name = ''Keyboard''
quantity = 5
is_available = True

print(product_name)
print(quantity)
print(is_available)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7186f0d2-66f0-48a1-aedc-e812e5e2359a', 73, 136, 'multiple_choice', 'foundational', 'What is the primary purpose of the `type()` function in Python?', '[{"text": "To convert a value from one data type to another.", "label": "A"}, {"text": "To check if a variable has been assigned a value.", "label": "B"}, {"text": "To determine the data type of a variable or value.", "label": "C"}, {"text": "To create a new data type.", "label": "D"}]', 'To determine the data type of a variable or value.', NULL, '2026-06-06 14:53:33.608063+00', 0.83607566, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b8f15465-aab1-4cf6-92c0-cd75b5758f16', 73, 136, 'short_answer', 'applied', 'If you execute `result = True` followed by `print(type(result))`, what exact output will be displayed in the console?', NULL, '<class ''bool''>', NULL, '2026-06-06 14:53:33.608063+00', 0.40684262, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8c3637e7-5b03-4ddc-af36-8eb0ba77d4f6', 73, 136, 'coding', 'applied', 'Declare a variable named `city_name` and assign it the string value `''London''`. Then, print the data type of `city_name` using the `type()` function.', NULL, NULL, '[{"input": "", "expected_output": "<class ''str''>\n"}]', '2026-06-06 14:53:33.608063+00', 0.42766297, '# Declare the variable city_name here

# Print its data type
# TODO: Add your code here');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('74bc5d84-d4d6-4b3a-8aa9-4d1a807cc588', 73, 137, 'multiple_choice', 'foundational', 'Which of the following is the correct way to create an f-string in Python?', '[{"text": "\"Hello, {name}\"", "label": "A"}, {"text": "f\"Hello, name\"", "label": "B"}, {"text": "F\"Hello, {name}\"", "label": "C"}, {"text": "s\"Hello, {name}\"", "label": "D"}]', 'F"Hello, {name}"', NULL, '2026-06-06 14:53:33.608063+00', 0.71233124, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f63efb58-f783-4a6a-8cd9-d492defb2db2', 73, 137, 'short_answer', 'applied', 'What would be the output of the following Python code snippet?
python
x = 10
y = 5
message = f"The sum of {x} and {y} is {x + y}."
print(message)', NULL, 'The sum of 10 and 5 is 15.', NULL, '2026-06-06 14:53:33.608063+00', 0.46440616, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('de9a1a2d-3bcd-431a-90ca-65678fa84068', 73, 137, 'coding', 'applied', 'You are given two variables: `city` representing a city name (string) and `temperature` representing the current temperature in that city (integer). Your task is to use an f-string to print a message in the format: ''The temperature in [city] is [temperature] degrees Celsius.''

For example, if `city` is ''London'' and `temperature` is 15, the output should be ''The temperature in London is 15 degrees Celsius.''', NULL, NULL, '[{"input": "", "expected_output": "The temperature in Paris is 22 degrees Celsius."}, {"input": "", "expected_output": "The temperature in New York is 10 degrees Celsius."}]', '2026-06-06 14:53:33.608063+00', 0.47703564, 'city = "Paris"
temperature = 22

# Your code here:
# Create an f-string to print the message
# print(...)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8f0aa2b7-f49a-4101-a9e8-43bb491fdf40', 74, 142, 'short_answer', 'applied', 'You want to print the string: `The file is located at C:\Users\Name\Documents\report.docx`. If you were to use a regular string (not a raw string), what would be the correctly escaped string literal to achieve this output, specifically considering the backslashes?', NULL, '`The file is located at C:\\Users\\Name\\Documents\\report.docx`', NULL, '2026-06-06 14:54:03.034616+00', 0.46447772, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d2fddc78-9b25-4bc4-8f60-413d0d101d0c', 73, 137, 'explanation', 'advanced', 'Explain one key advantage of using f-strings over traditional string concatenation using the `+` operator in Python, especially when dealing with multiple variables of different data types.', NULL, 'One key advantage of f-strings is their improved readability and conciseness. When using the `+` operator for concatenation with multiple variables of different data types, you often need to explicitly convert non-string types to strings using `str()`. This can make the code cluttered and harder to read. For example, `"Value: " + str(num) + ", Name: " + name` becomes much cleaner with an f-string: `f"Value: {num}, Name: {name}"`. The f-string handles the type conversion implicitly and allows direct embedding of expressions, making the intent clearer and the code less verbose.', NULL, '2026-06-06 14:53:33.608063+00', 0.69762665, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('42da7954-7a95-497b-a130-067ca0188798', 73, 138, 'multiple_choice', 'foundational', 'What will be the value and data type of `result` after executing the following Python code?

`value = "123"
result = int(value)`', '[{"text": "123 (string)", "label": "A"}, {"text": "\"123\" (integer)", "label": "B"}, {"text": "123 (integer)", "label": "C"}, {"text": "\"123\" (string)", "label": "D"}]', '123 (integer)', NULL, '2026-06-06 14:53:33.608063+00', 0.58549273, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1689809b-3c5e-4f60-a38c-9f450478538b', 73, 138, 'short_answer', 'applied', 'You have a variable `temperature = 98.6`. How would you convert this float into a string and store it in a new variable named `temp_str`?', NULL, 'temp_str = str(temperature)', NULL, '2026-06-06 14:53:33.608063+00', 0.62159705, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b8a5e6ba-1a56-40ff-9554-df0e588e9383', 73, 138, 'coding', 'applied', 'You are given a string `number_as_text` that represents a floating-point number. Convert this string into a float, then convert that float into an integer (truncating any decimal part). Finally, convert this integer back into a string. Print the final string.

For example, if `number_as_text` is "7.89", the output should be "7".', NULL, NULL, '[{"input": "", "expected_output": "25"}]', '2026-06-06 14:53:33.608063+00', 0.6352687, 'number_as_text = "25.42"

# Your code here:
# 1. Convert number_as_text to a float
# 2. Convert the float to an integer
# 3. Convert the integer to a string
# 4. Print the final string
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a638f650-a4e0-4abf-8c72-96892429389e', 74, 139, 'multiple_choice', 'foundational', 'What will be the output of the following Python code?

python
my_string = "Hello"
print(my_string[1])', '[{"text": "H", "label": "A"}, {"text": "e", "label": "B"}, {"text": "l", "label": "C"}, {"text": "o", "label": "D"}]', 'e', NULL, '2026-06-06 14:54:03.034616+00', 0.42131615, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d9b9370e-0a57-4b13-b314-57a449c7956f', 74, 139, 'short_answer', 'applied', 'Given the string `text = "Programming"`, what slice would you use to extract the substring `"gram"`?', NULL, 'text[3:7]', NULL, '2026-06-06 14:54:03.034616+00', 0.5413838, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('edcd7905-dc6c-44a2-a7e5-b8aaed57ad14', 74, 139, 'explanation', 'advanced', 'Explain the difference between `my_string[1]` and `my_string[1:2]` for any given string `my_string` that has at least two characters. What is the type of the result in each case?', NULL, 'Both `my_string[1]` and `my_string[1:2]` access the character at index 1. However, `my_string[1]` performs indexing, returning a single character as a string (e.g., ''e''). `my_string[1:2]` performs slicing, which *always* returns a new string (e.g., ''e''), even if it contains only one character. The key difference is that indexing returns a single character string, while slicing returns a substring, which is still a string object, potentially of length one.', NULL, '2026-06-06 14:54:03.034616+00', 0.63276637, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0d7a64ed-e7dd-411c-aae0-f25f7a06bd7f', 74, 139, 'coding', 'applied', 'You are given a string `word`. Your task is to print its first character, then its last character, and finally a slice containing all characters except the first and the last.

For example, if `word = "Python"`:
- The first character is ''P''.
- The last character is ''n''.
- The middle slice is ''ytho''.

Ensure each output is on a new line.', NULL, NULL, '[{"input": "", "expected_output": "E\nt\nlephan\n"}]', '2026-06-06 14:54:03.034616+00', 0.656469, 'word = "Elephant"

# Print the first character
# TODO

# Print the last character
# TODO

# Print the slice containing all characters except the first and last
# TODO
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6b811b86-60f6-43a5-897d-9e0557ff6e22', 74, 140, 'multiple_choice', 'foundational', 'What will be the value of `s` after executing the following code?
python
text = "  Python Programming  "
s = text.strip().upper()', '[{"text": "\"  PYTHON PROGRAMMING  \"", "label": "A"}, {"text": "\"PYTHON PROGRAMMING\"", "label": "B"}, {"text": "\"  python programming  \"", "label": "C"}, {"text": "\"python programming\"", "label": "D"}]', '"PYTHON PROGRAMMING"', NULL, '2026-06-06 14:54:03.034616+00', 0.5462611, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a65d70c0-6f02-4aad-afa8-8d33dfaf2068', 74, 140, 'short_answer', 'applied', 'You have a list of words: `[''first'', ''second'', ''third'']`. How would you use the `.join()` method to create a single string where the words are separated by a comma and a space (e.g., ''first, second, third'')?', NULL, '`'', ''.join([''first'', ''second'', ''third''])`', NULL, '2026-06-06 14:54:03.034616+00', 0.5190497, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('33e40b26-8c68-4985-96da-35d845ee69f7', 74, 141, 'multiple_choice', 'foundational', 'What will be the output of the following Python code?
`print(''world'' in ''Hello, world!'')`', '[{"text": "True", "label": "A"}, {"text": "False", "label": "B"}, {"text": "Error", "label": "C"}, {"text": "None", "label": "D"}]', 'True', NULL, '2026-06-06 14:54:03.034616+00', 0.5664521, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6cfa3b70-d2b5-400f-90e6-f1d022fde0ef', 74, 141, 'short_answer', 'applied', 'What is the result of `len(''programming'')`?', NULL, '11', NULL, '2026-06-06 14:54:03.034616+00', 0.52393556, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f72686e2-6e9f-4c2e-9cad-a83c3e79d3a7', 74, 141, 'explanation', 'advanced', 'Explain the difference in usage and purpose between the `+` operator and the `*` operator when applied to strings in Python. Provide a small example for each.', NULL, 'The `+` operator is used for string concatenation, which means joining two or more strings together end-to-end to form a new, longer string. For example: `str1 = ''Hello''; str2 = ''World''; combined = str1 + str2` results in `''HelloWorld''`. The `*` operator is used for string repetition. It creates a new string by repeating an existing string a specified number of times. For example: `word = ''abc''; repeated = word * 3` results in `''abcabcabc''`.', NULL, '2026-06-06 14:54:03.034616+00', 0.6840638, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f52034aa-e419-4782-99e7-965a76ffb4a0', 74, 141, 'coding', 'applied', 'Given the string `sentence = ''Python programming is powerful and versatile.''`, perform the following tasks:
1. Check if the substring ''powerful'' is present in `sentence` and print the boolean result.
2. Calculate the total length of `sentence` and print the integer result.
3. Create a new string by concatenating `sentence` with the string '' Learn it now!'' and print the new string.
4. Create a new string by repeating the first 6 characters of `sentence` twice and print it.', NULL, NULL, '[{"input": "", "expected_output": "True\n44\nPython programming is powerful and versatile. Learn it now!\nPythonPython"}]', '2026-06-06 14:54:03.034616+00', 0.5891112, 'sentence = ''Python programming is powerful and versatile.''

# Task 1: Check for substring ''powerful''
# TODO: Write your code here

# Task 2: Calculate sentence length
# TODO: Write your code here

# Task 3: Concatenate string
# TODO: Write your code here

# Task 4: Repeat first 6 characters
# TODO: Write your code here');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('13a5f2df-32dd-4472-81aa-d4d565a9603a', 74, 142, 'multiple_choice', 'foundational', 'Which of the following methods will correctly create a multi-line string in Python that preserves line breaks exactly as typed?', '[{"text": "Using single quotes (`''`) and manually adding `\\n` characters.", "label": "A"}, {"text": "Using double quotes (`\"`) and concatenating multiple strings with `+`.", "label": "B"}, {"text": "Using triple single quotes (`''''''`) or triple double quotes (`\"\"\"`).", "label": "C"}, {"text": "Using the `print()` function multiple times for each line.", "label": "D"}]', 'Using triple single quotes (`''''''`) or triple double quotes (`"""`).', NULL, '2026-06-06 14:54:03.034616+00', 0.5712296, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e2fb239f-87a4-4985-95a4-702add8de72f', 74, 142, 'coding', 'applied', 'Your task is to print a formatted message using both multi-line strings and escape sequences.

The message should be:


Hello, World!
This is a multiline message.
	- With an indented item.
It''s important to use ''quotes'' correctly.


Use a triple-quoted string for the main structure and incorporate any necessary escape sequences to achieve the exact output, including the tab and the single quotes.', NULL, NULL, '[{"input": "", "expected_output": "Hello, World!\nThis is a multiline message.\n\t- With an indented item.\nIt''s important to use ''quotes'' correctly."}]', '2026-06-06 14:54:03.034616+00', 0.48550713, '# Create your multi-line string here
formatted_message = ''''''
# TODO: Complete the multi-line string using escape sequences.
# The first line ''Hello, World!'' should not have a leading space from the triple quote.
# The indented item should use a tab character.
# The word ''quotes'' should be enclosed in single quotes.
''''''

print(formatted_message)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('592fac4d-0c92-40f9-8d8d-1ecec415cba8', 80, 169, 'coding', 'applied', 'You are given a list named `user_profiles` containing dictionaries. Each dictionary represents a user and includes their `name` and a `settings` dictionary, which in turn contains a `theme` and `notifications` boolean.

Your task is to extract the theme of the user named ''Eve''. Print the extracted theme.', NULL, NULL, '[{"input": "", "expected_output": "system"}]', '2026-06-06 14:57:40.230173+00', 0.3269836, 'user_profiles = [
    {
        ''id'': 101,
        ''name'': ''Alice'',
        ''settings'': {
            ''theme'': ''dark'',
            ''notifications'': True
        }
    },
    {
        ''id'': 102,
        ''name'': ''Bob'',
        ''settings'': {
            ''theme'': ''light'',
            ''notifications'': False
        }
    },
    {
        ''id'': 103,
        ''name'': ''Eve'',
        ''settings'': {
            ''theme'': ''system'',
            ''notifications'': True
        }
    }
]

# Your code goes here
# Find ''Eve''s profile and then access her theme
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ad52711e-c410-4eab-b1c4-6fb735d03db7', 80, 170, 'multiple_choice', 'foundational', 'Which of the following code snippets correctly iterates through a list of dictionaries, where each dictionary has a ''tag'' key and a ''value'' key, and prints only the ''tag'' for each dictionary?', '[{"text": "for item in my_list: print(item)", "label": "A"}, {"text": "for tag in my_list: print(tag[''tag''])", "label": "B"}, {"text": "for item in my_list: print(item[''tag''])", "label": "C"}, {"text": "for key, value in my_list.items(): print(key)", "label": "D"}]', 'for item in my_list: print(item[''tag''])', NULL, '2026-06-06 14:57:40.230173+00', 0.6557653, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ffec0d1a-f082-415f-af73-3c59c57c5dc5', 80, 170, 'short_answer', 'applied', 'Given the dictionary `data = {''fruits'': [''apple'', ''banana''], ''vegetables'': [''carrot'', ''spinach'']}`, write the Python code to print every individual item (fruit or vegetable) on its own line.', NULL, 'for category, items in data.items():
    for item in items:
        print(item)', NULL, '2026-06-06 14:57:40.230173+00', 0.6096414, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0fdeeee1-91f9-4b31-bc1f-8b5da6b80d16', 80, 170, 'coding', 'applied', 'You are given a list of dictionaries, where each dictionary represents a city and contains its ''name'' and a list of ''landmarks''. Your task is to iterate through this structure and print each city''s name, followed by each of its landmarks, indented. 

For example, if the input was `[{''name'': ''Paris'', ''landmarks'': [''Eiffel Tower'', ''Louvre'']}]`, the output should be:

City: Paris
  - Eiffel Tower
  - Louvre', NULL, NULL, '[{"input": "", "expected_output": "City: London\n  - Big Ben\n  - Tower Bridge\nCity: Rome\n  - Colosseum\n  - Vatican City\n  - Trevi Fountain\n"}]', '2026-06-06 14:57:40.230173+00', 0.5476528, 'cities_data = [
    {''name'': ''London'', ''landmarks'': [''Big Ben'', ''Tower Bridge'']},
    {''name'': ''Rome'', ''landmarks'': [''Colosseum'', ''Vatican City'', ''Trevi Fountain'']}
]

# Your code goes here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9e614b3b-bedd-455f-b12e-bf48dfd8a800', 80, 171, 'multiple_choice', 'foundational', 'You are designing a system to store information about books. Each book has a ''title'', ''author'', and ''publication_year''. You primarily need to display a list of all books, and occasionally search for a book by its title. Which nested data structure is generally the most straightforward and efficient for these primary uses?', '[{"text": "A dictionary where keys are book titles and values are lists of publication years.", "label": "A"}, {"text": "A list of dictionaries, where each dictionary represents a book.", "label": "B"}, {"text": "A dictionary where keys are authors and values are lists of book titles.", "label": "C"}, {"text": "A list of lists, where each inner list contains [title, author, publication_year].", "label": "D"}]', 'A list of dictionaries, where each dictionary represents a book.', NULL, '2026-06-06 14:57:40.230173+00', 0.51143175, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5a16ce89-cd1d-4c14-a50a-70ea7ad10238', 80, 171, 'explanation', 'advanced', 'You are building a system to manage user preferences for a streaming service. Each user has a unique `user_id`, and a list of genres they prefer. You need to frequently perform two operations: 
1. Given a `user_id`, quickly retrieve their preferred genres.
2. Add a new genre preference for an existing user.

Describe the optimal nested data structure for this scenario and explain why it is better than other common nested structures (like a list of dictionaries) for these specific operations. Focus on efficiency and ease of modification.', NULL, 'The optimal nested data structure would be a dictionary where keys are `user_id`s and values are lists of preferred genres. For example: `user_preferences = {''userA'': [''action'', ''comedy''], ''userB'': [''drama'', ''sci-fi'']}`.

**Why it''s optimal:**
1.  **Quick Retrieval by `user_id`:** Dictionaries provide O(1) average-case time complexity for key lookups. This means retrieving a user''s genres by their `user_id` is extremely fast, regardless of how many users there are. If it were a list of dictionaries, you would have to iterate through the list (O(n) complexity) to find the correct user''s dictionary.
2.  **Easy Modification (Adding a new genre):** Once the user''s list of genres is accessed (which is fast), appending a new genre to that list is an O(1) operation. In a list of dictionaries, after finding the user, modifying their genre list would be equally easy, but the initial lookup would be slower.

**Comparison to a list of dictionaries:**
A list of dictionaries (e.g., `[{''user_id'': ''userA'', ''genres'': [''action'']}, {''user_id'': ''userB'', ''genres'': [''drama'']}]`) would be less efficient for retrieving by `user_id` because you''d have to loop through the list until you found the dictionary with the matching `user_id`. While it''s good for iterating through all users, it''s poor for direct lookup by a specific identifier when that''s the primary access pattern.', NULL, '2026-06-06 14:57:40.230173+00', 0.6729713, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c7a5c159-6b89-4842-a031-11604e0e7bab', 82, 177, 'multiple_choice', 'foundational', 'Which of the following best describes the primary purpose of a `while` loop in Python?', '[{"text": "To define a function that can be called multiple times.", "label": "A"}, {"text": "To execute a block of code a specific, predetermined number of times.", "label": "B"}, {"text": "To repeat a block of code as long as a certain condition remains true.", "label": "C"}, {"text": "To make decisions in a program based on different conditions.", "label": "D"}]', 'To repeat a block of code as long as a certain condition remains true.', NULL, '2026-06-06 14:58:57.734578+00', 0.6583034, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fad19824-2bbd-434a-8adb-4d2d637a5155', 82, 177, 'short_answer', 'applied', 'Consider the following Python code:
python
x = 0
while x < 3:
    print(f"Value: {x}")
    x = x + 1

What will be the *last* line printed by this code before it finishes?', NULL, 'Value: 2', NULL, '2026-06-06 14:58:57.734578+00', 0.60047126, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a6051770-14da-47da-b988-2c4ccb0920bc', 82, 178, 'explanation', 'applied', 'Explain why it is crucial to update the loop variable within the body of a `while` loop, providing an example of how an un-updated variable could affect program execution.', NULL, 'Updating the loop variable within the `while` loop''s body is crucial because it''s the primary mechanism to change the loop''s condition, eventually making it `False` and terminating the loop. If the loop variable is not updated, or updated incorrectly such that the condition never becomes `False`, the loop will run indefinitely, leading to an ''infinite loop''. This consumes system resources and prevents the rest of the program from executing. For example:

python
count = 0
while count < 3:
    print("Hello")
    # count = count + 1  <-- Missing update!


Without `count = count + 1`, `count` will always be `0`, the condition `count < 3` will always be `True`, and "Hello" will print forever.', NULL, '2026-06-06 14:58:57.734578+00', 0.7170404, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fc19a22e-b2aa-41fa-8062-c04b4dc38d98', 82, 178, 'coding', 'applied', 'You need to create a simple counter that starts at `initial_value` (which is 5) and counts down to 1, printing each number as it counts. Use a `while` loop and update a loop variable to control the counting process and ensure the loop terminates correctly. Each number should be printed on a new line.', NULL, NULL, '[{"input": "", "expected_output": "5\n4\n3\n2\n1"}]', '2026-06-06 14:58:57.734578+00', 0.40969867, 'initial_value = 5
current_number = initial_value

# TODO: Write a while loop here that counts down from current_number to 1
#       and prints each number on a new line.
#       Ensure the loop variable is updated to guarantee termination.

');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d1dea447-69b2-4e57-a773-85887724409b', 82, 179, 'multiple_choice', 'foundational', 'What happens when a `break` statement is executed inside a `while` loop?', '[{"text": "The loop immediately terminates, and execution continues after the loop.", "label": "A"}, {"text": "The current iteration is skipped, and the loop proceeds to the next iteration.", "label": "B"}, {"text": "The program exits entirely.", "label": "C"}, {"text": "An error is raised.", "label": "D"}]', 'The loop immediately terminates, and execution continues after the loop.', NULL, '2026-06-06 14:58:57.734578+00', 0.7003005, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('19cb0482-dd4b-4b75-93f5-cfbc4739db85', 82, 179, 'short_answer', 'applied', 'You are writing a `while` loop to process a list of items. If an item is marked as ''invalid'', you want to immediately stop processing any further items. Which control flow statement would you use?', NULL, '`break`', NULL, '2026-06-06 14:58:57.734578+00', 0.4954735, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('268d15d8-396c-4462-ab5c-af17443f2a53', 82, 179, 'coding', 'applied', 'Write a `while` loop that initializes a variable `i` to 0. The loop should continue as long as `i` is less than 10. Inside the loop, increment `i`. If `i` is 3, use `continue` to skip printing. If `i` is 7, use `break` to exit the loop. Print `i` for all other values.', NULL, NULL, '[{"input": "", "expected_output": "1\n2\n4\n5\n6"}]', '2026-06-06 14:58:57.734578+00', 0.5948834, 'i = 0
while i < 10:
    i += 1
    # TODO: Add your continue and break statements here
    # Then print i
    
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fbf21dc3-5fae-444c-aac6-03ca397e2f57', 82, 180, 'multiple_choice', 'foundational', 'Which of the following is the most common reason for an infinite loop in Python?', '[{"text": "The `while` loop condition is always `True`.", "label": "A"}, {"text": "The `break` statement is used incorrectly.", "label": "B"}, {"text": "The loop body contains an `if` statement.", "label": "C"}, {"text": "The Python interpreter crashes.", "label": "D"}]', 'The `while` loop condition is always `True`.', NULL, '2026-06-06 14:58:57.734578+00', 0.6753387, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3c8a94aa-d9f0-45b8-a361-3928798f4009', 82, 180, 'short_answer', 'applied', 'Consider the following Python code:
python
x = 10
while x > 5:
    print(f"Value of x: {x}")
    x += 1

Will this loop terminate? If not, briefly explain why and how to fix it.', NULL, 'No, this loop will not terminate. The condition `x > 5` will always be true because `x` starts at 10 and is incremented by 1 in each iteration, making it progressively larger and never less than or equal to 5. To fix it, `x` should be decremented (e.g., `x -= 1`) so that it eventually becomes 5 or less, making the condition `x > 5` false.', NULL, '2026-06-06 14:58:57.734578+00', 0.7282829, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('19161dd8-89e3-48eb-95b4-909a57c7aa2b', 82, 180, 'coding', 'applied', 'The following `while` loop is intended to print numbers from 5 down to 1. However, it currently results in an infinite loop. Modify the `starter_code` to fix the infinite loop so that it prints ''5 4 3 2 1 Done!'' and terminates correctly.', NULL, NULL, '[{"input": "", "expected_output": "5 4 3 2 1 Done!\n"}]', '2026-06-06 14:58:57.734578+00', 0.58126676, 'num = 5
while num > 0:
    print(num, end=" ")
    # TODO: Add the line that prevents an infinite loop here

print("Done!")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('96c6f32b-8e46-409e-90d6-b0169bc1b881', 82, 181, 'multiple_choice', 'foundational', 'Why is simulating user input with a predefined list beneficial in certain programming scenarios?', '[{"text": "It makes the program run faster by skipping the `input()` function entirely.", "label": "A"}, {"text": "It allows for deterministic testing and execution when direct interactive `input()` is not feasible or desired.", "label": "B"}, {"text": "It automatically generates random inputs, making the program more robust.", "label": "C"}, {"text": "It simplifies debugging by automatically correcting invalid user entries.", "label": "D"}]', 'It allows for deterministic testing and execution when direct interactive `input()` is not feasible or desired.', NULL, '2026-06-06 14:58:57.734578+00', 0.66166663, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f33e1671-f707-4259-ba10-bbf777486a72', 82, 181, 'short_answer', 'applied', 'You are simulating user input using a list named `user_actions = [''start'', ''pause'', ''stop'']` within a `while` loop. What mechanism would you typically use to retrieve the next simulated input from this list in each iteration?', NULL, 'An index variable (e.g., `action_index`) that is incremented in each loop iteration, or an iterator (`iter(user_actions)`) combined with `next()`.', NULL, '2026-06-06 14:58:57.734578+00', 0.6988459, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('45dc2b5d-b8f5-488d-8273-c11a1ee28b5a', 82, 181, 'coding', 'applied', 'Create a `while` loop that simulates a user entering commands. Use the predefined list `commands = [''open'', ''read'', ''write'', ''exit'']` to provide input. The loop should print each command and stop when the command ''exit'' is encountered. You need to manage the index to access each item in `commands` sequentially.', NULL, NULL, '[{"input": "", "expected_output": "Processing command: open\nProcessing command: read\nProcessing command: write\nProcessing command: exit\n"}]', '2026-06-06 14:58:57.734578+00', 0.53189164, 'commands = [''open'', ''read'', ''write'', ''exit'']
command_index = 0

# TODO: Implement the while loop to simulate input and print commands
#       Stop when ''exit'' is encountered.
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('40c62e8c-0dfb-4a16-bc6b-9b90388fda6f', 83, 182, 'explanation', 'advanced', 'Explain why it is generally bad practice to remove items from a list while iterating over it directly in a `for` loop, and what the recommended alternative is when you want to ''filter out'' items.', NULL, 'Removing items from a list while iterating over it directly using `for item in my_list:` can lead to unexpected behavior and bugs. This is because when an item is removed, the list''s length changes, and the indices of subsequent items shift. This can cause some items to be skipped over entirely, or lead to `IndexError` if you''re iterating by index. The recommended alternative for ''filtering out'' items is to create a new list. You iterate through the original list, and if an item meets the desired criteria (i.e., it''s an item you want to *keep*), you add it to the new list. This approach avoids modifying the collection during iteration, ensuring all items are properly evaluated and preventing indexing issues.', NULL, '2026-06-06 14:59:35.774898+00', 0.67939484, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0b24f455-8890-4513-98ee-dafd5aa44774', 83, 183, 'multiple_choice', 'foundational', 'Which of the following best describes ''mapping data with transformations''?', '[{"text": "Removing specific items from a list based on a condition.", "label": "A"}, {"text": "Combining multiple lists into a single list.", "label": "B"}, {"text": "Creating a new data structure by applying a rule or function to each item of an existing data structure.", "label": "C"}, {"text": "Counting how many times a specific item appears in a list.", "label": "D"}]', 'Creating a new data structure by applying a rule or function to each item of an existing data structure.', NULL, '2026-06-06 14:59:35.774898+00', 0.3530971, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8aba9258-9af3-468e-ae54-b5d46659b6c5', 83, 183, 'short_answer', 'applied', 'You have a list of temperatures in Celsius: `celsius_temps = [0, 10, 25, 37]`. Write a list comprehension that converts these temperatures to Fahrenheit using the formula `F = C * 9/5 + 32` and stores them in a new list called `fahrenheit_temps`.', NULL, 'fahrenheit_temps = [temp * 9/5 + 32 for temp in celsius_temps]', NULL, '2026-06-06 14:59:35.774898+00', 0.41782677, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6de5379d-b120-4472-8587-9cb7c508e9ba', 83, 184, 'multiple_choice', 'foundational', 'What is the primary purpose of an ''accumulator'' variable in data aggregation?', '[{"text": "To store the individual items being processed in the loop.", "label": "A"}, {"text": "To control the number of iterations a loop performs.", "label": "B"}, {"text": "To gather and maintain a running total, count, or other summary value across loop iterations.", "label": "C"}, {"text": "To temporarily hold the result of a conditional check inside the loop.", "label": "D"}]', 'To gather and maintain a running total, count, or other summary value across loop iterations.', NULL, '2026-06-06 14:59:35.774898+00', 0.5836778, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f19b4ed6-ec8c-4bcc-9a72-decf1901a872', 83, 184, 'short_answer', 'applied', 'You have a list of `grades = [85, 92, 78, 95, 88]`. Write down the Python code snippet that correctly initializes an accumulator for calculating the maximum grade and updates it inside a loop. Assume the loop iterates `for grade in grades: ...`.', NULL, 'max_grade = -1
for grade in grades:
    if grade > max_grade:
        max_grade = grade', NULL, '2026-06-06 14:59:35.774898+00', 0.5130036, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d1983273-f95a-4b12-b616-27e3c2bd2134', 83, 184, 'coding', 'applied', 'You are given a list of `scores`. Your task is to count how many of these scores are considered ''passing'' (i.e., 70 or higher). Print the total count of passing scores.

For example, if `scores = [65, 80, 72, 55, 90]`, the output should be `3`.', NULL, NULL, '[{"input": "", "expected_output": "5"}]', '2026-06-06 14:59:35.774898+00', 0.3990092, 'scores = [65, 80, 72, 55, 90, 70, 60, 95]

# Initialize your accumulator here
passing_count = 0

# Loop through the scores and update the accumulator
for score in scores:
    # Your conditional logic and accumulator update go here
    pass # Remove this line and add your code

# Print the final result
print(passing_count)');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('53acd5ce-6b60-4ec3-a6d9-640fffa13f77', 83, 185, 'multiple_choice', 'foundational', 'What is the primary purpose of a guard clause?', '[{"text": "To define the main execution path of a function.", "label": "A"}, {"text": "To handle invalid conditions or edge cases early and exit.", "label": "B"}, {"text": "To loop through data structures more efficiently.", "label": "C"}, {"text": "To create reusable blocks of code for common tasks.", "label": "D"}]', 'To handle invalid conditions or edge cases early and exit.', NULL, '2026-06-06 14:59:35.774898+00', 0.4596629, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('97b3afe2-258f-47e7-8ec6-fbd4ef78ff71', 83, 185, 'explanation', 'applied', 'Explain how guard clauses can improve code readability and robustness.', NULL, 'Guard clauses improve readability by reducing the level of indentation for the main logic (the ''happy path''). By handling edge cases or invalid conditions at the beginning of a function and exiting early (e.g., with `return`, `continue`, `break`), the core logic of the function becomes less nested and easier to follow. They improve robustness by explicitly checking for conditions that could lead to errors or unexpected behavior, preventing the main logic from processing invalid data and ensuring the function behaves predictably under various inputs.', NULL, '2026-06-06 14:59:35.774898+00', 0.57371205, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('add66633-46f7-4a2f-a0d2-c81f2bd65a8d', 83, 185, 'coding', 'applied', 'You are given a function `calculate_discounted_price(original_price, discount_percentage)`. 

Implement guard clauses at the beginning of the function to handle the following invalid scenarios:
1. If `original_price` is less than 0, print ''Error: Original price cannot be negative.'' and return -1.
2. If `discount_percentage` is less than 0 or greater than 100, print ''Error: Discount percentage must be between 0 and 100.'' and return -1.

If all inputs are valid, calculate and return the discounted price. The formula for discounted price is `original_price * (1 - discount_percentage / 100)`.

Complete the `calculate_discounted_price` function.', NULL, NULL, '[{"input": "", "expected_output": "90.0\nError: Original price cannot be negative.\n-1\nError: Discount percentage must be between 0 and 100.\n-1\n50.0\nError: Discount percentage must be between 0 and 100.\n-1"}]', '2026-06-06 14:59:35.774898+00', 0.45379305, 'def calculate_discounted_price(original_price, discount_percentage):
    # TODO: Add guard clauses here


    # Main logic
    discount_factor = 1 - discount_percentage / 100
    return original_price * discount_factor

print(calculate_discounted_price(100, 10))
print(calculate_discounted_price(-50, 20))
print(calculate_discounted_price(200, 120))
print(calculate_discounted_price(50, 0))
print(calculate_discounted_price(50, -5))');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ab848d62-d642-4e1e-8e79-ee97d73e338c', 83, 186, 'multiple_choice', 'foundational', 'Consider the following Python code:

python
for i in range(2):
    for j in range(3):
        print(f"i={i}, j={j}")


How many times will the line `print(f"i={i}, j={j}")` be executed?', '[{"text": "2 times", "label": "A"}, {"text": "3 times", "label": "B"}, {"text": "5 times", "label": "C"}, {"text": "6 times", "label": "D"}]', '6 times', NULL, '2026-06-06 14:59:35.774898+00', 0.4888644, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f10cedbd-0727-454d-a464-7cd0afadab2f', 83, 186, 'short_answer', 'applied', 'You have a list of student names `[''Alice'', ''Bob'']` and a list of subjects `[''Math'', ''Science'']`. You want to print every possible combination of a student and a subject (e.g., ''Alice - Math'', ''Alice - Science'', ''Bob - Math'', ''Bob - Science''). How many lines of output would this produce if you used nested loops correctly?', NULL, '4', NULL, '2026-06-06 14:59:35.774898+00', 0.5895416, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('62295b29-b95f-4a3c-8d28-fe85284dba31', 88, 206, 'multiple_choice', 'foundational', 'Which of the following best describes the relationship established by inheritance?', '[{"text": "''has-a'' relationship", "label": "A"}, {"text": "''is-a'' relationship", "label": "B"}, {"text": "''part-of'' relationship", "label": "C"}, {"text": "''uses-a'' relationship", "label": "D"}]', '''is-a'' relationship', NULL, '2026-06-06 15:02:57.920346+00', 0.38237393, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('271d3a94-6554-41ec-8649-849c182ef565', 83, 186, 'explanation', 'advanced', 'Explain a scenario where using nested loops could lead to significant performance issues, and briefly suggest a conceptual alternative to mitigate this problem (without writing code).', NULL, 'A scenario where nested loops cause significant performance issues is when dealing with very large datasets, say comparing every item in a list of 100,000 items to every other item. This would involve 100,000 * 100,000 (10 billion) operations, which is prohibitively slow. This is an O(N^2) complexity. A conceptual alternative could involve using more efficient data structures (like hash tables/dictionaries for quick lookups) or algorithms that reduce the number of comparisons needed (e.g., sorting the data first and then using a single pass or two pointers, or specific optimized algorithms for tasks like finding pairs).', NULL, '2026-06-06 14:59:35.774898+00', 0.5307318, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ec21af8a-2ee0-4b82-9b2b-120ef48d6024', 83, 186, 'coding', 'applied', 'You are given a list of lists representing a 2D grid of numbers. Your task is to calculate the sum of all numbers in the grid.

Use nested `for` loops to iterate through each inner list and then through each number within that inner list, adding it to a running total. Finally, print the total sum.', NULL, NULL, '[{"input": "", "expected_output": "The total sum is: 45"}]', '2026-06-06 14:59:35.774898+00', 0.5793144, 'grid = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

total_sum = 0

# TODO: Use nested loops to sum all numbers in the grid


print(f"The total sum is: {total_sum}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4bf1cde2-4e09-4827-9cdd-cc43ad2b94c4', 84, 187, 'explanation', 'advanced', 'Explain the significance of indentation in defining the body of a Python function.', NULL, 'Indentation is crucial in Python because it defines code blocks. For functions, all statements that are part of the function''s body must be indented at the same level (typically 4 spaces) below the `def` line. If code is not indented correctly, Python will not consider it part of the function, leading to syntax errors or unexpected behavior. It''s how Python knows where the function''s code block begins and ends.', NULL, '2026-06-06 15:00:09.124422+00', 0.6483563, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('425837ff-5e9b-4769-a2c0-d3d4ed4af665', 84, 188, 'multiple_choice', 'foundational', 'What is the correct term for the variables listed inside the parentheses when defining a function?', '[{"text": "Arguments", "label": "A"}, {"text": "Variables", "label": "B"}, {"text": "Parameters", "label": "C"}, {"text": "Placeholders", "label": "D"}]', 'Parameters', NULL, '2026-06-06 15:00:09.124422+00', 0.57814366, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dd1a4f5a-05c7-4b92-a9a5-9ec545d0d927', 84, 188, 'short_answer', 'applied', 'Consider the following function definition: `def calculate_area(length, width):`. If you call this function as `calculate_area(10, 5)`, what are the specific ''arguments'' being passed?', NULL, '10 and 5', NULL, '2026-06-06 15:00:09.124422+00', 0.6604053, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0d03ba74-af7a-4955-9122-c7fda4b91f5c', 84, 188, 'explanation', 'advanced', 'Explain the difference between a function ''parameter'' and a function ''argument'' in Python, using an example.', NULL, 'A parameter is a variable defined in the function signature when you declare the function (e.g., `name` in `def greet(name):`). It acts as a placeholder for a value that will be provided when the function is called. An argument is the actual value passed to the function when you invoke it (e.g., `''Alice''` in `greet(''Alice'')`). When the function is called, the argument''s value is assigned to its corresponding parameter.', NULL, '2026-06-06 15:00:09.124422+00', 0.87380844, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('de2948cc-7955-4069-aeff-d9b68c2b1329', 84, 188, 'coding', 'applied', 'Define a function named `display_info` that takes two parameters: `item_name` and `quantity`. The function should print a message in the format: ''Item: [item_name], Quantity: [quantity]''.

After defining the function, call `display_info` twice:
1. With ''Apples'' and 5
2. With ''Oranges'' and 10', NULL, NULL, '[{"input": "", "expected_output": "Item: Apples, Quantity: 5\nItem: Oranges, Quantity: 10"}]', '2026-06-06 15:00:09.124422+00', 0.3337801, '# Define the display_info function below this line


# Call the function twice below this line
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6d7d5078-8c0d-44ea-8e80-ec4629cc4833', 84, 189, 'multiple_choice', 'foundational', 'What is the primary purpose of the `return` statement in a Python function?', '[{"text": "To display information directly to the user''s console.", "label": "A"}, {"text": "To pause the execution of the function until a condition is met.", "label": "B"}, {"text": "To send a value back from the function to the part of the code that called it.", "label": "C"}, {"text": "To stop the program immediately if an error occurs.", "label": "D"}]', 'To send a value back from the function to the part of the code that called it.', NULL, '2026-06-06 15:00:09.124422+00', 0.6139141, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b8cbdff3-c8e6-44b6-926a-02c4caa9a9cb', 84, 189, 'short_answer', 'applied', 'Consider the following two functions:

python
def greet_and_return_name(name):
    message = f"Hello, {name}!"
    return message

def greet_and_print_name(name):
    message = f"Hello, {name}!"
    print(message)


If you want to store the greeting message in a variable to use later (e.g., to write it to a file), which function would you call, `greet_and_return_name` or `greet_and_print_name`? Explain why.', NULL, '`greet_and_return_name`. This function uses the `return` statement to send the `message` string back to the caller, allowing it to be assigned to a variable. `greet_and_print_name` only displays the message to the console and returns `None`, so its output cannot be easily captured and used programmatically.', NULL, '2026-06-06 15:00:09.124422+00', 0.6522529, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('26828c6a-703b-4083-aeb7-f5351528e07b', 84, 189, 'coding', 'applied', 'Write a function named `calculate_area` that takes `width` and `height` as parameters. This function should calculate the area (`width * height`) and **return** this calculated area. 

Then, after defining your function, call `calculate_area` with `width=10` and `height=5`. Store the returned value in a variable named `room_area`. Finally, print a message in the format ''The room area is: X square units.'', replacing X with the value of `room_area`.', NULL, NULL, '[{"input": "", "expected_output": "The room area is: 50 square units.\n"}]', '2026-06-06 15:00:09.124422+00', 0.3070059, 'def calculate_area(width, height):
    # Your code here to calculate and return the area

# Call the function and print the result
# Your code here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1bc3fbfa-529c-492a-9049-0c6325cad68b', 84, 190, 'multiple_choice', 'foundational', 'Which of the following lines correctly calls a function named `calculate_area` that expects one argument?', '[{"text": "calculate_area;", "label": "A"}, {"text": "call calculate_area(5);", "label": "B"}, {"text": "calculate_area(5)", "label": "C"}, {"text": "def calculate_area(side):", "label": "D"}]', 'calculate_area(5)', NULL, '2026-06-06 15:00:09.124422+00', 0.4207446, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('99289e51-fca0-4807-825b-bcfccff6e6af', 84, 190, 'short_answer', 'applied', 'Suppose you have a function defined as `def show_message(text): print(text)`. Write the Python code to call this function and pass the string ''Welcome!'' as an argument.', NULL, 'show_message(''Welcome!'')', NULL, '2026-06-06 15:00:09.124422+00', 0.6381708, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0b7ed1f5-6b72-497c-8987-58d74fec9d86', 84, 190, 'coding', 'applied', 'You are provided with a function called `describe_pet` that takes two arguments: `animal_type` and `pet_name`. Your task is to call this function twice.

First call: Pass ''dog'' for `animal_type` and ''Buddy'' for `pet_name`.
Second call: Pass ''cat'' for `animal_type` and ''Whiskers'' for `pet_name`.

Make sure your calls exactly match the function''s expected arguments.', NULL, NULL, '[{"input": "", "expected_output": "I have a dog named Buddy.\nI have a cat named Whiskers.\n"}]', '2026-06-06 15:00:09.124422+00', 0.42336252, 'def describe_pet(animal_type, pet_name):
    print(f"I have a {animal_type} named {pet_name}.")

# Your code to call describe_pet goes below this line
# TODO: Call describe_pet for a dog named Buddy
# TODO: Call describe_pet for a cat named Whiskers');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ce3a40d1-1c3a-4d10-9159-375561ae27df', 84, 191, 'multiple_choice', 'foundational', 'Where should a docstring be placed within a Python function?', '[{"text": "Before the `def` statement.", "label": "A"}, {"text": "Immediately after the `def` statement, before any other code.", "label": "B"}, {"text": "After the `return` statement.", "label": "C"}, {"text": "Anywhere within the function body, as long as it starts with `\"\"\"`.", "label": "D"}]', 'Immediately after the `def` statement, before any other code.', NULL, '2026-06-06 15:00:09.124422+00', 0.6854884, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('12a5392d-65fe-45e3-aeb2-83d486ab4488', 84, 191, 'coding', 'applied', 'You have a function `add_numbers` that sums two integers. Add a docstring to this function following PEP 257 conventions. The docstring should briefly state what the function does, describe its two parameters (`num1`, `num2` both integers), and explain what it returns (an integer). After adding the docstring, print the docstring using the `__doc__` attribute.', NULL, NULL, '[{"input": "", "expected_output": "    Sums two integers.\n\n    Args:\n        num1 (int): The first integer.\n        num2 (int): The second integer.\n\n    Returns:\n        int: The sum of num1 and num2.\n    "}]', '2026-06-06 15:00:09.124422+00', 0.416454, 'def add_numbers(num1, num2):
    # TODO: Add a docstring here
    return num1 + num2

# Call the function (optional, not graded for this exercise)
# result = add_numbers(5, 3)
# print(result)

# TODO: Print the docstring here');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('29a69a55-a2b3-4d57-a251-056da3b8fdf0', 84, 191, 'explanation', 'advanced', 'Explain the primary difference between using a single-line comment (`#`) and a docstring (`"""..."""`) to document your code, particularly for functions. When would you choose one over the other?', NULL, 'Comments (`#`) are ignored by the Python interpreter and are primarily for developers to add internal notes or explain complex logic within the code. Docstrings (`"""..."""`), on the other hand, are special string literals that are preserved at runtime. They are used to document modules, functions, classes, and methods, explaining their purpose, parameters, and return values. Docstrings are accessible via the `__doc__` attribute and the `help()` function, making them part of the function''s public interface and useful for automated documentation tools. You would use a docstring to describe ''what'' a function does and ''how'' to use it, targeting users of the function. You would use a comment for ''why'' a particular piece of code is written a certain way or to explain complex implementation details, targeting future maintainers of the code.', NULL, '2026-06-06 15:00:09.124422+00', 0.7750701, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d87d1829-146a-4e3a-94fa-def99c3c32f9', 85, 192, 'multiple_choice', 'foundational', 'Consider the following Python function:

python
def greet(name, time_of_day):
    return f"Good {time_of_day}, {name}!"


Which of the following function calls uses *only* keyword arguments correctly?', '[{"text": "greet(\"morning\", \"Alice\")", "label": "A"}, {"text": "greet(name=\"Bob\", \"evening\")", "label": "B"}, {"text": "greet(time_of_day=\"afternoon\", name=\"Charlie\")", "label": "C"}, {"text": "greet(\"David\", time_of_day=\"night\")", "label": "D"}]', 'greet(time_of_day="afternoon", name="Charlie")', NULL, '2026-06-06 15:00:57.77261+00', 0.6455957, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e1346fac-71d4-4305-90b6-6b97cc133ecc', 85, 192, 'short_answer', 'applied', 'Given the function `calculate_area(length, width)`, provide an example of a function call that uses a mix of positional and keyword arguments to calculate the area of a rectangle with a length of 10 and a width of 5. The output should be a single Python function call.', NULL, 'calculate_area(10, width=5)', NULL, '2026-06-06 15:00:57.77261+00', 0.43724942, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f52e72dc-61e6-4886-abd0-509ae4cfd4b9', 85, 192, 'coding', 'applied', 'You are given a function `display_product_info(product_name, price, quantity)` that takes three parameters. Your task is to call this function twice.

1. First, call `display_product_info` using *only positional arguments*. Pass `"Laptop"` for `product_name`, `1200.50` for `price`, and `3` for `quantity`.
2. Second, call `display_product_info` using *only keyword arguments*. Pass `"Mouse"` for `product_name`, `25.99` for `price`, and `10` for `quantity`. You can specify the keyword arguments in any order.

Print the return value of each function call on a new line.', NULL, NULL, '[{"input": "", "expected_output": "Product: Laptop, Price: $1200.50, Quantity: 3\nProduct: Mouse, Price: $25.99, Quantity: 10\n"}]', '2026-06-06 15:00:57.77261+00', 0.5492706, 'def display_product_info(product_name, price, quantity):
    return f"Product: {product_name}, Price: ${price:.2f}, Quantity: {quantity}"

# Call 1: Using only positional arguments
# TODO: Write your code here


# Call 2: Using only keyword arguments
# TODO: Write your code here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c19cb785-0321-4acd-b437-f464a9e2103c', 85, 193, 'multiple_choice', 'foundational', 'Which of the following function definitions correctly uses a default argument?', '[{"text": "def func(a=10, b):", "label": "A"}, {"text": "def func(a, b=20):", "label": "B"}, {"text": "def func(a=5, b=10):", "label": "C"}, {"text": "def func(a, b, c=None, d):", "label": "D"}]', 'def func(a, b=20):', NULL, '2026-06-06 15:00:57.77261+00', 0.62058026, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c2c9c41d-c2f3-48f7-808b-6796e4c1c422', 85, 193, 'short_answer', 'applied', 'Consider the following function:

python
def describe_item(item, color=''red'', size=''medium''):
    return f"This is a {color} {size} {item}."


What will be the output of `print(describe_item(''shirt'', size=''large''))`?', NULL, 'This is a red large shirt.', NULL, '2026-06-06 15:00:57.77261+00', 0.44290343, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a76865f9-2889-4b31-b395-9315cbcfda35', 85, 194, 'multiple_choice', 'foundational', 'Which of the following function definitions correctly uses `*args` to accept an arbitrary number of positional arguments?', '[{"text": "def my_function(**args):", "label": "A"}, {"text": "def my_function(*args, param1):", "label": "B"}, {"text": "def my_function(param1, *args):", "label": "C"}, {"text": "def my_function(*args, **kwargs):", "label": "D"}]', 'def my_function(param1, *args):', NULL, '2026-06-06 15:00:57.77261+00', 0.6911454, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a8e9459b-60c8-4a31-82d9-4dfad019d250', 85, 194, 'short_answer', 'applied', 'Inside a function defined as `def process_items(category, *items):`, what will be the data type of the `items` variable?', NULL, 'tuple', NULL, '2026-06-06 15:00:57.77261+00', 0.41384605, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dae5e8cb-521d-4c3f-89b0-9e005a3b8ea2', 85, 194, 'coding', 'applied', 'Create a function named `concatenate_strings` that accepts one regular positional argument, `separator`, and then an arbitrary number of additional strings using `*strings_to_join`. The function should print all the `strings_to_join` concatenated together, with `separator` placed between them. If no additional strings are provided, it should print an empty string.', NULL, NULL, '[{"input": "", "expected_output": "hello-world\nPython is fun\n\n"}]', '2026-06-06 15:00:57.77261+00', 0.2020534, 'def concatenate_strings(separator, *strings_to_join):
    # TODO: Implement the function
    pass

concatenate_strings("-", "hello", "world")
concatenate_strings(" ", "Python", "is", "fun")
concatenate_strings("--")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2264b1c3-1272-46b9-88de-37a32fe29f53', 85, 195, 'multiple_choice', 'foundational', 'What data type does `kwargs` represent inside a function when `**kwargs` is used in the function signature?', '[{"text": "A list of tuples", "label": "A"}, {"text": "A dictionary", "label": "B"}, {"text": "A set of strings", "label": "C"}, {"text": "A tuple of key-value pairs", "label": "D"}]', 'A dictionary', NULL, '2026-06-06 15:00:57.77261+00', 0.47636643, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1eb61403-baf9-4c33-8cd2-5c23d7d129b6', 85, 195, 'explanation', 'applied', 'Explain a practical scenario where using `**kwargs` in a Python function would be beneficial. Describe how `**kwargs` helps solve the problem in that scenario.', NULL, 'A practical scenario for `**kwargs` is when designing a flexible `log_message` function or an `HTML_tag` generator. For `log_message`, you might want to log a standard message but also allow optional details like `timestamp`, `level`, `user_id`, or `session_id` depending on the context. `**kwargs` allows you to accept any number of these additional, descriptive keyword arguments without having to define them all explicitly in the function signature. The function can then iterate over the `kwargs` dictionary to include these details in the log output, making the function highly reusable and adaptable to various logging needs without constant modifications to its definition.', NULL, '2026-06-06 15:00:57.77261+00', 0.6180825, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e0c30774-69f5-44f2-a7cc-d191119aeb21', 85, 195, 'coding', 'applied', 'You need to create a function `format_data` that takes a `title` as a required positional argument, and then accepts any number of additional keyword arguments. The function should print the `title` followed by a new line. Then, it should print each additional keyword argument on a new line in the format `KEY: VALUE`. If no additional keyword arguments are provided, it should print ''No extra details.''', NULL, NULL, '[{"input": "", "expected_output": "User Information\nname: Alice\nage: 30\ncity: London\n\n---\n\nProduct Details\nproduct_id: P101\n\n---\n\nReport Summary\nNo extra details."}]', '2026-06-06 15:00:57.77261+00', 0.5156689, 'def format_data(title, **extra_details):
    # Your code here
    pass

# Test cases (do not modify)
format_data("User Information", name="Alice", age=30, city="London")
print("\n---\n")
format_data("Product Details", product_id="P101")
print("\n---\n")
format_data("Report Summary")');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9facc022-1832-4602-9f32-3356d55917ac', 85, 196, 'multiple_choice', 'foundational', 'When is a default argument value, such as an empty list `[]`, evaluated in a Python function?', '[{"text": "Every time the function is called.", "label": "A"}, {"text": "Only when the function is called without explicitly providing a value for that argument.", "label": "B"}, {"text": "Once, when the function is defined.", "label": "C"}, {"text": "Only when the interpreter first encounters the function definition.", "label": "D"}]', 'Once, when the function is defined.', NULL, '2026-06-06 15:00:57.77261+00', 0.600411, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1fa61cb1-4ab5-42c3-8c5d-0a0f5c3f46d4', 85, 196, 'short_answer', 'applied', 'You have the following Python code:

python
def add_tag(item, tags_list=[]):
    tags_list.append(item)
    return tags_list

result1 = add_tag(''python'')
result2 = add_tag(''programming'')

print(result1)
print(result2)


What will be the exact output of this code?', NULL, '[''python'', ''programming'']
[''python'', ''programming'']', NULL, '2026-06-06 15:00:57.77261+00', 0.46519437, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('02c1a5c2-6246-4025-a0c3-e41ac38ab9fd', 85, 196, 'coding', 'applied', 'You are tasked with writing a function `add_to_collection(item, collection=None)` that adds an `item` to a `collection`. If no `collection` is provided, it should create a new empty list as the `collection`. Ensure your function correctly handles subsequent calls, so that each call without providing a `collection` starts with an independent, empty list. Then, demonstrate its corrected behavior by calling it twice without providing a collection.

Your output should print the result of these two calls on separate lines.', NULL, NULL, '[{"input": "", "expected_output": "[''first item'']\n[''second item'']"}]', '2026-06-06 15:00:57.77261+00', 0.56526625, 'def add_to_collection(item, collection=None):
    # TODO: Implement the correct logic here
    pass # Replace this pass statement

# Call the function twice without providing a collection and print the results
# TODO: Add function calls and print statements here
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('96a708d0-9efa-41cf-8098-b8cb751f7d18', 85, 196, 'explanation', 'advanced', 'Explain why using a mutable object (like a list or dictionary) as a default argument value in Python can lead to unexpected behavior. Describe the core mechanism behind this issue and provide the standard solution to prevent it.', NULL, 'The issue arises because default argument values are evaluated only once, when the function is defined, not every time the function is called. When a mutable object (like a list, dict, or set) is used as a default, all subsequent calls to the function that omit that argument will share the exact same mutable object in memory. Any modification made to this shared mutable object within one function call will persist and be visible in all future calls that use the default. This leads to unexpected side effects because the ''default'' state isn''t reset as one might intuitively expect.

The standard solution is to use `None` as the default value for the mutable argument. Then, inside the function, check if the argument''s value is `None`. If it is, initialize the mutable object (e.g., `my_list = []`) at that point. This ensures that a new, independent mutable object is created only when the argument is not explicitly provided, effectively resetting the default for each such call.', NULL, '2026-06-06 15:00:57.77261+00', 0.7792684, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('deeb28f6-12ec-4fd2-b0f4-3f5458e2005d', 86, 197, 'multiple_choice', 'foundational', 'Which of the following best describes the Python Standard Library?', '[{"text": "A collection of third-party modules that must be installed using pip.", "label": "A"}, {"text": "A set of core programming languages that Python interacts with.", "label": "B"}, {"text": "A collection of built-in modules included with every Python installation, offering ready-to-use functionality.", "label": "C"}, {"text": "A framework for creating graphical user interfaces in Python.", "label": "D"}]', 'A collection of built-in modules included with every Python installation, offering ready-to-use functionality.', NULL, '2026-06-06 15:01:36.354886+00', 0.57486385, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('83b796eb-5d2c-405a-99cb-cd84eb4f5b5e', 86, 197, 'explanation', 'applied', 'You are starting a new project that requires calculating trigonometric functions (like sine and cosine). Explain why using a module from the Python Standard Library for this task is generally preferred over writing the functions yourself.', NULL, 'Using a standard library module (like `math`) for trigonometric functions is preferred because these modules are:
1.  **Reliable and Tested:** They have been extensively tested by many developers over a long time, making them robust and bug-free.
2.  **Efficient:** They are often implemented in highly optimized C code, leading to better performance than a typical Python implementation.
3.  **Convenient:** They save development time as you don''t need to write, debug, and maintain your own version of common functions.
4.  **Standardized:** They ensure consistency and correctness across different projects and developers.', NULL, '2026-06-06 15:01:36.354886+00', 0.6133119, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6ff65b10-ffea-4a5b-b6f3-44f46ab9d149', 86, 197, 'coding', 'foundational', 'The Python Standard Library includes the `math` module, which contains a constant for pi (π). Your task is to print the value of pi using this constant.', NULL, NULL, '[{"input": "", "expected_output": "3.141592653589793"}]', '2026-06-06 15:01:36.354886+00', 0.45996565, '# Import the math module
# Your code here to print the value of pi
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0ca79100-99e3-4e8e-8310-71efa83b1160', 86, 198, 'multiple_choice', 'foundational', 'Which of the following statements correctly imports an entire module named `math_operations`?', '[{"text": "import math_operations", "label": "A"}, {"text": "from math_operations import *", "label": "B"}, {"text": "import math_operations.all", "label": "C"}, {"text": "include math_operations", "label": "D"}]', 'import math_operations', NULL, '2026-06-06 15:01:36.354886+00', 0.5717586, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c5d4f7d4-96fc-4670-8f93-197879d3a094', 86, 198, 'short_answer', 'applied', 'You have a module named `utils.py` containing a function `format_text(text)` and a variable `MAX_LENGTH = 100`. Write the Python statement to import only `format_text` and `MAX_LENGTH` into your current script, so you can use them directly without a prefix.', NULL, 'from utils import format_text, MAX_LENGTH', NULL, '2026-06-06 15:01:36.354886+00', 0.42709288, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('00f3732a-43d9-4b6e-8642-426d82556475', 86, 198, 'explanation', 'advanced', 'Explain the key difference between `import my_module` and `from my_module import my_function`. When would you choose one over the other?', NULL, 'When you use `import my_module`, the entire module is loaded, and you must access its contents (like functions or variables) using the module name as a prefix, e.g., `my_module.my_function()`. This helps prevent naming conflicts if other modules or your script have items with the same name.

When you use `from my_module import my_function`, only the specified item (`my_function` in this case) is imported directly into the current script''s namespace. You can then call `my_function()` directly without the `my_module.` prefix. This is useful when you only need a few specific items from a module and want to avoid repetitive prefixing. However, it increases the risk of naming conflicts if `my_function` clashes with another item in your script or other imported modules.', NULL, '2026-06-06 15:01:36.354886+00', 0.7566235, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a9681007-a6c6-4c3c-8ac8-c89970800cdc', 89, 210, 'short_answer', 'applied', 'In the context of multiple cooperating classes, describe the ''has-a'' relationship (also known as composition or aggregation) with a brief example.', NULL, 'The ''has-a'' relationship describes when one class contains or ''has'' an instance (or instances) of another class as one of its attributes. This implies ownership or a part-of relationship. For example, an `Order` class ''has-a'' list of `Product` objects, or a `Car` class ''has-a'' `Engine` object.', NULL, '2026-06-06 15:03:36.683155+00', 0.38981417, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a84e3bdb-bcca-4509-8b01-5a773434782f', 86, 198, 'coding', 'applied', 'You are given a module `stats_module.py` (you don''t need to create it) that contains a function `calculate_average(numbers)` and a variable `APPROX_PI = 3.14`. Your task is to write a Python script that:
1. Imports the `calculate_average` function from `stats_module` so it can be called directly.
2. Imports the entire `stats_module` (for `APPROX_PI`).
3. Calculates the average of `[10, 20, 30]` using the imported function.
4. Prints the calculated average.
5. Prints the `APPROX_PI` variable using the module-prefixed method.

Expected Output Format:
Average: <average_value>
Approximate Pi: <pi_value>', NULL, NULL, '[{"input": "", "expected_output": "Average: 20.0\nApproximate Pi: 3.14"}]', '2026-06-06 15:01:36.354886+00', 0.5701445, '# This file represents stats_module.py (you don''t need to edit or create it)
# def calculate_average(numbers):
#     return sum(numbers) / len(numbers)
# APPROX_PI = 3.14

# Your code goes here

# 1. Import calculate_average directly
# 2. Import the entire stats_module

numbers = [10, 20, 30]

# 3. Calculate average
# 4. Print average

# 5. Print APPROX_PI
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('916884b3-8ce9-4bd0-9981-30b35a87beed', 86, 199, 'multiple_choice', 'foundational', 'Which of the following is the correct syntax to import the `random` module and alias it as `rnd`?', '[{"text": "alias random as rnd", "label": "A"}, {"text": "import random, rnd", "label": "B"}, {"text": "import random as rnd", "label": "C"}, {"text": "from random import rnd", "label": "D"}]', 'import random as rnd', NULL, '2026-06-06 15:01:36.354886+00', 0.44572753, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9bc7cb87-a75a-4669-ab3f-d526eaa421ca', 86, 199, 'coding', 'applied', 'The `collections` module in Python''s standard library contains a `deque` class (double-ended queue). Import the `deque` class from the `collections` module and alias it as `DQ`. Then, create an instance of `DQ` with the elements `[10, 20, 30]` and print the `DQ` object.

Your output should be the string representation of the `DQ` object.', NULL, NULL, '[{"input": "", "expected_output": "deque([10, 20, 30])"}]', '2026-06-06 15:01:36.354886+00', 0.2235345, '# Your code here
# from collections import deque as DQ
# my_dq = DQ([10, 20, 30])
# print(my_dq)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ad1f8c81-49a5-4667-9722-432378dc7b72', 86, 199, 'explanation', 'advanced', 'Explain two distinct reasons why a developer might choose to use module aliasing when importing modules or their contents, providing a brief example for each reason.', NULL, 'A strong answer should include:
1.  **Readability/Convenience (Shorter Names):** Long module names can make code cluttered and hard to read. Aliasing provides a shorter, more convenient name without losing clarity. Example: `import pandas as pd` (for data analysis) or `import matplotlib.pyplot as plt` (for plotting).
2.  **Avoiding Name Clashes:** If you''re importing multiple modules or components that have functions/variables with the same name, aliasing can prevent conflicts. It allows both components to be used by giving one or both an alternative name. Example: If both `module_a` and `module_b` have a function called `process()`, you could do `from module_a import process as process_a` and `from module_b import process as process_b`.', NULL, '2026-06-06 15:01:36.354886+00', 0.72484815, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f8d2c350-d72c-4886-a387-43ac6a35a3de', 86, 200, 'multiple_choice', 'foundational', 'Which Python standard library module would you typically use to find the square root of a number?', '[{"text": "`random`", "label": "A"}, {"text": "`math`", "label": "B"}, {"text": "`datetime`", "label": "C"}, {"text": "`sys`", "label": "D"}]', '`math`', NULL, '2026-06-06 15:01:36.354886+00', 0.42345026, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c0e904e6-3abd-437a-b078-d579e57f12d4', 86, 200, 'short_answer', 'applied', 'You want to simulate a dice roll (a random integer between 1 and 6, inclusive). Write the single line of Python code, including the necessary import statement, that would achieve this. Assume you want to store the result in a variable named `dice_roll`.', NULL, 'import random
dice_roll = random.randint(1, 6)', NULL, '2026-06-06 15:01:36.354886+00', 0.44902512, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('74b6c0d7-ba21-43e0-9fc5-55f6b22d37e9', 86, 201, 'multiple_choice', 'foundational', 'Which of the following is NOT a primary benefit of organizing code with functions?', '[{"text": "Increased code reusability", "label": "A"}, {"text": "Easier debugging by isolating issues", "label": "B"}, {"text": "Automatic code optimization for faster execution", "label": "C"}, {"text": "Improved code readability and modularity", "label": "D"}]', 'Automatic code optimization for faster execution', NULL, '2026-06-06 15:01:36.354886+00', 0.3881563, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1d3c044d-7e10-4012-9e51-96407969c14e', 86, 201, 'explanation', 'advanced', 'You are working on a program that processes data from a file, performs several calculations, and then generates a report. Explain how using functions for each of these distinct steps (reading data, performing calculations, generating report) contributes to better code organization and maintainability. Provide at least three specific advantages.', NULL, 'Using functions for distinct steps like reading data, performing calculations, and generating reports offers several advantages:

1.  **Modularity and Readability:** Each function encapsulates a specific task. For example, `read_data_from_file()` clearly indicates its purpose, making the main program flow easier to understand at a high level. This breaks down a complex problem into smaller, more manageable units.
2.  **Reusability:** If you need to perform the same data reading or calculation logic in another part of the program or even in a different project, you can simply call the existing function without rewriting the code. This saves development time and reduces the chance of introducing new bugs.
3.  **Easier Debugging and Testing:** If an issue arises, say in the calculation part, you can focus your debugging efforts solely on the `perform_calculations()` function. It''s much easier to test a small, focused function in isolation than to debug a large block of intertwined code. This isolation helps pinpoint and resolve problems more efficiently.
4.  **Collaboration:** When working in teams, different developers can work on different functions simultaneously without stepping on each other''s toes as much, as long as the function interfaces (inputs and outputs) are well-defined.', NULL, '2026-06-06 15:01:36.354886+00', 0.52364933, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c485b0af-3ba0-4d43-bc7d-58a6bf73c3fb', 86, 201, 'coding', 'applied', 'You need to convert temperatures from Celsius to Fahrenheit and then display them. Create a function named `celsius_to_fahrenheit` that takes a temperature in Celsius as an argument and returns its Fahrenheit equivalent. The formula is `Fahrenheit = Celsius * 9/5 + 32`. Then, use this function to convert `25` Celsius and `0` Celsius, printing each result on a new line, formatted as ''X Celsius is Y Fahrenheit.''.', NULL, NULL, '[{"input": "", "expected_output": "25 Celsius is 77.0 Fahrenheit.\n0 Celsius is 32.0 Fahrenheit."}]', '2026-06-06 15:01:36.354886+00', 0.11559767, '# Define the celsius_to_fahrenheit function here
def celsius_to_fahrenheit(celsius):
    # TODO: Implement the conversion formula
    pass

# Convert 25 Celsius and print the result
# TODO

# Convert 0 Celsius and print the result
# TODO
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9ac6d872-7f3f-4e0c-bddf-9a595b6a62b0', 87, 205, 'coding', 'applied', 'You are given a `Robot` class. Create two instances of `Robot`: one named ''Robby'' with initial energy 100, and another named ''Terminator'' with initial energy 200. Make ''Robby'' move, which should decrease its energy by 10. Finally, print the current energy level of both ''Robby'' and ''Terminator''.', NULL, NULL, '[{"input": "", "expected_output": "Robby moved. Energy remaining: 90\nRobby''s energy: 90\nTerminator''s energy: 200\n"}]', '2026-06-06 15:02:10.125507+00', 0.2277551, 'class Robot:
    def __init__(self, name, energy):
        self.name = name
        self.energy = energy

    def move(self):
        if self.energy >= 10:
            self.energy -= 10
            print(f''{self.name} moved. Energy remaining: {self.energy}'')
        else:
            print(f''{self.name} is out of energy!'')

# Your code here:
# Create instances
# Robby moves
# Print energy levels
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6ae26a47-647b-4972-b73f-3d3e5c2517db', 88, 206, 'coding', 'applied', 'You are building a system for a pet store. Create a base class `Animal` with an `__init__` method that takes a `name` and a `species` and stores them as attributes. Add a method `make_sound()` that returns ''Generic animal sound.''.

Then, create a subclass `Dog` that inherits from `Animal`. The `Dog` class''s `__init__` method should take a `name` and `breed`. It should also set the `species` attribute to ''Dog'' (using the inherited attribute). The `Dog` class should add a new method `fetch()` that returns ''Fetching the ball!''.

Finally, create an instance of `Dog` named ''Buddy'' of breed ''Golden Retriever'' and print its name, species, the sound it makes, and what it does when fetching.', NULL, NULL, '[{"input": "", "expected_output": "Buddy\nDog\nGeneric animal sound.\nFetching the ball!"}]', '2026-06-06 15:02:57.920346+00', 0.5484523, 'class Animal:
    def __init__(self, name, species):
        self.name = name
        self.species = species

    def make_sound(self):
        return "Generic animal sound."

class Dog(Animal):
    # TODO: Implement the __init__ method for Dog
    # TODO: Add the fetch method for Dog
    pass # Remove this line after implementing

# Create a Dog instance and print its details
# buddy = ...
# print(buddy.name)
# print(buddy.species)
# print(buddy.make_sound())
# print(buddy.fetch())
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('da861462-797c-4fa0-a15d-ce495bada923', 88, 206, 'short_answer', 'foundational', 'If you have a `Plant` class and you want to create a new class `Flower` that reuses `Plant`''s attributes and methods, how would you define the `Flower` class header in Python?', NULL, 'class Flower(Plant):', NULL, '2026-06-06 15:02:57.920346+00', 0.4611903, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('75ea7861-550b-44b0-b006-de99bdbd0655', 88, 206, 'explanation', 'advanced', 'Explain two primary benefits of using inheritance in object-oriented programming.', NULL, 'Two primary benefits of using inheritance are:

1.  **Code Reusability:** Inheritance allows subclasses to reuse attributes and methods defined in their superclass. This means you don''t have to write the same code multiple times for related classes, leading to less redundant code, easier maintenance, and fewer potential bugs.
2.  **Establishing ''is-a'' Relationships and Polymorphism (Specialization):** Inheritance models a natural ''is-a'' hierarchy (e.g., a `Dog` ''is an'' `Animal`). This creates a clear structure for your code. It also enables polymorphism, where a subclass can be treated as an instance of its superclass, but can also provide specialized implementations (overriding methods) for shared behaviors. This allows for more flexible and extensible designs where different types of objects can respond to the same method call in their own specific ways.', NULL, '2026-06-06 15:02:57.920346+00', 0.53633726, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('baa9c931-86e9-42de-be80-b2b80379ebb1', 88, 207, 'multiple_choice', 'foundational', 'What is the primary purpose of calling `super().__init__()` within a subclass''s `__init__` method?', '[{"text": "To prevent the superclass from being initialized.", "label": "A"}, {"text": "To explicitly call and execute the superclass''s constructor (initializer).", "label": "B"}, {"text": "To define new attributes specific to the subclass.", "label": "C"}, {"text": "To completely replace the superclass''s initialization logic.", "label": "D"}]', 'To explicitly call and execute the superclass''s constructor (initializer).', NULL, '2026-06-06 15:02:57.920346+00', 0.5758515, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2660caf7-9d5d-4edf-9075-c4c71f8d8e4f', 88, 207, 'short_answer', 'applied', 'Consider a `Shape` class with a `calculate_area()` method. If a subclass `Circle` needs to provide its own formula for calculating the area, what programming concept would `Circle` use for its `calculate_area()` method?', NULL, 'Method Overriding', NULL, '2026-06-06 15:02:57.920346+00', 0.44857964, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('831ede24-6677-4d47-b833-004894dba4f6', 88, 207, 'explanation', 'advanced', 'Explain a potential issue that could arise if you forget to call `super().__init__()` in a subclass''s constructor, especially if the superclass initializes essential attributes. Provide a simple Python code example demonstrating this issue and how to fix it.', NULL, 'Forgetting to call `super().__init__()` means the superclass''s initialization logic will never run. If the superclass''s `__init__` method sets up attributes or performs necessary setup that the subclass relies on, these attributes will be missing. This typically leads to an `AttributeError` when the subclass or any other part of the program tries to access those uninitialized attributes.

**Example of the issue:**
python
class Base:
    def __init__(self, value):
        self.base_value = value

class Derived(Base):
    def __init__(self, value, multiplier):
        # Forgot to call super().__init__(value)
        self.derived_value = self.base_value * multiplier # AttributeError here!

d = Derived(10, 2)
print(d.derived_value)


**How to fix it:**
python
class Base:
    def __init__(self, value):
        self.base_value = value

class Derived(Base):
    def __init__(self, value, multiplier):
        super().__init__(value) # Correctly calls parent''s __init__
        self.derived_value = self.base_value * multiplier

d = Derived(10, 2)
print(d.derived_value) # Output: 20', NULL, '2026-06-06 15:02:57.920346+00', 0.72762144, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5eccc131-4410-4cfe-a9e4-336c3e1d6272', 88, 207, 'coding', 'applied', 'You are given a `Vehicle` class and need to create a `Car` subclass. The `Vehicle` class has an `__init__` method that takes `brand` and `year`. It also has a `get_description` method that returns `f''{self.brand} from {self.year}''`. 

Your task is to:
1. Complete the `Car` class''s `__init__` method so it correctly initializes the `brand` and `year` using `super().__init__()` and adds a new attribute `num_wheels` (always 4 for a car).
2. Override the `get_description` method in the `Car` class. This overridden method should first get the description from the `Vehicle` class using `super().get_description()` and then append `, with {num_wheels} wheels` to it.', NULL, NULL, '[{"input": "", "expected_output": "Ford from 2020, with 4 wheels"}]', '2026-06-06 15:02:57.920346+00', 0.7054872, 'class Vehicle:
    def __init__(self, brand, year):
        self.brand = brand
        self.year = year

    def get_description(self):
        return f''{self.brand} from {self.year}''

class Car(Vehicle):
    def __init__(self, brand, year):
        # TODO: Call the superclass''s __init__ method
        # TODO: Initialize num_wheels attribute to 4
        pass # Remove this line after implementing

    def get_description(self):
        # TODO: Get the description from the Vehicle class
        # TODO: Append the number of wheels to the description
        pass # Remove this line after implementing

# Test cases - DO NOT MODIFY BELOW THIS LINE
my_car = Car("Ford", 2020)
print(my_car.get_description())
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('25876d97-ad1b-42bd-b84e-6aa02c91f4a4', 88, 208, 'multiple_choice', 'foundational', 'Which of the following best describes the relationship between classes in composition?', '[{"text": "''is-a'' relationship", "label": "A"}, {"text": "''has-a'' relationship", "label": "B"}, {"text": "''uses-a'' relationship (for static methods)", "label": "C"}, {"text": "''creates-a'' relationship", "label": "D"}]', '''has-a'' relationship', NULL, '2026-06-06 15:02:57.920346+00', 0.42078617, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('731c1096-41bb-41cc-8561-745ce67e5853', 89, 213, 'multiple_choice', 'foundational', 'Which of the following best describes the primary purpose of a class designed for ''managing collections''?', '[{"text": "To define the properties and behaviors of a single, complex entity.", "label": "A"}, {"text": "To store, organize, and operate on multiple instances of another class.", "label": "B"}, {"text": "To inherit functionality from multiple parent classes.", "label": "C"}, {"text": "To handle all input and output operations for a program.", "label": "D"}]', 'To store, organize, and operate on multiple instances of another class.', NULL, '2026-06-06 15:03:36.683155+00', 0.5837321, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('48880580-f164-4b45-9af3-c8a61e8be2f3', 88, 208, 'explanation', 'advanced', 'Explain two key advantages of using composition over inheritance for code reuse and flexibility in object-oriented design.', NULL, 'A strong answer should highlight:
1.  **Flexibility and adaptability**: Composition allows an object''s behavior to be changed at runtime by swapping out its component objects, something that is not possible with inheritance. It also makes it easier to change the type of a component without affecting the composite class.
2.  **Loose coupling**: Composition reduces the dependency between classes. The composite class only needs to know about the interface of its components, not their internal implementation details. This makes systems easier to maintain, test, and understand, as changes in one component are less likely to break others.
3.  **Avoiding the ''Diamond Problem'' (or multiple inheritance issues)**: Composition provides a clean alternative to multiple inheritance, preventing complex and ambiguous class hierarchies that can arise when a class inherits from multiple parents with overlapping methods or attributes.', NULL, '2026-06-06 15:02:57.920346+00', 0.35151613, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6dbe39d9-0a8a-4a35-8cf8-3588e7f3d4fc', 88, 208, 'coding', 'applied', 'You are building a system for a `Laptop`. A laptop ''has a'' `Processor` and ''has a'' `Battery`. Implement the `Processor` and `Battery` classes, and then integrate them into the `Laptop` class using composition.

The `Processor` class should have attributes `model` and `clock_speed_ghz`. It should have a method `get_specs` that returns a string like ''Processor: Intel Core i7 @ 2.5 GHz''.

The `Battery` class should have attributes `capacity_mah` and `charge_percentage`. It should have a method `get_status` that returns a string like ''Battery: 5000 mAh, 75% charged''.

The `Laptop` class should take `model`, `processor_model`, `clock_speed_ghz`, `battery_capacity_mah`, and `initial_charge` as initialization arguments. It should create instances of `Processor` and `Battery` internally. It must have a method `display_info` that prints the laptop''s model, processor specs, and battery status on separate lines.

Your output should exactly match the expected output for the given `Laptop` instance.', NULL, NULL, '[{"input": "", "expected_output": "Laptop Model: HP Spectre\nProcessor: Intel Core i7 @ 2.8 GHz\nBattery: 6000 mAh, 90% charged"}]', '2026-06-06 15:02:57.920346+00', 0.43874303, 'class Processor:
    def __init__(self, model, clock_speed_ghz):
        # TODO: Implement Processor constructor
        pass

    def get_specs(self):
        # TODO: Implement method to return processor specifications
        pass

class Battery:
    def __init__(self, capacity_mah, charge_percentage):
        # TODO: Implement Battery constructor
        pass

    def get_status(self):
        # TODO: Implement method to return battery status
        pass

class Laptop:
    def __init__(self, model, processor_model, clock_speed_ghz, battery_capacity_mah, initial_charge):
        self.model = model
        # TODO: Create Processor and Battery instances here using composition
        # self.processor = ...
        # self.battery = ...

    def display_info(self):
        # TODO: Implement method to display laptop information
        pass

# Create a Laptop instance and display its info
my_laptop = Laptop("HP Spectre", "Intel Core i7", 2.8, 6000, 90)
my_laptop.display_info()
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('dccafd4b-8119-4071-9833-d026e1c5569b', 88, 209, 'multiple_choice', 'foundational', 'Which relationship best describes composition?', '[{"text": "Is-a relationship", "label": "A"}, {"text": "Has-a relationship", "label": "B"}, {"text": "Behaves-like relationship", "label": "C"}, {"text": "Extends-from relationship", "label": "D"}]', 'Has-a relationship', NULL, '2026-06-06 15:02:57.920346+00', 0.39718258, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('96c431f1-23ce-4b55-9a05-95850aaad139', 88, 209, 'short_answer', 'applied', 'When might inheritance lead to a ''tightly coupled'' design, and why is this generally considered a weakness?', NULL, 'Inheritance leads to tightly coupled designs when changes in the base class (superclass) force modifications or unexpected behavior in its derived classes (subclasses). This is a weakness because it makes the system less flexible, harder to maintain, and more prone to bugs, as a change in one part of the hierarchy can have cascading effects on others.', NULL, '2026-06-06 15:02:57.920346+00', 0.40415993, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7a6a03a0-1ea4-4142-94ad-a66b16795748', 88, 209, 'explanation', 'advanced', 'You are designing a software system for a car manufacturer. They need to model various car models, each with different engine types (e.g., gasoline, electric, hybrid), tire types (e.g., summer, winter, all-season), and infotainment systems. Discuss why composition would generally be a more flexible and maintainable design choice than inheritance for handling the different engine, tire, and infotainment system options for a `Car` class.', NULL, 'A strong answer should highlight the following points:

1.  **Flexibility and Runtime Changes:** Composition allows different engine, tire, and infotainment objects to be swapped in and out of a `Car` object at runtime or during its construction. With inheritance, you would need to define a separate `Car` subclass for every combination of engine, tire, and infotainment, leading to an explosion of classes and a rigid hierarchy.

2.  **Avoidance of Multiple Inheritance Issues:** If you tried to use inheritance for all these features (e.g., `Car` inherits from `GasolineEngine`, `SummerTires`, `StandardInfotainment`), you would quickly run into the complexities of Python''s multiple inheritance or the ''diamond problem'' in languages that support it. Composition elegantly avoids this by having the `Car` ''has-a'' `Engine`, ''has-a'' `Tires`, and ''has-a'' `InfotainmentSystem`.

3.  **Loose Coupling:** Composition creates a loosely coupled system. Changes to how an `ElectricEngine` works (e.g., adding a new charging method) do not require changes to the `Car` class itself, as long as the `Car`''s interaction interface with the `Engine` remains consistent. In contrast, with inheritance, changes in a base class can propagate to subclasses.

4.  **Promotes Modularity and Reusability of Components:** Engine types, tire types, and infotainment systems can be developed, tested, and reused independently as distinct components. A `GasolineEngine` could potentially be used in a `Motorcycle` class as well, without `Motorcycle` needing to be part of a `Car` inheritance hierarchy.

5.  **Simpler Hierarchies:** The `Car` class itself can maintain a simple, clear inheritance hierarchy (e.g., `LuxuryCar` ''is-a'' `Car`), while its internal components (engine, tires, infotainment) are managed through composition. This keeps the `Car`''s primary ''is-a'' relationship clear and avoids creating overly deep or complex inheritance trees for orthogonal features.', NULL, '2026-06-06 15:02:57.920346+00', 0.796432, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('954c484d-aae1-484f-b9d7-bc9f971e8adb', 88, 209, 'coding', 'applied', 'You are developing a `PaymentProcessor` that can handle different payment methods. Implement the `PaymentProcessor` class using composition, where it ''has-a'' `payment_method` object. Create two concrete payment method classes: `CreditCardPayment` and `PayPalPayment`.

Your `PaymentProcessor` should have a method `process_payment(amount)` that delegates the actual payment processing to its `payment_method` object.

**Expected Output:**

Processing $100.00 with Credit Card.
Processing $50.00 with PayPal.', NULL, NULL, '[{"input": "", "expected_output": "Processing $100.00 with Credit Card.\nProcessing $50.00 with PayPal."}]', '2026-06-06 15:02:57.920346+00', 0.25672647, 'class CreditCardPayment:
    def pay(self, amount):
        return f"Processing ${amount:.2f} with Credit Card."

class PayPalPayment:
    def pay(self, amount):
        return f"Processing ${amount:.2f} with PayPal."

class PaymentProcessor:
    def __init__(self, payment_method):
        # TODO: Initialize the PaymentProcessor with a payment_method object
        pass

    def process_payment(self, amount):
        # TODO: Delegate the payment processing to the payment_method object
        pass

# Test cases
cc_processor = PaymentProcessor(CreditCardPayment())
print(cc_processor.process_payment(100))

pp_processor = PaymentProcessor(PayPalPayment())
print(pp_processor.process_payment(50))
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6ae7b5ad-de76-4e6e-8c77-e5b37c67f70f', 89, 210, 'multiple_choice', 'foundational', 'Why is it often beneficial to use multiple cooperating classes instead of a single large class to model a complex system?', '[{"text": "It makes the code always run faster.", "label": "A"}, {"text": "It reduces the total number of lines of code.", "label": "B"}, {"text": "It improves code organization, reusability, and makes responsibilities clearer.", "label": "C"}, {"text": "It prevents all runtime errors automatically.", "label": "D"}]', 'It improves code organization, reusability, and makes responsibilities clearer.', NULL, '2026-06-06 15:03:36.683155+00', 0.32667828, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('cb2bb299-7679-4f79-ab27-84528fb19834', 89, 210, 'coding', 'applied', 'You are building a simple library system. Design two classes: `Book` and `Library`. 

The `Book` class should have an `__init__` method that takes `title` and `author` as arguments and stores them. It should also have a `get_info` method that returns a string formatted as ''Title: [title], Author: [author]''.

The `Library` class should have an `__init__` method that initializes an empty list called `books`. It should have an `add_book` method that takes a `Book` object and adds it to its `books` list. It should also have a `list_books` method that prints the info of all books currently in the library, one book per line. If the library has no books, it should print ''The library is empty.''', NULL, NULL, '[{"input": "", "expected_output": "--- Library before adding books ---\nThe library is empty.\n\n--- Library after adding books ---\nTitle: The Hitchhiker''s Guide to the Galaxy, Author: Douglas Adams\nTitle: Pride and Prejudice, Author: Jane Austen\n"}]', '2026-06-06 15:03:36.683155+00', 0.45904157, 'class Book:
    # TODO: Implement __init__ and get_info methods
    pass

class Library:
    # TODO: Implement __init__, add_book, and list_books methods
    pass

# --- Test Cases --- 
library = Library()
print("--- Library before adding books ---")
library.list_books()

book1 = Book("The Hitchhiker''s Guide to the Galaxy", "Douglas Adams")
book2 = Book("Pride and Prejudice", "Jane Austen")

library.add_book(book1)
library.add_book(book2)

print("\n--- Library after adding books ---")
library.list_books()
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('64c0aa51-d2e1-4a87-9433-db85e1c3915c', 89, 211, 'multiple_choice', 'foundational', 'Which special method is primarily intended for providing a human-readable, user-friendly string representation of an object?', '[{"text": "`__str__`", "label": "A"}, {"text": "`__repr__`", "label": "B"}, {"text": "`__format__`", "label": "C"}, {"text": "`__display__`", "label": "D"}]', '`__str__`', NULL, '2026-06-06 15:03:36.683155+00', 0.51496327, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1c5dc910-cb60-4523-8cc8-027c7e935ab1', 89, 211, 'explanation', 'applied', 'Explain the difference in purpose between the `__str__` and `__repr__` methods in Python classes, and provide an example scenario where defining both separately would be beneficial.', NULL, 'The `__str__` method aims to provide a user-friendly, human-readable string representation of an object. It''s what gets called by `print()` or `str()`. Its purpose is to be clear and concise for someone consuming the output, not necessarily to provide all internal details. The `__repr__` method aims to provide an unambiguous, developer-focused string representation of an object. It''s what gets called by `repr()` or when an object is displayed in an interactive console. A common convention is for `__repr__` to return a string that, if passed to `eval()`, would recreate the object.

An example scenario where both are beneficial: Consider a `Point` class. `__str__` might return `"(10, 20)"` (easy for a user to understand the coordinates). `__repr__` might return `"Point(x=10, y=20)"` (explicitly shows the constructor call and attribute names, useful for debugging or serialization). If `__str__` just returned `Point(x=10, y=20)`, it would be less ''friendly'' for general display, and if `__repr__` returned `(10, 20)`, it wouldn''t be unambiguous about what ''10'' and ''20'' represent or how to recreate the object.', NULL, '2026-06-06 15:03:36.683155+00', 0.7788465, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c492dd66-97bb-46cb-a276-14f687477f53', 89, 211, 'coding', 'applied', 'You are given a `Color` class. Your task is to implement the `__str__` and `__repr__` methods for this class.

- The `__str__` method should return a string in the format ''Color: <name> (#<hex_code>)''.
- The `__repr__` method should return a string that could be used to recreate the object, in the format ''Color(name=''<name>'', hex_code=''#<hex_code>'')''.

After implementing these methods, create two `Color` objects and print them using both `print()` and `repr()` to demonstrate their output.', NULL, NULL, '[{"input": "", "expected_output": "Color: Red (#FF0000)\nColor(name=''Red'', hex_code=''#FF0000'')\nColor: Blue (#0000FF)\nDebugging: Color(name=''Blue'', hex_code=''#0000FF'')"}]', '2026-06-06 15:03:36.683155+00', 0.5485657, 'class Color:
    def __init__(self, name, hex_code):
        self.name = name
        self.hex_code = hex_code

    # TODO: Implement the __str__ method here

    # TODO: Implement the __repr__ method here


# Create Color objects
red = Color(''Red'', ''#FF0000'')
blue = Color(''Blue'', ''#0000FF'')

# Demonstrate __str__ and __repr__
print(red)
print(repr(red))
print(str(blue))
print(f"Debugging: {blue!r}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6d30ba78-d3b5-4608-838b-f575ae32ac1d', 89, 212, 'multiple_choice', 'foundational', 'What is the primary purpose of encapsulation in object-oriented programming?', '[{"text": "To make all class attributes globally accessible.", "label": "A"}, {"text": "To combine data and the methods that operate on that data into a single unit.", "label": "B"}, {"text": "To allow multiple inheritance easily.", "label": "C"}, {"text": "To define abstract interfaces for classes.", "label": "D"}]', 'To combine data and the methods that operate on that data into a single unit.', NULL, '2026-06-06 15:03:36.683155+00', 0.38046178, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2a3c0e0b-dc8e-498b-9c83-a60e30c7f0a2', 89, 212, 'short_answer', 'applied', 'In Python, what is the conventional way to indicate that an attribute `secret_value` should be treated as private, and what is the difference in behavior between using one underscore (`_secret_value`) versus two underscores (`__secret_value`)?', NULL, 'A single underscore (`_secret_value`) indicates a ''weak internal use indicator'' or a convention that the attribute should be treated as private by developers, but it can still be accessed directly. Two underscores (`__secret_value`) trigger name mangling, transforming the attribute name (e.g., `_ClassName__secret_value`), making it harder to access directly from outside the class and providing a stronger form of data hiding. However, it''s not truly private as it can still be accessed via the mangled name.', NULL, '2026-06-06 15:03:36.683155+00', 0.5748095, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9263024c-a810-4616-9139-15ce5c52db87', 89, 212, 'coding', 'applied', 'You are tasked with creating a `Product` class. This class should encapsulate the product''s `__price` attribute. Implement the `Product` class with the following requirements:
1. The `__price` attribute must be initialized with a positive value. If a non-positive value is provided, it should default to `1.0`.
2. Provide a public method `get_price()` that returns the current price.
3. Provide a public method `set_price(new_price)` that allows updating the price. The `new_price` must be positive. If a non-positive `new_price` is provided, the price should remain unchanged, and a message ''Invalid price: Price must be positive.'' should be printed.

After defining the class, create an instance, test setting a valid price, then an invalid price, and finally print the price.', NULL, NULL, '[{"input": "", "expected_output": "Initial price: 10.5\nPrice after valid update: 12.75\nInvalid price: Price must be positive.\nPrice after invalid update attempt: 12.75\n"}]', '2026-06-06 15:03:36.683155+00', 0.448378, 'class Product:
    def __init__(self, initial_price):
        # TODO: Initialize __price with initial_price, ensuring it''s positive. Default to 1.0 if not.
        pass

    def get_price(self):
        # TODO: Return the current __price.
        pass

    def set_price(self, new_price):
        # TODO: Update __price if new_price is positive. Otherwise, print an error and keep current price.
        pass

# Test cases
my_product = Product(10.50)
print(f"Initial price: {my_product.get_price()}")

my_product.set_price(12.75)
print(f"Price after valid update: {my_product.get_price()}")

my_product.set_price(-5.00)
print(f"Price after invalid update attempt: {my_product.get_price()}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('15de34eb-5599-4f56-a125-3f417bfc0127', 89, 213, 'short_answer', 'applied', 'If you have a `Student` class, what would be a suitable name for a class whose responsibility is to manage multiple `Student` instances?', NULL, 'Classroom / Roster / School / Students', NULL, '2026-06-06 15:03:36.683155+00', 0.39134055, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f072ccec-9f69-42c8-b6f4-3b6dd8701b9e', 89, 213, 'explanation', 'advanced', 'Explain the benefit of using a ''collection managing class'' (like a `Shopping_Cart` for `Product` objects) over simply using a global list of `Product` objects directly in your program. Focus on design principles.', NULL, 'Using a collection managing class like `Shopping_Cart` encapsulates the logic related to managing products (adding, removing, calculating total price, etc.) within a single, dedicated entity. This improves modularity, making the code easier to understand, maintain, and test. It also prevents scattering collection-related operations throughout the codebase, reducing potential for errors and improving code organization. In contrast, a global list would lead to scattered logic, making it harder to track modifications to the cart and increasing dependencies across different parts of the program.', NULL, '2026-06-06 15:03:36.683155+00', 0.61341923, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b4e704ab-8df9-4f9c-bac6-2a0db118c95e', 89, 213, 'coding', 'applied', 'You are given a `Task` class. Create a `TaskManager` class that manages `Task` objects. Implement methods in `TaskManager` to `add_task(task)`, `get_all_tasks()`, and `__len__` to return the number of tasks. The `get_all_tasks()` method should return a list of the titles of all tasks.', NULL, NULL, '[{"input": "", "expected_output": "Number of tasks: 2\nAll task titles: [''Buy groceries'', ''Walk the dog'']\nNumber of tasks after adding another: 3\nAll task titles after adding another: [''Buy groceries'', ''Walk the dog'', ''Read Python book'']\n"}]', '2026-06-06 15:03:36.683155+00', 0.3419027, 'class Task:
    def __init__(self, title, description):
        self.title = title
        self.description = description

class TaskManager:
    def __init__(self):
        # TODO: Initialize an empty collection to store tasks
        pass

    def add_task(self, task):
        # TODO: Add the given task object to the collection
        pass

    def get_all_tasks(self):
        # TODO: Return a list containing the titles of all tasks
        pass

    def __len__(self):
        # TODO: Return the number of tasks in the collection
        pass

# Test cases
task1 = Task("Buy groceries", "Milk, eggs, bread")
task2 = Task("Walk the dog", "Morning and evening")
task3 = Task("Read Python book", "Chapter 5")

manager = TaskManager()
manager.add_task(task1)
manager.add_task(task2)

print(f"Number of tasks: {len(manager)}")
print(f"All task titles: {manager.get_all_tasks()}")

manager.add_task(task3)
print(f"Number of tasks after adding another: {len(manager)}")
print(f"All task titles after adding another: {manager.get_all_tasks()}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7bce91b6-9f7a-4f34-89c3-b8290f841c35', 90, 214, 'multiple_choice', 'foundational', 'What is the primary characteristic of Pyodide''s in-memory filesystem?', '[{"text": "It stores files directly on the user''s hard drive.", "label": "A"}, {"text": "It is a permanent storage solution accessible after closing the browser tab.", "label": "B"}, {"text": "It exists entirely within the browser''s memory and is temporary.", "label": "C"}, {"text": "It requires a special `pyodide.filesystem` module for all file operations.", "label": "D"}]', 'It exists entirely within the browser''s memory and is temporary.', NULL, '2026-06-06 15:04:17.161503+00', 0.5925486, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('66b01670-a5f2-4606-932e-fde08001fdda', 90, 214, 'explanation', 'advanced', 'Explain why Pyodide utilizes an in-memory filesystem instead of directly accessing the user''s local disk. What are the main implications of this design choice for a developer using Pyodide?', NULL, 'Pyodide runs Python in a web browser, which is a sandboxed environment for security reasons. Web browsers typically prevent direct access to a user''s local disk to protect against malicious software and maintain user privacy. Therefore, Pyodide cannot directly read or write files to the operating system''s filesystem.

Instead, Pyodide provides an ''in-memory filesystem'' (VFS) that simulates a disk filesystem within the browser''s RAM. This allows standard Python file operations (like `open`, `read`, `write`) to function as expected without breaking the browser''s security model.

The main implications for a developer are:
1.  **Temporariness:** Any files created or modified in this VFS are lost when the browser tab is closed, refreshed, or the Pyodide interpreter is reset. There is no persistence across sessions.
2.  **Isolation:** Files created in one Pyodide instance (e.g., one tab) are not accessible by another Pyodide instance or by other applications on the user''s computer.
3.  **Performance:** In-memory operations are generally very fast, as they avoid disk I/O.
4.  **Security:** It maintains the browser''s security model, preventing unauthorized access to the user''s local files.', NULL, '2026-06-06 15:04:17.161503+00', 0.75349766, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('feb81267-2224-4833-94c9-f633d039993d', 90, 214, 'coding', 'applied', 'Create a Python script that uses Pyodide''s in-memory filesystem. First, create a directory named `data` within `/home/pyodide`. Then, create a file named `message.txt` inside this `data` directory and write the text `Hello from Pyodide!` into it. Finally, read the content of `message.txt` and print it to the console.', NULL, NULL, '[{"input": "", "expected_output": "Hello from Pyodide!"}]', '2026-06-06 15:04:17.161503+00', 0.6439281, 'import os

# TODO: Create the ''data'' directory in /home/pyodide

# TODO: Define the full path for message.txt

# TODO: Write content to message.txt

# TODO: Read and print the content of message.txt
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('edbbbd8b-9d16-40ce-8b88-23d5ee1a9f7c', 90, 215, 'multiple_choice', 'foundational', 'Which file mode should you use if you want to add content to an existing file without deleting its previous content?', '[{"text": "''r''", "label": "A"}, {"text": "''w''", "label": "B"}, {"text": "''a''", "label": "C"}, {"text": "''x''", "label": "D"}]', '''a''', NULL, '2026-06-06 15:04:17.161503+00', 0.3540017, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a2ab5ecb-65c9-4f4b-be0c-489bc8a1654a', 90, 215, 'explanation', 'applied', 'Explain why using the `with` statement for file operations is considered best practice in Python, even though you can also use `open()` and `close()` explicitly.', NULL, 'The `with` statement (as a context manager) ensures that the file is automatically closed when the block is exited, regardless of whether the operations within the block succeed or encounter an error. This prevents resource leaks, ensures data is properly flushed, and makes the code cleaner and safer than manually calling `file_object.close()`.', NULL, '2026-06-06 15:04:17.161503+00', 0.59781885, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77440e9e-00a5-46a8-8578-8fbb3200bee4', 90, 215, 'coding', 'applied', 'You need to process a list of names. First, write each name from the provided `names` list into a file named `names_list.txt`, with each name on a new line. Then, read the content of `names_list.txt` line by line and print each line, removing any leading/trailing whitespace (including newlines).', NULL, NULL, '[{"input": "", "expected_output": "Alice\nBob\nCharlie\nDavid\n"}]', '2026-06-06 15:04:17.161503+00', 0.45901042, 'names = [''Alice'', ''Bob'', ''Charlie'', ''David'']

# TODO: Write names to ''names_list.txt'', one per line


# TODO: Read names from ''names_list.txt'' and print them, stripped of whitespace
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ec3d7da4-e9a5-438c-9829-72fc34cf9981', 90, 216, 'multiple_choice', 'foundational', 'Which block of code in a `try...except...else...finally` construct is guaranteed to execute, regardless of whether an exception occurs or not?', '[{"text": "`try`", "label": "A"}, {"text": "`except`", "label": "B"}, {"text": "`else`", "label": "C"}, {"text": "`finally`", "label": "D"}]', '`finally`', NULL, '2026-06-06 15:04:17.161503+00', 0.5715828, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('fc913333-3fe2-4fba-bd74-5c328ec1aa46', 90, 216, 'short_answer', 'applied', 'Explain the primary purpose of the `else` block in a `try...except...else` statement.', NULL, 'The `else` block executes only if the code within the `try` block runs completely without raising any exceptions.', NULL, '2026-06-06 15:04:17.161503+00', 0.5932983, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('46997893-32b9-41c6-9b3f-08d1daeac497', 90, 216, 'coding', 'applied', 'Create a function `get_list_element(data_list, index)` that safely attempts to access an element from `data_list` at the specified `index`. 

- If the access is successful, print the element''s value (e.g., ''Element found: X'').
- If an `IndexError` occurs (index is out of bounds), print ''Error: Index out of range.''.
- If any other unexpected error occurs (you can use a general `except` or `Exception`), print ''An unexpected error occurred.''.
- Always print ''Attempted element access.'' at the very end.', NULL, NULL, '[{"input": "", "expected_output": "Element found: 20\nAttempted element access.\nError: Index out of range.\nAttempted element access.\nAn unexpected error occurred.\nAttempted element access."}]', '2026-06-06 15:04:17.161503+00', 0.30786312, 'def get_list_element(data_list, index):
    # Your code goes here
    pass

# Test cases
get_list_element([10, 20, 30], 1)
get_list_element([10, 20, 30], 5)
get_list_element([10, 20, 30], ''a'') # This should trigger a TypeError, caught by general except');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7f9d946a-4aac-4c39-b316-b8449dc48f4c', 90, 217, 'multiple_choice', 'foundational', 'Which of the following exception types is specifically raised when you try to access a list element using an index that is outside the list''s valid range?', '[{"text": "TypeError", "label": "A"}, {"text": "ValueError", "label": "B"}, {"text": "IndexError", "label": "C"}, {"text": "KeyError", "label": "D"}]', 'IndexError', NULL, '2026-06-06 15:04:17.161503+00', 0.42264563, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('885ab543-9ce0-4329-9e8a-9c75aee565fd', 90, 217, 'short_answer', 'applied', 'You are writing a program that reads a number from a configuration file and converts it to an integer. If the file is not found, you want to print ''Configuration file not found.''. If the content read from the file cannot be converted to an integer, you want to print ''Invalid number in configuration.''. What two specific exception types should you catch to handle these two scenarios precisely?', NULL, 'FileNotFoundError, ValueError', NULL, '2026-06-06 15:04:17.161503+00', 0.62491775, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b548ebd6-cc9a-432c-88a0-dfdb38e279cf', 90, 217, 'coding', 'applied', 'Implement the `process_data` function. This function takes two arguments: `data_string` (a string that should represent a number) and `divisor` (an integer). The function should attempt the following:
1. Convert `data_string` to an integer.
2. Divide the converted integer by `divisor`.

Your `process_data` function must include `try-except` blocks to handle the following specific exceptions:
- `ValueError`: If `data_string` cannot be converted to an integer. In this case, print ''Error: Invalid data string.''.
- `ZeroDivisionError`: If `divisor` is 0. In this case, print ''Error: Cannot divide by zero.''.
- `TypeError`: If `divisor` is not an integer (e.g., a string or float). In this case, print ''Error: Divisor must be an integer.''.

For any other unexpected exception, catch it using a general `Exception` and print ''An unexpected error occurred.''.

If the operation is successful, print the result of the division.

**Example Usage:**
python
process_data(''100'', 5)
process_data(''abc'', 10)
process_data(''50'', 0)
process_data(''20'', ''two'')
process_data(None, 2) # Example of another unexpected error', NULL, NULL, '[{"input": "", "expected_output": "20.0\nError: Invalid data string.\nError: Cannot divide by zero.\nError: Divisor must be an integer.\nAn unexpected error occurred.\n"}]', '2026-06-06 15:04:17.161503+00', 0.659762, 'def process_data(data_string, divisor):
    try:
        # TODO: Implement the conversion and division, and handle exceptions
        pass
    except ValueError:
        print(''Error: Invalid data string.'')
    except ZeroDivisionError:
        print(''Error: Cannot divide by zero.'')
    except TypeError:
        print(''Error: Divisor must be an integer.'')
    except Exception:
        print(''An unexpected error occurred.'')

# Test cases
process_data(''100'', 5)
process_data(''abc'', 10)
process_data(''50'', 0)
process_data(''20'', ''two'')
process_data(None, 2)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6e87aa41-d7e0-4796-a0ce-a4ed2da0773f', 90, 218, 'multiple_choice', 'foundational', 'Which Python `json` module function is used to convert a Python dictionary into a JSON formatted string?', '[{"text": "`json.loads()`", "label": "A"}, {"text": "`json.read()`", "label": "B"}, {"text": "`json.dumps()`", "label": "C"}, {"text": "`json.stringify()`", "label": "D"}]', '`json.dumps()`', NULL, '2026-06-06 15:04:17.161503+00', 0.63623166, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a22b7215-acf1-4df4-b86c-882d8981ca8a', 90, 218, 'short_answer', 'applied', 'You have a JSON string: `json_str = ''{"item": "apple", "price": 1.0}''`. What Python object will `json.loads(json_str)` return, and what will be the value associated with the key ''item'' in that object?', NULL, 'It will return a Python dictionary. The value associated with ''item'' will be ''apple''.', NULL, '2026-06-06 15:04:17.161503+00', 0.6096341, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('24add1ad-b90b-4c1d-a969-be8896935728', 90, 218, 'coding', 'applied', 'You are given a Python dictionary representing an inventory item. Your task is to:
1. Convert this dictionary into a JSON string.
2. Then, convert that JSON string back into a Python dictionary.
3. Finally, print the value of the ''quantity'' key from the *deserialized* dictionary.

Use the `json` module for both serialization and deserialization.', NULL, NULL, '[{"input": "", "expected_output": "15\n"}]', '2026-06-06 15:04:17.161503+00', 0.54447865, 'import json

item_data = {
    "product_id": "A123",
    "name": "Laptop",
    "price": 1200.50,
    "quantity": 15,
    "available": True
}

# Your code here:
# 1. Serialize item_data to a JSON string
json_string = # TODO: Call json.dumps()

# 2. Deserialize the JSON string back to a Python dictionary
deserialized_item = # TODO: Call json.loads()

# 3. Print the ''quantity'' from the deserialized dictionary
# print(...)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('77c7574c-83ec-4f4f-b080-c8d270d18431', 91, 219, 'multiple_choice', 'foundational', 'What happens when an `assert` statement''s condition evaluates to `False`?', '[{"text": "The program continues execution as if nothing happened.", "label": "A"}, {"text": "A `SyntaxError` is raised.", "label": "B"}, {"text": "An `AssertionError` is raised, stopping program execution.", "label": "C"}, {"text": "A warning message is printed to the console, and the program continues.", "label": "D"}]', 'An `AssertionError` is raised, stopping program execution.', NULL, '2026-06-06 15:05:05.858366+00', 0.64350003, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e0128b66-b3cd-4093-8f48-16bf7c6bd0f7', 91, 219, 'short_answer', 'applied', 'You have a function that processes a list of items. You want to ensure that the list is never empty before proceeding. Write a single line of Python code using `assert` that checks this condition, providing the error message ''List cannot be empty'' if it fails. Assume `my_list` is the list variable.', NULL, 'assert len(my_list) > 0, "List cannot be empty"', NULL, '2026-06-06 15:05:05.858366+00', 0.4733127, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('15626c0b-c73a-40b5-b97d-7920485fa5ca', 91, 220, 'multiple_choice', 'foundational', 'Which of the following is the correct way to define a test method within a `unittest.TestCase` subclass?', '[{"text": "def run_test_addition(self):", "label": "A"}, {"text": "def _test_subtraction(self):", "label": "B"}, {"text": "def test_division(self):", "label": "C"}, {"text": "def check_multiplication(self):", "label": "D"}]', 'def test_division(self):', NULL, '2026-06-06 15:05:05.858366+00', 0.6921827, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('205e5581-f7c8-4447-a028-aad87cb53eb2', 91, 220, 'short_answer', 'applied', 'You have a function `divide(numerator, denominator)` and you want to test if `divide(10, 2)` correctly returns `5`. Which `unittest.TestCase` assertion method would be most appropriate to use for this check?', NULL, 'assertEqual', NULL, '2026-06-06 15:05:05.858366+00', 0.4289213, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3bb263b7-269c-4c77-9b34-15a6dc70159e', 91, 220, 'coding', 'applied', 'You are given a simple function `is_even(number)` that returns `True` if the number is even, and `False` otherwise. Your task is to complete the `TestIsEven` class by adding a test method `test_odd_number` that checks if `is_even(7)` correctly returns `False` using `self.assertFalse()`.

Make sure your script can be run directly using `unittest.main()` to execute the tests.', NULL, NULL, '[{"input": "", "expected_output": "..\n----------------------------------------------------------------------\nRan 2 tests in 0.000s\n\nOK\n"}]', '2026-06-06 15:05:05.858366+00', 0.5045881, 'import unittest

def is_even(number):
    return number % 2 == 0

class TestIsEven(unittest.TestCase):
    def test_even_number(self):
        self.assertTrue(is_even(4))

    # TODO: Add a test method named test_odd_number
    # It should check if is_even(7) correctly returns False
    # using self.assertFalse()

if __name__ == ''__main__'':
    unittest.main()');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c80f9183-b0a8-4f2d-ae9a-4977abd37d98', 91, 221, 'multiple_choice', 'foundational', 'Which of the following scenarios is primarily designed to test an ''edge case'' for a function that calculates the average of a list of numbers?', '[{"text": "Passing a list of 10 positive numbers.", "label": "A"}, {"text": "Passing a list containing a single number.", "label": "B"}, {"text": "Passing a list that includes negative numbers.", "label": "C"}, {"text": "Passing an empty list, expecting an error.", "label": "D"}]', 'Passing a list containing a single number.', NULL, '2026-06-06 15:05:05.858366+00', 0.40538386, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ca744b2b-b3df-4b69-9bcc-2cdd36441861', 91, 221, 'short_answer', 'applied', 'You are testing a function `is_valid_email(email_string)` which checks if a given string is a valid email address. Provide an example input that would serve as an ''error condition'' test case for this function, and briefly explain why.', NULL, 'Example input: `is_valid_email(''invalid-email'')` or `is_valid_email(''user@.com'')` or `is_valid_email(''user@com'')`. Explanation: This input lacks a domain or a proper domain structure, which should be caught as an invalid email address, testing the function''s ability to handle incorrect formats.', NULL, '2026-06-06 15:05:05.858366+00', 0.36814445, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('eaed7df0-c5e2-43df-9acc-2934d8e9652f', 91, 221, 'coding', 'applied', 'You have a function `get_grade(score)` that determines a letter grade based on a numerical score (0-100). Implement a simple test function `test_get_grade()` using `assert` statements to cover one **typical input**, one **edge case**, and one **error condition** for the `get_grade` function.

Assume the following grading scale:
- 90-100: ''A''
- 80-89: ''B''
- 70-79: ''C''
- 60-69: ''D''
- 0-59: ''F''

For scores outside 0-100, `get_grade` should raise a `ValueError`.', NULL, NULL, '[{"input": "", "expected_output": "All tests passed!\n"}]', '2026-06-06 15:05:05.858366+00', 0.4846256, 'def get_grade(score):
    if not isinstance(score, (int, float)):
        raise TypeError("Score must be a number")
    if not (0 <= score <= 100):
        raise ValueError("Score must be between 0 and 100")
    
    if 90 <= score <= 100:
        return ''A''
    elif 80 <= score < 90:
        return ''B''
    elif 70 <= score < 80:
        return ''C''
    elif 60 <= score < 70:
        return ''D''
    else:
        return ''F''

def test_get_grade():
    # TODO: Add a typical input test case
    # assert get_grade(75) == ''C''

    # TODO: Add an edge case test case
    # assert get_grade(0) == ''F''

    # TODO: Add an error condition test case (expecting ValueError)
    # try:
    #     get_grade(105)
    #     assert False, "ValueError not raised for score > 100"
    # except ValueError:
    #     assert True

    print("All tests passed!")

test_get_grade()');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0eb806be-7a9d-412e-abe4-85d82d5c3dfd', 91, 221, 'explanation', 'advanced', 'Explain why it is crucial to include ''error condition'' test cases in addition to ''typical'' and ''edge case'' test cases when developing robust software. What kind of problems might go undetected if error conditions are not thoroughly tested?', NULL, 'Error condition test cases are crucial because they verify that the code behaves gracefully and predictably when presented with invalid or unexpected input, rather than crashing or producing incorrect results. Without them, problems such as unhandled exceptions (leading to program crashes), security vulnerabilities (e.g., buffer overflows if not in Python, or unexpected data exposure), data corruption, or misleading error messages (or lack thereof) can go undetected. Testing error conditions ensures the software is robust and resilient against misuse or accidental bad data, improving its reliability and user experience.', NULL, '2026-06-06 15:05:05.858366+00', 0.5199818, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b08222e4-6074-46dd-ace7-ad954930277a', 91, 222, 'multiple_choice', 'foundational', 'What is the correct order of the ''Red-Green-Refactor'' cycle in Test-Driven Development (TDD)?', '[{"text": "Write failing test, write code to pass test, improve code.", "label": "A"}, {"text": "Write code, write test, improve code.", "label": "B"}, {"text": "Improve code, write failing test, write code to pass test.", "label": "C"}, {"text": "Write passing test, write code, refactor.", "label": "D"}]', 'Write failing test, write code to pass test, improve code.', NULL, '2026-06-06 15:05:05.858366+00', 0.46183744, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2ba3748e-cc7a-4b66-8461-b2b88770868d', 91, 222, 'short_answer', 'applied', 'You are practicing TDD for a function `add(a, b)` that sums two numbers. You''ve just written your first test `test_add_positive_numbers` and run it. What is the expected outcome of running this test at this stage, and why?', NULL, 'The test is expected to fail. This is because the `add` function has not been written yet, so the test will likely raise a `NameError` or `AttributeError` when trying to call a non-existent function. This initial failure confirms that the test itself is working correctly and will catch an issue once the function is implemented.', NULL, '2026-06-06 15:05:05.858366+00', 0.46737114, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('e3386c10-c307-4b72-9b60-853e90578ad7', 91, 222, 'coding', 'applied', 'Following the TDD methodology, you are about to implement a function named `reverse_string(s)` that takes a string `s` and returns its reversed version. Your task is to complete the ''Red'' phase of TDD by writing a single `unittest` test method that asserts the expected behavior for a simple input like ''hello''.

**Instructions:**
1.  Define a class `TestReverseString` that inherits from `unittest.TestCase`.
2.  Inside this class, create a method `test_simple_reverse`.
3.  In `test_simple_reverse`, use `self.assertEqual()` to check if `reverse_string(''hello'')` would correctly return `''olleh''`.

Your code should only contain the test class and method, as the `reverse_string` function itself is not yet implemented (which is why the test should fail).

**Expected output:** When your (correctly written) test is run, it should produce an error (e.g., `NameError`) because the `reverse_string` function is not defined. Your output must *exactly* match the `expected_output` for the `NameError` from calling the undefined function.', NULL, NULL, '[{"input": "", "expected_output": "NameError: name ''reverse_string'' is not defined"}]', '2026-06-06 15:05:05.858366+00', 0.47581342, 'import unittest

# The function reverse_string is not defined yet, which is intentional for TDD''s ''Red'' phase.

class TestReverseString(unittest.TestCase):
    # TODO: Write the test_simple_reverse method here

# This part ensures unittest runs when the script is executed, but only if not imported.
# For the purpose of this exercise, you do not need to modify this block.
# We are simulating a direct run for the expected error output.
# if __name__ == ''__main__'':
#     unittest.main()

# To demonstrate the ''Red'' phase directly without unittest.main() output, 
# we''ll trigger the NameError explicitly for this problem''s grading.
# In a real TDD scenario, you''d use unittest.main() or a test runner.
# We''ll just call the test method directly to get the specific error.
# You should *not* remove the unittest import or class definition.

# --- DO NOT MODIFY THE LINES BELOW FOR THIS EXERCISE --- 
# This block ensures the NameError is caught and printed in a deterministic way for grading.
try:
    test_suite = TestReverseString()
    test_suite.test_simple_reverse()
except NameError as e:
    print(f"NameError: {e}")
except Exception as e:
    print(f"An unexpected error occurred: {type(e).__name__}: {e}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('bb1d48be-4b0c-41df-b807-9592dbb43145', 91, 223, 'multiple_choice', 'foundational', 'Consider the following `unittest` failure output:


======================================================================
FAIL: test_empty_string (__main__.TestStringProcessor.test_empty_string)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "my_module.py", line 15, in test_empty_string
    self.assertEqual(process_string(""), "")
AssertionError: ''none'' != ''''
- none


----------------------------------------------------------------------
Ran 1 test in 0.001s

FAILED (failures=1)


What was the `expected` output from the `process_string("")` call, according to this failure report?', '[{"text": "''none''", "label": "A"}, {"text": "'''' (an empty string)", "label": "B"}, {"text": "The test timed out", "label": "C"}, {"text": "An unexpected exception occurred", "label": "D"}]', ''''' (an empty string)', NULL, '2026-06-06 15:05:05.858366+00', 0.7661814, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('04c88c35-cea4-4f42-af83-aecaa59f17c3', 91, 223, 'short_answer', 'applied', 'A `unittest` failure report contains the line `TypeError: unsupported operand type(s) for +: ''int'' and ''str''`. What does this specific error message suggest about the bug in the code under test, rather than in the test itself?', NULL, 'It suggests that the function being tested is attempting to perform an addition operation between an integer and a string, which is an invalid operation in Python. This indicates a type mismatch bug within the implementation of the function being tested, not an assertion failure or a problem with how the test is set up.', NULL, '2026-06-06 15:05:05.858366+00', 0.5716751, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f9d3d4e4-f66c-4e7a-8194-382f3d9e25a8', 91, 223, 'coding', 'applied', 'The following code has an intentional bug. Your task is to identify and fix the bug so that the provided test passes. You do not need to modify the test code itself.

The `calculate_discount` function should apply a 10% discount if the `price` is 100 or more, and no discount otherwise. The test `test_discount_threshold` is currently failing.

Read the test failure output carefully to understand why it''s failing and fix `calculate_discount`.', NULL, NULL, '[{"input": "", "expected_output": "All tests passed!\n"}]', '2026-06-06 15:05:05.858366+00', 0.3990613, 'import unittest

def calculate_discount(price):
    # TODO: Fix this function to correctly apply discount
    if price > 100:
        return price * 0.9
    return price

class TestDiscountCalculator(unittest.TestCase):
    def test_discount_threshold(self):
        # This test checks behavior at the discount threshold
        self.assertEqual(calculate_discount(100), 90.0, "Should apply 10% discount at exactly 100")
        self.assertEqual(calculate_discount(99), 99.0, "Should not apply discount below 100")


if __name__ == ''__main__'':
    # Run tests and print only failures and errors for concise output
    suite = unittest.TestSuite()
    suite.addTest(unittest.makeSuite(TestDiscountCalculator))
    runner = unittest.TextTestRunner(verbosity=0, failfast=True)
    runner.run(suite)
    # The following print statement is for the coding question''s expected output.
    # It should only execute if the tests pass and no failfast occurs.
    print("All tests passed!")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('3937d0f0-c34c-4dc1-b4ec-7e3654cbd555', 92, 224, 'multiple_choice', 'foundational', 'Which of the following best describes how you ''load'' an in-lesson dataset that is already pre-loaded into a variable named `student_scores`?', '[{"text": "You use `pd.read_csv(''student_scores.csv'')`.", "label": "A"}, {"text": "You simply refer to the variable name `student_scores` directly.", "label": "B"}, {"text": "You run `import student_scores`.", "label": "C"}, {"text": "You call a special `load_data(''student_scores'')` function.", "label": "D"}]', 'You simply refer to the variable name `student_scores` directly.', NULL, '2026-06-06 15:05:47.241746+00', 0.4238979, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4a116cdf-be47-4e22-8ae7-47a4e1e54453', 92, 224, 'coding', 'applied', 'A dataset containing daily temperature readings is pre-loaded into a Pandas DataFrame variable named `daily_temperatures`. Your task is to print the first two rows of this DataFrame and then print its overall shape (number of rows and columns).', NULL, NULL, '[{"input": "", "expected_output": "         Date    City  Temp_C\n0  2023-07-01  London    20.5\n1  2023-07-02  London    22.1\n(5, 3)\n"}]', '2026-06-06 15:05:47.241746+00', 0.36863512, 'import pandas as pd

# Assume daily_temperatures is a pre-loaded DataFrame
daily_temperatures = pd.DataFrame({
    ''Date'': [''2023-07-01'', ''2023-07-02'', ''2023-07-03'', ''2023-07-04'', ''2023-07-05''],
    ''City'': [''London'', ''London'', ''Paris'', ''Paris'', ''London''],
    ''Temp_C'': [20.5, 22.1, 25.3, 24.8, 21.0]
})

# TODO: Print the first two rows of daily_temperatures

# TODO: Print the shape of daily_temperatures
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f3a1b703-fd05-42ec-8b26-38858e443cca', 92, 224, 'explanation', 'advanced', 'Why is it important to use methods like `.head()`, `.info()`, or `.shape` immediately after ''accessing'' a pre-loaded in-lesson dataset, even if you know its variable name?', NULL, 'It''s important for several reasons: 
1. **Confirmation:** It confirms that the dataset was successfully accessed and is indeed available as the expected Python object (e.g., a DataFrame).
2. **Initial Inspection:** `.head()` provides a quick visual check of the data''s content, allowing you to see the first few rows and get a sense of what the data looks like.
3. **Structure Understanding:** `.shape` immediately tells you the dimensions (number of rows and columns), which is fundamental for planning analysis. `.info()` provides crucial details about data types for each column, non-null counts, and memory usage, helping identify potential data quality issues or needs for type conversion before any computation.', NULL, '2026-06-06 15:05:47.241746+00', 0.4563893, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8463c8ef-7d1e-4a84-88cd-e2aed2726122', 92, 225, 'multiple_choice', 'foundational', 'Which of the following statistics is generally more affected by extreme outlier values?', '[{"text": "Median", "label": "A"}, {"text": "Mean", "label": "B"}, {"text": "Minimum", "label": "C"}, {"text": "Maximum", "label": "D"}]', 'Mean', NULL, '2026-06-06 15:05:47.241746+00', 0.43865663, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('11777c6b-b44c-453e-a864-c529e747109f', 92, 225, 'short_answer', 'applied', 'You have a Pandas Series named `prices` containing product prices. What single Pandas method can you call on `prices` to quickly display a table including the mean, median, min, and max values (among others)?', NULL, '.describe()', NULL, '2026-06-06 15:05:47.241746+00', 0.60862213, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c1df45e2-1f10-4149-ace5-b23977d61a65', 92, 225, 'coding', 'applied', 'You are given a list of `sales_figures` for a week. Your task is to calculate the mean, median, minimum, and maximum sales figures. Print each value on a new line, labeled clearly (e.g., ''Mean: [value]'').

Use the `statistics` module for mean and median, and built-in Python functions for min and max.', NULL, NULL, '[{"input": "", "expected_output": "Mean: 141.42857142857142\nMedian: 145\nMin: 110\nMax: 170"}]', '2026-06-06 15:05:47.241746+00', 0.57036334, 'import statistics

sales_figures = [120, 150, 135, 160, 145, 110, 170]

# TODO: Calculate and print the mean sales figure

# TODO: Calculate and print the median sales figure

# TODO: Calculate and print the minimum sales figure

# TODO: Calculate and print the maximum sales figure');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('72f2629e-2072-4557-be73-cbe8b7a283a9', 92, 226, 'multiple_choice', 'foundational', 'Which Matplotlib function is best suited for visualizing the relationship between two continuous numerical variables, where each data point is shown individually?', '[{"text": "`plt.plot()`", "label": "A"}, {"text": "`plt.bar()`", "label": "B"}, {"text": "`plt.scatter()`", "label": "C"}, {"text": "`plt.hist()`", "label": "D"}]', '`plt.scatter()`', NULL, '2026-06-06 15:05:47.241746+00', 0.68509704, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('aed35350-47e1-4f07-a743-347d9f50c490', 92, 226, 'short_answer', 'applied', 'You have a list of product categories and their corresponding sales figures. Which `matplotlib.pyplot` function would you use to compare the sales of these different categories?', NULL, 'plt.bar()', NULL, '2026-06-06 15:05:47.241746+00', 0.7013187, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('68513124-31ae-4623-a4f9-09e2dcdff31c', 92, 226, 'explanation', 'advanced', 'Describe a scenario where a line plot would be misleading for your data, and explain why a bar plot or scatter plot would be a more appropriate choice instead. Provide a concrete example for each.', NULL, 'A line plot implies continuity or a trend between points, which can be misleading if the x-axis represents distinct, unordered categories rather than a continuous progression. For example:

**Misleading Line Plot Scenario:** If you have ''Sales by Region'' (e.g., North, South, East, West) and use a line plot, connecting ''North'' to ''South'' then ''South'' to ''East'' implies a relationship or ordering that doesn''t exist. The visual ''slope'' between regions suggests a trend where there is none, as the order of regions on the x-axis is arbitrary.

**Appropriate Choice: Bar Plot:** For ''Sales by Region'', a bar plot (`plt.bar()`) is much more appropriate. Each region would have its own distinct bar, and the height of the bar would represent its sales. This clearly shows the sales magnitude for each discrete category without implying continuity or an artificial order between them. The visual comparison of bar heights directly answers which region sold more.

**Appropriate Choice: Scatter Plot:** A line plot would also be misleading if you want to show the relationship between two continuous variables where the order of observations isn''t critical or there are many individual data points, and you''re looking for clusters or correlations rather than a sequential trend. For example, plotting ''Height vs. Weight'' for individual students with a line plot would imply an ordered sequence among students, which is incorrect. A scatter plot (`plt.scatter()`) would correctly display each student as an individual point, allowing for visual identification of any correlation or pattern between height and weight across the population.', NULL, '2026-06-06 15:05:47.241746+00', 0.6890306, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('91cc692f-0f7d-49e4-b777-4b29f359ae10', 92, 227, 'multiple_choice', 'foundational', 'Which Matplotlib function is used to add a label to the x-axis of a plot?', '[{"text": "plt.title()", "label": "A"}, {"text": "plt.ylabel()", "label": "B"}, {"text": "plt.xlabel()", "label": "C"}, {"text": "plt.axis_x_label()", "label": "D"}]', 'plt.xlabel()', NULL, '2026-06-06 15:05:47.241746+00', 0.67120993, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0693bd5b-7318-4958-aa9d-018050e24978', 92, 227, 'short_answer', 'applied', 'You''ve created a line plot showing ''Temperature'' over ''Time''. What two `matplotlib.pyplot` functions would you use to set the x-axis label to ''Time (hours)'' and the y-axis label to ''Temperature (°C)''?', NULL, 'plt.xlabel(''Time (hours)'') and plt.ylabel(''Temperature (°C)'')', NULL, '2026-06-06 15:05:47.241746+00', 0.65171325, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('58f86777-4aa2-4f40-a667-c98d921d7451', 92, 227, 'explanation', 'advanced', 'Explain why adding labels and titles to plots is considered best practice in data visualization, beyond just making the plot ''look nicer''.', NULL, 'Adding labels and titles is best practice because it ensures clarity and unambiguous communication of the data. Without them, a viewer might misinterpret what the axes represent, what units are being used, or what the overall purpose/message of the plot is. This can lead to incorrect conclusions or difficulty in understanding the insights the data is meant to convey. Good labels and titles make a plot self-explanatory and accessible to a wider audience, even those unfamiliar with the dataset.', NULL, '2026-06-06 15:05:47.241746+00', 0.64045787, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('7c2f1ca4-3a15-4add-8095-af38b5fbbf1d', 92, 228, 'multiple_choice', 'foundational', 'When interpreting a line plot showing sales over time, what is the primary pattern you should look for to understand sales performance?', '[{"text": "The number of colors used in the plot", "label": "A"}, {"text": "The overall trend (e.g., increasing, decreasing, stable)", "label": "B"}, {"text": "The font size of the axis labels", "label": "C"}, {"text": "Whether the line is perfectly straight", "label": "D"}]', 'The overall trend (e.g., increasing, decreasing, stable)', NULL, '2026-06-06 15:05:47.241746+00', 0.43570068, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8097aa12-8dc7-4e6c-b5d5-ba3f7dc6cb58', 92, 228, 'short_answer', 'applied', 'You are presented with a scatter plot showing ''Daily Temperature'' on the x-axis and ''Number of Ice Cream Sales'' on the y-axis. You observe that as the daily temperature increases, the number of ice cream sales generally also increases. What kind of relationship does this visualization suggest between temperature and ice cream sales?', NULL, 'A positive correlation (or direct relationship).', NULL, '2026-06-06 15:05:47.241746+00', 0.62105125, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('f7092952-d771-4e9b-919f-1c901852e3db', 92, 228, 'explanation', 'advanced', 'Explain why it is important to critically examine axis labels, units, and legends before drawing conclusions from any visualization, even if the patterns seem obvious at first glance.', NULL, 'Strong answers will highlight that axis labels define what data is being measured and in what context (e.g., ''Sales in USD'' vs. ''Sales in units''). Units clarify the scale and magnitude of the data (e.g., ''thousands'' vs. ''millions''). Legends differentiate multiple data series or categories within a single plot. Without understanding these elements, one might misinterpret the scale, compare unrelated data, or draw conclusions about the wrong variables, leading to incorrect insights and decisions. For example, a ''dip'' in a line chart might be negligible if the y-axis scale is very large, but significant if the scale is small.', NULL, '2026-06-06 15:05:47.241746+00', 0.57965404, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d164e278-c788-49b5-afb3-3edeed01f139', 92, 228, 'coding', 'applied', 'You are provided with a dictionary representing monthly sales data. Your task is to identify and print the month with the highest sales and the month with the lowest sales. Assume `monthly_sales` is already defined.', NULL, NULL, '[{"input": "", "expected_output": "Highest sales month: July with 25000 units\nLowest sales month: January with 12000 units"}]', '2026-06-06 15:05:47.241746+00', 0.091351435, 'monthly_sales = {
    ''January'': 12000,
    ''February'': 15000,
    ''March'': 13000,
    ''April'': 18000,
    ''May'': 22000,
    ''June'': 21000,
    ''July'': 25000,
    ''August'': 23000,
    ''September'': 19000,
    ''October'': 16000,
    ''November'': 20000,
    ''December'': 24000
}

# TODO: Find the month with the highest sales
# TODO: Find the month with the lowest sales

# Print your findings
# print(f"Highest sales month: {highest_month} with {highest_sales} units")
# print(f"Lowest sales month: {lowest_month} with {lowest_sales} units")');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('6f8cf3e4-4628-4b0d-b4f7-48cc2c0f56c5', 93, 229, 'multiple_choice', 'foundational', 'Which of the following best defines ''game state'' in a text-based logic game?', '[{"text": "The background story and lore of the game world.", "label": "A"}, {"text": "The visual design and aesthetics of the game''s interface.", "label": "B"}, {"text": "All the dynamic data that describes the current situation of the game.", "label": "C"}, {"text": "The fixed rules and mechanics that govern how the game is played.", "label": "D"}]', 'All the dynamic data that describes the current situation of the game.', NULL, '2026-06-06 15:06:59.098614+00', 0.42154664, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c5549163-77fa-4783-ba68-6421052e9f10', 93, 229, 'short_answer', 'applied', 'In a text-based adventure, a player moves from ''forest'' to ''cave'' and picks up a ''silver sword''. Describe two distinct elements of the game state that would need to be updated.', NULL, '1. Player''s current location (from ''forest'' to ''cave''). 2. Player''s inventory (add ''silver sword''). (Also acceptable: the ''cave''s items list would need to remove ''silver sword''.)', NULL, '2026-06-06 15:06:59.098614+00', 0.5605766, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('22cb4ce1-9bd2-4824-b809-3ca7e6125199', 93, 229, 'coding', 'applied', 'You are starting to build a text-based game. The player begins in the ''Town Square'' and has an empty inventory. There are two rooms: ''Town Square'' which contains a ''map'', and ''Old Library'' which contains a ''dusty book''.

Your task is to complete the `game_state` dictionary below according to these specifications. Then, simulate the player moving from ''Town Square'' to ''Old Library'' and picking up the ''dusty book''. Finally, print the player''s new location and updated inventory.

Expected Output:
Player is now in: Old Library
Player''s inventory: [''dusty book'']', NULL, NULL, '[{"input": "", "expected_output": "Player is now in: Old Library\nPlayer''s inventory: [''dusty book'']"}]', '2026-06-06 15:06:59.098614+00', 0.67485064, 'game_state = {
    "player_location": "Town Square",
    "inventory": [],
    "rooms": {
        "Town Square": {"description": "A bustling square.", "items": ["map"]},
        "Old Library": {"description": "A quiet, dusty library.", "items": ["dusty book"]}
    }
}

# TODO: Update the player''s location to ''Old Library''


# TODO: Simulate picking up the ''dusty book'' from the ''Old Library'' and adding it to the player''s inventory
#       Remember to also remove the item from the room it was picked from!



print(f"Player is now in: {game_state[''player_location'']}")
print(f"Player''s inventory: {game_state[''inventory'']}")
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8b04d014-28cc-4309-962b-6c6c10f98a9b', 93, 230, 'multiple_choice', 'foundational', 'What is the primary purpose of a game loop in a text-based logic game?', '[{"text": "To only handle player input.", "label": "A"}, {"text": "To continuously update the game state and process turns.", "label": "B"}, {"text": "To display graphics on the screen.", "label": "C"}, {"text": "To store all game data in memory.", "label": "D"}]', 'To continuously update the game state and process turns.', NULL, '2026-06-06 15:06:59.098614+00', 0.57648766, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('deb0f3c9-f721-431f-ae2e-71b501fd4665', 93, 230, 'short_answer', 'applied', 'In a game loop, why is the order of operations (e.g., processing input, updating state, checking conditions) generally important?', NULL, 'The order is important because actions taken in one step often depend on the results or state established in a previous step. For example, processing player input first allows the game state to be updated based on that input, and then checking win/loss conditions makes sense after the state has changed from the player''s action.', NULL, '2026-06-06 15:06:59.098614+00', 0.46367812, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('61d1a0a0-0d55-479b-81eb-308d953de11e', 93, 230, 'coding', 'applied', 'Implement the `process_turn` function according to the following rules:
- If the `action` is ''collect_item'', print ''You collected a mysterious item.''
- If the `action` is ''use_item'', print ''You used the mysterious item.''
- For any other action (like ''wait'' or ''look around''), print ''You decide to '' followed by the `action`.

The provided game loop will call your function with a sequence of actions.', NULL, NULL, '[{"input": "", "expected_output": "--- Turn 1 ---\nYou collected a mysterious item.\n--- Turn 2 ---\nYou decide to wait\n--- Turn 3 ---\nYou used the mysterious item.\n--- Turn 4 ---\nYou decide to look around\n\nGame simulation ended.\n"}]', '2026-06-06 15:06:59.098614+00', 0.6140517, 'def process_turn(current_turn_number, action):
    print(f"--- Turn {current_turn_number} ---")
    # TODO: Implement the turn logic here based on the ''action'' variable
    if action == ''collect_item'':
        # Your code here
        pass
    elif action == ''use_item'':
        # Your code here
        pass
    else:
        # Your code here
        pass

# --- Game Loop (DO NOT MODIFY BELOW THIS LINE) ---
def run_game_simulation(actions):
    turn_number = 1
    for action in actions:
        process_turn(turn_number, action)
        turn_number += 1
    print("\nGame simulation ended.")

# Test cases for the game loop
# These actions will be processed by your process_turn function
run_game_simulation([''collect_item'', ''wait'', ''use_item'', ''look around''])
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8fa8aa7f-eddc-485e-9ed4-8f010c2b63a3', 93, 231, 'multiple_choice', 'foundational', 'Which of the following is an example of a ''losing condition'' in a text-based game?', '[{"text": "The player collects all five magical artifacts.", "label": "A"}, {"text": "The player successfully navigates to the final boss room.", "label": "B"}, {"text": "The player''s ''health'' variable drops to 0 or less.", "label": "C"}, {"text": "The player discovers a secret passage.", "label": "D"}]', 'The player''s ''health'' variable drops to 0 or less.', NULL, '2026-06-06 15:06:59.098614+00', 0.47078273, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('74c190ff-ef3c-4c9c-8fe5-e5fdd5ddc523', 93, 231, 'explanation', 'applied', 'Explain why it''s important to check win/loss conditions regularly (e.g., after every turn) in a game, rather than just at a single point or sporadically.', NULL, 'Checking win/loss conditions regularly ensures that the game ends immediately once the criteria are met, providing prompt feedback to the player. If checks are infrequent, the player might continue playing beyond the point of winning or losing, leading to confusion, frustration, or a sense that their actions don''t have immediate consequences. This is crucial for maintaining game integrity and player engagement, as the game state can change rapidly with each player action or turn.', NULL, '2026-06-06 15:06:59.098614+00', 0.53357226, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b358c214-e324-480d-a1a1-db1bfc32c01f', 93, 231, 'coding', 'applied', 'You are building a text-based game where the player needs to collect 3 ''treasures'' to win. However, they only have 5 ''moves'' to do so. If they run out of moves before collecting all treasures, they lose. Implement the `check_game_over` function to determine the game''s outcome.

Use the provided `game_state` dictionary which contains `treasures_collected` and `moves_left`.', NULL, NULL, '[{"input": "", "expected_output": "Test 1 (Win): win\nTest 2 (Lose): lose\nTest 3 (Continue): continue\nTest 4 (Continue): continue\nTest 5 (Lose): lose"}]', '2026-06-06 15:06:59.098614+00', 0.59870964, 'def check_game_over(game_state):
    """
    Checks if the game has ended in a win, loss, or is still ongoing.
    Args:
        game_state (dict): A dictionary containing ''treasures_collected'' (int) and ''moves_left'' (int).
    Returns:
        str: ''win'' if all treasures are collected, ''lose'' if moves run out before collecting all treasures, ''continue'' otherwise.
    """
    # TODO: Implement the win/loss conditions here
    if game_state[''treasures_collected''] == 3:
        return ''win''
    elif game_state[''moves_left''] <= 0 and game_state[''treasures_collected''] < 3:
        return ''lose''
    else:
        return ''continue''

# --- Test Cases --- (Do not modify below this line)

# Test Case 1: Player wins
state1 = {''treasures_collected'': 3, ''moves_left'': 2}
print(f"Test 1 (Win): {check_game_over(state1)}")

# Test Case 2: Player loses
state2 = {''treasures_collected'': 1, ''moves_left'': 0}
print(f"Test 2 (Lose): {check_game_over(state2)}")

# Test Case 3: Game continues
state3 = {''treasures_collected'': 2, ''moves_left'': 3}
print(f"Test 3 (Continue): {check_game_over(state3)}")

# Test Case 4: Game continues (more moves than needed, but not enough treasures yet)
state4 = {''treasures_collected'': 2, ''moves_left'': 10}
print(f"Test 4 (Continue): {check_game_over(state4)}")

# Test Case 5: Player loses (negative moves_left implies ran out)
state5 = {''treasures_collected'': 2, ''moves_left'': -1}
print(f"Test 5 (Lose): {check_game_over(state5)}")');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('ef50a45b-9dbc-4839-a67e-9bfe8f84fab3', 93, 232, 'multiple_choice', 'foundational', 'Which of the following is the primary benefit of using Object-Oriented Programming (OOP) in game design?', '[{"text": "It makes the game run faster by optimizing memory usage.", "label": "A"}, {"text": "It generates random events automatically, making games more unpredictable.", "label": "B"}, {"text": "It organizes code into reusable, modular components (classes and objects), improving maintainability and readability.", "label": "C"}, {"text": "It automatically creates graphical user interfaces (GUIs) for text-based games.", "label": "D"}]', 'It organizes code into reusable, modular components (classes and objects), improving maintainability and readability.', NULL, '2026-06-06 15:06:59.098614+00', 0.43899024, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('c76117dc-0712-4aab-9b14-44bda8a746ec', 93, 232, 'short_answer', 'applied', 'In an object-oriented text-based game, what kind of information would typically be stored as attributes within a `Player` class?', NULL, 'Attributes within a `Player` class would typically include things like `name`, `health`, `inventory` (a list of items), `current_location` (or `current_room`), `score`, or `strength`.', NULL, '2026-06-06 15:06:59.098614+00', 0.62356335, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a8e3bbac-8744-40ca-8365-384ded8a07d9', 93, 232, 'coding', 'applied', 'You are designing a text-based logic game. Create a Python class named `Enemy` with an `__init__` method that takes `name` and `health` as parameters and assigns them to instance attributes. Add a method named `take_damage` that takes a `damage_amount` and subtracts it from the `health` attribute. If health drops to 0 or below, print a message indicating the enemy has been defeated. Finally, create an instance of `Enemy`, make it take some damage, and print its remaining health.', NULL, NULL, '[{"input": "", "expected_output": "Goblin took 15 damage.\nGoblin''s health: 35\nGoblin took 40 damage.\nGoblin has been defeated!\nGoblin''s health: -5\n"}]', '2026-06-06 15:06:59.098614+00', 0.46114275, 'class Enemy:
    def __init__(self, name, health):
        # TODO: Initialize name and health attributes
        pass

    def take_damage(self, damage_amount):
        # TODO: Subtract damage from health
        # TODO: If health <= 0, print ''name has been defeated!''
        pass

# Create an enemy instance
# Make the enemy take damage
# Print the enemy''s current health
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('d26a83ab-c583-4052-a6e3-01e7c61738b1', 93, 233, 'multiple_choice', 'foundational', 'Which Python module is primarily used for generating random numbers and making random selections?', '[{"text": "math", "label": "A"}, {"text": "sys", "label": "B"}, {"text": "random", "label": "C"}, {"text": "collections", "label": "D"}]', 'random', NULL, '2026-06-06 15:06:59.098614+00', 0.7095916, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('1e4c4a77-09fd-4acc-842a-eff4754bc23f', 93, 233, 'explanation', 'advanced', 'Explain the purpose of `random.seed()` in the context of game development and testing. Why would a developer choose to use it, and what are its implications for the ''randomness'' perceived by the player versus the developer?', NULL, 'A strong answer should cover these points:
- `random.seed(value)` initializes the pseudo-random number generator with a specific starting point (the ''seed'').
- Purpose for developers: It makes sequences of ''random'' numbers reproducible and predictable. This is crucial for testing game logic, debugging, and ensuring that bugs related to random events can be reliably re-created and fixed.
- Implications for the player: If `random.seed()` is used in the final game (e.g., using a fixed seed or one derived from a game save), it can lead to a less ''random'' or varied experience on subsequent playthroughs if the seed isn''t changed. For a true ''random'' experience for the player, the seed is usually derived from unpredictable sources like the current time (which `random` does by default if no seed is explicitly provided). However, for a developer, reproducibility trumps pure randomness during the development and testing phases.', NULL, '2026-06-06 15:06:59.098614+00', 0.70527303, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('951939af-8a45-4b13-adba-dd8d89820330', 94, 234, 'multiple_choice', 'foundational', 'What is the primary characteristic of a Monte Carlo simulation?', '[{"text": "It provides exact analytical solutions to complex mathematical problems.", "label": "A"}, {"text": "It relies on generating a large number of random samples or trials.", "label": "B"}, {"text": "It is exclusively used for optimizing algorithms.", "label": "C"}, {"text": "It can only be applied to problems with perfectly known probability distributions.", "label": "D"}]', 'It relies on generating a large number of random samples or trials.', NULL, '2026-06-06 15:07:36.119482+00', 0.6289466, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('10f62bc4-0999-4f1d-b4be-0336b7fb2cc4', 94, 234, 'short_answer', 'applied', 'If you wanted to estimate the area of an irregularly shaped pond on a map without using complex geometric formulas, how would a Monte Carlo approach conceptually work?', NULL, 'You would randomly ''drop'' a large number of points onto a known rectangular area that completely encloses the pond. Then, you would count how many of these random points fall within the pond''s boundaries. The ratio of points inside the pond to the total points dropped, multiplied by the area of the enclosing rectangle, would give an approximation of the pond''s area.', NULL, '2026-06-06 15:07:36.119482+00', 0.5469441, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('623ca1fa-e713-4e97-a2a7-04168b8b7ad1', 94, 234, 'explanation', 'advanced', 'Explain why Monte Carlo simulations are particularly useful when direct calculation or analytical solutions are ''too complex'' or ''impossible''. What property of the simulation allows it to tackle such problems?', NULL, 'Monte Carlo simulations are useful for complex problems because they don''t require an explicit, exact mathematical formula to calculate the desired value. Instead, they rely on repeatedly sampling from a random process that models the problem. Even if the underlying distributions or interactions are complex, by observing a large number of random outcomes, statistical properties emerge that approximate the true value. This ''brute force'' probabilistic sampling allows estimation where direct deterministic calculation is intractable.', NULL, '2026-06-06 15:07:36.119482+00', 0.76268035, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('4a127d82-bcb7-4434-8952-700e5628d8f0', 94, 235, 'multiple_choice', 'foundational', 'Which Python `random` module function is used to generate a floating-point number in the range [0.0, 1.0)?', '[{"text": "`random.randint(0, 1)`", "label": "A"}, {"text": "`random.uniform(0.0, 1.0)`", "label": "B"}, {"text": "`random.random()`", "label": "C"}, {"text": "`random.choice([0.0, 1.0])`", "label": "D"}]', '`random.random()`', NULL, '2026-06-06 15:07:36.119482+00', 0.670841, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('0bb72e82-b3ba-4ecf-9948-aea296d1d51d', 94, 235, 'short_answer', 'applied', 'You need to simulate choosing a random day of the week from ''Monday'', ''Tuesday'', ..., ''Sunday''. Which `random` module function would be most appropriate for this task, and how would you call it?', NULL, '`random.choice(days_list)` or `random.choice([''Monday'', ''Tuesday'', ''Wednesday'', ''Thursday'', ''Friday'', ''Saturday'', ''Sunday''])`', NULL, '2026-06-06 15:07:36.119482+00', 0.43081394, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('9d0742ed-cbdb-4b1a-a298-4f0fea77e3e3', 94, 235, 'explanation', 'advanced', 'Explain the purpose of `random.seed()` in the context of generating random numbers for simulations. Why is it useful, especially during development and testing?', NULL, 'The `random.seed(value)` function initializes the pseudo-random number generator. Its purpose is to make sequences of ''random'' numbers reproducible. This is extremely useful in simulations for several reasons:  1. **Debugging:** If a simulation produces unexpected results, setting a seed allows developers to re-run the simulation with the exact same sequence of ''random'' numbers, making it easier to isolate and fix bugs. 2. **Testing:** It ensures that automated tests relying on random numbers produce consistent and predictable outcomes across different test runs. 3. **Reproducibility of Results:** For research or demonstration purposes, it guarantees that others can replicate the exact same simulation results by using the same seed value.', NULL, '2026-06-06 15:07:36.119482+00', 0.54796815, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('10915aa3-0020-4617-9e1b-8407a7ecd1ba', 94, 236, 'multiple_choice', 'foundational', 'Which of the following data structures is most commonly used in Python to accumulate results from multiple simulation trials?', '[{"text": "A dictionary", "label": "A"}, {"text": "A list", "label": "B"}, {"text": "A set", "label": "C"}, {"text": "A tuple", "label": "D"}]', 'A list', NULL, '2026-06-06 15:07:36.119482+00', 0.6644846, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('5b2fdd60-4848-4cdd-9fd3-d804cafc231e', 94, 236, 'short_answer', 'applied', 'You are simulating a process over 100 trials. For each trial, you calculate a `score`. You want to find the maximum `score` across all trials. Before starting the simulation loop, what is the best way to initialize a variable that will store the maximum score seen so far?', NULL, 'Initialize it to a very small number, e.g., `max_score = -float(''inf'')` or `max_score = 0` (if scores are non-negative).', NULL, '2026-06-06 15:07:36.119482+00', 0.54062074, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('8dbdd989-3c29-405a-9689-8e6e06f1b6d8', 94, 236, 'explanation', 'advanced', 'Describe the key steps involved in collecting and analyzing aggregated data from a simulation with multiple trials. What role does the choice of data structure play in this process?', NULL, 'The key steps involve:
1.  **Initialization of an accumulator:** Before the simulation loop, create an empty data structure (e.g., a list) to hold the results of each trial.
2.  **Running trials:** Execute the core simulation logic for a specified number of trials.
3.  **Accumulating results:** Within each iteration of the trial loop, extract the relevant outcome from that trial and append it to the accumulator data structure.
4.  **Post-simulation analysis:** After all trials are complete, use the aggregated data in the accumulator to perform statistical analysis (e.g., calculating averages, medians, standard deviations, counts, frequencies, finding min/max values) to draw conclusions.

The choice of data structure is crucial: A **list** is excellent for storing sequences of individual trial outcomes because it''s mutable and allows easy appending. If you need to store more complex results per trial (e.g., multiple values associated with a trial ID), a list of **dictionaries** or **tuples** might be more appropriate. For unique outcomes, a **set** could be used, though this is less common for general result accumulation where duplicates are often meaningful.', NULL, '2026-06-06 15:07:36.119482+00', 0.729274, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('a674cb6e-01bf-46ed-a7bf-60de2e035eae', 94, 236, 'coding', 'applied', 'You are simulating a ''number generator'' that always produces `fixed_value = 5`. Your task is to run 4 trials. In each trial, you ''generate'' this number twice and then subtract the second ''generated'' number from the first. Store the result of each subtraction in a list called `trial_differences`. Print `trial_differences` at the end.', NULL, NULL, '[{"input": "", "expected_output": "[0, 0, 0, 0]\n"}]', '2026-06-06 15:07:36.119482+00', 0.6098519, 'fixed_value = 5

trial_differences = [] # Initialize an empty list to accumulate results

num_trials = 4

for _ in range(num_trials):
    # TODO: ''Generate'' the number twice (using fixed_value)
    # TODO: Calculate the difference between the two ''generations''
    # TODO: Append the difference to trial_differences

print(trial_differences)
');
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('949f7da1-1007-48fd-8a21-a3cb55b06dc5', 94, 237, 'multiple_choice', 'foundational', 'Which Matplotlib function is typically used to display a plot after it has been created?', '[{"text": "plt.display()", "label": "A"}, {"text": "plt.render()", "label": "B"}, {"text": "plt.show()", "label": "C"}, {"text": "plt.draw()", "label": "D"}]', 'plt.show()', NULL, '2026-06-06 15:07:36.119482+00', 0.6351999, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('2f00aa60-7332-4d08-823b-f3355d0d8776', 94, 237, 'short_answer', 'applied', 'You have a list `data = [10, 12, 15, 11, 13]` representing simulation results over 5 steps. Write the Python code using `matplotlib.pyplot` to create a simple line plot of this data, setting the y-axis label to ''Simulation Value''. You do not need to save or show the plot, just set up the plot itself.', NULL, 'import matplotlib.pyplot as plt
plt.plot(data)
plt.ylabel(''Simulation Value'')', NULL, '2026-06-06 15:07:36.119482+00', 0.7234692, NULL);
INSERT INTO public.questions (id, module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases, created_at, groundedness, starter_code) VALUES ('b22735de-35b9-4967-a290-e52180a1c771', 94, 237, 'explanation', 'advanced', 'Explain how Matplotlib can be used in the context of generative art. Provide a specific example of what kind of generative art could be created and what Matplotlib functions would be essential.', NULL, 'Matplotlib can be a core tool for generative art by translating mathematical functions, algorithmic processes, or simulation outputs into visual forms. Instead of plotting empirical data, generative artists feed computed data points (e.g., from fractals, cellular automata, or parametric equations) into Matplotlib''s plotting functions to create abstract or structured visuals.

For example, one could generate a ''fractal tree'' or ''L-system'' art. An algorithm would recursively generate points for branches based on rules (e.g., angle, length reduction). Matplotlib''s `plt.plot()` function would be essential to connect these points with lines, drawing the branches. Colors, line thickness, and transparency could be manipulated to add aesthetic variation. `plt.scatter()` could also be used to mark points or nodes. The lack of traditional axes and ticks can be achieved by `plt.axis(''off'')`, focusing purely on the generated pattern. Saving the figure with `plt.savefig()` allows for permanent capture of the generated artwork.', NULL, '2026-06-06 15:07:36.119482+00', 0.64988595, NULL);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.books_id_seq', 3, true);


--
-- Name: concepts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.concepts_id_seq', 237, true);


--
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.modules_id_seq', 94, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subjects_id_seq', 9, true);


--
-- PostgreSQL database dump complete
--

\unrestrict hi9uduG4x8ewj9oqRmJt4FRdFmv0ZDa70oljR8Dpn5yLa2SDlzn3Tha0flx48SA

