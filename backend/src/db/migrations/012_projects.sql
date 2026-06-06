-- AI Academy — Projects
--
-- A first-class, subject-scoped Project: a brief, starter files preloaded into
-- the practice surface, and a list of acceptance criteria the tutor checks a
-- submission against. project_submissions records each review.

CREATE TABLE IF NOT EXISTS projects (
  id                  SERIAL PRIMARY KEY,
  subject_id          INT NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  slug                TEXT NOT NULL UNIQUE,
  title               TEXT NOT NULL,
  brief               TEXT NOT NULL,            -- markdown
  starter             JSONB NOT NULL DEFAULT '{}'::jsonb,  -- { html, css } | { code }
  acceptance_criteria JSONB NOT NULL DEFAULT '[]'::jsonb,  -- string[]
  order_index         INT NOT NULL DEFAULT 0,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_projects_subject ON projects(subject_id);

CREATE TABLE IF NOT EXISTS project_submissions (
  id               SERIAL PRIMARY KEY,
  user_id          UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  project_id       INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  content          JSONB NOT NULL,              -- { html, css } | { code }
  passed           BOOLEAN NOT NULL DEFAULT FALSE,
  feedback         TEXT,
  criteria_results JSONB,                       -- [{ criterion, met, note }]
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_project_submissions_user ON project_submissions(user_id, project_id);

-- ─── Seed: HTML & CSS projects ─────────────────────────────────────────────────
INSERT INTO projects (subject_id, slug, title, brief, starter, acceptance_criteria, order_index)
SELECT s.id, v.slug, v.title, v.brief, v.starter::jsonb, v.criteria::jsonb, v.ord
FROM subjects s,
  (VALUES
    (
      'profile-card', 'Profile Card',
      E'## Profile Card\n\nBuild a single, centered **profile card** for a fictional person.\n\nYour card should include:\n- An avatar **image** (use any image URL) with descriptive `alt` text\n- The person''s **name** as a heading\n- A short **bio** paragraph\n- A **button** (e.g. "Follow") that changes appearance on hover\n\nStyle it like a real card: padding, rounded corners, and a subtle shadow, centered on the page.',
      '{"html":"<div class=\"card\">\n  <!-- avatar, name, bio, button go here -->\n</div>","css":"body {\n  font-family: system-ui, sans-serif;\n  display: flex;\n  justify-content: center;\n  padding: 2rem;\n}\n\n.card {\n  /* style your card */\n}"}',
      '["The page contains an <img> with a non-empty alt attribute","There is a heading element (h1-h3) for the name","There is a paragraph of bio text","There is a <button> element","The button has a :hover style","The card has padding, border-radius, and a box-shadow","The card is horizontally centered on the page"]',
      1
    ),
    (
      'pricing-table', 'Pricing Table',
      E'## Pricing Table\n\nBuild a **three-column pricing table**. Each column is a plan card containing:\n- A plan **name** (heading)\n- A **price**\n- A **list of features** (use a `<ul>`)\n- A **call-to-action button**\n\nLay the three cards out side by side using **Flexbox or Grid**, and visually **highlight the middle plan** (e.g. a colored border or larger scale).',
      '{"html":"<section class=\"plans\">\n  <!-- three .plan cards -->\n</section>","css":"body { font-family: system-ui, sans-serif; padding: 2rem; }\n\n.plans {\n  /* arrange the plans in three columns */\n}"}',
      '["There are exactly three plan cards","The plans are arranged in columns using flexbox or grid","Each plan has a price","Each plan uses a <ul> for its feature list","Each plan has a button","The middle plan is visually highlighted differently from the other two"]',
      2
    ),
    (
      'responsive-landing', 'Responsive Landing Page',
      E'## Responsive Landing Page\n\nBuild a small **landing page** that adapts to screen size. It should include:\n- A **header** with a navigation bar\n- A **hero** section with a headline and a call-to-action button\n- A **features** section laid out with Flexbox or Grid (3 items)\n- A **footer**\n\nUse **semantic elements** and at least one **`@media` query** so the layout works on both phone and desktop widths.',
      '{"html":"<header>\n  <nav><!-- logo + links --></nav>\n</header>\n<main>\n  <section class=\"hero\"><!-- headline + CTA --></section>\n  <section class=\"features\"><!-- 3 features --></section>\n</main>\n<footer><!-- footer --></footer>","css":"* { box-sizing: border-box; }\nbody { margin: 0; font-family: system-ui, sans-serif; }\n\n/* Add a @media query for larger screens */"}',
      '["Uses semantic elements: header, nav, main or section, and footer","The hero section has a headline and a call-to-action button","The features section uses flexbox or grid and contains three items","Includes at least one @media query","The layout is readable and does not overflow on a narrow (mobile) width"]',
      3
    )
  ) AS v(slug, title, brief, starter, criteria, ord)
WHERE s.slug = 'html-css'
ON CONFLICT (slug) DO NOTHING;
