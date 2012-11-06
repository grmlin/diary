Meteor.methods
  getCollectionCount : (collection, selector = {}) ->
    isCollection = typeof global[collection] is "object"
    return if isCollection then global[collection].find(selector).count() else 0 
