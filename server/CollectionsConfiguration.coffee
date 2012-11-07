do ->
  getArticleSlug = (slug) ->
    if Articles.find({slug: slug}).count() > 0
      return getArticleSlug(slug + "_")
    else
      return slug

  updateTags = (doc) ->
    doc.tags?.forEach(addTag)

  addTag = (tag) ->
    if tag and tag isnt "" and Tags.find({name: tag}).count() is 0
      console.log("Adding TAG #{tag}")

      Tags.insert
        name: tag

  Tags.remove({})
  Articles.find().forEach((doc)->
    updateTags(doc)
  )

  Articles.allow
    insert: (userId, doc) ->
      # the user must be logged in
      doc.time = (new Date()).getTime()
      doc.user_name = Meteor.users.findOne(userId)?.username
      doc.slug = getArticleSlug(slugify(doc.title))

      userId and doc.title and doc.tags.length > 0 and doc.intro

    update: (userId, docs, fields, modifier) ->
      mod = modifier.$set

      throw new Meteor.Error(500, "You can only change one article at a time!") if docs.length > 1

      mod.slug = getArticleSlug(slugify(mod.title))
      userId and mod.title and mod.tags.length > 0 and mod.intro

  query = Articles.find()
  handle = query.observe
    added: updateTags
    changed: updateTags

  Meteor.methods
    getArticleSlug: (id) ->
      a = Articles.findOne(id)
      throw new Meteor.Error(500, "Article does not exist") unless a

      return a.slug