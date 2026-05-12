const mongoose = require('mongoose');
const User = require('./models/User');
const Product = require('./models/Product');
const Order = require('./models/Order');
const LiveSession = require('./models/LiveSession');
require('dotenv').config();

const seedData = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI);
    console.log('Connected to MongoDB for seeding...');

    // Clear existing data
    await User.deleteMany({});
    await Product.deleteMany({});
    await Order.deleteMany({});
    await LiveSession.deleteMany({});

    // Create Sellers
    const sellers = await User.create([
      {
        name: 'Priya Fashion',
        email: 'priya@example.com',
        password: 'password123',
        role: 'seller',
        handle: '@priya_sarees',
        location: 'Indore, MP',
        avatar: 'https://res.cloudinary.com/demo/image/upload/v1631234567/sample.jpg',
        bio: 'Handwoven treasures from local artisans of MP 🌸',
        isVerified: true
      },
      {
        name: 'Green Bazaar',
        email: 'green@example.com',
        password: 'password123',
        role: 'seller',
        handle: '@green_bazaar',
        location: 'Dewas, MP',
        avatar: 'https://res.cloudinary.com/demo/image/upload/v1631234567/sample.jpg',
      }
    ]);

    // Create Products
    await Product.create([
      {
        name: 'Silk Saree Blue',
        description: 'Pure Banarasi silk saree with intricate zari work.',
        price: 1299,
        oldPrice: 2100,
        category: 'Fashion',
        seller: sellers[0]._id,
        tags: ['Handloom', 'In Stock', 'Free Delivery'],
        stock: 10,
        rating: 4.8,
        reviewsCount: 234,
        soldCount: 1200
      },
      {
        name: 'Organic Ghee 500g',
        description: 'Pure organic ghee from grass-fed cows.',
        price: 450,
        category: 'Food',
        seller: sellers[1]._id,
        stock: 50,
        rating: 4.9
      }
    ]);

    console.log('Database seeded successfully!');
    process.exit();
  } catch (err) {
    console.error('Error seeding database:', err);
    process.exit(1);
  }
};

seedData();
