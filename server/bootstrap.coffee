Bootstrap = do ->
  BOOTSTRAP_CONFIG = 'bootstrap'

  defaultUsers = DEFAULT_USER ? []
  Meteor._debug("Default users: ",defaultUsers)

  Bootstrap =
    boot: ->
      Meteor._debug "Booting application"
      # configure users
      Accounts.config
        forbidClientAccountCreation: true
        
      # create default users  
      Meteor._debug("Creating default users... currently active: ")
      Meteor._debug Meteor.users.find().fetch()
      
      defaultUsers.forEach (user) ->
        unless Meteor.users.find({username: user.username}).count() > 0
          Meteor._debug "Creating user #{user.username}"
  
          userId = Accounts.createUser user
          Accounts.sendEnrollmentEmail userId