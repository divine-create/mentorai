-- MentorAI v1.0 — Seed: 8 Python modules
INSERT INTO modules (slug, title, description, order_index, estimated_hours_min, estimated_hours_max) VALUES
  ('python-fundamentals',   'Python Fundamentals',        'Variables, data types, operators, I/O',                              1, 4, 6),
  ('control-flow',          'Control Flow',               'if/else, loops (for, while), break/continue',                        2, 3, 5),
  ('functions',             'Functions',                  'Defining functions, scope, return values, recursion basics',          3, 4, 6),
  ('data-structures',       'Data Structures',            'Lists, tuples, dicts, sets, list comprehension',                     4, 5, 7),
  ('oop',                   'Object-Oriented Programming','Classes, instances, inheritance, encapsulation',                     5, 6, 8),
  ('file-handling',         'File Handling & Exceptions', 'Reading/writing files, try/except, custom exceptions',               6, 3, 4),
  ('working-with-apis',     'Working with APIs',          'HTTP requests, JSON, REST APIs, authentication basics',              7, 4, 6),
  ('capstone',              'Capstone Project',           'Learner-chosen project applying all modules; AI-guided',             8, 8, 12)
ON CONFLICT (slug) DO NOTHING;

-- Unlock module 1 for all existing users (handled in application logic for new users)
