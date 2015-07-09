# Oracle Schema Documentation
Automatic generation of HTML schema documentation using the Oracle data dictionary tables.

---

**UNFINISHED WORK IN PROGRESS**

---

## Usage

Install the prerequisites.
* Install [node](https://nodejs.org)
* Install [gulp](http://gulpjs.com) and [bower](http://bower.io) using npm. Note: you may need to use sudo before installing node packages globally.
```bash
npm install --global gulp bower
```

Get a copy of this project and build it.
* Clone from github and go to the root of the project.
```bash
git clone https://github.com/eggplantpasta/oracle-schema-doc.git
cd oracle-schema-doc
```
* Install packages to bower_components/.
```bash
bower install
```
* Build and serve the project which will open the result in your browser.
```bash
gulp serve
```

## About
This app was scaffolded using the [Yeoman](http://yeoman.io) generator [gulp-webapp](https://github.com/yeoman/generator-gulp-webapp) with the added recipe [Handlebars](https://github.com/yeoman/generator-gulp-webapp/blob/master/docs/recipes/handlebars.md).

It uses the following web frontend tools:
* [HTML5 Boilerplate](https://html5boilerplate.com)
* [Sass](http://sass-lang.com)
* [Bootstrap](http://getbootstrap.com)
* [Modernizr](http://modernizr.com)
* [Handlebars](http://handlebarsjs.com)
* [JQuery](https://jquery.com)
