do ->
  getArticleSlug = (slug) ->
    if Articles.find({slug: slug}).count() > 0
      return getArticleSlug(slug + "_")
    else
      return slug

  updateTags = (doc) ->
    doc.tags?.forEach(addTag)
    cleanUpTags()

  addTag = (tag) ->
    if tag and tag isnt "" and Tags.find({name: tag}).count() is 0
      console.log("Adding TAG #{tag}")

      Tags.insert
        name: tag
        slug: slugify(tag)

  cleanUpTags = () ->
    # remove unused tags
    Tags.find().forEach((tag) ->
      console.log("Searching for tag #{tag.name}")
      unless Articles.find({tags: tag.name}).count() > 0
        Tags.remove(tag._id)
    )

  # Update all tags
  Articles.find().forEach((doc)->
    updateTags(doc)
  )


  Articles.allow
    insert: (userId, doc) ->
      # the user must be logged in
      doc.time = (new Date()).getTime()
      doc.user_name = Meteor.users.findOne(userId)?.username
      doc.slug = getArticleSlug(slugify(doc.title))
      doc.is_archived = false

      if doc.tags
        doc.tags.forEach (tag, i) ->
          doc.tags[i] = _.string.trim(tag)

        updateTags(doc.tags)

      userId and doc.title and doc.tags.length > 0 and doc.intro

    update: (userId, docs, fields, modifier) ->
      mod = modifier.$set
      changeArchiveState = no
      
      throw new Meteor.Error(500, "You can only change one article at a time!") if docs.length > 1

      #mod.slug = getArticleSlug(slugify(mod.title))

      console.log "is_archived: ", mod.is_archived
      # archive?
      if mod.is_archived is true or mod.is_archived is false
        changeArchiveState = yes  
      else if mod.tags
        mod.tags.forEach (tag, i) ->
          mod.tags[i] = _.string.trim(tag)

        updateTags(mod.tags)

      console.log "allowing change: ", changeArchiveState  
      userId and (changeArchiveState or (mod.title and mod.tags.length > 0 and mod.intro))

  query = Articles.find()
  handle = query.observe
    added: updateTags
    changed: updateTags

  Meteor.methods
    getArticleSlug: (id) ->
      a = Articles.findOne(id)
      throw new Meteor.Error(500, "Article does not exist") unless a

      return a.slug