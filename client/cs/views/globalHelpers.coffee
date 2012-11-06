Handlebars.registerHelper 'show_view', (viewNames) ->
  show = no
  names = viewNames.split(',')
  names.forEach((name) ->
    show = yes if appState.isState(name)
  )
  
  return show

Handlebars.registerHelper 'print_active_class', (viewName) ->
  " active "  if appState.isState viewName

Handlebars.registerHelper 'show_login', () ->
  Session.get("show_login") or Meteor.userId() isnt null

Handlebars.registerHelper 'is_user', () ->
  Meteor.userId() isnt null

Handlebars.registerHelper 'datestring', (time) ->
  moment(time).format("MMMM Do YYYY")

Handlebars.registerHelper 'current_article', ->
  slug = appState.getSelectedArticleSlug()
  if slug
    a = Articles.findOne({slug: slug})
    return a
