Bootstrap = do ->
  BOOTSTRAP_CONFIG = 'bootstrap'

  require = __meteor_bootstrap__.require
  path    = require 'path'
  fs      = require 'fs'

  base = path.resolve '.'
  if base is '/'
    base = path.dirname global.require.main.filename
  
  config = "#{base}/server/config/bootstrap" 
  defaultUsers = if fs.existsSync(config) then require(config) else []

  Bootstrap =
    boot: ->
      Meteor._debug "Booting application"
      # configure users
      Accounts.config
        forbidClientAccountCreation: true
        
      # create default users  
      defaultUsers.forEach (user) ->
        Meteor._debug "Checking for bootstrap user #{user.username}"
        unless Meteor.users.find({username: user.username}).count() > 0
          Meteor._debug "Creating user #{user.username}"
  
          userId = Accounts.createUser user
          Accounts.sendEnrollmentEmail userId