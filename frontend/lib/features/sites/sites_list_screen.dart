import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/site_service.dart';
import '../../core/models/site.dart';
import '../../core/services/observation_service.dart';
import '../../core/models/observation.dart';

/// Sites List screen - "Mes Chantiers" for Chef de Chantier
class SitesListScreen extends StatefulWidget {
  final String title;
  final String? backRoute;
  final bool isAdmin;

  const SitesListScreen({
    super.key,
    this.title = 'Mes Sites',
    this.backRoute,
    this.isAdmin = false, // defaults to false
  });

  @override
  State<SitesListScreen> createState() => _SitesListScreenState();
}

class _SitesListScreenState extends State<SitesListScreen> {
  List<Site> _sites = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSites();
  }

  Future<void> _loadSites() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final sites = await SiteService.getAllSites();
      setState(() {
        _sites = sites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<String?> _getLastObservation(int siteId) async {
    try {
      final observations = await ObservationService.getObservationsBySite(siteId);
      if (observations.isEmpty) {
        return 'Aucune observation';
      }
      // Trier par date décroissante pour obtenir la plus récente
      observations.sort((a, b) {
        final dateA = a.observationDate ?? a.createdAt;
        final dateB = b.observationDate ?? b.createdAt;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateB.compareTo(dateA);
      });
      
      final lastObs = observations.first;
      final obsDate = lastObs.observationDate ?? lastObs.createdAt;
      if (obsDate == null) {
        return 'Aucune observation';
      }
      final now = DateTime.now();
      final diff = now.difference(obsDate);
      
      if (diff.inDays == 0) {
        return "Aujourd'hui à ${obsDate.hour.toString().padLeft(2, '0')}:${obsDate.minute.toString().padLeft(2, '0')}";
      } else if (diff.inDays == 1) {
        return "Hier à ${obsDate.hour.toString().padLeft(2, '0')}:${obsDate.minute.toString().padLeft(2, '0')}";
      } else {
        return "Il y a ${diff.inDays} jours";
      }
    } catch (e) {
      return 'Aucune observation';
    }
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
          onPressed: () => context.go(widget.backRoute ?? '/dashboard'),
        ),
        title: Text(
          widget.title,
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
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.textLightPrimary),
            onPressed: _loadSites,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Erreur: $_error',
                        style: GoogleFonts.inter(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadSites,
                        child: const Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : _sites.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.construction,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun site trouvé',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ajoutez un site pour commencer',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadSites,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _sites.length,
                        itemBuilder: (context, index) {
                          final site = _sites[index];
                          return FutureBuilder<String?>(
                            future: _getLastObservation(site.id ?? 0),
                            builder: (context, snapshot) {
                              final lastObservation = snapshot.data ?? 'Aucune observation';
                              final hasRisk = site.riskScore != null && site.riskScore! > 0;
                              final riskIcon = hasRisk && (site.riskScore ?? 0) > 7
                                  ? Icons.local_fire_department
                                  : hasRisk && (site.riskScore ?? 0) > 4
                                      ? Icons.warning
                                      : hasRisk
                                          ? Icons.bolt
                                          : null;
                              final riskColor = hasRisk && (site.riskScore ?? 0) > 7
                                  ? AppColors.riskHigh
                                  : hasRisk && (site.riskScore ?? 0) > 4
                                      ? AppColors.riskMedium
                                      : hasRisk
                                          ? AppColors.riskLow
                                          : null;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildSiteCard(
                                  context: context,
                                  site: site,
                                  lastObservation: lastObservation,
                                  riskIcon: riskIcon,
                                  riskColor: riskColor,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isAdmin) {
            context.push('/sites/create').then((_) => _loadSites());
          } else {
            context.go('/observation/new');
          }
        },
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildSiteCard({
    required BuildContext context,
    required Site site,
    required String lastObservation,
    IconData? riskIcon,
    Color? riskColor,
  }) {
    final phase = site.siteType ?? 'Non spécifié';
    const phaseColor = Color(0xFF3B82F6);
    
    return GestureDetector(
      onTap: widget.isAdmin
          ? null
          : () => context.pushNamed(
                'siteDetail',
                pathParameters: {'id': site.id.toString()},
              ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                    site.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightPrimary,
                    ),
                  ),
                ),
                if (riskIcon != null && riskColor != null)
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: riskColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(riskIcon, color: riskColor, size: 24),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: phaseColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                phase,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: phaseColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dernière observation: $lastObservation',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textLightSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.add_box_outlined,
                  label: 'Ajouter observati...',
                  onTap: () => context.go('/observation/new'),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  context: context,
                  icon: Icons.visibility_outlined,
                  label: 'Voir incidents',
                  onTap: () => context.go('/incidents'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.textLightPrimary),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textLightPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
