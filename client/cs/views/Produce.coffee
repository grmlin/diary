do ->
  getItem = (classname, template) ->
    editable = document.createElement('li')
    editable.className = classname
    editable.innerHTML = template()  
    
    return editable
  
  Template.produce.events
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
    
    "click .new-image": (evt) ->
      evt.preventDefault()

      editable = getItem "a-new-image", Template.image_editor
      document.getElementById('article-contents').appendChild(editable)