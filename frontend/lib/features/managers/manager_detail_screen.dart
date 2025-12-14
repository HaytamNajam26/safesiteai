import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Manager Detail screen to view and edit manager info
/// Allows assigning projects and sites to the manager
class ManagerDetailScreen extends StatefulWidget {
  final String managerId;

  const ManagerDetailScreen({super.key, required this.managerId});

  @override
  State<ManagerDetailScreen> createState() => _ManagerDetailScreenState();
}

class _ManagerDetailScreenState extends State<ManagerDetailScreen> {
  // Mock data - in real app, fetch by managerId
  late Map<String, dynamic> _manager;
  late List<Map<String, dynamic>> _assignedProjects;
  late List<Map<String, dynamic>> _assignedSites;

  @override
  void initState() {
    super.initState();
    _loadManagerData();
  }

  void _loadManagerData() {
    // Mock data based on managerId
    _manager = {
      'id': widget.managerId,
      'name': 'Jean Dupont',
      'initials': 'JD',
      'email': 'jean.dupont@safesite.ai',
      'phone': '+33 6 12 34 56 78',
      'role': 'Chef de Chantier',
      'active': true,
    };

    _assignedProjects = [
      {'id': '1', 'name': 'Projet Grand Paris - Lot B2', 'status': 'Active'},
      {'id': '2', 'name': 'Tour Trinity', 'status': 'Active'},
      {'id': '3', 'name': 'Metro Ligne 15', 'status': 'On Hold'},
    ];

    _assignedSites = [
      {'id': '1', 'name': 'Site Alpha - Fondations', 'project': 'Grand Paris'},
      {'id': '2', 'name': 'Site Beta - Structure', 'project': 'Grand Paris'},
      {'id': '3', 'name': 'Tour Trinity - Zone A', 'project': 'Tour Trinity'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLightPrimary),
          onPressed: () => context.go('/managers'),
        ),
        title: Text(
          'Détails du Chef',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF0055D4)),
            onPressed: () {
              // TODO: Navigate to edit mode
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mode édition - Coming soon')),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Chantiers Assignés',
              icon: Icons.construction,
              onAdd: () => _showAssignProjectDialog(context),
              child: _buildAssignedProjects(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Sites Assignés',
              icon: Icons.location_on,
              onAdd: () => _showAssignSiteDialog(context),
              child: _buildAssignedSites(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF0055D4).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _manager['initials'],
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0055D4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            _manager['name'],
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textLightPrimary,
            ),
          ),
          const SizedBox(height: 4),
          // Role badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0055D4).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Text(
              _manager['role'],
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0055D4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Contact info
          _buildInfoRow(Icons.email_outlined, _manager['email']),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone_outlined, _manager['phone']),
          const SizedBox(height: 16),
          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _manager['active']
                      ? AppColors.riskLow
                      : AppColors.textLightSecondary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _manager['active'] ? 'Actif' : 'Inactif',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _manager['active']
                      ? AppColors.riskLow
                      : AppColors.textLightSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: AppColors.textLightSecondary),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textLightSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required VoidCallback onAdd,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF0055D4)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLightPrimary,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onAdd,
              icon: Icon(
                Icons.add_circle_outline,
                color: const Color(0xFF0055D4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildAssignedProjects() {
    return Column(
      children: _assignedProjects.map((project) {
        final Color statusColor = project['status'] == 'Active'
            ? AppColors.riskLow
            : project['status'] == 'On Hold'
            ? AppColors.riskMedium
            : AppColors.textLightSecondary;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  project['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textLightPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  project['status'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: AppColors.riskHigh,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _assignedProjects.remove(project);
                  });
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAssignedSites() {
    return Column(
      children: _assignedSites.map((site) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      site['name'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textLightPrimary,
                      ),
                    ),
                    Text(
                      site['project'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textLightSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: AppColors.riskHigh,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _assignedSites.remove(site);
                  });
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showAssignProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Assigner un Chantier',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.construction, color: const Color(0xFF0055D4)),
              title: Text('Port de Gennevilliers'),
              onTap: () {
                setState(() {
                  _assignedProjects.add({
                    'id': '4',
                    'name': 'Port de Gennevilliers',
                    'status': 'Active',
                  });
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.construction, color: const Color(0xFF0055D4)),
              title: Text('Nouveau Stade'),
              onTap: () {
                setState(() {
                  _assignedProjects.add({
                    'id': '5',
                    'name': 'Nouveau Stade',
                    'status': 'Active',
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _showAssignSiteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Assigner un Site',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: const Color(0xFF0055D4)),
              title: Text('Site Gamma - Finitions'),
              subtitle: Text('Grand Paris'),
              onTap: () {
                setState(() {
                  _assignedSites.add({
                    'id': '4',
                    'name': 'Site Gamma - Finitions',
                    'project': 'Grand Paris',
                  });
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: const Color(0xFF0055D4)),
              title: Text('Zone B - Parking'),
              subtitle: Text('Tour Trinity'),
              onTap: () {
                setState(() {
                  _assignedSites.add({
                    'id': '5',
                    'name': 'Zone B - Parking',
                    'project': 'Tour Trinity',
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
        ],
      ),
    );
  }
}
