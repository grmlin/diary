Publisher =
  wirePublications: ->
    Meteor.publish "articles_list", (nPerPage) ->
      articles = Articles.find({},
        {
        fields:
          dynamic_content: no
        sort:
          time: -1
        limit: nPerPage
        }

      )
      Meteor._debug "Publishing #{articles.count()} Articles (max #{nPerPage})"
      return articles

    Meteor.publish "article_selected", (slug) ->
      if slug
        articles = Articles.find({slug: slug})
        Meteor._debug "Publishing #{articles.count()} Articles for slug #{slug}"
        return articles
      else
        return null
