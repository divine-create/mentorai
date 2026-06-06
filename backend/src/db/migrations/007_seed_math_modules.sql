-- AI Academy — Seed: 8 Mathematics modules, concepts & questions (subject_id = 2)
--
-- Concept IDs continue from Python (1-27), starting at 28.
-- Question types: multiple_choice, short_answer, explanation (no 'coding').
-- Module and concept IDs resolved dynamically via subqueries.

BEGIN;

-- ─── Modules ─────────────────────────────────────────────────────────────────

INSERT INTO modules (slug, title, description, subject_id, order_index,
                     estimated_hours_min, estimated_hours_max)
VALUES
  ('numbers-operations',  'Numbers & Operations',     'Arithmetic, fractions, decimals, percentages, ratios',          2, 1, 3, 5),
  ('algebra-basics',       'Algebra Fundamentals',     'Variables, expressions, equations, inequalities',               2, 2, 4, 6),
  ('linear-equations',     'Linear Equations & Graphs', 'Slope, intercepts, graphing lines, systems of equations',     2, 3, 4, 6),
  ('polynomials',          'Polynomials & Factoring',  'Exponents, polynomial operations, factoring techniques',        2, 4, 4, 6),
  ('quadratics',           'Quadratic Equations',      'Quadratic formula, completing the square, discriminant',        2, 5, 4, 6),
  ('functions-relations',  'Functions & Relations',    'Notation, domain/range, transformations, inverse functions',    2, 6, 5, 7),
  ('geometry-trig',        'Geometry & Trigonometry',  'Angles, triangles, Pythagorean theorem, trig ratios',          2, 7, 5, 7),
  ('stats-probability',    'Statistics & Probability',  'Mean/median/mode, probability, data display, events',         2, 8, 4, 6)
ON CONFLICT (slug) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 1 — Numbers & Operations  (slug: numbers-operations)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 28, m.id, 'Arithmetic Fundamentals',
       'Basic operations with integers, order of operations, number properties', 1
FROM modules m WHERE m.slug = 'numbers-operations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 29, m.id, 'Fractions & Decimals',
       'Converting between fractions and decimals, operations with fractions', 2
FROM modules m WHERE m.slug = 'numbers-operations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 30, m.id, 'Ratios & Proportions',
       'Comparing quantities, proportional relationships, unit rates', 3
FROM modules m WHERE m.slug = 'numbers-operations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 31, m.id, 'Percentages',
       'Percentage calculations, increases and decreases, real-world applications', 4
FROM modules m WHERE m.slug = 'numbers-operations'
ON CONFLICT (id) DO NOTHING;

