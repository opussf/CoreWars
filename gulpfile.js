const gulp = require('gulp');
const ts = require('gulp-typescript');
const { deleteAsync } = require('del');
const { spawn } = require('child_process');

const tsProject = ts.createProject('tsconfig.json');

const paths = {
	ts: ['src/**/*.ts'],
	tests: ['tests/**/*.ts', 'tests/visual/*.html'],
}

// Clean dist/
async function clean() {
  await deleteAsync(['dist']);
}

// Test
function test(cb) {
  const proc = spawn(
    'node',
    ['--require', 'ts-node/register', '--test', 'tests/**/*.test.ts'],
    { stdio: 'inherit' }
  );
  proc.on('close', (code) => {
    if (code !== 0) cb(new Error(`Tests failed with code ${code}`));
    else cb();
  });
}

function visual(cb) {
  const proc = spawn(
    'npx',
    ['http-server', '.', '-p', '8080', '-o', 'tests/visual/index.html'],
    { stdio: 'inherit' }
  );
  proc.on('close', cb);
}

// Compile TypeScript
function build() {
  return tsProject.src()
    .pipe(tsProject())
    .pipe(gulp.dest('dist'));
}

// Watch for changes
function watch() {
  gulp.watch([...paths.ts, ...paths.tests], gulp.series(clean, test, build, visual));
}

exports.clean = clean;
exports.test = test;
exports.build = gulp.series(clean, test, build);
exports.watch = watch;
exports.visual = gulp.series(clean, build, visual);
exports.default = gulp.series(clean, test, build);
