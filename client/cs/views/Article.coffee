Template.article_content.helpers
  get_content: (content) ->
    result = Template["article:#{content.type}"](content)

Template.article_content.rendered = ->
  this.findAll('pre code').forEach((el) ->
    hljs.highlightBlock(el)
  )
     