-- Questions — Numbers & Operations (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 28, 'multiple_choice', 'foundational',
  'What is the value of 7 × 8 + 3?',
  '[{"label":"A","text":"56"},{"label":"B","text":"59"},{"label":"C","text":"61"},{"label":"D","text":"83"}]'::jsonb,
  '59', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 29, 'multiple_choice', 'foundational',
  'Which of the following is equal to 3/4?',
  '[{"label":"A","text":"0.25"},{"label":"B","text":"0.50"},{"label":"C","text":"0.75"},{"label":"D","text":"1.33"}]'::jsonb,
  '0.75', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 30, 'multiple_choice', 'applied',
  'If 3/5 of a number is 24, what is the number?',
  '[{"label":"A","text":"30"},{"label":"B","text":"36"},{"label":"C","text":"40"},{"label":"D","text":"45"}]'::jsonb,
  '40', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 31, 'multiple_choice', 'applied',
  'What is 15% of 200?',
  '[{"label":"A","text":"15"},{"label":"B","text":"25"},{"label":"C","text":"30"},{"label":"D","text":"35"}]'::jsonb,
  '30', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 29, 'short_answer', 'foundational',
  'What is the sum of 1/3 and 1/6? Express as a simplified fraction.',
  NULL, '1/2', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 29, 'short_answer', 'applied',
  'Express 0.375 as a fraction in simplest form.',
  NULL, '3/8', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 29, 'short_answer', 'advanced',
  'What is 2/3 divided by 4/5? Express as a simplified fraction.',
  NULL, '5/6', NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 28, 'explanation', 'foundational',
  'Explain what the order of operations (PEMDAS/BODMAS) means and why it is important. Give an example.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 29, 'explanation', 'applied',
  'Why do we need a common denominator to add or subtract fractions? Explain with an example.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'numbers-operations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 31, 'multiple_choice', 'advanced',
  'A store offers 20% off a $75 item, then an additional 10% off the reduced price. What is the final price?',
  '[{"label":"A","text":"$50.00"},{"label":"B","text":"$52.50"},{"label":"C","text":"$54.00"},{"label":"D","text":"$55.00"}]'::jsonb,
  '$54.00', NULL
FROM modules m WHERE m.slug = 'numbers-operations';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 2 — Algebra Fundamentals  (slug: algebra-basics)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 32, m.id, 'Variables & Expressions',
       'Understanding variables, writing algebraic expressions, translating words to math', 1
FROM modules m WHERE m.slug = 'algebra-basics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 33, m.id, 'Simplifying Expressions',
       'Combining like terms, distributive property, simplifying', 2
FROM modules m WHERE m.slug = 'algebra-basics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 34, m.id, 'Solving Equations',
       'One-step and multi-step equations, isolating the variable', 3
FROM modules m WHERE m.slug = 'algebra-basics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 35, m.id, 'Inequalities',
       'Solving and graphing inequalities, compound inequalities', 4
FROM modules m WHERE m.slug = 'algebra-basics'
ON CONFLICT (id) DO NOTHING;

-- Questions — Algebra Fundamentals (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 34, 'multiple_choice', 'foundational',
  'What is the value of x if 2x + 5 = 13?',
  '[{"label":"A","text":"3"},{"label":"B","text":"4"},{"label":"C","text":"6"},{"label":"D","text":"9"}]'::jsonb,
  '4', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 32, 'multiple_choice', 'foundational',
  'Which expression means "5 more than twice a number n"?',
  '[{"label":"A","text":"5n + 2"},{"label":"B","text":"2n + 5"},{"label":"C","text":"2(n + 5)"},{"label":"D","text":"n + 10"}]'::jsonb,
  '2n + 5', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 33, 'multiple_choice', 'applied',
  'Simplify: 3(x + 2) - x',
  '[{"label":"A","text":"2x + 6"},{"label":"B","text":"3x + 6"},{"label":"C","text":"2x + 2"},{"label":"D","text":"4x + 6"}]'::jsonb,
  '2x + 6', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 34, 'multiple_choice', 'applied',
  'Solve for x: 3x - 7 = 2x + 5',
  '[{"label":"A","text":"x = 2"},{"label":"B","text":"x = 10"},{"label":"C","text":"x = 12"},{"label":"D","text":"x = -12"}]'::jsonb,
  'x = 12', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 33, 'short_answer', 'foundational',
  'Simplify: 4a + 3a - 2a',
  NULL, '5a', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 34, 'short_answer', 'applied',
  'Solve for x: 5(x - 3) = 2x + 9. Show your steps and give the final value of x.',
  NULL, 'x = 8', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 34, 'short_answer', 'advanced',
  'Solve for x: 2(x + 3) = 3(x - 1) + 5. What is x?',
  NULL, 'x = 4', NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 32, 'explanation', 'foundational',
  'What is a variable in algebra? What does it represent, and how is it different from a constant?',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 32, 'explanation', 'applied',
  'Explain the difference between an algebraic expression and an equation. Provide one example of each.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'algebra-basics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 35, 'multiple_choice', 'advanced',
  'For what value of k does 2x + k = 3x - 5 have the solution x = 7?',
  '[{"label":"A","text":"k = -2"},{"label":"B","text":"k = 2"},{"label":"C","text":"k = 12"},{"label":"D","text":"k = -12"}]'::jsonb,
  'k = 2', NULL
FROM modules m WHERE m.slug = 'algebra-basics';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 3 — Linear Equations & Graphs  (slug: linear-equations)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 36, m.id, 'Slope & Rate of Change',
       'Calculating slope from points and equations, steepness and direction', 1
FROM modules m WHERE m.slug = 'linear-equations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 37, m.id, 'Y-Intercept & X-Intercept',
       'Identifying intercepts from equations and graphs, meaning of intercepts', 2
FROM modules m WHERE m.slug = 'linear-equations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 38, m.id, 'Graphing Lines',
       'Plotting lines from slope-intercept, standard, and point-slope form', 3
FROM modules m WHERE m.slug = 'linear-equations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 39, m.id, 'Systems of Equations',
       'Solving systems by substitution, elimination, and graphical method', 4
FROM modules m WHERE m.slug = 'linear-equations'
ON CONFLICT (id) DO NOTHING;

-- Questions — Linear Equations & Graphs (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 36, 'multiple_choice', 'foundational',
  'What is the slope of the line y = 3x + 2?',
  '[{"label":"A","text":"2"},{"label":"B","text":"3"},{"label":"C","text":"5"},{"label":"D","text":"1/3"}]'::jsonb,
  '3', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 37, 'multiple_choice', 'foundational',
  'What is the y-intercept of the line y = -2x + 7?',
  '[{"label":"A","text":"-2"},{"label":"B","text":"7"},{"label":"C","text":"5"},{"label":"D","text":"-7"}]'::jsonb,
  '7', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 36, 'multiple_choice', 'applied',
  'What is the slope of the line passing through the points (1, 3) and (4, 9)?',
  '[{"label":"A","text":"1"},{"label":"B","text":"2"},{"label":"C","text":"3"},{"label":"D","text":"6"}]'::jsonb,
  '2', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 39, 'multiple_choice', 'applied',
  'Solve the system: x + y = 10 and x - y = 4. What is the value of x?',
  '[{"label":"A","text":"3"},{"label":"B","text":"5"},{"label":"C","text":"7"},{"label":"D","text":"8"}]'::jsonb,
  '7', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 36, 'short_answer', 'foundational',
  'Write the equation of a line in slope-intercept form with slope 5 and y-intercept -3.',
  NULL, 'y = 5x - 3', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 37, 'short_answer', 'applied',
  'What is the x-intercept of the line y = 2x - 8?',
  NULL, '4', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 39, 'short_answer', 'advanced',
  'Solve the system: 3x + 2y = 16 and x - y = 2. Give your answer as (x, y).',
  NULL, '(4, 2)', NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 36, 'explanation', 'foundational',
  'What does the slope of a line represent geometrically? Explain positive, negative, zero, and undefined slope.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 39, 'explanation', 'applied',
  'Explain what it means when two lines are parallel vs perpendicular in terms of their slopes.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'linear-equations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 36, 'multiple_choice', 'advanced',
  'Which equation represents a line perpendicular to y = (2/3)x + 1?',
  '[{"label":"A","text":"y = (2/3)x + 4"},{"label":"B","text":"y = (3/2)x + 4"},{"label":"C","text":"y = (-3/2)x + 4"},{"label":"D","text":"y = (-2/3)x + 4"}]'::jsonb,
  'y = (-3/2)x + 4', NULL
FROM modules m WHERE m.slug = 'linear-equations';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 4 — Polynomials & Factoring  (slug: polynomials)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 40, m.id, 'Exponents & Powers',
       'Laws of exponents, zero and negative exponents, scientific notation', 1
FROM modules m WHERE m.slug = 'polynomials'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 41, m.id, 'Polynomial Operations',
       'Adding, subtracting, multiplying polynomials, degree and leading coefficient', 2
FROM modules m WHERE m.slug = 'polynomials'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 42, m.id, 'Factoring Basics',
       'Greatest common factor, factoring by grouping, factoring trinomials', 3
FROM modules m WHERE m.slug = 'polynomials'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 43, m.id, 'Special Factoring Patterns',
       'Difference of squares, perfect square trinomials, sum/difference of cubes', 4
FROM modules m WHERE m.slug = 'polynomials'
ON CONFLICT (id) DO NOTHING;

-- Questions — Polynomials & Factoring (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 40, 'multiple_choice', 'foundational',
  'What is x³ × x⁴?',
  '[{"label":"A","text":"x⁷"},{"label":"B","text":"x¹²"},{"label":"C","text":"x⁴"},{"label":"D","text":"2x⁷"}]'::jsonb,
  'x⁷', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 41, 'multiple_choice', 'foundational',
  'What is the degree of the polynomial 3x⁴ - 2x² + 7?',
  '[{"label":"A","text":"2"},{"label":"B","text":"3"},{"label":"C","text":"4"},{"label":"D","text":"7"}]'::jsonb,
  '4', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 42, 'multiple_choice', 'applied',
  'Which is the factored form of x² - 9?',
  '[{"label":"A","text":"(x - 3)²"},{"label":"B","text":"(x + 3)(x - 3)"},{"label":"C","text":"(x + 9)(x - 1)"},{"label":"D","text":"(x - 9)(x + 1)"}]'::jsonb,
  '(x + 3)(x - 3)', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 41, 'multiple_choice', 'applied',
  'Expand: (x + 3)(x - 2)',
  '[{"label":"A","text":"x² + x - 6"},{"label":"B","text":"x² + 5x - 6"},{"label":"C","text":"x² - x - 6"},{"label":"D","text":"x² + x + 6"}]'::jsonb,
  'x² + x - 6', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 40, 'short_answer', 'foundational',
  'Simplify: (2x³)²',
  NULL, '4x⁶', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 42, 'short_answer', 'applied',
  'Factor completely: 2x² + 7x + 3',
  NULL, '(2x + 1)(x + 3)', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 43, 'short_answer', 'advanced',
  'Factor completely: x⁴ - 16',
  NULL, '(x² + 4)(x + 2)(x - 2)', NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 40, 'explanation', 'foundational',
  'State the zero exponent rule and explain why a⁰ = 1 for any nonzero value of a.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 42, 'explanation', 'applied',
  'Explain the steps you would use to factor the trinomial 3x² + 10x + 8. Show your reasoning.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'polynomials';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 43, 'multiple_choice', 'advanced',
  'Which is the factored form of 4x² - 12x + 9?',
  '[{"label":"A","text":"(2x - 3)(2x + 3)"},{"label":"B","text":"(2x - 3)²"},{"label":"C","text":"(2x + 3)²"},{"label":"D","text":"(4x - 3)²"}]'::jsonb,
  '(2x - 3)²', NULL
FROM modules m WHERE m.slug = 'polynomials';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 5 — Quadratic Equations  (slug: quadratics)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 44, m.id, 'Standard Form & Vertex Form',
       'ax² + bx + c form, a(x-h)² + k form, converting between forms', 1
FROM modules m WHERE m.slug = 'quadratics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 45, m.id, 'Factoring Quadratics',
       'Factoring trinomials, finding roots by factoring, zero product property', 2
FROM modules m WHERE m.slug = 'quadratics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 46, m.id, 'Quadratic Formula',
       'Deriving and applying x = (-b ± sqrt(b²-4ac)) / 2a, solving any quadratic', 3
FROM modules m WHERE m.slug = 'quadratics'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 47, m.id, 'The Discriminant',
       'Using b² - 4ac to determine number and type of solutions', 4
FROM modules m WHERE m.slug = 'quadratics'
ON CONFLICT (id) DO NOTHING;

-- Questions — Quadratic Equations (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 45, 'multiple_choice', 'foundational',
  'What are the solutions of x² - 5x + 6 = 0?',
  '[{"label":"A","text":"x = 1 and x = 6"},{"label":"B","text":"x = 2 and x = 3"},{"label":"C","text":"x = -2 and x = -3"},{"label":"D","text":"x = -1 and x = 6"}]'::jsonb,
  'x = 2 and x = 3', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 44, 'multiple_choice', 'foundational',
  'In the equation y = ax² + bx + c, what shape does the graph form?',
  '[{"label":"A","text":"Line"},{"label":"B","text":"Circle"},{"label":"C","text":"Parabola"},{"label":"D","text":"Hyperbola"}]'::jsonb,
  'Parabola', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 44, 'multiple_choice', 'applied',
  'What is the vertex of the parabola y = (x - 3)² + 2?',
  '[{"label":"A","text":"(-3, 2)"},{"label":"B","text":"(3, -2)"},{"label":"C","text":"(3, 2)"},{"label":"D","text":"(-3, -2)"}]'::jsonb,
  '(3, 2)', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 45, 'multiple_choice', 'applied',
  'Solve by factoring: x² - 4x - 5 = 0',
  '[{"label":"A","text":"x = 1 and x = -5"},{"label":"B","text":"x = -1 and x = 5"},{"label":"C","text":"x = 1 and x = 5"},{"label":"D","text":"x = -1 and x = -5"}]'::jsonb,
  'x = -1 and x = 5', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 47, 'short_answer', 'foundational',
  'What is the value of the discriminant for x² + 4x + 4 = 0?',
  NULL, '0', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 46, 'short_answer', 'applied',
  'Use the quadratic formula to solve 2x² + 3x - 2 = 0. Give both solutions.',
  NULL, 'x = 1/2 and x = -2', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 47, 'short_answer', 'advanced',
  'For what values of k does x² + kx + 9 = 0 have exactly one real solution?',
  NULL, 'k = 6 or k = -6', NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 44, 'explanation', 'foundational',
  'Explain what the vertex of a parabola represents. How does the value of a determine if the vertex is a maximum or minimum?',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 47, 'explanation', 'applied',
  'Under what conditions does a quadratic have two distinct real solutions, one real solution, or no real solutions? Relate to the discriminant.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'quadratics';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 47, 'multiple_choice', 'advanced',
  'The discriminant of a quadratic equation is -4. How many real solutions does it have?',
  '[{"label":"A","text":"0"},{"label":"B","text":"1"},{"label":"C","text":"2"},{"label":"D","text":"Cannot be determined"}]'::jsonb,
  '0', NULL
FROM modules m WHERE m.slug = 'quadratics';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 6 — Functions & Relations  (slug: functions-relations)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 48, m.id, 'Function Notation & Evaluation',
       'f(x) notation, evaluating functions, input/output tables', 1
FROM modules m WHERE m.slug = 'functions-relations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 49, m.id, 'Domain & Range',
       'Identifying valid inputs and outputs, interval notation', 2
FROM modules m WHERE m.slug = 'functions-relations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 50, m.id, 'Function Transformations',
       'Shifts, reflections, stretches, and compressions of function graphs', 3
FROM modules m WHERE m.slug = 'functions-relations'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 51, m.id, 'Inverse Functions',
       'Finding and verifying inverses, horizontal line test, notation', 4
FROM modules m WHERE m.slug = 'functions-relations'
ON CONFLICT (id) DO NOTHING;

-- Questions — Functions & Relations (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 48, 'multiple_choice', 'foundational',
  'If f(x) = 2x + 3, what is f(5)?',
  '[{"label":"A","text":"10"},{"label":"B","text":"13"},{"label":"C","text":"15"},{"label":"D","text":"7"}]'::jsonb,
  '13', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 48, 'multiple_choice', 'foundational',
  'Which of the following relations is NOT a function?',
  '[{"label":"A","text":"{(1,2), (2,3), (3,4)}"},{"label":"B","text":"{(1,2), (1,3), (2,4)}"},{"label":"C","text":"{(0,1), (2,1), (4,1)}"},{"label":"D","text":"{(5,6), (7,8), (9,10)}"}]'::jsonb,
  '{(1,2), (1,3), (2,4)}', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 49, 'multiple_choice', 'applied',
  'What is the domain of f(x) = sqrt(x - 2)?',
  '[{"label":"A","text":"All real numbers"},{"label":"B","text":"x > 2"},{"label":"C","text":"x >= 2"},{"label":"D","text":"x >= 0"}]'::jsonb,
  'x >= 2', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 50, 'multiple_choice', 'applied',
  'If g(x) = x², what is g(x + 1)?',
  '[{"label":"A","text":"x² + 1"},{"label":"B","text":"x² + 2x + 1"},{"label":"C","text":"(x + 1)² + 1"},{"label":"D","text":"x² + x + 1"}]'::jsonb,
  'x² + 2x + 1', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 48, 'short_answer', 'foundational',
  'If f(x) = 3x - 1, find f(0) + f(2).',
  NULL, '5', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 49, 'short_answer', 'applied',
  'What is the range of f(x) = x² + 1? Express using inequality notation.',
  NULL, 'y >= 1', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 51, 'short_answer', 'advanced',
  'If f(x) = 2x + 1, find the inverse function f-inverse(x).',
  NULL, 'f-inverse(x) = (x - 1)/2', NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 48, 'explanation', 'foundational',
  'Explain the difference between a relation and a function. Use the vertical line test in your explanation.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 50, 'explanation', 'applied',
  'Describe how the graph of y = f(x) changes when replaced by y = f(x - 2) + 3. What do the -2 and +3 each do?',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'functions-relations';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 48, 'multiple_choice', 'advanced',
  'If f(x) = 2x - 1, what is f(f(3))?',
  '[{"label":"A","text":"5"},{"label":"B","text":"7"},{"label":"C","text":"9"},{"label":"D","text":"11"}]'::jsonb,
  '9', NULL
FROM modules m WHERE m.slug = 'functions-relations';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 7 — Geometry & Trigonometry  (slug: geometry-trig)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 52, m.id, 'Angles & Lines',
       'Types of angles, parallel and perpendicular lines, angle relationships', 1
FROM modules m WHERE m.slug = 'geometry-trig'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 53, m.id, 'Triangles & Pythagorean Theorem',
       'Triangle classification, Pythagorean theorem, special right triangles', 2
FROM modules m WHERE m.slug = 'geometry-trig'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 54, m.id, 'Trigonometric Ratios',
       'Sine, cosine, tangent definitions and applications in right triangles', 3
FROM modules m WHERE m.slug = 'geometry-trig'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 55, m.id, 'Area & Perimeter',
       'Area and perimeter formulas for triangles, rectangles, circles, composites', 4
FROM modules m WHERE m.slug = 'geometry-trig'
ON CONFLICT (id) DO NOTHING;

-- Questions — Geometry & Trigonometry (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 53, 'multiple_choice', 'foundational',
  'What is the sum of the interior angles of a triangle?',
  '[{"label":"A","text":"90 degrees"},{"label":"B","text":"180 degrees"},{"label":"C","text":"270 degrees"},{"label":"D","text":"360 degrees"}]'::jsonb,
  '180 degrees', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 53, 'multiple_choice', 'foundational',
  'In a right triangle with legs of length 3 and 4, what is the hypotenuse?',
  '[{"label":"A","text":"6"},{"label":"B","text":"7"},{"label":"C","text":"5"},{"label":"D","text":"25"}]'::jsonb,
  '5', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 54, 'multiple_choice', 'applied',
  'What is the value of sin(30 degrees)?',
  '[{"label":"A","text":"sqrt(3)/2"},{"label":"B","text":"1/2"},{"label":"C","text":"sqrt(2)/2"},{"label":"D","text":"1"}]'::jsonb,
  '1/2', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 52, 'multiple_choice', 'applied',
  'A triangle has angles measuring 50 degrees and 70 degrees. What is the third angle?',
  '[{"label":"A","text":"50 degrees"},{"label":"B","text":"55 degrees"},{"label":"C","text":"60 degrees"},{"label":"D","text":"65 degrees"}]'::jsonb,
  '60 degrees', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 54, 'short_answer', 'foundational',
  'What is the value of cos(60 degrees)?',
  NULL, '1/2', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 53, 'short_answer', 'applied',
  'A right triangle has a hypotenuse of length 13 and one leg of length 5. What is the other leg?',
  NULL, '12', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 54, 'short_answer', 'advanced',
  'In a right triangle, if tan(theta) = 3/4 and the hypotenuse is 10, what is sin(theta)?',
  NULL, '3/5', NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 53, 'explanation', 'foundational',
  'State the Pythagorean theorem and provide a real-world example where you would use it.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 54, 'explanation', 'applied',
  'What is the relationship between the sine and cosine of complementary angles? Explain why sin(theta) = cos(90 - theta).',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'geometry-trig';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 55, 'multiple_choice', 'advanced',
  'What is the area of a triangle with vertices at (0,0), (6,0), and (3,4)?',
  '[{"label":"A","text":"6"},{"label":"B","text":"10"},{"label":"C","text":"12"},{"label":"D","text":"24"}]'::jsonb,
  '12', NULL
FROM modules m WHERE m.slug = 'geometry-trig';


-- ═══════════════════════════════════════════════════════════════════════════════
-- MODULE 8 — Statistics & Probability  (slug: stats-probability)
-- ═══════════════════════════════════════════════════════════════════════════════

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 56, m.id, 'Measures of Central Tendency',
       'Mean, median, mode, weighted averages, choosing the best measure', 1
FROM modules m WHERE m.slug = 'stats-probability'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 57, m.id, 'Data Display & Interpretation',
       'Bar charts, histograms, box plots, scatter plots, reading data', 2
FROM modules m WHERE m.slug = 'stats-probability'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 58, m.id, 'Basic Probability',
       'Probability as fraction, decimal, percentage; experimental vs theoretical', 3
FROM modules m WHERE m.slug = 'stats-probability'
ON CONFLICT (id) DO NOTHING;

INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT 59, m.id, 'Combined Events',
       'Independent and dependent events, addition rule, multiplication rule', 4
FROM modules m WHERE m.slug = 'stats-probability'
ON CONFLICT (id) DO NOTHING;

-- Questions — Statistics & Probability (10)

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'multiple_choice', 'foundational',
  'What is the mean of the data set {4, 8, 6, 10, 12}?',
  '[{"label":"A","text":"6"},{"label":"B","text":"8"},{"label":"C","text":"10"},{"label":"D","text":"40"}]'::jsonb,
  '8', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'multiple_choice', 'foundational',
  'In the ordered data set {3, 5, 5, 7, 9}, what is the median?',
  '[{"label":"A","text":"3"},{"label":"B","text":"5"},{"label":"C","text":"7"},{"label":"D","text":"9"}]'::jsonb,
  '5', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'multiple_choice', 'applied',
  'What is the mode of {2, 3, 3, 4, 5, 5, 5}?',
  '[{"label":"A","text":"2"},{"label":"B","text":"3"},{"label":"C","text":"4"},{"label":"D","text":"5"}]'::jsonb,
  '5', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 58, 'multiple_choice', 'applied',
  'A fair six-sided die is rolled. What is the probability of rolling an even number?',
  '[{"label":"A","text":"1/3"},{"label":"B","text":"1/2"},{"label":"C","text":"2/3"},{"label":"D","text":"1/6"}]'::jsonb,
  '1/2', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'short_answer', 'foundational',
  'Find the mean of the data set {15, 20, 25, 30, 40}.',
  NULL, '26', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 57, 'short_answer', 'applied',
  'The data set {12, 15, 18, 18, 21, 25, 30} has min 12 and max 30. What is the range?',
  NULL, '18', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 59, 'short_answer', 'advanced',
  'Two fair six-sided dice are rolled. What is the probability that the sum equals 7? Express as a simplified fraction.',
  NULL, '1/6', NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'explanation', 'foundational',
  'Explain the difference between mean, median, and mode. Give an example where all three are the same and one where they differ.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 56, 'explanation', 'applied',
  'In what situation would the median be a better measure of central tendency than the mean? Use an example with skewed data.',
  NULL, NULL, NULL
FROM modules m WHERE m.slug = 'stats-probability';

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer, test_cases)
SELECT m.id, 59, 'multiple_choice', 'advanced',
  'If P(A) = 0.4, P(B) = 0.5, and A and B are independent, what is P(A and B)?',
  '[{"label":"A","text":"0.1"},{"label":"B","text":"0.2"},{"label":"C","text":"0.45"},{"label":"D","text":"0.9"}]'::jsonb,
  '0.2', NULL
FROM modules m WHERE m.slug = 'stats-probability';


COMMIT;
