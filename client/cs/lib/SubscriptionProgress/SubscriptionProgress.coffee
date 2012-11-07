SubscriptionProgress = do ->
  SESSION_KEY = "subscription_loader_loads"
  uid = 0


  class SubscriptionLoader
    _firstLoadCallback: null
    _firstLoadFinished: no
    _subscriptionsInitiallyLoaded: 0
    
    constructor: () ->
      @_uid = uid++;
      @_subscriptions = {}

    addSubscription: (getArgs) ->
      firstTime = yes
      Meteor.autosubscribe =>
        getArgs(() =>
          subscribeArguments = Array.prototype.slice.call(arguments)
          name = _.first(subscribeArguments)
          cb = _.last(subscribeArguments)

          if typeof cb is "function"
            subscribeArguments = _.initial subscribeArguments
          else
            cb = ->

          args = subscribeArguments.concat([=>
            @_subscriptionsInitiallyLoaded++ if firstTime
            firstTime = no
            
            @_onLoadComplete(_.first(subscribeArguments))
            cb.apply @
          ])

          @_subscriptions[name] = true
          @_onBeforeLoad(name)
          Meteor.subscribe.apply(Meteor.subscribe, args)
        )

    isLoading: () ->
      isLoading = false
      for own name, type of @_subscriptions
        if @isSubscriptionLoading(name)
          isLoading = true
          break

      return isLoading

    isSubscriptionLoading: (name) ->
      @_getLoadState(name) is true

    getLoadingItems: ->
      items = []
      for own name, type of @_subscriptions
        items.push(name) if @isSubscriptionLoading(name)

      return items

    getSubscriptionCount: ->
      Object.keys(@_subscriptions).length
    
    registerInitialLoadHandler: (cb) ->
      @_firstLoadCallback = cb     
      
    #private
    _getKey: (name) ->
      "#{SESSION_KEY}_#{name}_#{@_uid}"

    _setLoadState: (name, isLoading) ->
      Session.set @_getKey(name), isLoading

    _getLoadState: (name) ->
      Session.get @_getKey(name)

    _onBeforeLoad: (name) ->
      @_setLoadState name, true
      #Meteor._debug "####LOADER#### Subscription \"#{name}\" loads new data now "

    _onLoadComplete: (name) =>
      #Meteor._debug "<SubscriptionProgress> #{name} loaded "

      @_setLoadState name, false
      
      if not @_firstLoadFinished and @_subscriptionsInitiallyLoaded >= @getSubscriptionCount()
        @_firstLoadFinished = yes
        @_firstLoadCallback?.call(this)
      
      #Meteor._debug "####LOADER#### Subscription \"#{name}\" was sucessfully refreshed "