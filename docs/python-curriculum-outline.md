# Platform-Native Python Curriculum

A comprehensive zero-to-competent Python course, **authored for The AI Academy** —
not adapted from a book. Every module is designed around the platform's own
affordances: the in-browser Pyodide editor, tutor-authored `[[EXERCISE]]`
directives, inline `[[QUIZ]]` checks that feed `inSession` mastery, runnable
visuals, and mastery-gated progression.

> Optional: each module can be **silently book-grounded** (RAG over the uploaded
> Python Crash Course) so factual content stays vetted, while the *delivery* is
> native to this platform. The learner never sees a book.

---

## Design principles (what "platform-native" means)

1. **Everything runs in the browser sandbox.** No "install Python", no VS Code,
   no system terminal, no saving `.py` files. The learner writes and runs real
   code right here, every lesson.
2. **The run-once / non-interactive model is taught honestly.** Code runs once
   and `input()` returns an empty string. Lessons use hardcoded values, function
   parameters, and editable variables so output is always meaningful — and
   Module 1 explains *why* up front.
3. **Visuals are generated, never referenced.** Where a concept wants a picture,
   the learner produces it with runnable code (`matplotlib` charts, ASCII
   sketches, program output) and sees it live — no figures to "look at".
4. **Capstones run in the sandbox.** No `pygame`, no Django, no live web APIs
   (they don't run in Pyodide). Projects are data viz, text/logic games, and
   simulations — all fully runnable here.
5. **Every concept has a hands-on hook.** Each module ships at least one tailored
   `[[EXERCISE]]` and one `[[QUIZ]]`. Quizzes feed the `inSession` mastery
   component; the module completes when the learner passes its Final Assessment
   (≥80%).
6. **Assessment item mix per module** (so mastery's components all populate):
   `multiple_choice` + `short_answer` (→ in-session/comprehension),
   `coding` (→ coding-unaided), and `explanation` (→ explanation quality).

---

## Curriculum map (7 phases · 23 modules)

| # | Phase | Module |
|---|-------|--------|
| 1 | Foundations | Your first program & how code runs here |
| 2 | Foundations | Variables & data types |
| 3 | Foundations | Strings in depth |
| 4 | Foundations | Numbers & arithmetic |
| 5 | Collections | Lists |
| 6 | Collections | Looping over data |
| 7 | Collections | Tuples & immutability |
| 8 | Collections | Dictionaries |
| 9 | Collections | Nested data structures |
| 10 | Control flow | Conditionals & boolean logic |
| 11 | Control flow | `while` loops & program flow |
| 12 | Control flow | Processing data (loops + conditionals) |
| 13 | Functions | Defining functions |
| 14 | Functions | Arguments in depth |
| 15 | Functions | Modules & organizing code |
| 16 | OOP | Classes & objects |
| 17 | OOP | Inheritance & composition |
| 18 | OOP | Modeling with classes |
| 19 | Robust code | Files & exceptions (+ JSON) |
| 20 | Robust code | Testing your code |
| 21 | Capstone | Data analysis & visualization |
| 22 | Capstone | A text-based logic game |
| 23 | Capstone | Simulation & generative art |

---

## Phase 1 — Foundations

### Module 1 — Your first program & how code runs here
**Goal:** Run code in the sandbox; understand the run-once, non-interactive model.
**Concepts:** `print()`, the editor + Run loop, comments, syntax errors, the
"runs once, `input()` returns `''`" rule and how to work with hardcoded values.
**Exercise:** Print a three-line greeting; change a `name` variable and re-run to
see the output change.
**Quiz:** "What does `input()` return in this environment?" → (empty string).
**Assessment focus:** read output, fix a one-line syntax error (coding), explain
what a comment is for (explanation).

### Module 2 — Variables & data types
**Goal:** Store and label data; recognize the core types.
**Concepts:** assignment, naming rules, `str`/`int`/`float`/`bool`, `type()`,
f-strings, `str()`/`int()`/`float()` conversion.
**Exercise:** Build a "profile card" string with f-strings from `name`, `age`,
`city` variables.
**Quiz:** Predict the type of `3 / 2` vs `3 // 2`.
**Assessment focus:** convert `"42"` to an int and use it (coding); explain why
`"5" + 5` errors (explanation).

### Module 3 — Strings in depth
**Goal:** Manipulate text confidently.
**Concepts:** indexing & slicing, `.upper()/.lower()/.strip()/.replace()/.split()
/.join()`, `in`, `len()`, multi-line strings, escape sequences.
**Exercise:** Given a messy `" Ada Lovelace "`, normalize it to `"ada-lovelace"`.
**Quiz:** What does `"hello"[1:4]` produce? → `"ell"`.
**Assessment focus:** slice + transform a string (coding); explain slice bounds
(explanation).

### Module 4 — Numbers & arithmetic
**Goal:** Compute with numbers correctly.
**Concepts:** `+ - * / // % **`, operator precedence, float vs int, rounding,
underscores in literals, `abs()/round()/min()/max()`.
**Exercise:** Compute a restaurant bill split: total, tip %, per-person, rounded.
**Quiz:** Value of `17 % 5`? → 2.
**Assessment focus:** write a small formula (coding); explain `//` vs `/`
(explanation).

---

## Phase 2 — Collections

### Module 5 — Lists
**Goal:** Hold ordered collections.
**Concepts:** literals, indexing (incl. negative), slicing, `append/insert/remove
/pop/sort/sorted/reverse`, `len`, list of any type, mutation vs copy.
**Exercise:** Maintain a "to-do" list: add three items, remove one, sort, print.
**Quiz:** What does `[1,2,3][-1]` return? → 3.
**Assessment focus:** transform a list (coding); explain why a list is mutable
(explanation).

### Module 6 — Looping over data
**Goal:** Repeat work over a collection.
**Concepts:** `for` loops, indentation/blocks, `range()`, `enumerate()`,
accumulator pattern, building a list in a loop, intro to list comprehensions.
**Exercise:** Sum the even numbers from 1–20; then rewrite as a comprehension.
**Quiz:** How many times does `for i in range(2, 8)` iterate? → 6.
**Assessment focus:** loop + accumulate (coding); explain indentation's role
(explanation).

### Module 7 — Tuples & immutability
**Goal:** Use fixed collections and unpacking.
**Concepts:** tuple literals, immutability, unpacking, when to prefer tuples,
returning multiple values (foreshadows functions).
**Exercise:** Store an (x, y) point, unpack it, and compute distance from origin.
**Quiz:** Which raises an error: `t[0]` or `t[0] = 9`? → assignment.
**Assessment focus:** unpack a tuple (coding); explain tuple vs list choice
(explanation).

### Module 8 — Dictionaries
**Goal:** Map keys to values.
**Concepts:** literals, lookup, add/update/delete, `.get()`, `.keys()/.values()
/.items()`, iterating, `in` on keys, counting pattern.
**Exercise:** Count word frequencies in a sentence and print the top word.
**Quiz:** What does `d.get('x', 0)` do when `'x'` is absent? → returns 0.
**Assessment focus:** build a frequency dict (coding); explain key uniqueness
(explanation).

### Module 9 — Nested data structures
**Goal:** Model real-world data.
**Concepts:** list of dicts, dict of lists, nested indexing, iterating nested
structures, choosing a shape for data.
**Exercise:** Given a list of `{"name","score"}` dicts, print each name and the
class average.
**Quiz:** Access pattern for `users[0]["roles"][1]`.
**Assessment focus:** iterate a list-of-dicts (coding); explain when to nest
(explanation).

---

## Phase 3 — Control flow & logic

### Module 10 — Conditionals & boolean logic
**Goal:** Make decisions.
**Concepts:** `if/elif/else`, comparison operators, `and/or/not`, truthiness,
chained comparisons, nesting, the conditional expression.
**Exercise:** Grade classifier — map a numeric score to A–F with `if/elif`.
**Quiz:** Value of `not (3 > 2 and 1 > 5)`? → True.
**Assessment focus:** branch on input values (coding); explain truthiness of `[]`
and `0` (explanation).

### Module 11 — `while` loops & program flow
**Goal:** Repeat until a condition changes.
**Concepts:** `while`, loop variables, `break`/`continue`, avoiding infinite
loops, flags, simulating "input" with a preset list (run-once model).
**Exercise:** Process a preset queue of orders with `while` until it's empty.
**Quiz:** What ends a `while` loop early regardless of its condition? → `break`.
**Assessment focus:** drain a list with `while` (coding); explain `break` vs
`continue` (explanation).

### Module 12 — Processing data (loops + conditionals)
**Goal:** Combine the tools to analyze data.
**Concepts:** filtering, mapping, aggregating, guard clauses, nested loops,
building summaries.
**Exercise:** From a list of temperatures, report count above freezing, the max,
and the average.
**Quiz:** Which structure filters items while iterating? (conditional inside loop)
**Assessment focus:** filter + aggregate (coding); explain a chosen approach
(explanation).

---

## Phase 4 — Functions

### Module 13 — Defining functions
**Goal:** Package reusable logic.
**Concepts:** `def`, parameters, `return` vs `print`, scope basics, docstrings,
calling functions, returning values into variables.
**Exercise:** Write `is_palindrome(text)` and test it on three words.
**Quiz:** Difference between a function that `return`s vs one that `print`s.
**Assessment focus:** author a function from a spec (coding); explain local scope
(explanation).

### Module 14 — Arguments in depth
**Goal:** Flexible function interfaces.
**Concepts:** positional vs keyword args, default values, `*args`, `**kwargs`,
returning multiple values (tuple unpacking), mutable-default gotcha.
**Exercise:** `make_pizza(size, *toppings)` that prints an order summary.
**Quiz:** What does `*args` collect arguments into? → a tuple.
**Assessment focus:** write a variadic function (coding); explain the mutable
default-arg pitfall (explanation).

### Module 15 — Modules & organizing code
**Goal:** Structure larger programs.
**Concepts:** the standard library, `import`, `from … import`, aliasing,
`random`, `math`, `datetime`, `string`; why we split code into functions/files.
**Exercise:** Use `random` to shuffle a deck of cards (built as a list) and deal
a hand.
**Quiz:** What does `import math as m` let you write? → `m.sqrt(...)`.
**Assessment focus:** use a stdlib module (coding); explain namespacing
(explanation).

---

## Phase 5 — Object-oriented programming

### Module 16 — Classes & objects
**Goal:** Bundle data + behavior.
**Concepts:** `class`, `__init__`, attributes, methods, `self`, creating
instances, default attribute values, modifying attributes.
**Exercise:** A `BankAccount` class with `deposit`/`withdraw` and a balance.
**Quiz:** What is `self` in a method? → the instance being acted on.
**Assessment focus:** define a small class (coding); explain instance vs class
(explanation).

### Module 17 — Inheritance & composition
**Goal:** Reuse and extend behavior.
**Concepts:** subclassing, `super().__init__`, overriding methods, composition
(an object holding another object), when to inherit vs compose.
**Exercise:** `SavingsAccount(BankAccount)` that adds interest.
**Quiz:** What does `super()` give access to? → the parent class's methods.
**Assessment focus:** extend a base class (coding); explain inheritance vs
composition (explanation).

### Module 18 — Modeling with classes
**Goal:** Design a small object model.
**Concepts:** multiple cooperating classes, `__str__`/`__repr__`, encapsulation,
a class managing a collection of instances.
**Exercise:** `Library` holding `Book` objects: add, check out, list available.
**Quiz:** What does `__str__` control? → the readable string form of an object.
**Assessment focus:** model two cooperating classes (coding); explain a design
choice (explanation).

---

## Phase 6 — Robust code

### Module 19 — Files & exceptions (+ JSON)
**Goal:** Persist data and handle failure gracefully.
**Concepts:** Pyodide's in-memory filesystem, `open`/`with`, reading & writing
text, `try/except/else/finally`, common exception types, `json.dumps/loads`.
**Exercise:** Write a list of scores to a file as JSON, read it back, and total
it — all in the sandbox filesystem.
**Quiz:** Which block always runs, error or not? → `finally`.
**Assessment focus:** round-trip JSON to a file (coding); explain why we catch
specific exceptions (explanation).

### Module 20 — Testing your code
**Goal:** Verify behavior automatically.
**Concepts:** `assert`, `unittest` basics, writing test cases, edge cases,
test-first thinking, reading a failing test.
**Exercise:** Write three `unittest` cases for the `is_palindrome` from Module 13.
**Quiz:** What does `assertEqual(a, b)` check? → that `a == b`.
**Assessment focus:** write a passing test for a function (coding); explain why
edge cases matter (explanation).

---

## Phase 7 — Capstones (all fully runnable in the sandbox)

### Module 21 — Capstone A: Data analysis & visualization
**Goal:** Turn raw data into a chart.
**Concepts:** loading a built-in dataset (a Python list/dict in the lesson),
computing summary stats, `matplotlib` line/bar/scatter, labels & titles, reading
a chart you generated.
**Exercise:** Plot monthly rainfall (provided as a list) as a labeled bar chart
and annotate the wettest month.
**Quiz:** Which `matplotlib` call renders the figure? → `plt.show()`.
**Assessment focus:** generate a labeled chart from data (coding); explain what
the chart reveals (explanation).

### Module 22 — Capstone B: A text-based logic game
**Goal:** Combine state, loops, conditionals, and classes into a program.
**Concepts:** game state, a turn loop (driven by a preset move list given the
run-once model), win/lose conditions, a `Game` class, randomness.
**Exercise:** Build "Guess the Number" that plays out a preset list of guesses
and reports hits/misses and the result.
**Quiz:** Why drive the game from a preset move list here? → `input()` isn't
interactive in this environment.
**Assessment focus:** implement game logic with a class + loop (coding); explain
the state machine (explanation).

### Module 23 — Capstone C: Simulation & generative art
**Goal:** Model a process and visualize the outcome.
**Concepts:** Monte Carlo thinking, `random`, accumulating results over many
trials, plotting a random walk or dice-roll distribution with `matplotlib`.
**Exercise:** Simulate 1,000 dice rolls, tally the sums, and plot the
distribution; or plot a 2-D random walk.
**Quiz:** Roughly what shape is the sum-of-two-dice distribution? → triangular /
peaked at 7.
**Assessment focus:** run a simulation and visualize it (coding); explain why
more trials smooth the result (explanation).

---

## Sequencing & gating

- Modules unlock in order; each completes when its **Final Assessment ≥ 80%**.
- In-chat quizzes feed the `inSession` mastery component (10%); the Final
  Assessment dominates (final 40% / coding-unaided 30% / explanation 20%).
- Phases 1–4 are prerequisites for the capstones; the OOP phase (16–18) is a
  prerequisite for the game capstone (22).

## Build notes (if you generate this into the platform)
- Create a **new "Python (Platform-Native)" subject** with `practice_kind = 'code'`
  so the Pyodide editor and `[[EXERCISE]]` flow are enabled.
- Generate as `published = false` drafts → review in the admin Content tab →
  publish per module.
- Optionally attach the Python Crash Course book to the subject so generation +
  live tutoring are silently book-grounded for factual accuracy.
- Target item counts per module: ~6–8 assessment questions spanning all four
  types so every mastery component populates.
