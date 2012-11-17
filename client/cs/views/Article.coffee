Meteor.View.create "article_content",
  elements: 
    "pre code": "codeBlocks"

  helpers:
    "get_content": "getContent"
    
  events:
    "click h2": "onClick"
    "click .archive-article": "onArchive"
    "click .publish-article": "onPublish"

  callbacks: 
    rendered: "onRendered"
  
  # constructor 
  initialize: ->
    
  # template helpers
  getContent: (content) ->
    Meteor._debug "view #{@name}#getContent"
    result = Template["article:#{content.type}"](content)
    
  # event handling
  onClick: (evt) ->
    console.log evt
    Meteor._debug "view #{@name} clicked"

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

