Template.article_content.helpers 
  get_content: (content) ->
    result = Template["article:#{content.type}"](content)
     