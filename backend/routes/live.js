const express = require('express');
const router = express.Router();
const LiveSession = require('../models/LiveSession');
const auth = require('../middleware/auth');
const { upload } = require('../config/cloudinary');

// Get all live sessions
router.get('/', async (req, res) => {
  try {
    const sessions = await LiveSession.find({ isLive: true }).populate('seller', 'name avatar');
    res.json(sessions);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Start live session (Seller only)
router.post('/', auth, upload.single('thumbnail'), async (req, res) => {
  try {
    if (req.user.role !== 'seller') return res.status(403).json({ message: 'Only sellers can go live' });

    const session = new LiveSession({
      seller: req.user.id,
      title: req.body.title,
      category: req.body.category,
      thumbnail: req.file ? req.file.path : ''
    });
    await session.save();
    res.status(201).json(session);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
