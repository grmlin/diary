class ArticleEditor
  constructor: (@view) ->

  
  getContentArray: ->
    result = []

    elements = @view.querySelectorAll('.dynamic-content > li')

    for node in elements
      content = ArticleContentFactory.getContent(node)
      result.push(content.getContentDataAsObject()) if content

    return result
      
  insert: (collection) ->
    collection.insert(
      title: @view.querySelector('input[name=title]').value
      subtitle: @view.querySelector('input[name=subtitle]').value
      tags: @view.querySelector('input[name=tags]').value.split(',')
      intro: @view.querySelector('textarea[name=intro]').value
      dynamic_content: @getContentArray()
    )