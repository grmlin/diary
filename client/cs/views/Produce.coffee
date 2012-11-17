do ->
  TEXTAREA_LINE_HEIGHT = 20

  growTextarea = (textarea) ->
    newHeight = textarea.scrollHeight
    currentHeight = textarea.clientHeight

    if newHeight > currentHeight
      textarea.style.height = newHeight + 1 * TEXTAREA_LINE_HEIGHT + 'px'

  Template.produce.rendered = ->
    this.findAll('textarea').forEach((textarea) ->
      growTextarea(textarea)
    )
    
  Template.produce.events
    "submit form": (evt) ->
      evt.preventDefault()
      
      editor = new ArticleEditor(evt.currentTarget)
      
      if appState.isState(appState.ADMIN_NEW)
        editor.insert(Articles)
      else if appState.isState(appState.ADMIN_EDIT)
        editor.update(Articles)

    "paste .dynamic-content textarea": (evt) ->
      growTextarea evt.currentTarget

    "keyup .dynamic-content textarea": (evt) ->
      growTextarea evt.currentTarget
