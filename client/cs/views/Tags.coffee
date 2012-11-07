Template.tags.helpers
  tags: ->
    Tags.find()

  is_current: (name) ->
    appState.getSelectedTag() is name