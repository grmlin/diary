appRouter = new AppRouter()
progress = new SubscriptionProgress()
progressView = new SubscriptionProgressTemplateHelper(progress)


Meteor.startup ->
  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'
    
  progress.registerInitialLoadHandler(->
    Meteor._debug "#{progress.getSubscriptionCount()} subscriptions loaded initially"
  )
  
  Backbone.history.start({pushState: true})

  if Backbone.history.fragment is ""
    appRouter.navigate "/l", trigger: true
  
  