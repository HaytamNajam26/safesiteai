import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Create Project screen for Superviseur Général
/// Based on the provided mockup image
class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _projectNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sitesCountController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedManager;

  final List<String> _managers = [
    'Jean Dupont',
    'Marie Martin',
    'Pierre Bernard',
    'Sophie Leroy',
  ];

  @override
  void dispose() {
    _projectNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _sitesCountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: const Color(0xFF0055D4)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day}/${date.month}/${date.year}';
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
          onPressed: () => context.go('/admin-dashboard'),
        ),
        title: Text(
          'Créer un Chantier',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
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
            // Project Name
            _buildLabel('Nom du Chantier'),
            _buildTextField(
              controller: _projectNameController,
              hint: 'e.g. Downtown Tower Construction',
            ),
            const SizedBox(height: 20),

            // Location
            _buildLabel('Location'),
            _buildTextField(
              controller: _locationController,
              hint: 'Enter project location',
              suffixIcon: Icons.map_outlined,
            ),
            const SizedBox(height: 20),

            // Start Date
            _buildLabel('Start Date'),
            _buildDateField(
              value: _formatDate(_startDate),
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 20),

            // End Date
            _buildLabel('End Date'),
            _buildDateField(
              value: _formatDate(_endDate),
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(height: 20),

            // Site Manager
            _buildLabel('Site Manager'),
            _buildDropdownField(),
            const SizedBox(height: 20),

            // Description
            _buildLabel('Description'),
            _buildTextArea(
              controller: _descriptionController,
              hint: 'Add a short description of the project',
            ),
            const SizedBox(height: 20),

            // Estimated number of sites
            _buildLabel('Estimated number of sites'),
            _buildTextField(
              controller: _sitesCountController,
              hint: 'e.g. 5',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 100), // Space for bottom buttons
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(context),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textLightPrimary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textLightSecondary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: const Color(0xFF0055D4), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: const Color(0xFF0055D4))
            : null,
      ),
    );
  }

  Widget _buildDateField({required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: value == 'Select date'
                    ? AppColors.textLightSecondary
                    : AppColors.textLightPrimary,
              ),
            ),
            Icon(Icons.calendar_today_outlined, color: const Color(0xFF0055D4)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedManager,
          hint: Text(
            'Select a manager',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textLightSecondary,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textLightSecondary,
          ),
          items: _managers.map((String manager) {
            return DropdownMenuItem<String>(
              value: manager,
              child: Text(manager, style: GoogleFonts.inter(fontSize: 16)),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedManager = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textLightSecondary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: const Color(0xFF0055D4), width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => context.go('/admin-dashboard'),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0055D4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save project
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Project created successfully!'),
                      backgroundColor: AppColors.riskLow,
                    ),
                  );
                  context.go('/admin-dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0055D4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
                child: Text(
                  'Create Project',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
