do ->
  getItem = (classname, template, data = {}) ->
    editable = document.createElement('li')
    editable.className = classname
    editable.innerHTML = template(data)

    return editable
    
  Template.entry_create_form.helpers
    get_content: (content) ->
      c = ""
      switch content.type
        when "paragraph"
          c = "<li class='a-new-paragraph'>#{Template.paragraph_editor(content)}</li>"
          
        when "image"
          c = "<li class='a-new-image'>#{Template.image_editor(content)}</li>"
      
        when "code"
          c = "<li class='a-new-codesnippet' data-current='#{content.content.type}'>#{Template.code_editor(content)}</li>"
      c
  
  Template.entry_create_form.rendered = ->
    this.findAll('.dynamic-content li').forEach((li) ->
      current = li.getAttribute('data-current')
      dropdown = new LangDropdown($(li).find('.language-toggle'), current)
      $(li).data("LangDropdown",dropdown)
    )
    
    $('#article-contents').sortable
      handle: ".handle"
      forcePlaceholderSize: true
      helper: "clone"
  
      
  Template.entry_create_form.events
    "click .delete" : (evt) ->
      evt.preventDefault()
      li = event.currentTarget.parentNode
      ul = li.parentNode
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
      $(editable).data("LangDropdown",dropdown)
  
    "click .new-image": (evt) ->
      evt.preventDefault()
  
      editable = getItem "a-new-image", Template.image_editor
      document.getElementById('article-contents').appendChild(editable)
      editor = new ImageEditor(editable)
  
  
