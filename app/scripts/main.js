/*global oracleSchemaDoc $*/
'use strict';
$.get('json/overview.json', function(data) {
  var html = oracleSchemaDoc.templates.overview(data);
  $('#overview').html(html);
});
