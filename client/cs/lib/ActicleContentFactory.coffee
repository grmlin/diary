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
        Meteor._debug.log "codesnippet"

      when "a-new-paragraph"
        Meteor._debug.log "a-new-paragraph"
        content = new Paragraph(node)

      when "a-new-image"
        Meteor._debug.log "a-new-image"
        content = new BlockImage(node)
                                            
      else
        Meteor._debug.log "wtf"   
        
    return content