import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Project Detail screen to view and edit project info
/// Allows assigning managers and viewing sites
class ProjectDetailScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late Map<String, dynamic> _project;
  late List<Map<String, dynamic>> _assignedManagers;
  late List<Map<String, dynamic>> _sites;

  @override
  void initState() {
    super.initState();
    _loadProjectData();
  }

  void _loadProjectData() {
    // Mock data based on projectId
    _project = {
      'id': widget.projectId,
      'name': 'Projet Grand Paris - Lot B2',
      'location': 'Paris 15e',
      'status': 'Active',
      'startDate': '15/01/2024',
      'endDate': '30/12/2025',
      'description':
          'Construction de la nouvelle ligne de métro avec 5 stations et tunnels associés.',
    };

    _assignedManagers = [
      {
        'id': '1',
        'name': 'Jean Dupont',
        'initials': 'JD',
        'role': 'Chef Principal',
      },
      {
        'id': '2',
        'name': 'Marie Martin',
        'initials': 'MM',
        'role': 'Chef Adjoint',
      },
    ];

    _sites = [
      {
        'id': '1',
        'name': 'Site Alpha - Fondations',
        'status': 'Active',
        'risk': 'low',
      },
      {
        'id': '2',
        'name': 'Site Beta - Structure',
        'status': 'Active',
        'risk': 'medium',
      },
      {
        'id': '3',
        'name': 'Site Gamma - Finitions',
        'status': 'Pending',
        'risk': 'high',
      },
      {
        'id': '4',
        'name': 'Site Delta - Tunnels',
        'status': 'Active',
        'risk': 'low',
      },
      {
        'id': '5',
        'name': 'Station Centrale',
        'status': 'Active',
        'risk': 'medium',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _project['status'] == 'Active'
        ? AppColors.riskLow
        : _project['status'] == 'On Hold'
        ? AppColors.riskMedium
        : AppColors.textLightSecondary;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLightPrimary),
          onPressed: () => context.go('/projects'),
        ),
        title: Text(
          'Détails du Chantier',
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
            _buildProjectHeader(statusColor),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Chefs Assignés',
              icon: Icons.people,
              onAdd: () => _showAssignManagerDialog(context),
              child: _buildAssignedManagers(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Sites (${_sites.length})',
              icon: Icons.location_on,
              onAdd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ajouter un site - Coming soon'),
                  ),
                );
              },
              child: _buildSites(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeader(Color statusColor) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _project['name'],
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLightPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  _project['status'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on_outlined, _project['location']),
          const SizedBox(height: 8),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            '${_project['startDate']} - ${_project['endDate']}',
          ),
          const SizedBox(height: 16),
          Text(
            _project['description'],
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textLightSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
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

  Widget _buildAssignedManagers() {
    return Column(
      children: _assignedManagers.map((manager) {
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0055D4).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    manager['initials'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0055D4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      manager['name'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLightPrimary,
                      ),
                    ),
                    Text(
                      manager['role'],
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
                    _assignedManagers.remove(manager);
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

  Widget _buildSites() {
    return Column(
      children: _sites.map((site) {
        final Color riskColor = site['risk'] == 'high'
            ? AppColors.riskHigh
            : site['risk'] == 'medium'
            ? AppColors.riskMedium
            : AppColors.riskLow;

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
              Container(
                width: 8,
                height: 40,
                decoration: BoxDecoration(
                  color: riskColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
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
                      site['status'],
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
                    _sites.remove(site);
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

  void _showAssignManagerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Assigner un Chef',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF0055D4).withValues(alpha: 0.1),
                child: Text(
                  'PB',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0055D4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text('Pierre Bernard'),
              subtitle: Text('Disponible'),
              onTap: () {
                setState(() {
                  _assignedManagers.add({
                    'id': '3',
                    'name': 'Pierre Bernard',
                    'initials': 'PB',
                    'role': 'Chef Sécurité',
                  });
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF0055D4).withValues(alpha: 0.1),
                child: Text(
                  'SL',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0055D4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text('Sophie Leroy'),
              subtitle: Text('Disponible'),
              onTap: () {
                setState(() {
                  _assignedManagers.add({
                    'id': '4',
                    'name': 'Sophie Leroy',
                    'initials': 'SL',
                    'role': 'Chef Adjoint',
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
