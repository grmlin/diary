AppRouter = Backbone.Router.extend
  routes:
    "l": "list"
    "t/:tag": "tag"
    "a/:article": "article"
    "p": "produce",
    "login": "login"
  
  initialize: ->
    $ =>
      $("body").on "click", ".internal-link", (evt) =>
        evt.preventDefault()
        @navigate evt.currentTarget.getAttribute("href"), trigger: true
        
  list: -> 
    Meteor._debug("/list")
    appState.setState(appState.LIST)
    
  tag: (tag) ->
    Meteor._debug("/tag/#{tag}")
    appState.setState(appState.TAG)

  article: (article) ->
    Meteor._debug("/article/#{article}")
    appState.setState(appState.ARTICLE)

  produce: ->
    Meteor._debug("/produce")
    appState.setState(appState.ADMIN_NEW)
    
  login: ->
    Session.set "show_login", true
    appState.setState(appState.LIST)
