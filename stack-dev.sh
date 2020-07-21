#!/bin/sh

# installation de Gulp et des plugins
npm init
npm install gulp -D
npm install node-sass -D
npm install gulp-sass -D
npm install gulp-csso -D
npm install bootstrap -D
npm install gulp-purgecss -D
npm install gulp-useref -D
npm install critical -D
npm install fancy-log -D
npm install gulp-cache-bust -D

#création des différents répertoires
mkdir src
mkdir src/js
mkdir src/sass
mkdir src/img

#création des fichiers nécéssaires
npx -p touch nodetouch gulpfile.js
npx -p touch nodetouch src/js/main.js
npx -p touch nodetouch src/sass/style.scss
npx -p touch nodetouch src/sass/my-bts.scss


# mise en place de bootstrap avec my-bts.scss et import dans style.scss
echo "@import "my-bts.scss";" > src/sass/style.scss

# copie des scripts nécéssaires à bootstrap
cp node_modules/bootstrap/dist/js/bootstrap.bundle.min.js src/js/
cp node_modules/bootstrap/dist/js/bootstrap.min.js src/js/

#liaison avec bootstrap dans my-bts.scss
cat > src/sass/my-bts.scss << eof
/*!
 * Bootstrap v4.5.0 (https://getbootstrap.com/)
 * Copyright 2011-2020 The Bootstrap Authors
 * Copyright 2011-2020 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */
 
@import "../../node_modules/bootstrap/scss/functions";
@import "../../node_modules/bootstrap/scss/variables";
@import "../../node_modules/bootstrap/scss/mixins";
@import "../../node_modules/bootstrap/scss/root";
@import "../../node_modules/bootstrap/scss/reboot";
@import "../../node_modules/bootstrap/scss/type";
@import "../../node_modules/bootstrap/scss/images";
@import "../../node_modules/bootstrap/scss/code";
@import "../../node_modules/bootstrap/scss/grid";
@import "../../node_modules/bootstrap/scss/tables";
@import "../../node_modules/bootstrap/scss/forms";
@import "../../node_modules/bootstrap/scss/buttons";
@import "../../node_modules/bootstrap/scss/transitions";
@import "../../node_modules/bootstrap/scss/dropdown";
@import "../../node_modules/bootstrap/scss/button-group";
@import "../../node_modules/bootstrap/scss/input-group";
@import "../../node_modules/bootstrap/scss/custom-forms";
@import "../../node_modules/bootstrap/scss/nav";
@import "../../node_modules/bootstrap/scss/navbar";
@import "../../node_modules/bootstrap/scss/card";
@import "../../node_modules/bootstrap/scss/breadcrumb";
@import "../../node_modules/bootstrap/scss/pagination";
@import "../../node_modules/bootstrap/scss/badge";
@import "../../node_modules/bootstrap/scss/jumbotron";
@import "../../node_modules/bootstrap/scss/alert";
@import "../../node_modules/bootstrap/scss/progress";
@import "../../node_modules/bootstrap/scss/media";
@import "../../node_modules/bootstrap/scss/list-group";
@import "../../node_modules/bootstrap/scss/close";
@import "../../node_modules/bootstrap/scss/toasts";
@import "../../node_modules/bootstrap/scss/modal";
@import "../../node_modules/bootstrap/scss/tooltip";
@import "../../node_modules/bootstrap/scss/popover";
@import "../../node_modules/bootstrap/scss/carousel";
@import "../../node_modules/bootstrap/scss/spinners";
@import "../../node_modules/bootstrap/scss/utilities";
@import "../../node_modules/bootstrap/scss/print";
eof

#############
# gulpfile.js
#############

#initialisation des plugins
cat > gulpfile.js << eof
const { src, dest, parallel, series, watch } = require("gulp");
const sass = require("gulp-sass");
const useref = require("gulp-useref");
const minifyCSS = require("gulp-csso");
const purgecss = require("gulp-purgecss");
const responsive = require("gulp-responsive");
const log = require("fancy-log");
const critical = require("critical").stream;
const cachebust = require("gulp-cache-bust");
eof

# Variables des path
cat >> gulpfile.js << eof
// file path  variables
const files = {
  scssPath: "./src/sass/*.scss",
  jsPath: "./src/js/*.js",
  imgPath: "./src/img/**/",
  phpPath: "./src/**/*.php",
  htmlPath: "./src/*.html",
  distCssPath: "dist/css/*.css",
  dist: "./dist/",
  distFile: "./dist/*.html",
};
eof

# cacheBust
cat >> gulpfile.js << eof
/*******************************
 * cacheBust task
 * Add timestamp version to css
 *******************************/
function cacheBust() {
  return src(files.distFile)
    .pipe(cachebust({ type: "timestamp" }))
    .pipe(dest(files.dist));
}
eof

# Critical task
cat >> gulpfile.js << eof
/****************
 * Critical task
 * Inline critical-path css and load the existing stylesheets asynchronously
 ****************/
function criticalTask() {
  return src(files.htmlPath)
    .pipe(
      critical({
        base: files.dist,
        inline: true,
        css: "dist/css/style.css",
      })
    )
    .on("error", (err) => {
      log.error(err.message);
    })
    .pipe(dest("./dist"));
}
eof
# JS Task
cat >> gulpfile.js << eof
/*****************
 * JS Task
 * Parse build blocks in HTML files to replace references to non-optimized scripts or stylesheets with useref
 *  - I use it only for js
 *****************/
function jsTask() {
  return src(files.htmlPath).pipe(useref()).pipe(dest(files.dist));
}
eof

# sass Task
cat >> gulpfile.js << eof
/******************
 * sass Task
 * - sass task with gulp-sass
 * - purgecss with gulp-purgecss
 * - minify with gulp-csso
 ******************/
function sassTask() {
  return (
    src(files.scssFile)
      // Use sass with the files found, and log any errors
      .pipe(sass())
      .on("error", sass.logError)
      .pipe(
        purgecss({
          content: [files.htmlPath, files.jsPath],
        })
      )
      //minify css
      .pipe(minifyCss())
      // What is the destination for the compiled file?
      .pipe(dest(files.dist + "/css"))
  );
}
eof
# Watch task
cat >> gulpfile.js << eof
/****************
 * Watch task
 * Default task to compile file on save to dist
 *  - jstask
 ****************/
function watchTask() {
  watch(
    [files.scssFile, files.jsPath, files.htmlPath],
    series(sassTask, jsTask, criticalTask, cacheBust)
  );
}
eof

# Exports
cat >> gulpfile.js << eof
exports.watch = watchTask;
exports.js = jsTask;
exports.sass = sassTask;
exports.img = mImagesTask;
exports.critical = criticalTask;
exports.cache = cacheBust;
eof

#############
# index.html
#############

cat > src/index.html << eof
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./css/style.css" />
    <title>Document</title>
  </head>
  <body>
    <h1>It works !</h1>
    <!-- build:js js/main.js -->
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <!-- endbuild -->
  </body>
</html>
eof
