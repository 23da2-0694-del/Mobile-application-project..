import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/product_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/product_cart.dart';

class ProductListingScreen extends StatefulWidget {
  final String? initialCategory;

  const ProductListingScreen({super.key, this.initialCategory});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late String _selectedCategory;
  bool _isGridView = true;
  String _sortBy = 'Featured';

  final List<String> _sortOptions = [
    'Featured',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
    'Newest',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'All';
  }

  List<Product> get _displayProducts {
    List<Product> result = _selectedCategory == 'All'
        ? SampleData.products
        : SampleData.products
            .where((p) => p.category == _selectedCategory)
            .toList();

    switch (_sortBy) {
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        result = result.where((p) => p.isNew).toList() +
            result.where((p) => !p.isNew).toList();
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_outlined : Icons.grid_view_outlined,
              size: 22,
            ),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filter bar
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              scrollDirection: Axis.horizontal,
              itemCount: SampleData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final cat = SampleData.categories[i];
                final selected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.primaryDark : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? AppTheme.primaryDark
                            : AppTheme.dividerColor,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            selected ? Colors.white : AppTheme.textDark,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Sort bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_displayProducts.length} Items',
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: AppTheme.textLight),
                ),
                const Spacer(),
                const Icon(Icons.sort, size: 18, color: AppTheme.textLight),
                const SizedBox(width: 4),
                DropdownButton<String>(
                  value: _sortBy,
                  underline: const SizedBox(),
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppTheme.primaryDark,
                      fontWeight: FontWeight.w500),
                  items: _sortOptions
                      .map((s) =>
                          DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _sortBy = v);
                  },
                ),
              ],
            ),
          ),

          // Products
          Expanded(
            child: _displayProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory_2_outlined,
                            size: 60, color: AppTheme.textLight),
                        const SizedBox(height: 12),
                        Text('No products found',
                            style: GoogleFonts.poppins(
                                color: AppTheme.textLight)),
                      ],
                    ),
                  )
                : _isGridView
                    ? GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.44,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                        itemCount: _displayProducts.length,
                        itemBuilder: (context, i) =>
                            ProductCard(product: _displayProducts[i]),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _displayProducts.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: ProductCard(
                            product: _displayProducts[i],
                            isWide: true,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
