Publisher =
  wirePublications: ->
    Meteor.publish "articles_list", (nPerPage, currentTagSlugs) ->
      selector = {}

      if this.userId is null
        selector.is_archived = no

      if currentTagSlugs
        tags = Tags.find({slug:
          {$in: currentTagSlugs}})
        tagNames = []
        tags.forEach (tag) ->
          tagNames.push(tag.name)
        selector.tags = {$in: tagNames}

      articles = Articles.find(selector,
        {
        fields:
          dynamic_content: no
        sort:
          time: -1
        limit: nPerPage
        }

      )
      return articles

    Meteor.publish "article_selected", (slug) ->
      if slug
        articles = Articles.find({slug: slug})
        return articles
      else
        return null

    Meteor.publish "tags", ->
      Tags.find()
