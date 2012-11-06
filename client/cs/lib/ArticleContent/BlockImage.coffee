class BlockImage extends Content
  @CONTENT_TYPE: "image"
  constructor: (node) ->
    super(node, Paragraph.CONTENT_TYPE)
    
    img = node.querySelector('.editor img')
    @content = if img then "![#{img.alt}](#{img.src})" else null