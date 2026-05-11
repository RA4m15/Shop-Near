const express = require('express');
const router = express.Router();
const Chat = require('../models/Chat');
const Message = require('../models/Message');
const auth = require('../middleware/auth');

// Get all chats for current user
router.get('/', auth, async (req, res) => {
  try {
    const chats = await Chat.find({
      participants: { $in: [req.user.id] }
    }).populate('participants', 'name avatar');
    res.json(chats);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get messages for a specific chat
router.get('/:chatId/messages', auth, async (req, res) => {
  try {
    const messages = await Message.find({ chat: req.params.chatId })
      .sort({ createdAt: 1 });
    res.json(messages);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Create/Get chat between two users
router.post('/start', auth, async (req, res) => {
  try {
    const { receiverId } = req.body;
    let chat = await Chat.findOne({
      participants: { $all: [req.user.id, receiverId] }
    });

    if (!chat) {
      chat = new Chat({
        participants: [req.user.id, receiverId]
      });
      await chat.save();
    }
    res.json(chat);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Send message
router.post('/message', auth, async (req, res) => {
  try {
    const { chatId, text } = req.body;
    const message = new Message({
      chat: chatId,
      sender: req.user.id,
      text
    });
    await message.save();

    // Update last message in chat
    await Chat.findByIdAndUpdate(chatId, {
      lastMessage: text,
      updatedAt: Date.now()
    });

    // Emit socket event
    const chat = await Chat.findById(chatId);
    chat.participants.forEach(participantId => {
      if (participantId.toString() !== req.user.id) {
        req.io.emit(`new_message_${participantId}`, message);
      }
    });

    res.status(201).json(message);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
