Template.article_content.helpers
  get_content: (content) ->
    result = Template["article:#{content.type}"](content)

Template.article_content.rendered = ->
  this.findAll('code').forEach((el) ->
    hljs.highlightBlock(el)
  )
     