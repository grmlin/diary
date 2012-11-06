do ->
  TEXTAREA_LINE_HEIGHT = 20

  
  getItem = (classname, template) ->
    editable = document.createElement('li')
    editable.className = classname
    editable.innerHTML = template()  
    
    return editable
  
  growTextarea = (textarea) ->
    newHeight = textarea.scrollHeight
    currentHeight = textarea.clientHeight

    if newHeight > currentHeight
      textarea.style.height = newHeight + 5 * TEXTAREA_LINE_HEIGHT + 'px'
      
  Template.produce.events
    "submit form": (evt) ->
      evt.preventDefault()
      editor = new ArticleEditor(evt.currentTarget)
      editor.insert(Articles)
    
    "paste textarea": (evt) ->
      growTextarea evt.currentTarget

    "keyup textarea": (evt) ->
      growTextarea evt.currentTarget
        
    "click .delete" : (evt) ->
      evt.preventDefault()
      li = event.currentTarget.parentNode
      ul = li.parentNode
      console.log(li, ul)
      evt.currentTarget.parentElement.parentElement.removeChild(evt.currentTarget.parentElement)
      
    "click .new-paragraph": (evt) ->
      evt.preventDefault()
  
      editable = getItem "a-new-paragraph", Template.paragraph_editor
      document.getElementById('article-contents').appendChild(editable)
  
    "click .new-code": (evt) ->
      evt.preventDefault()

      editable = getItem "a-new-codesnippet", Template.code_editor
      document.getElementById('article-contents').appendChild(editable)

      dropdown = new LangDropdown($(editable.querySelector('.language-toggle')))
      dropdown.onLangChanged = (langDescription) =>
        #id = Messages.findOne({short_id:Session.get(SESSION_SHORT_MESSAGE_ID)})?._id
        #messagesController.updateMessageType(id,dropdown.getLang())
    
    "click .new-image": (evt) ->
      evt.preventDefault()

      editable = getItem "a-new-image", Template.image_editor
      document.getElementById('article-contents').appendChild(editable)
      editor = new ImageEditor(editable)