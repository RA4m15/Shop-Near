const express = require('express');
const router = express.Router();
const Product = require('../models/Product');
const auth = require('../middleware/auth');
const { upload } = require('../config/cloudinary');

// Get all products
router.get('/', async (req, res) => {
  try {
    const products = await Product.find().populate('seller', 'name avatar');
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Create product (Seller only)
router.post('/', auth, upload.array('images', 5), async (req, res) => {
  try {
    if (req.user.role !== 'seller') return res.status(403).json({ message: 'Only sellers can add products' });

    const imageUrls = req.files.map(file => file.path);
    const product = new Product({
      ...req.body,
      images: imageUrls,
      seller: req.user.id
    });
    await product.save();
    res.status(201).json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
