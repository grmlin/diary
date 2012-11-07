class AbstractPagination
  _countFetchDelay: null,
  constructor: (@collectionName, @countOptionsCb, @nPerPage = 10) ->
    @sessionCountKey = "#{@collectionName}_pagination_count"
    @sessionPageNumberKey = "#{@collectionName}_pagination_page_number"
    @sessionNPerPageKey = "#{@collectionName}_pagination_n_per_page"
    
    Session.set @sessionCountKey, 0
    @_setNPerPage @nPerPage

    window[@collectionName].find().observe
      added: =>
        @_getCollectionCount()
      removed: =>
        @_getCollectionCount()
        
    @_setPageNumber()

  _getCollectionCount: ->
    try
      Meteor.clearTimeout @_countFetchDelay
      @_countFetchDelay = setTimeout(@_fetchCount, 500)
    catch e
      Meteor._debug("Counting #{@collectionName} failed: ", e)
      
  _fetchCount: =>
    Meteor.call("getCollectionCount", @collectionName, @countOptionsCb(), (err, res) =>
      Meteor._debug(err) if err
      Meteor._debug "#{@collectionName} has #{res} items"
      Session.set @sessionCountKey, res
    )
    
  _getPageNumber: ->
    Session.get @sessionPageNumberKey
  
  _setPageNumber: (page = 1) ->
    Session.set @sessionPageNumberKey, page

  _getNPerPage: ->
    Session.get @sessionNPerPageKey
  
  _setNPerPage: (n = 10) ->
    Session.set @sessionNPerPageKey, n
    
  hasMore: ->
    @_getPageNumber() * @nPerPage < Session.get(@sessionCountKey)
  
  hasLess: ->
    @_getPageNumber() > 1
  
  getCount: ->
    Session.get @sessionCountKey
    
  next: ->
    page = @_getPageNumber()
    @_setPageNumber(page + 1) if @hasMore()

  back: ->
    page = @_getPageNumber()
    @_setPageNumber(page - 1) if page > 1
  
  more: ->
    @_setNPerPage(@_getNPerPage() * 2)