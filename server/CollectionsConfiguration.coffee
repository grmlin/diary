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
      doc.slug = getArticleSlug(slugify(doc.title ? ""))

      userId and doc.title and doc.tags.length > 0 and doc.intro

    update: (userId, doc) ->
      # the user must be logged in
      userId