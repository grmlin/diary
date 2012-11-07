do ->
  Template.list.helpers
    articles: ->
      Articles.find({}, {
      sort:
        time: -1
      })

    tagname: ->
      appState.getSelectedTag()

  Template.list.rendered = ->
    if appState.isState(appState.LIST)
      articlesPagination.enableLazyLoading()
    else
      articlesPagination.disableLazyLoading()
