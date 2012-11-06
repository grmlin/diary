Publisher =
  wirePublications: ->
    Meteor.publish "articles_list", (nPerPage) ->
      articles = Articles.find({},
        {
        fields:
          dynamic_content: no
        },
        limit: nPerPage
      )
      Meteor._debug "Publishing #{articles.count()} Articles (max #{nPerPage})"
      return articles

    Meteor.publish "article_selected", (slug) ->
      Articles.find({slug: slug})  