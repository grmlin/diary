Template.tags.helpers
  tags: ->
    Tags.find()

  is_current: (slug) ->
    _.contains(appState.getSelectedTagSlugs(), slug)

Template.tags.events =
  "click a:not(.active)": (evt) ->
    unless appState.getSelectedTagSlugs() is null
      evt.preventDefault()
      evt.stopPropagation()
      
      url = evt.currentTarget.getAttribute('href')
      tag = url.replace('/t/', '')
      appRouter.navigate "/#{Backbone.history.fragment},#{tag}", {trigger: true}


  "click a.active": (evt) ->
    unless appState.getSelectedTagSlugs() is null
      evt.preventDefault()
      evt.stopPropagation()
      
      currentTags = appState.getSelectedTagSlugs()
      tag = evt.currentTarget.getAttribute('href').replace('/t/', '')
      remaining = _.without(currentTags, tag)
      url = if remaining.length > 0 then "/t/#{remaining}" else "/l"
      appRouter.navigate url, {trigger: true}

