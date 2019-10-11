const mongoose = require('mongoose')

const profileSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  duration: {
    type: Number,
    required: true
  },
  minTempo: {
    type: Number,
    required: true
  },
  maxTempo: {
    type: Number,
    required: true
  },
  numIntervals: {
    type: Number,
    required: true
  },
  intervalType: {
    type: Number,
    required: true
  },
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  }
}, {
  timestamps: true
})

module.exports = mongoose.model('Profile', profileSchema)
