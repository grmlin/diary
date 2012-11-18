do ->
  getItem = (classname, template, data = {}) ->
    editable = document.createElement('li')
    editable.className = classname
    editable.innerHTML = template(data)

    return editable

  CreateView = Meteor.View.create 
    elements:
      "#article-contents": "dynamicContent"
      ".content-editor-actions > .btn-toolbar": "editorActions"

    helpers:
      "get_content": "getContent"

    events:
      "click .new-paragraph": "addParagraph"
      "click .new-code": "addCode"
      "click .new-image": "addImage"
      "click .delete": "onDelete"

    callbacks:
      rendered: "onRendered"

    getContent: (content) ->
      c = ""
      switch content.type
        when "paragraph"
          c = "<li class='a-new-paragraph'>#{Template.paragraph_editor(content)}</li>"

        when "image"
          c = "<li class='a-new-image'>#{Template.image_editor(content)}</li>"

        when "code"
          c = "<li class='a-new-codesnippet' data-current='#{content.content.type}'>#{Template.code_editor(content)}</li>"
      c
      
    addParagraph: (evt) ->
      evt.preventDefault()
      editable = getItem "a-new-paragraph", Template.paragraph_editor
      @dynamicContent[0]?.appendChild(editable)

    addCode: (evt) ->
      evt.preventDefault()

      editable = getItem "a-new-codesnippet", Template.code_editor
      @dynamicContent[0]?.appendChild(editable)

      dropdown = new LangDropdown($(editable.querySelector('.language-toggle')))
      $(editable).data("LangDropdown", dropdown)

    addImage: (evt) ->
      evt.preventDefault()

      editable = getItem "a-new-image", Template.image_editor
      @dynamicContent[0]?.appendChild(editable)
      editor = new ImageEditor(editable)

    onDelete: (evt) ->
      evt.preventDefault()
      evt.currentTarget.parentElement.parentElement.removeChild(evt.currentTarget.parentElement)

    onRendered: (tpl) ->
      if appState.isState(appState.ADMIN_EDIT)
        actions = $(@editorActions)
        top = actions.offset().top

        actions.affix
          offset:
            top: () ->
              top - 10

      tpl.findAll('.dynamic-content li').forEach((li) ->
        current = li.getAttribute('data-current')
        dropdown = new LangDropdown($(li).find('.language-toggle'), current)
        $(li).data("LangDropdown", dropdown)
      )

      $('#article-contents').sortable
        handle: ".handle"
        forcePlaceholderSize: true
        helper: "clone"

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

  createView = new CreateView("entry_create_form")
