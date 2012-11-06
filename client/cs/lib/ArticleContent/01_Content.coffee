class Content
  content: ""
  usesMarkdown: yes

  constructor: (@node, @type) ->

  getContentDataAsObject: ->
    return {
    type: @type
    usesMarkdown: @usesMarkdown
    content: @content
    }
