import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_theme.dart';

/// Daily Report / Create Observation screen with image picker
class CreateObservationScreen extends StatefulWidget {
  const CreateObservationScreen({super.key});

  @override
  State<CreateObservationScreen> createState() =>
      _CreateObservationScreenState();
}

class _CreateObservationScreenState extends State<CreateObservationScreen> {
  double _epiCompliance = 85;
  double _equipmentState = 9;
  double _siteClean = 7;
  double _fatigue = 4;
  int _minorIncidents = 1;
  int _majorIncidents = 0;
  final List<String> _selectedActivities = ['Maçonnerie', 'Grutage'];
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImages.add(image);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  String _formatDate(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';
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
          onPressed: () => context.go('/dashboard'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rapport Journalier',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textLightPrimary,
              ),
            ),
            Text(
              _formatDate(DateTime.now()),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textLightSecondary,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Météo & Présence
            _buildSection(
              title: 'Météo & Présence',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          label: 'Température',
                          value: '21°C',
                          icon: Icons.thermostat_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          label: 'Humidité',
                          value: '65%',
                          icon: Icons.water_drop_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          label: 'Ouvriers présents',
                          value: '15',
                          icon: Icons.groups_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          label: 'Heures travaillées',
                          value: '8',
                          icon: Icons.access_time,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Activités du Jour
            _buildSection(
              title: 'Activités du Jour',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildActivityChip('Maçonnerie'),
                  _buildActivityChip('Électricité'),
                  _buildActivityChip('Plomberie'),
                  _buildActivityChip('Grutage'),
                  _buildActivityChip('Peinture'),
                  _buildActivityChip('Fondations'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Évaluations de Sécurité
            _buildSection(
              title: 'Évaluations de Sécurité',
              child: Column(
                children: [
                  _buildSlider(
                    label: 'Conformité EPI',
                    value: _epiCompliance,
                    max: 100,
                    suffix: '%',
                    color: const Color(0xFF3B82F6),
                    onChanged: (v) => setState(() => _epiCompliance = v),
                  ),
                  _buildSlider(
                    label: 'État des équipements',
                    value: _equipmentState,
                    max: 10,
                    suffix: '/10',
                    color: const Color(0xFF3B82F6),
                    onChanged: (v) => setState(() => _equipmentState = v),
                  ),
                  _buildSlider(
                    label: 'Propreté du site',
                    value: _siteClean,
                    max: 10,
                    suffix: '/10',
                    color: const Color(0xFF3B82F6),
                    onChanged: (v) => setState(() => _siteClean = v),
                  ),
                  _buildSlider(
                    label: 'Niveau de fatigue',
                    value: _fatigue,
                    max: 10,
                    suffix: '/10',
                    color: AppColors.riskMedium,
                    onChanged: (v) => setState(() => _fatigue = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Incidents
            _buildSection(
              title: 'Incidents',
              child: Row(
                children: [
                  Expanded(
                    child: _buildIncidentCounter(
                      label: 'Incidents mineurs',
                      value: _minorIncidents,
                      color: AppColors.riskMedium,
                      onDecrement: () {
                        if (_minorIncidents > 0) {
                          setState(() => _minorIncidents--);
                        }
                      },
                      onIncrement: () => setState(() => _minorIncidents++),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildIncidentCounter(
                      label: 'Incidents graves',
                      value: _majorIncidents,
                      color: AppColors.riskHigh,
                      onDecrement: () {
                        if (_majorIncidents > 0) {
                          setState(() => _majorIncidents--);
                        }
                      },
                      onIncrement: () => setState(() => _majorIncidents++),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Notes & Photos
            _buildSection(
              title: 'Notes & Photos',
              child: Column(
                children: [
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Ajouter des notes supplémentaires...',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.textLightSecondary,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ..._selectedImages.asMap().entries.map((entry) {
                          return _buildSelectedImage(entry.key, entry.value);
                        }),
                        _buildAddPhotoButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => context.go('/observation/result'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Enregistrer',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImage(int index, XFile image) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image.path,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.image, color: Colors.grey.shade500),
                );
              },
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: () => _removeImage(index),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textLightPrimary,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textLightSecondary),
              const SizedBox(width: 8),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLightPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChip(String label) {
    final isSelected = _selectedActivities.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedActivities.remove(label);
          } else {
            _selectedActivities.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textLightPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double max,
    required String suffix,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textLightPrimary,
                ),
              ),
              Text(
                '${value.toInt()}$suffix',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: color,
              trackHeight: 6,
            ),
            child: Slider(value: value, max: max, onChanged: onChanged),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentCounter({
    required String label,
    required int value,
    required Color color,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textLightSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: AppColors.textLightSecondary,
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 8),
              Text(
                '$value',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: AppColors.textLightSecondary,
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: AppColors.textLightSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              'Ajouter',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textLightSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
