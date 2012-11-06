class ArticleEditor
  constructor: (@view) ->

  _onArticleChange: (err, id) =>
    appRouter.openArticle(id) if id
    Meteor._debug("Error saving article!", err.reason) if err

  getContentArray: ->
    result = []

    elements = @view.querySelectorAll('.dynamic-content > li')

    for node in elements
      content = ArticleContentFactory.getContent(node)
      result.push(content.getContentDataAsObject()) if content

    return result

  insert: (collection) ->
    collection.insert({
    title: @view.querySelector('input[name=title]').value
    subtitle: @view.querySelector('input[name=subtitle]').value
    tags: @view.querySelector('input[name=tags]').value.split(',')
    intro: @view.querySelector('textarea[name=intro]').value
    dynamic_content: @getContentArray()
    }, @_onArticleChange)

  update: (collection) ->
    id = @view.querySelector('input[name=edit_id]').value
    collection.update(id, {
    $set:
      {
      title: @view.querySelector('input[name=title]').value
      subtitle: @view.querySelector('input[name=subtitle]').value
      tags: @view.querySelector('input[name=tags]').value.split(',')
      intro: @view.querySelector('textarea[name=intro]').value
      dynamic_content: @getContentArray()
      }
    }, (err) =>
      @_onArticleChange(err, id)
    )