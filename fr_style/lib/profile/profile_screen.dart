import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';
import '../providers/user_provider.dart';
import 'orders_screen.dart';
import 'edit_profile_screen.dart';
import 'addresses_screen.dart';
import 'settings_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 22),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFFE8E8E8),
                        child: ClipOval(
                          child: Consumer<UserProvider>(
                            builder: (context, user, _) => Image.network(
                              user.profileImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.person,
                                size: 50,
                                color: AppTheme.textLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryDark,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_outlined,
                            size: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Consumer<UserProvider>(
                    builder: (context, user, _) => Column(
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: AppTheme.textLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrdersScreen()),
                        ),
                        child: _statItem('5', 'Orders'),
                      ),
                      Container(
                          height: 30,
                          width: 1,
                          color: AppTheme.dividerColor,
                          margin:
                              const EdgeInsets.symmetric(horizontal: 24)),
                      _statItem('12', 'Wishlist'),
                      Container(
                          height: 30,
                          width: 1,
                          color: AppTheme.dividerColor,
                          margin:
                              const EdgeInsets.symmetric(horizontal: 24)),
                      _statItem('3', 'Reviews'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // My Orders section
            _sectionCard(
              context,
              title: 'MY ORDERS',
              items: [
                _menuItem(
                  icon: Icons.local_shipping_outlined,
                  label: 'Active Orders',
                  badge: '2',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrdersScreen(initialIndex: 0)),
                  ),
                ),
                _menuItem(
                  icon: Icons.history_outlined,
                  label: 'Order History',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrdersScreen(initialIndex: 1)),
                  ),
                ),
                _menuItem(
                  icon: Icons.cancel_outlined,
                  label: 'Cancelled Orders',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OrdersScreen(initialIndex: 2)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Account settings
            _sectionCard(
              context,
              title: 'SETTINGS',
              items: [
                _menuItem(
                  icon: Icons.person_outline,
                  label: 'Edit Profile',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  ),
                ),
                _menuItem(
                  icon: Icons.location_on_outlined,
                  label: 'Delivery Addresses',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddressesScreen()),
                  ),
                ),
                _menuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const SettingsDetailScreen(title: 'Notifications')),
                  ),
                ),
                _menuItem(
                  icon: Icons.lock_outline,
                  label: 'Change Password',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const SettingsDetailScreen(title: 'Change Password')),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Support
            _sectionCard(
              context,
              title: 'SUPPORT',
              items: [
                _menuItem(
                  icon: Icons.help_outline,
                  label: 'Help Center',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const SettingsDetailScreen(title: 'Help Center')),
                  ),
                ),
                _menuItem(
                  icon: Icons.info_outline,
                  label: 'About FR Style\'s',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SettingsDetailScreen(
                            title: 'About FR Style\'s')),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Sign Out
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.logout,
                      size: 20, color: Colors.redAccent),
                ),
                title: Text(
                  'Sign Out',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryDark,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              fontSize: 12, color: AppTheme.textLight),
        ),
      ],
    );
  }

  Widget _sectionCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textLight,
                letterSpacing: 1.2,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? badge,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppTheme.primaryDark),
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios,
              size: 14, color: AppTheme.textLight),
        ],
      ),
      onTap: onTap,
    );
  }
}
