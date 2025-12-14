import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Chef Dashboard screen matching dashboard_chef/code.html mockup
class ChefDashboardScreen extends StatefulWidget {
  const ChefDashboardScreen({super.key});

  @override
  State<ChefDashboardScreen> createState() => _ChefDashboardScreenState();
}

class _ChefDashboardScreenState extends State<ChefDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedSite = 'Site A';

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
                    _buildRiskScoreSection(),
                    const SizedBox(height: 16),
                    _buildWeatherWidget(),
                    const SizedBox(height: 24),
                    _buildMySitesSection(context),
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
              decoration: BoxDecoration(color: const Color(0xFF3B82F6)),
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
                      color: const Color(0xFF3B82F6),
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
                    'Chef de Chantier',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Menu Items - Scrollable
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 8),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    route: '/dashboard',
                    isSelected: true,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.location_on,
                    label: 'Mes Sites',
                    route: '/sites',
                    isSelected: false,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.warning_amber,
                    label: 'Incidents',
                    route: '/incidents',
                    isSelected: false,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.description,
                    label: 'Rapports',
                    route: '/reports',
                    isSelected: false,
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.add_a_photo,
                    label: 'Nouvelle Observation',
                    route: '/observation/new',
                    isSelected: false,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.analytics,
                    label: 'Analyse du Risque',
                    route: '/observation/result',
                    isSelected: false,
                  ),
                ],
              ),
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
            const SizedBox(height: 16),
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
        ? const Color(0xFF3B82F6)
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
      selectedTileColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
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
        color: AppColors.backgroundLight.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Hamburger Menu Button
          IconButton(
            icon: const Icon(Icons.menu, size: 28),
            color: AppColors.textLightPrimary,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: 8),
          Icon(Icons.security, color: AppColors.primaryBlue, size: 30),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'SafeSite AI',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textLightPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSite,
                icon: Icon(
                  Icons.expand_more,
                  color: AppColors.textLightPrimary,
                  size: 20,
                ),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textLightPrimary,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedSite = newValue;
                    });
                  }
                },
                items: <String>['Site A', 'Site B']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskScoreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Score de risque du jour',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Risque de niveau moyen',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textLightPrimary,
                    ),
                  ),
                  Text(
                    '65',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.riskMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.full),
                child: LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.riskMedium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Risque élevé dû aux vents forts et à l\'utilisation de la grue.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textLightSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.grain, // rainy icon
                  size: 24,
                  color: AppColors.textLightSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Météo sur le site',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textLightPrimary,
                ),
              ),
            ],
          ),
          Text(
            '15°C, Pluie légère',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textLightSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMySitesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes Sites',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 12),
        _buildSiteCard(
          context: context,
          name: 'Site Alpha',
          location: 'Paris 15e',
          riskLevel: 'high',
          riskLabel: 'Élevé',
          icon: Icons.gpp_bad,
        ),
        const SizedBox(height: 8),
        _buildSiteCard(
          context: context,
          name: 'Site Beta',
          location: 'Clichy',
          riskLevel: 'low',
          riskLabel: 'Faible',
          icon: Icons.health_and_safety,
        ),
      ],
    );
  }

  Widget _buildSiteCard({
    required BuildContext context,
    required String name,
    required String location,
    required String riskLevel,
    required String riskLabel,
    required IconData icon,
  }) {
    final Color riskColor = riskLevel == 'high'
        ? AppColors.riskHigh
        : riskLevel == 'medium'
        ? AppColors.riskMedium
        : AppColors.riskLow;

    final Color riskBgColor = riskLevel == 'high'
        ? AppColors.riskHigh.withValues(alpha: 0.1)
        : riskLevel == 'medium'
        ? AppColors.riskMedium.withValues(alpha: 0.1)
        : AppColors.riskLow.withValues(alpha: 0.1);

    return GestureDetector(
      onTap: () => context.go('/sites'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: riskBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: riskColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textLightPrimary,
                    ),
                  ),
                  Text(
                    location,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textLightSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: riskBgColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text(
                riskLabel,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: FloatingActionButton.extended(
        onPressed: () => context.go('/observation/new'),
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        icon: const Icon(Icons.add_a_photo, size: 28),
        label: Text(
          'Nouvelle observation',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
