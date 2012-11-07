appState = do() ->
  SESSION_KEY = "appstate_current"
  SESSION_KEY_ARTICLE_SLUG = "appstate_current_article"
  SESSION_KEY_TAG = "appstate_current_tag"
  
  appState =
    LIST      : "list"
    TAG       : "tag"
    ARTICLE   : "article"
    ADMIN_NEW : "admin_new"
    ADMIN_EDIT : "admin_edit"
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

    setSelectedTag: (tag) ->
      Session.set SESSION_KEY_TAG, tag

    getSelectedTag: () ->
      Session.get SESSION_KEY_TAG


  appState.setState(null)

  Meteor.autorun ->
    state = appState.getState()
    appState.setSelectedArticleSlug(null) if state isnt appState.ARTICLE and state isnt appState.ADMIN_EDIT
    appState.setSelectedTag(null) if state isnt appState.TAG

  return appState
  