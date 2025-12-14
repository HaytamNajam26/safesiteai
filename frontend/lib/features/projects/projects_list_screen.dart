import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Projects List screen for Superviseur Général (Liste des Chantiers)
class ProjectsListScreen extends StatelessWidget {
  const ProjectsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLightPrimary),
          onPressed: () => context.go('/admin-dashboard'),
        ),
        title: Text(
          'Liste des Chantiers',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textLightPrimary),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return _buildProjectCard(context, project);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/projects/create'),
        backgroundColor: const Color(0xFF0055D4),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    final Color statusColor = project['status'] == 'Active'
        ? AppColors.riskLow
        : project['status'] == 'On Hold'
        ? AppColors.riskMedium
        : AppColors.textLightSecondary;

    return GestureDetector(
      onTap: () => context.go('/projects/${project['sites']}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project['name'],
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    project['status'],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.textLightSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  project['location'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: AppColors.textLightSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  project['manager'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textLightSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${project['sites']} sites',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _projects = [
    {
      'name': 'Projet Grand Paris - Lot B2',
      'location': 'Paris 15e',
      'manager': 'Jean Dupont',
      'sites': 5,
      'status': 'Active',
    },
    {
      'name': 'Tour Trinity',
      'location': 'La Défense',
      'manager': 'Marie Martin',
      'sites': 3,
      'status': 'Active',
    },
    {
      'name': 'Réhabilitation Hôpital Necker',
      'location': 'Paris 6e',
      'manager': 'Pierre Bernard',
      'sites': 8,
      'status': 'On Hold',
    },
    {
      'name': 'Metro Ligne 15',
      'location': 'Boulogne',
      'manager': 'Sophie Leroy',
      'sites': 12,
      'status': 'Active',
    },
    {
      'name': 'Port de Gennevilliers',
      'location': 'Gennevilliers',
      'manager': 'Jean Dupont',
      'sites': 2,
      'status': 'Completed',
    },
  ];
}
