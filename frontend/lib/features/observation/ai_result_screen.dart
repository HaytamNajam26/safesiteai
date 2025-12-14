import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

/// AI Result screen showing risk analysis with circular gauge
class AIResultScreen extends StatelessWidget {
  const AIResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLightPrimary),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(
          'Analyse du Risque',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Circular Gauge
            _buildCircularGauge(),
            const SizedBox(height: 16),
            // Risk Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.riskHigh.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Risque Élevé',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.riskHigh,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Main Factors
            _buildMainFactors(),
            const SizedBox(height: 32),
            // Recommendations
            _buildRecommendations(),
            const SizedBox(height: 40),
            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Compris',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularGauge() {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: _CircularGaugePainter(value: 82),
        child: Center(
          child: Text(
            '82',
            style: GoogleFonts.inter(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: AppColors.riskHigh,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainFactors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facteurs Principaux',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _buildFactorCard(
          icon: Icons.security,
          iconColor: AppColors.riskMedium,
          title: 'Équipement de Protection (EPI)',
          subtitle: 'Conformité 72% (Objectif > 90%)',
        ),
        const SizedBox(height: 8),
        _buildFactorCard(
          icon: Icons.thermostat,
          iconColor: AppColors.riskHigh,
          title: 'Conditions Météorologiques',
          subtitle: 'Température 42°C (Seuil > 40°C)',
        ),
      ],
    );
  }

  Widget _buildFactorCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
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
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommandations',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _buildRecommendationItem(
          'Rappel immédiat sur le port du casque à toute l\'équipe sur la zone C.',
        ),
        const SizedBox(height: 12),
        _buildRecommendationItem(
          'Augmenter la fréquence des pauses hydratation à 15 minutes toutes les heures.',
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.textLightSecondary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textLightPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final int value;

  _CircularGaugePainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = AppColors.riskHigh
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (value / 100) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
