-- AI Academy — Seed: 10 HTML & CSS modules, concepts & questions (html-css)
--
-- Concept IDs continue from Math (28-59), starting at 60.
-- Question types: multiple_choice, short_answer, explanation (no 'coding' —
-- web practice is the live playground, not auto-graded test cases).
-- Idempotent: re-running replaces this subject's questions (delete-then-insert)
-- so it can't duplicate the way an unguarded seed would.

BEGIN;

-- ─── Modules ─────────────────────────────────────────────────────────────────
INSERT INTO modules (slug, title, description, subject_id, order_index, estimated_hours_min, estimated_hours_max)
SELECT v.slug, v.title, v.description, s.id, v.ord, v.hmin, v.hmax
FROM subjects s,
  (VALUES
    ('html-foundations',     'HTML Foundations',                'What HTML is, document structure, elements and attributes',       1, 2, 4),
    ('html-text-media',      'Text, Links & Images',            'Formatting text, hyperlinks, and embedding images',               2, 2, 4),
    ('html-structure',       'Lists, Tables & Semantic HTML',   'Lists, tables, and semantic structural elements',                 3, 3, 5),
    ('html-forms',           'Forms & Input',                   'Forms, input types, labels, and accessibility',                   4, 3, 5),
    ('css-foundations',      'CSS Foundations',                 'What CSS is, how to add it, syntax and basic selectors',          5, 3, 5),
    ('css-selectors',        'Selectors, Specificity & Cascade','Combinators, pseudo-classes/elements, specificity, the cascade',   6, 4, 6),
    ('css-box-model',        'The Box Model',                   'Content, padding, border, margin, box-sizing and display',        7, 3, 5),
    ('css-colors-typography','Colors, Backgrounds & Typography','Color formats, backgrounds, fonts and text styling',              8, 3, 5),
    ('css-flexbox-grid',     'Layout: Flexbox & Grid',          'Modern layout with Flexbox and CSS Grid',                         9, 4, 6),
    ('css-responsive-advanced','Responsive Design & Capstone',  'Responsive units, media queries, transitions, animations',       10, 5, 7)
  ) AS v(slug, title, description, ord, hmin, hmax)
WHERE s.slug = 'html-css'
ON CONFLICT (slug) DO NOTHING;

