Publisher =
  wirePublications: ->
    Meteor.publish "articles_list", (nPerPage, tag) ->
      selector = if tag then {tags: tag } else {}
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
