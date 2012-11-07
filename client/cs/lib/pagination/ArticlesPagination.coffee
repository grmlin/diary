ArticlesPagination = do ->
  LAZY_OFFSET = 300
  $win = $(window)
  $doc = $(document)

  class ArticlesPagination extends AbstractPagination
    @SCROLL_EVENT = "scroll.articles-list"
    @N_PER_PAGE: 10
    @getCountOptions: ->
      {}

    constructor: (progress) ->
      @uid = Meteor.uuid()
      @listsLoading = false
      
      super("Articles", ArticlesPagination.getCountOptions, ArticlesPagination.N_PER_PAGE)

      progress.addSubscription (subscribe) =>
        currentTag = appState.getSelectedTag()
        console.log "Updating articles #{currentTag}"
        subscribe 'articles_list', @_getNPerPage(), currentTag, =>
          Meteor._debug "Fetchted #{Articles.find().count()} Articles"

      progress.addSubscription (subscribe) =>
        currentSlug = appState.getSelectedArticleSlug()
        if currentSlug
          subscribe 'article_selected', currentSlug, ->
            #console.dir(Articles.findOne({slug:currentSlug}))  

      Meteor.autorun(=>
        @listsLoading = progress.isSubscriptionLoading('articles_list')
      )

    _onScroll: () =>
      moreToCome =  @hasMore()

      if moreToCome and not @listsLoading
        top = window.pageYOffset ? $win.scrollTop()
        isBottom = top + $win.height() >= $doc.height() - LAZY_OFFSET
        if isBottom
          console.log "loading more ----- !!!111"
          @listsLoading = yes
          @more()

    enableLazyLoading: () ->
      $win.on(ArticlesPagination.SCROLL_EVENT + ".#{@uid}", @_onScroll)
      @_onScroll()

    disableLazyLoading: () ->
      $win.off(ArticlesPagination.SCROLL_EVENT + ".#{@uid}")
      @reset()
