class BlockImage extends Content
  @CONTENT_TYPE: "image"
  constructor: (node) ->
    super(node, BlockImage.CONTENT_TYPE)
    
    img = node.querySelector('.editor img')
    @content = if img then "![#{img.alt}](#{img.src})" else null