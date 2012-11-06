Template.list.helpers
  articles: ->
    Articles.find({}, {
    sort:
      time: -1
    })

