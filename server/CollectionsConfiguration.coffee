do ->
  getArticleSlug = (slug) ->
    if Articles.find({slug: slug}).count() > 0
      return getArticleSlug(slug + "_")
    else
      return slug

  Articles.allow
    insert: (userId, doc) ->
      # the user must be logged in
      console.log doc
      doc.time = (new Date()).getTime()
      doc.user_name = Meteor.users.findOne(userId)?.username
      doc.slug = getArticleSlug(slugify(doc.title))

      userId and doc.title and doc.tags.length > 0 and doc.intro

    update: (userId, docs, fields, modifier) ->
      console.log "Updating article"
      mod = modifier.$set

      throw new Meteor.Error(500, "You can only change one article at a time!") if docs.length > 1
      
      mod.slug = getArticleSlug(slugify(mod.title))

      userId and mod.title and mod.tags.length > 0 and mod.intro

  Meteor.methods
    getArticleSlug: (id) ->
      a = Articles.findOne(id)
      throw new Meteor.Error(500, "Article does not exist") unless a
      
      return a.slug