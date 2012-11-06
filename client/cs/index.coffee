appRouter = new AppRouter()
progress = new SubscriptionProgress()
progressView = new SubscriptionProgressTemplateHelper(progress)
articlesPagination = null

Meteor.startup ->
  articlesPagination = new ArticlesPagination()

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'

  progress.registerInitialLoadHandler(->
    Meteor._debug "#{progress.getSubscriptionCount()} subscriptions loaded initially"
    Backbone.history.start({pushState: true})

    if Backbone.history.fragment is ""
      appRouter.navigate "/l", trigger: true

  )
  
  progress.addSubscription (subscribe) =>
    currentSlug = appState.getSelectedArticleSlug()
    subscribe 'article_selected', currentSlug, ->
      #console.dir(Articles.findOne({slug:currentSlug}))  
      

  