-- ─── Concepts (ids 60-99) ──────────────────────────────────────────────────────
INSERT INTO concepts (id, module_id, title, description, order_index)
SELECT v.id, m.id, v.title, v.descr, v.ord
FROM modules m
JOIN (VALUES
  -- M1 HTML Foundations
  (60, 'html-foundations', 'What HTML Is',            'The role of HTML; elements, tags and attributes', 1),
  (61, 'html-foundations', 'Document Structure',      'DOCTYPE, html, head and body', 2),
  (62, 'html-foundations', 'Headings & Paragraphs',   'h1-h6, paragraphs and line breaks', 3),
  (63, 'html-foundations', 'Attributes & Comments',   'Global attributes and HTML comments', 4),
  -- M2 Text, Links & Images
  (64, 'html-text-media',  'Text Formatting',         'strong, em, b, i, mark and small', 1),
  (65, 'html-text-media',  'Hyperlinks',              'The a element, href, target, relative vs absolute URLs', 2),
  (66, 'html-text-media',  'Images',                  'The img element, src, alt and dimensions', 3),
  (67, 'html-text-media',  'Inline vs Block',         'Inline and block element categories', 4),
  -- M3 Lists, Tables & Semantic HTML
  (68, 'html-structure',   'Lists',                   'Unordered, ordered and description lists', 1),
  (69, 'html-structure',   'Tables',                  'table, tr, th, td and table sections', 2),
  (70, 'html-structure',   'Semantic Elements',       'header, nav, main, section, article, aside, footer', 3),
  (71, 'html-structure',   'Div, Span & Grouping',    'Generic containers and document outline', 4),
  -- M4 Forms & Input
  (72, 'html-forms',       'The Form Element',        'form, action and method', 1),
  (73, 'html-forms',       'Input Types',             'text, email, password, number, checkbox, radio', 2),
  (74, 'html-forms',       'Labels & Accessibility',  'label, for, fieldset and legend', 3),
  (75, 'html-forms',       'Selects, Textareas, Buttons','select, option, textarea, button and validation', 4),
  -- M5 CSS Foundations
  (76, 'css-foundations',  'What CSS Is & How to Add It','Inline, internal and external CSS', 1),
  (77, 'css-foundations',  'CSS Syntax',              'Selectors, properties, values and declaration blocks', 2),
  (78, 'css-foundations',  'Basic Selectors',         'Type, class and id selectors', 3),
  (79, 'css-foundations',  'Colors & Units Intro',    'Basic color values and length units', 4),
  -- M6 Selectors, Specificity & Cascade
  (80, 'css-selectors',    'Combinators',             'Descendant, child and sibling combinators', 1),
  (81, 'css-selectors',    'Pseudo-classes',          'hover, focus, nth-child and friends', 2),
  (82, 'css-selectors',    'Pseudo-elements',         'before, after and first-line', 3),
  (83, 'css-selectors',    'Specificity & the Cascade','How conflicting rules and inheritance resolve', 4),
  -- M7 The Box Model
  (84, 'css-box-model',    'Content, Padding, Border, Margin','The four layers of every box', 1),
  (85, 'css-box-model',    'box-sizing',              'content-box vs border-box', 2),
  (86, 'css-box-model',    'Display & Visibility',    'block, inline, inline-block, none', 3),
  (87, 'css-box-model',    'Sizing & Overflow',       'width, height and overflow', 4),
  -- M8 Colors, Backgrounds & Typography
  (88, 'css-colors-typography','Color Formats',       'Named, hex, rgb/rgba and hsl', 1),
  (89, 'css-colors-typography','Backgrounds',         'background-color, image, position and size', 2),
  (90, 'css-colors-typography','Fonts',               'font-family, web fonts, size and weight', 3),
  (91, 'css-colors-typography','Text Styling',        'Alignment, decoration, spacing and line-height', 4),
  -- M9 Flexbox & Grid
  (92, 'css-flexbox-grid', 'Flex Container',          'display:flex, direction and wrap', 1),
  (93, 'css-flexbox-grid', 'Flex Alignment',          'justify-content, align-items and gap', 2),
  (94, 'css-flexbox-grid', 'Grid Basics',             'display:grid and template tracks', 3),
  (95, 'css-flexbox-grid', 'Grid Placement',          'Areas, spanning and gaps', 4),
  -- M10 Responsive & Capstone
  (96, 'css-responsive-advanced','Responsive Units & Viewport','Percent, em/rem, vw/vh and the viewport meta', 1),
  (97, 'css-responsive-advanced','Media Queries',     'Breakpoints and mobile-first design', 2),
  (98, 'css-responsive-advanced','Transitions & Transforms','Smooth state changes and transforms', 3),
  (99, 'css-responsive-advanced','Animations & Capstone','Keyframe animations; building a full page', 4)
) AS v(id, slug, title, descr, ord) ON m.slug = v.slug
ON CONFLICT (id) DO NOTHING;

-- ─── Questions ─────────────────────────────────────────────────────────────────
-- Idempotency: clear this subject's questions before re-seeding.
DELETE FROM questions WHERE module_id IN (
  SELECT id FROM modules WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'html-css')
);

