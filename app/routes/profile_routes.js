// Import Express and set up the router
const express = require('express')
const router = express.Router()

// Import passport and set up authentication
const passport = require('passport')
const requireToken = passport.authenticate('bearer', {
  session: false
})

// Import custom errors and set up error handlers
const customErrors = require('../../lib/custom_errors')
const handle404 = customErrors.handle404
const requireOwnership = customErrors.requireOwnership

const removeBlanks = require('../../lib/remove_blank_fields')
const Profile = require('../models/profile')

// Create a user profile
router.post('/profiles', requireToken, (request, response, next) => {
  const newProfile = request.body.profile
  Profile.create({
    name: newProfile.name,
    duration: newProfile.duration,
    minTempo: newProfile.minTempo,
    maxTempo: newProfile.maxTempo,
    owner: request.user.id
  })
    .then((profile) => {
      response.status(201).json({ profile: profile.toObject() })
    })
    .catch(next)
})

// Get a list of all profiles for a given user
router.get('/profiles', requireToken, (request, response, next) => {
  Profile.find()
    .then((profiles) => {
      return profiles.map((profile) => profile.toObject())
    })
    // Need to ONLY return those profiles belonging to given user, no others. 
    .then((profiles) => {
      const newProfiles = []
      profiles.forEach((profile) => {
        if (JSON.stringify(profile.owner) === JSON.stringify(request.user.id)) {
          newProfiles.push(profile)
        }
      })
      return newProfiles
    })
    .then((profiles) => response.status(200).json({ profiles }))
    .catch(next)
})

// Retrieve a particular profile for use
router.get('/profiles/:id', requireToken, (request, response, next) => {
  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => {
      // it will throw an error if the current user isn't the owner
      requireOwnership(request, profile)

      // Otherwise return existing profile
      return profile
    })
    .then((profile) => response.status(200).json({ profile: profile.toObject() }))
    .catch(next)
})

// Update a given user profile
router.patch('/profiles/:id', requireToken, removeBlanks, (request, response, next) => {
  delete request.body.profile.owner
  const updatedProfile = request.body.profile

  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => {
      // it will throw an error if the current user isn't the owner
      requireOwnership(request, profile)

      // Otherwise, return the updated profile
      return profile.update({
        name: updatedProfile.name,
        duration: updatedProfile.duration,
        minTempo: updatedProfile.minTempo,
        maxTempo: updatedProfile.maxTempo
      })
    })
    .then(() => response.sendStatus(204))
    .catch(next)
})

// Remove a given user profile
router.delete('/profiles/:id', requireToken, (request, response, next) => {
  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => {
      // throw an error if current user doesn't own `profile`
      requireOwnership(request, profile)

      // delete the example ONLY IF the above didn't throw
      profile.remove()
    })
    .then(() => response.sendStatus(204))
    .catch(next)
})

module.exports = router
