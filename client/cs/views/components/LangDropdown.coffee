class LangDropdown 
  constructor: (@toggle) ->
    
    @button = @toggle.prev()
    @list = @toggle.next()

    @button.dropdown()
    @toggle.dropdown()

    @list.on 'click', 'li:not(.active) a', @_onLangSelect
    
  _onLangSelect: (evt) =>
    evt.preventDefault()
    $(evt.currentTarget).parent().addClass('active').siblings('.active').removeClass "active"

    @button.text evt.currentTarget.textContent
    @onLangChanged evt.currentTarget.textContent
    
  onLangChanged : (langDescription) ->
    
  getLang: ->
    @list.find('li.active a').attr('data-val')