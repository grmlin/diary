Meteor.methods
  getCollectionCount : (collection, selector = {}) ->
    isCollection = typeof global[collection] is "object"
    return if isCollection then global[collection].find(selector).count() else 0

  getArticlesCount: (articlesSlugs) ->
    #TODO duplicated from Publisher.coffee
    selector = {}
    
    if this.userId is null
      selector.is_archived = no
      
    if articlesSlugs isnt null
      tags = Tags.find({slug:
        {$in: articlesSlugs}})
      tagNames = []
      tags.forEach (tag) ->
        tagNames.push(tag.name)
      selector.tags = {$in: tagNames}

    Articles.find(selector).count()