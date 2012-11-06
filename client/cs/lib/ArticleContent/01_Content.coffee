class Content
  content: ""
  constructor: (@node, @type) ->

  getContentDataAsObject: ->
    return {
    type: @type
    content: @content
    }
