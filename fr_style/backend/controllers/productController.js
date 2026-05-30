const Product = require('../models/Product');

// @desc    Get all products
// @route   GET /api/products
const getProducts = async (req, res) => {
  try {
    const products = await Product.find({});
    
    // If no products in DB, return some mock data for demonstration
    if (products.length === 0) {
      return res.json([
        {
          _id: "1",
          name: "Modern Silk Dress",
          description: "A beautiful modern silk dress perfect for summer evenings.",
          price: 120.00,
          category: "Women",
          image: "https://images.unsplash.com/photo-1539008835657-9e8e9680c956?auto=format&fit=crop&q=80&w=400",
          countInStock: 10,
          rating: 4.5,
          numReviews: 12
        },
        {
          _id: "2",
          name: "Casual Denim Jacket",
          description: "Classic denim jacket with a modern fit.",
          price: 85.00,
          category: "Men",
          image: "https://images.unsplash.com/photo-1551537482-f2075a1d41f2?auto=format&fit=crop&q=80&w=400",
          countInStock: 5,
          rating: 4.2,
          numReviews: 8
        },
        {
            _id: "3",
            name: "Premium Leather Handbag",
            description: "High-quality leather handbag with elegant finish.",
            price: 150.00,
            category: "Accessories",
            image: "https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&q=80&w=400",
            countInStock: 3,
            rating: 4.8,
            numReviews: 20
          }
      ]);
    }

    res.json(products);
  } catch (error) {
    res.status(500).json({ message: 'Server Error' });
  }
};

// @desc    Get single product
// @route   GET /api/products/:id
const getProductById = async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);

    if (product) {
      res.json(product);
    } else {
      res.status(404).json({ message: 'Product not found' });
    }
  } catch (error) {
    res.status(500).json({ message: 'Server Error' });
  }
};

module.exports = {
  getProducts,
  getProductById,
};
