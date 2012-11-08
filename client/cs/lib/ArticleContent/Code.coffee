class Code extends Content
  @CONTENT_TYPE: "code"
  constructor: (node) ->
    super(node, Code.CONTENT_TYPE)
    
    dropdown = $(node).data("LangDropdown")
    #console.log dropdown.getLang()
    
    @content = 
      code : node.querySelector('textarea').value
      type : dropdown.getLang()