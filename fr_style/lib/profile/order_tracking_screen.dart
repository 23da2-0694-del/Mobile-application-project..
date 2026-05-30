import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../models/order_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Track Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: 24),
            _buildTrackingTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final firstItem = order.items.isNotEmpty ? order.items.first : null;
    final itemsCount = order.items.fold(0, (sum, item) => sum + item.quantity);
    final title = firstItem != null 
      ? '${firstItem.product.name}${order.items.length > 1 ? ' + ${order.items.length - 1} more' : ''}'
      : 'Empty Order';
    final imageUrl = firstItem?.product.imageUrl ?? 'https://via.placeholder.com/150';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: AppTheme.dividerColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Order #${order.id.length > 6 ? order.id.substring(order.id.length - 6) : order.id}',
                  style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textLight),
                ),
                const SizedBox(height: 4),
                Text(
                  '$itemsCount items • \$${order.total.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryDark, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final statusIndex = _getStatusIndex(order.status);
    
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text('Order Status', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 24),
          _buildTimelineStep('Order Placed', 'We have received your order', true, statusIndex >= 0),
          _buildTimelineStep('Processing', 'Your order is being prepared', statusIndex >= 1, statusIndex >= 1),
          _buildTimelineStep('Shipped', 'Your item is on the way', statusIndex >= 2, statusIndex >= 2),
          _buildTimelineStep('Delivered', 'Item has been delivered', statusIndex >= 3, statusIndex >= 3, isLast: true),
        ],
      ),
    );
  }

  int _getStatusIndex(String status) {
    switch (status.toLowerCase()) {
      case 'processing': return 1;
      case 'shipping': return 2;
      case 'shipped': return 2;
      case 'delivered': return 3;
      case 'cancelled': return -1;
      default: return 0; // order placed
    }
  }

  Widget _buildTimelineStep(String title, String subtitle, bool isCompleted, bool isActive, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? AppTheme.primaryDark : Colors.transparent,
                  border: Border.all(
                    color: isActive ? AppTheme.primaryDark : AppTheme.dividerColor,
                    width: 2,
                  ),
                ),
                child: isActive 
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? AppTheme.primaryDark : AppTheme.dividerColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive ? AppTheme.textDark : AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
                if (!isLast) const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
