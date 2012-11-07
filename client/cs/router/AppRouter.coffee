AppRouter = Backbone.Router.extend
  routes:
    "l": "list"
    "t/:tag": "tag"
    "a/:article": "article"
    "p": "produce"
    "p/:article": "produceExisting"
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
    appState.setSelectedArticleSlug(article)

  produce: ->
    Meteor._debug("/produce")
    appState.setState(appState.ADMIN_NEW)

  produceExisting: (article) ->
    Meteor._debug("/edit/#{article}")
    appState.setState(appState.ADMIN_EDIT)
    appState.setSelectedArticleSlug(article)
    
  login: ->
    Session.set "show_login", true
    appState.setState(appState.LIST)

  openArticle: (id) ->
    Meteor.call "getArticleSlug", id, (err, slug) =>
      @navigate("/a/#{slug}", trigger: true) if err is undefined
      Meteor._debug("Couldn't open article #{id}", err) if err
