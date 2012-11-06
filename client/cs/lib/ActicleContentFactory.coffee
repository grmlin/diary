ArticleContentFactory =
  ###
  "a-new-codesnippet"
  "a-new-paragraph"
  "a-new-image"
  ###
  getContent: (node) ->
    content = null
    switch node.className

      when "a-new-codesnippet"
        console.log "codesnippet"

      when "a-new-paragraph"
        console.log "a-new-paragraph"
        content = new Paragraph(node)

      when "a-new-image"
        console.log "a-new-image"
        content = new BlockImage(node)
                                            
      else
        console.log "wtf"   
        
    return content