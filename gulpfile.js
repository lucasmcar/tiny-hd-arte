const { src, dest, series } = require('gulp');
const cleanCSS = require('gulp-clean-css');
const uglify = require('gulp-uglify');
const rename = require('gulp-rename');
const gutil = require('gulp-util');

// Minificar CSS (incluindo subpasta admin)
function minifyCSS() {
    return src(['public/assets/**/*.css', '!public/assets/**/*.min.css'], { base: './' })
        .pipe(cleanCSS())
        .pipe(rename({ suffix: '.min' }))
        .pipe(dest(file => file.base))
        .on('error', gutil.log)
        .on('data', file => {
            console.log(`Processando CSS: ${file.path}`);
        });
}

// Minificar JS (incluindo subpasta admin)
function minifyJS() {
    return src(['public/assets/**/*.js', '!public/assets/**/*.min.js'], { base: './' })
        .pipe(uglify())
        .pipe(rename({ suffix: '.min' }))
        .pipe(dest(file => file.base))
        .on('error', gutil.log)
        .on('data', file => {
            console.log(`Processando JS: ${file.path}`);
        });
}

// Tarefa padrão
exports.default = series(minifyCSS, minifyJS);