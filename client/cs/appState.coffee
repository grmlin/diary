appState = do() ->
  SESSION_KEY = "appstate_current"
  SESSION_KEY_ARTICLE_SLUG = "appstate_current_article"
  appState =
    LIST      : "list"
    TAG       : "tag"
    ARTICLE   : "article"
    ADMIN_NEW : "admin_new"
    ADMIN     : "admin"
    
    setState: (state) ->
      Session.set(SESSION_KEY, state)
    
    getState: ->
      Session.get(SESSION_KEY)

    isState: (state) ->
      @getState() is state
      
    getSelectedArticleSlug: () ->
      Session.get SESSION_KEY_ARTICLE_SLUG
      
    setSelectedArticleSlug: (slug) ->
      Session.set(SESSION_KEY_ARTICLE_SLUG, slug)
      

  appState.setState(null)

  Meteor.autorun ->
    Session.set('SELECTED_ARTICLE', null) if not appState.isState(appState.ARTICLE)

  return appState
  