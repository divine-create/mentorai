// Copy the .sql migration files into dist/ after `tsc`.
//
// migrate.ts resolves its migrations dir as `path.join(__dirname, 'migrations')`,
// which after compilation is `dist/db/migrations`. tsc only emits .ts → .js, so
// the .sql files must be copied alongside for `node dist/db/migrate.js` to work
// in production (the container can't rely on ts-node / src/). Runs via `postbuild`.

const fs = require('fs');
const path = require('path');

const src = path.join(__dirname, '..', 'src', 'db', 'migrations');
const dest = path.join(__dirname, '..', 'dist', 'db', 'migrations');

fs.mkdirSync(dest, { recursive: true });
let n = 0;
for (const file of fs.readdirSync(src)) {
  if (!file.endsWith('.sql')) continue;
  fs.copyFileSync(path.join(src, file), path.join(dest, file));
  n++;
}
console.log(`copy-migrations: copied ${n} .sql file(s) to dist/db/migrations`);
