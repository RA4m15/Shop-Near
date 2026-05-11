const mongoose = require('mongoose');

const liveSessionSchema = new mongoose.Schema({
  seller: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  title: { type: String, required: true },
  category: { type: String, required: true },
  viewersCount: { type: Number, default: 0 },
  thumbnail: { type: String, default: '' },
  isLive: { type: Boolean, default: true },
  startedAt: { type: Date, default: Date.now },
  endedAt: { type: Date }
});

module.exports = mongoose.model('LiveSession', liveSessionSchema);
