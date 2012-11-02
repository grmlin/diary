Meteor.startup ->
  Accounts.config
    forbidClientAccountCreation: true
  
  
  Publisher.wirePublications()