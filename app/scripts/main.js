/*global oracleSchemaDoc Handlebars $*/
'use strict';

// custom block helper that updates the <head><title>
Handlebars.registerHelper('headTitle', function(options) {
  document.title = options.fn(this);
  return '';
});

Handlebars.registerPartial('overview', oracleSchemaDoc.templates.overview);
// fetch the json data and apply it to the pre-compiled template
$.get('json/overview.json', function(data) {
  var html = oracleSchemaDoc.templates.page(data);
  $('#page').html(html);
});
// fetch the json data and apply it to the pre-compiled templates
//$.get('json/overview.json', function(data) {
//  var html = oracleSchemaDoc.templates.overview(data);
//  $('#overview').html(html);
//});
