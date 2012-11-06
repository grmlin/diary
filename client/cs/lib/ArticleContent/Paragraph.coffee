class Paragraph extends Content
  @CONTENT_TYPE: "paragraph"
  constructor: (node) ->
    super(node, Paragraph.CONTENT_TYPE)
    @content = node.querySelector('textarea').value