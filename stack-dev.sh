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
npx -p touch nodetouch src/sass/my-bts.scss

# mise en place de bootstrap avec my-bts.scss et import dans style.scss
echo "@import "my-bts.scss";" > src/sass/style.scss

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
