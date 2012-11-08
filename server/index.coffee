Meteor.startup ->
  Bootstrap.boot()
  
  Publisher.wirePublications()
