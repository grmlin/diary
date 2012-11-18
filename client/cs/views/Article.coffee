do ->
  ArticleView = Meteor.View.create 
    elements: 
      "pre code": "codeBlocks"
  
    helpers:
      "get_content": "getContent"
      
    events:
      "click .archive-article": "onArchive"
      "click .publish-article": "onPublish"
  
    callbacks: 
      rendered: "onRendered"
    
    # constructor 
    initialize: () ->
      
    # template helpers
    getContent: (content) ->
      result = Template["article:#{content.type}"](content)
      
    # event handling
    onArchive: (evt) ->
      Articles.update(evt.currentTarget.value, {
      $set:
        {
        is_archived: true
        }
      })
  
    onPublish: (evt) ->
      Articles.update(evt.currentTarget.value, {
      $set:
        {
        is_archived: false
        }
      })
  
    # template callbacks
  
    onRendered: (template) ->
      @codeBlocks.forEach((el) ->
        hljs.highlightBlock(el)
      )
  
  
  article = new ArticleView("article_content")