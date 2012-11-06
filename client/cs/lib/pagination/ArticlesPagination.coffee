class ArticlesPagination extends AbstractPagination
  @N_PER_PAGE: 10
  @getCountOptions: ->
    {}

  constructor: () ->
    super("Articles", ArticlesPagination.getCountOptions, ArticlesPagination.N_PER_PAGE)

    progress.addSubscription (subscribe) =>
      subscribe 'articles_list', @_getNPerPage(), =>
        Meteor._debug "Fetchted #{Articles.find().count()} Articles"
