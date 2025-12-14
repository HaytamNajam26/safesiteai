import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Admin Dashboard screen for Superviseur Général
/// Based on dashboard_admin/code.html mockup
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundLight,
      drawer: _buildNavigationDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildAppBar(),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKPIGrid(),
                    const SizedBox(height: 32),
                    _buildNonConformitiesSection(),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF0055D4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      size: 36,
                      color: const Color(0xFF0055D4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SafeSite AI',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Superviseur Général',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Menu Items
            _buildDrawerItem(
              context: context,
              icon: Icons.dashboard,
              label: 'Dashboard',
              route: '/admin-dashboard',
              isSelected: true,
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.construction,
              label: 'Liste des Chantiers',
              route: '/projects',
              isSelected: false,
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.location_on,
              label: 'Liste des Sites',
              route:
                  '/sites?title=Tous les Sites&backRoute=/admin-dashboard&isAdmin=true',
              isSelected: false,
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.people,
              label: 'Liste des Chefs',
              route: '/managers',
              isSelected: false,
            ),
            const Divider(),
            _buildDrawerItem(
              context: context,
              icon: Icons.logout,
              label: 'Déconnexion',
              route: '/login',
              isSelected: false,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required bool isSelected,
    bool isDestructive = false,
  }) {
    final Color itemColor = isDestructive
        ? AppColors.riskHigh
        : isSelected
        ? const Color(0xFF0055D4)
        : AppColors.textLightPrimary;

    return ListTile(
      leading: Icon(icon, color: itemColor),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: itemColor,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF0055D4).withValues(alpha: 0.1),
      onTap: () {
        Navigator.pop(context); // Close drawer
        context.go(route);
      },
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hamburger Menu Button - uses _scaffoldKey
          IconButton(
            icon: const Icon(Icons.menu, size: 28),
            color: AppColors.textLightPrimary,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Dashboard',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textLightPrimary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(
                Icons.account_circle,
                size: 32,
                color: AppColors.textLightPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildKPICard(
          icon: Icons.foundation,
          label: 'Total Projects',
          value: '128',
          isAlert: false,
        ),
        _buildKPICard(
          icon: Icons.location_on,
          label: 'Total Sites',
          value: '34',
          isAlert: false,
        ),
        _buildKPICard(
          icon: Icons.manage_accounts,
          label: 'Active Managers',
          value: '16',
          isAlert: false,
        ),
        _buildKPICard(
          icon: Icons.warning,
          label: "Today's Alerts",
          value: '5',
          isAlert: true,
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required IconData icon,
    required String label,
    required String value,
    required bool isAlert,
  }) {
    final Color accentColor = isAlert
        ? AppColors.riskMedium
        : AppColors.textLightSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: isAlert
            ? Border.all(
                color: AppColors.riskMedium.withValues(alpha: 0.8),
                width: 2,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: accentColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: accentColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textLightPrimary,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNonConformitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Non-Conformities',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _buildNonConformityItem(
          icon: Icons.engineering,
          title: 'No Helmet Detected',
          subtitle: 'Site A / Project Phoenix',
          time: '10:45 AM',
          isCritical: true,
        ),
        const SizedBox(height: 12),
        _buildNonConformityItem(
          icon: Icons.warning,
          title: 'No Vest Detected',
          subtitle: 'Site C / Skyscraper Initiative',
          time: '10:42 AM',
          isCritical: false,
        ),
        const SizedBox(height: 12),
        _buildNonConformityItem(
          icon: Icons.warning,
          title: 'Proximity Breach',
          subtitle: 'Site B / Metro Tunnel',
          time: '09:15 AM',
          isCritical: false,
        ),
      ],
    );
  }

  Widget _buildNonConformityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isCritical,
  }) {
    final Color accentColor = isCritical
        ? AppColors.riskHigh
        : AppColors.riskMedium;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: accentColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLightPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textLightSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.go('/projects/create'),
      backgroundColor: const Color(0xFF0055D4),
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 32),
    );
  }
}
