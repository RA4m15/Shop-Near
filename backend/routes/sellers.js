const express = require('express');
const router = express.Router();
const User = require('../models/User');
const Product = require('../models/Product');
const Order = require('../models/Order');
const auth = require('../middleware/auth');

// Get all sellers
router.get('/', async (req, res) => {
  try {
    const sellers = await User.find({ role: 'seller' }).select('-password');
    res.json(sellers);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get seller analytics
router.get('/analytics', auth, async (req, res) => {
  try {
    if (req.user.role !== 'seller') {
      return res.status(403).json({ message: 'Access denied. Only sellers can view analytics.' });
    }

    const orders = await Order.find({ seller: req.user.id });
    const totalOrders = orders.length;
    const totalRevenue = orders.reduce((sum, order) => sum + order.amount, 0);
    const pendingOrders = orders.filter(o => o.status === 'Pending').length;
    const deliveredOrders = orders.filter(o => o.status === 'Delivered').length;

    // Last 30 days revenue (placeholder logic)
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    const recentOrders = orders.filter(o => o.orderDate >= thirtyDaysAgo);
    
    res.json({
      totalOrders,
      totalRevenue,
      pendingOrders,
      deliveredOrders,
      recentRevenue: recentOrders.reduce((sum, order) => sum + order.amount, 0),
      rating: 4.8 // Mock rating
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get seller products
router.get('/products', auth, async (req, res) => {
  try {
    if (req.user.role !== 'seller') {
      return res.status(403).json({ message: 'Access denied. Only sellers can view their products.' });
    }
    const products = await Product.find({ seller: req.user.id });
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
