Template.article_content.helpers 
  current_article: ->
    Articles.findOne({slug:appState.getSelectedArticleSlug()})

  get_content: (content) ->
    console.dir content
    result = Template["article:#{content.type}"](content)
     