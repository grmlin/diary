Handlebars.registerHelper 'show_view', (viewName) ->
  appState.isState viewName
  
Handlebars.registerHelper 'print_active_class', (viewName) ->
  " active "  if appState.isState viewName

Handlebars.registerHelper 'show_login', () ->
  Session.get("show_login") or Meteor.userId() isnt null  
  
Handlebars.registerHelper 'is_user', () ->
  Meteor.userId() isnt null
