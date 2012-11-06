Template.article_content.helpers 
  get_content: (content) ->
    console.dir content
    result = Template["article:#{content.type}"](content)
     