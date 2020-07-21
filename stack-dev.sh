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

#création des différents répertoires
mkdir src
mkdir src/js
mkdir src/sass
mkdir src/img

#création des fichiers nécéssaires
npx -p touch nodetouch gulpfile.js
npx -p touch nodetouch src/js/main.js
npx -p touch nodetouch src/sass/style.scss

# mise en place de bootstrap avec my-bts.scss et import dans style.scss
cp node_modules/bootstrap/scss/bootstrap.scss src/sass/my-bts.scss
echo "@import "my-bts.scss";" > src/sass/style.scss