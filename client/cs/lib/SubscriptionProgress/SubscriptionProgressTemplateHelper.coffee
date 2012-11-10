class SubscriptionProgressTemplateHelper
  @DELAY: 500
  constructor: (@_progress, @_templateName = "subscription_progress") ->
    
    unless typeof Template[@_templateName] isnt "function"
      Template[@_templateName].helpers
        has_loading_subscription: =>
          @_progress.isLoading()

        items: =>
          @_progress.getLoadingItems()

        hint: (item) =>
          result = item
          name = "subscription_progress:#{item}"
          if typeof Template[name] is "function"
            result = Template[name]()

          return result

      Template[@_templateName].rendered = ->
        $(this.find('.loading-list')).delay(SubscriptionProgressTemplateHelper.DELAY).fadeIn(200)
