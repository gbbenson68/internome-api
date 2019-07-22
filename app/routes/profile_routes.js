const express = require('express')
const router = express.Router()

const customErrors = require('../../lib/custom_errors')
const handle404 = customErrors.handle404
// const removeBlanks = require('../../lib/remove_blank_fields')
// const requireOwnership = customErrors.requireOwnership
// const passport = require('passport')
// const requireToken = passport.authenticate('bearer', {
// session: false
// })
const Profile = require('../models/profile')

// Create a user profile
// router.post('/profiles', requireToken, (request, response, next) => {
router.post('/profiles', (request, response, next) => {
  const newProfile = request.body.profile
  Profile.create({
    name: newProfile.name,
    duration: newProfile.duration,
    minTempo: newProfile.minTempo,
    maxTempo: newProfile.maxTempo
  })
    .then((profile) => {
      response.status(201).json({ profile: profile.toObject() })
    })
    .catch(next)
})

// Get a list of all profiles for a given user
// router.get('/profiles', requireToken, (request, response, next) => {
router.get('/profiles', (request, response, next) => {
  // request.body.profile.owner = request.user.id
  Profile.find()
    .then((profiles) => {
      return profiles.map((profile) => profile.toObject())
    })
    .then((profiles) => response.status(200).json({ profiles }))
    .catch(next)
})

// Retrieve a particular profile for use
// router.get('/profiles/:id', requireToken, (request, response, next) => {
router.get('/profiles/:id', (request, response, next) => {
  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => response.status(200).json({ profile: profile.toObject() }))
    .catch(next)
})

// Update a given user profile
// router.patch('/profiles/:id', requireToken, (request, response, next) => {
router.patch('/profiles/:id', (request, response, next) => {
  // delete request.body.example.owner
  const updatedProfile = request.body.profile

  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => {
      // it will throw an error if the current user isn't the owner
      // requireOwnership(request, profile)
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
// router.delete('/profiles/:id', requireToken, (request, response, next) => {
router.delete('/profiles/:id', (request, response, next) => {
  Profile.findById(request.params.id)
    .then(handle404)
    .then((profile) => {
      // throw an error if current user doesn't own `profile`
      // requireOwnership(request, profile)
      // delete the example ONLY IF the above didn't throw
      profile.remove()
    })
    .then(() => response.sendStatus(204))
    .catch(next)
})

module.exports = router