INSERT INTO questions (module_id, concept_id, type, difficulty, prompt, options, correct_answer)
SELECT m.id, v.concept_id, v.type, v.difficulty, v.prompt, v.options::jsonb, v.correct_answer
FROM modules m
JOIN (VALUES
  -- ── M1 HTML Foundations ──
  ('html-foundations', 60, 'multiple_choice', 'foundational', 'What does HTML stand for?',
    '[{"label":"A","text":"HyperText Markup Language"},{"label":"B","text":"HighText Machine Language"},{"label":"C","text":"Hyperlinks and Text Markup Language"},{"label":"D","text":"Home Tool Markup Language"}]', 'HyperText Markup Language'),
  ('html-foundations', 61, 'multiple_choice', 'foundational', 'Which element contains the visible content of a web page?',
    '[{"label":"A","text":"<head>"},{"label":"B","text":"<body>"},{"label":"C","text":"<title>"},{"label":"D","text":"<meta>"}]', '<body>'),
  ('html-foundations', 61, 'multiple_choice', 'foundational', 'Which line tells the browser the document is HTML5?',
    '[{"label":"A","text":"<html5>"},{"label":"B","text":"<!DOCTYPE html>"},{"label":"C","text":"<doctype html5>"},{"label":"D","text":"<meta charset=html>"}]', '<!DOCTYPE html>'),
  ('html-foundations', 62, 'multiple_choice', 'applied', 'How many levels of section headings does HTML provide?',
    '[{"label":"A","text":"3"},{"label":"B","text":"5"},{"label":"C","text":"6"},{"label":"D","text":"10"}]', '6'),
  ('html-foundations', 62, 'short_answer', 'foundational', 'Write the HTML tag for the largest (top-level) heading.',
    NULL, '<h1>'),
  ('html-foundations', 60, 'explanation', 'foundational', 'Explain the difference between an HTML element, a tag, and an attribute. Give an example of each.',
    NULL, NULL),
  -- ── M2 Text, Links & Images ──
  ('html-text-media', 65, 'multiple_choice', 'foundational', 'Which element creates a hyperlink?',
    '[{"label":"A","text":"<link>"},{"label":"B","text":"<a>"},{"label":"C","text":"<href>"},{"label":"D","text":"<nav>"}]', '<a>'),
  ('html-text-media', 66, 'multiple_choice', 'foundational', 'Which attribute specifies the path to an image file?',
    '[{"label":"A","text":"href"},{"label":"B","text":"src"},{"label":"C","text":"link"},{"label":"D","text":"path"}]', 'src'),
  ('html-text-media', 65, 'multiple_choice', 'applied', 'Which attribute makes a link open in a new browser tab?',
    '[{"label":"A","text":"rel=\"new\""},{"label":"B","text":"target=\"_blank\""},{"label":"C","text":"open=\"tab\""},{"label":"D","text":"window=\"new\""}]', 'target="_blank"'),
  ('html-text-media', 64, 'short_answer', 'foundational', 'Which tag semantically marks text as strongly important (and renders bold by default)?',
    NULL, '<strong>'),
  ('html-text-media', 67, 'multiple_choice', 'applied', 'Which of these is an inline element by default?',
    '[{"label":"A","text":"<div>"},{"label":"B","text":"<p>"},{"label":"C","text":"<span>"},{"label":"D","text":"<section>"}]', '<span>'),
  ('html-text-media', 65, 'explanation', 'applied', 'Explain the difference between an absolute URL and a relative URL in a link href, with an example of each.',
    NULL, NULL),
  -- ── M3 Lists, Tables & Semantic HTML ──
  ('html-structure', 68, 'multiple_choice', 'foundational', 'Which element creates an unordered (bulleted) list?',
    '[{"label":"A","text":"<ol>"},{"label":"B","text":"<ul>"},{"label":"C","text":"<li>"},{"label":"D","text":"<list>"}]', '<ul>'),
  ('html-structure', 69, 'multiple_choice', 'foundational', 'Which element defines a row in a table?',
    '[{"label":"A","text":"<td>"},{"label":"B","text":"<th>"},{"label":"C","text":"<tr>"},{"label":"D","text":"<row>"}]', '<tr>'),
  ('html-structure', 70, 'multiple_choice', 'applied', 'Which semantic element best wraps the main site navigation links?',
    '[{"label":"A","text":"<div>"},{"label":"B","text":"<nav>"},{"label":"C","text":"<menu>"},{"label":"D","text":"<header>"}]', '<nav>'),
  ('html-structure', 70, 'multiple_choice', 'applied', 'Which element represents a self-contained piece of content such as a blog post?',
    '[{"label":"A","text":"<section>"},{"label":"B","text":"<article>"},{"label":"C","text":"<aside>"},{"label":"D","text":"<div>"}]', '<article>'),
  ('html-structure', 68, 'short_answer', 'applied', 'Which list element would you use for a numbered, ordered sequence of steps?',
    NULL, '<ol>'),
  ('html-structure', 70, 'explanation', 'applied', 'Why are semantic elements (header, nav, main, article) preferable to using <div> for everything? Give two reasons.',
    NULL, NULL),
  -- ── M4 Forms & Input ──
  ('html-forms', 72, 'multiple_choice', 'foundational', 'Which <form> attribute sets the URL the data is submitted to?',
    '[{"label":"A","text":"method"},{"label":"B","text":"action"},{"label":"C","text":"src"},{"label":"D","text":"target"}]', 'action'),
  ('html-forms', 73, 'multiple_choice', 'foundational', 'Which input type masks the characters as they are typed?',
    '[{"label":"A","text":"text"},{"label":"B","text":"password"},{"label":"C","text":"hidden"},{"label":"D","text":"number"}]', 'password'),
  ('html-forms', 73, 'multiple_choice', 'applied', 'Which input type lets the user choose only ONE option from a group?',
    '[{"label":"A","text":"checkbox"},{"label":"B","text":"radio"},{"label":"C","text":"select"},{"label":"D","text":"toggle"}]', 'radio'),
  ('html-forms', 72, 'multiple_choice', 'applied', 'Which method should a login form use so the password is not exposed in the URL?',
    '[{"label":"A","text":"GET"},{"label":"B","text":"POST"},{"label":"C","text":"SEND"},{"label":"D","text":"PUT"}]', 'POST'),
  ('html-forms', 75, 'short_answer', 'applied', 'Which element creates a multi-line text input box?',
    NULL, '<textarea>'),
  ('html-forms', 74, 'explanation', 'applied', 'Explain how associating a <label> with an <input> (via for and id) improves usability and accessibility.',
    NULL, NULL),
  -- ── M5 CSS Foundations ──
  ('css-foundations', 76, 'multiple_choice', 'foundational', 'Which HTML element links an external stylesheet?',
    '[{"label":"A","text":"<style>"},{"label":"B","text":"<css>"},{"label":"C","text":"<link>"},{"label":"D","text":"<script>"}]', '<link>'),
  ('css-foundations', 77, 'multiple_choice', 'foundational', 'In the rule  p { color: red; }  what is  color ?',
    '[{"label":"A","text":"selector"},{"label":"B","text":"property"},{"label":"C","text":"value"},{"label":"D","text":"declaration"}]', 'property'),
  ('css-foundations', 78, 'multiple_choice', 'foundational', 'Which selector targets elements with the class name  box ?',
    '[{"label":"A","text":"#box"},{"label":"B","text":".box"},{"label":"C","text":"box"},{"label":"D","text":"*box"}]', '.box'),
  ('css-foundations', 76, 'multiple_choice', 'applied', 'Which way of adding CSS is best for styling an entire multi-page site?',
    '[{"label":"A","text":"inline style attribute"},{"label":"B","text":"internal <style> block"},{"label":"C","text":"external stylesheet"},{"label":"D","text":"it does not matter"}]', 'external stylesheet'),
  ('css-foundations', 78, 'short_answer', 'foundational', 'Which single character begins a CSS id selector?',
    NULL, '#'),
  ('css-foundations', 77, 'explanation', 'foundational', 'Describe the three parts of a CSS rule (selector, property, value) using a concrete example.',
    NULL, NULL),
  -- ── M6 Selectors, Specificity & Cascade ──
  ('css-selectors', 80, 'multiple_choice', 'foundational', 'What does the selector  div p  (with a space) match?',
    '[{"label":"A","text":"a div directly inside a p"},{"label":"B","text":"all p elements inside a div"},{"label":"C","text":"div and p elements"},{"label":"D","text":"a p immediately after a div"}]', 'all p elements inside a div'),
  ('css-selectors', 81, 'multiple_choice', 'foundational', 'Which pseudo-class styles an element while the mouse is over it?',
    '[{"label":"A","text":":focus"},{"label":"B","text":":hover"},{"label":"C","text":":active"},{"label":"D","text":":visited"}]', ':hover'),
  ('css-selectors', 82, 'multiple_choice', 'applied', 'Which pseudo-element inserts generated content AFTER an element?',
    '[{"label":"A","text":"::before"},{"label":"B","text":"::after"},{"label":"C","text":"::first-line"},{"label":"D","text":"::marker"}]', '::after'),
  ('css-selectors', 83, 'multiple_choice', 'advanced', 'Which selector has the HIGHEST specificity?',
    '[{"label":"A","text":"a class like .btn"},{"label":"B","text":"an id like #btn"},{"label":"C","text":"a tag like button"},{"label":"D","text":"the universal selector *"}]', 'an id like #btn'),
  ('css-selectors', 80, 'short_answer', 'applied', 'Which combinator character selects only DIRECT children?',
    NULL, '>'),
  ('css-selectors', 83, 'explanation', 'advanced', 'Two rules target the same element with conflicting values. Explain how CSS decides which wins (mention specificity and source order).',
    NULL, NULL),
  -- ── M7 The Box Model ──
  ('css-box-model', 84, 'multiple_choice', 'foundational', 'Which box-model layer is the space INSIDE the border, around the content?',
    '[{"label":"A","text":"margin"},{"label":"B","text":"padding"},{"label":"C","text":"border"},{"label":"D","text":"outline"}]', 'padding'),
  ('css-box-model', 84, 'multiple_choice', 'foundational', 'Which layer is the transparent space OUTSIDE the border, separating elements?',
    '[{"label":"A","text":"padding"},{"label":"B","text":"margin"},{"label":"C","text":"border"},{"label":"D","text":"gap"}]', 'margin'),
  ('css-box-model', 85, 'multiple_choice', 'applied', 'Which box-sizing value makes width include padding and border?',
    '[{"label":"A","text":"content-box"},{"label":"B","text":"border-box"},{"label":"C","text":"padding-box"},{"label":"D","text":"full-box"}]', 'border-box'),
  ('css-box-model', 86, 'multiple_choice', 'applied', 'Which display value flows inline but still allows setting width and height?',
    '[{"label":"A","text":"inline"},{"label":"B","text":"block"},{"label":"C","text":"inline-block"},{"label":"D","text":"flex"}]', 'inline-block'),
  ('css-box-model', 86, 'short_answer', 'foundational', 'Which display value hides an element and removes it from the layout entirely?',
    NULL, 'none'),
  ('css-box-model', 84, 'explanation', 'applied', 'Describe the four layers of the CSS box model from the inside out, and what each one controls.',
    NULL, NULL),
  -- ── M8 Colors, Backgrounds & Typography ──
  ('css-colors-typography', 88, 'multiple_choice', 'foundational', 'Which is the hex color code for white?',
    '[{"label":"A","text":"#FFFFFF"},{"label":"B","text":"#000000"},{"label":"C","text":"rgb(0,0,0)"},{"label":"D","text":"white(255)"}]', '#FFFFFF'),
  ('css-colors-typography', 88, 'multiple_choice', 'applied', 'In rgba(0,0,0,0.5), what does the fourth value control?',
    '[{"label":"A","text":"brightness"},{"label":"B","text":"alpha (opacity)"},{"label":"C","text":"hue angle"},{"label":"D","text":"saturation"}]', 'alpha (opacity)'),
  ('css-colors-typography', 90, 'multiple_choice', 'foundational', 'Which property sets the typeface of text?',
    '[{"label":"A","text":"font-style"},{"label":"B","text":"font-family"},{"label":"C","text":"text-font"},{"label":"D","text":"typeface"}]', 'font-family'),
  ('css-colors-typography', 89, 'multiple_choice', 'applied', 'Which property sets an image as an element background?',
    '[{"label":"A","text":"image"},{"label":"B","text":"background-image"},{"label":"C","text":"bg-src"},{"label":"D","text":"src"}]', 'background-image'),
  ('css-colors-typography', 91, 'short_answer', 'foundational', 'Which CSS property controls the vertical space between lines of text?',
    NULL, 'line-height'),
  ('css-colors-typography', 88, 'explanation', 'applied', 'Explain the difference between hex, rgb() and hsl() color notations, and give one situation where hsl() is especially convenient.',
    NULL, NULL),
  -- ── M9 Flexbox & Grid ──
  ('css-flexbox-grid', 92, 'multiple_choice', 'foundational', 'Which declaration turns an element into a flex container?',
    '[{"label":"A","text":"display: flexbox"},{"label":"B","text":"display: flex"},{"label":"C","text":"flex: on"},{"label":"D","text":"layout: flex"}]', 'display: flex'),
  ('css-flexbox-grid', 93, 'multiple_choice', 'applied', 'In Flexbox, which property aligns items along the MAIN axis?',
    '[{"label":"A","text":"align-items"},{"label":"B","text":"justify-content"},{"label":"C","text":"align-content"},{"label":"D","text":"place-items"}]', 'justify-content'),
  ('css-flexbox-grid', 93, 'multiple_choice', 'applied', 'In Flexbox, which property aligns items along the CROSS axis?',
    '[{"label":"A","text":"justify-content"},{"label":"B","text":"align-items"},{"label":"C","text":"flex-wrap"},{"label":"D","text":"order"}]', 'align-items'),
  ('css-flexbox-grid', 94, 'multiple_choice', 'applied', 'Which property defines the columns of a CSS grid?',
    '[{"label":"A","text":"grid-columns"},{"label":"B","text":"grid-template-columns"},{"label":"C","text":"columns"},{"label":"D","text":"grid-cols"}]', 'grid-template-columns'),
  ('css-flexbox-grid', 93, 'short_answer', 'applied', 'Which property adds space between flex or grid items?',
    NULL, 'gap'),
  ('css-flexbox-grid', 92, 'explanation', 'applied', 'When would you choose Flexbox over CSS Grid, and vice versa? Give a one-line rule of thumb.',
    NULL, NULL),
  -- ── M10 Responsive Design & Capstone ──
  ('css-responsive-advanced', 97, 'multiple_choice', 'foundational', 'Which CSS at-rule applies styles based on the screen width?',
    '[{"label":"A","text":"@screen"},{"label":"B","text":"@media"},{"label":"C","text":"@responsive"},{"label":"D","text":"@width"}]', '@media'),
  ('css-responsive-advanced', 96, 'multiple_choice', 'applied', 'Which unit is relative to the ROOT element font size?',
    '[{"label":"A","text":"px"},{"label":"B","text":"em"},{"label":"C","text":"rem"},{"label":"D","text":"vh"}]', 'rem'),
  ('css-responsive-advanced', 96, 'multiple_choice', 'applied', 'Which unit equals 1% of the viewport width?',
    '[{"label":"A","text":"vw"},{"label":"B","text":"vh"},{"label":"C","text":"%"},{"label":"D","text":"em"}]', 'vw'),
  ('css-responsive-advanced', 99, 'multiple_choice', 'applied', 'Which at-rule defines the steps of a CSS animation?',
    '[{"label":"A","text":"@animation"},{"label":"B","text":"@keyframes"},{"label":"C","text":"@transition"},{"label":"D","text":"@motion"}]', '@keyframes'),
  ('css-responsive-advanced', 98, 'short_answer', 'applied', 'Which property animates a smooth change between states (for example on hover)?',
    NULL, 'transition'),
  ('css-responsive-advanced', 97, 'explanation', 'advanced', 'Explain what mobile-first responsive design means and how media queries support it.',
    NULL, NULL)
) AS v(slug, concept_id, type, difficulty, prompt, options, correct_answer) ON m.slug = v.slug;

COMMIT;
