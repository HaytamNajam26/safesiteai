import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Managers List screen for Superviseur Général (Liste des Chefs)
class ManagersListScreen extends StatelessWidget {
  const ManagersListScreen({super.key});

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
          'Liste des Chefs',
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
        itemCount: _managers.length,
        itemBuilder: (context, index) {
          final manager = _managers[index];
          return _buildManagerCard(context, manager);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/managers/create'),
        backgroundColor: const Color(0xFF0055D4),
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildManagerCard(BuildContext context, Map<String, dynamic> manager) {
    return GestureDetector(
      onTap: () => context.go(
        '/managers/${manager['initials'].toString().toLowerCase()}',
      ),
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
        child: Row(
          children: [
            // Avatar
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF0055D4).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  manager['initials'],
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0055D4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manager['name'],
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    manager['email'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textLightSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.construction,
                        size: 14,
                        color: AppColors.textLightSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${manager['projects']} projets',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textLightSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textLightSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${manager['sites']} sites',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textLightSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Status indicator
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: manager['active']
                    ? AppColors.riskLow
                    : AppColors.textLightSecondary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _managers = [
    {
      'name': 'Jean Dupont',
      'initials': 'JD',
      'email': 'jean.dupont@safesite.ai',
      'projects': 3,
      'sites': 7,
      'active': true,
    },
    {
      'name': 'Marie Martin',
      'initials': 'MM',
      'email': 'marie.martin@safesite.ai',
      'projects': 2,
      'sites': 5,
      'active': true,
    },
    {
      'name': 'Pierre Bernard',
      'initials': 'PB',
      'email': 'pierre.bernard@safesite.ai',
      'projects': 4,
      'sites': 10,
      'active': true,
    },
    {
      'name': 'Sophie Leroy',
      'initials': 'SL',
      'email': 'sophie.leroy@safesite.ai',
      'projects': 1,
      'sites': 3,
      'active': false,
    },
    {
      'name': 'Luc Moreau',
      'initials': 'LM',
      'email': 'luc.moreau@safesite.ai',
      'projects': 2,
      'sites': 4,
      'active': true,
    },
  ];
}
