appState = do() ->
  SESSION_KEY = "appstate_current"
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
      
  

  appState.setState(null)

  return appState
  