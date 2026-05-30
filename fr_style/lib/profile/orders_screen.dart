import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  final int initialIndex;
  const OrdersScreen({super.key, this.initialIndex = 0});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryDark,
          labelColor: AppTheme.primaryDark,
          unselectedLabelColor: AppTheme.textLight,
          labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'History'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList('active'),
          _buildOrdersList('history'),
          _buildOrdersList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String type) {
    final orders = _getMockOrders(type);

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 60, color: AppTheme.textLight.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              'No $type orders found',
              style: GoogleFonts.poppins(color: AppTheme.textLight),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, i) {
        final order = orders[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order['id']}',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    order['date'],
                    style: GoogleFonts.poppins(color: AppTheme.textLight, fontSize: 12),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order['imageUrl'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['name'],
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order['itemsCount']} items • \$${order['total']}',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textLight),
                        ),
                      ],
                    ),
                  ),
                  _statusBadge(order['status']),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        padding: EdgeInsets.zero,
                        side: const BorderSide(color: AppTheme.dividerColor),
                      ),
                      child: Text('Details', style: GoogleFonts.poppins(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (type == 'active')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: EdgeInsets.zero,
                          backgroundColor: AppTheme.primaryDark,
                        ),
                        child: Text('Track', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
                      ),
                    )
                  else if (type == 'history')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: EdgeInsets.zero,
                          backgroundColor: AppTheme.accentColor,
                        ),
                        child: Text('Reorder', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'delivered':
        color = Colors.green;
        break;
      case 'shipping':
        color = Colors.blue;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      case 'processing':
        color = Colors.orange;
        break;
      default:
        color = AppTheme.textLight;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMockOrders(String type) {
    if (type == 'active') {
      return [
        {
          'id': '2849',
          'date': 'Oct 24, 2026',
          'name': 'Classic Brown Coat & Slim Fit Trousers',
          'itemsCount': 2,
          'total': '135.98',
          'status': 'Shipping',
          'imageUrl': 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=200',
        },
        {
          'id': '2845',
          'date': 'Oct 22, 2026',
          'name': 'Minimalist Watch',
          'itemsCount': 1,
          'total': '75.00',
          'status': 'Processing',
          'imageUrl': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=200',
        },
      ];
    } else if (type == 'history') {
      return [
        {
          'id': '2712',
          'date': 'Sep 15, 2026',
          'name': 'Leather Ankle Boots',
          'itemsCount': 1,
          'total': '120.00',
          'status': 'Delivered',
          'imageUrl': 'https://images.unsplash.com/photo-1608256246200-53e635b5b65f?w=200',
        },
      ];
    } else {
      return [
        {
          'id': '2650',
          'date': 'Aug 20, 2026',
          'name': 'Floral Summer Dress',
          'itemsCount': 1,
          'total': '55.00',
          'status': 'Cancelled',
          'imageUrl': 'https://images.unsplash.com/photo-1572804013427-4d7ca7268217?w=200',
        },
      ];
    }
  }
}
