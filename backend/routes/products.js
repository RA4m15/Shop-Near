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
    console.log('Incoming product request from:', req.user.id);
    console.log('Body:', req.body);
    
    if (req.user.role !== 'seller') {
      console.log('Access denied: User is not a seller');
      return res.status(403).json({ message: 'Only sellers can add products' });
    }

    if (!req.files || req.files.length === 0) {
      console.log('Error: No images uploaded');
      return res.status(400).json({ message: 'At least one image is required' });
    }

    const imageUrls = req.files.map(file => file.path);
    console.log('Images uploaded to Cloudinary:', imageUrls);

    const product = new Product({
      ...req.body,
      images: imageUrls,
      seller: req.user.id
    });

    await product.save();
    console.log('Product saved successfully in MongoDB:', product._id);
    res.status(201).json(product);
  } catch (err) {
    console.error('Error creating product:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
