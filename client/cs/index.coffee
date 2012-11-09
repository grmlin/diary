appRouter = new AppRouter()
progress = new SubscriptionProgress()
progressView = new SubscriptionProgressTemplateHelper(progress)

articlesPagination = new ArticlesPagination(progress)

Meteor.startup ->

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'
    
  Accounts.config
    forbidClientAccountCreation: true
    
  progress.addSubscription (subscribe) =>
    subscribe 'tags'
        
  progress.registerInitialLoadHandler(->
    Meteor._debug "#{progress.getSubscriptionCount()} subscriptions loaded initially"
    document.body.className += " page-loaded "
    Backbone.history.start({pushState: true})

    if Backbone.history.fragment is ""
      appRouter.navigate "/l", trigger: true

  )  