Template.article_content.helpers
  get_content: (content) ->
    result = Template["article:#{content.type}"](content)

Template.article_content.rendered = ->
  this.findAll('pre code').forEach((el) ->
    hljs.highlightBlock(el)
  )
     
Template.article_content.events = 
  "click .archive-article": (evt) ->
    Articles.update(evt.currentTarget.value, {
    $set:
      {
        is_archived: true
      }
    })

  "click .publish-article": (evt) ->
    Articles.update(evt.currentTarget.value, {
    $set:
      {
      is_archived: false
      }
    })
