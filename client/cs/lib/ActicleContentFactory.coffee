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
        Meteor._debug "codesnippet"

      when "a-new-paragraph"
        Meteor._debug "a-new-paragraph"
        content = new Paragraph(node)

      when "a-new-image"
        Meteor._debug "a-new-image"
        content = new BlockImage(node)
                                            
      else
        Meteor._debug "wtf"   
        
    return content