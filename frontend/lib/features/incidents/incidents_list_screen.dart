import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Incidents List screen with search and filter chips
class IncidentsListScreen extends StatefulWidget {
  const IncidentsListScreen({super.key});

  @override
  State<IncidentsListScreen> createState() => _IncidentsListScreenState();
}

class _IncidentsListScreenState extends State<IncidentsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSeverity = 'All';
  String _selectedStatus = 'All';
  String _selectedDateRange = 'All Time';

  // Mock Data
  final List<Map<String, dynamic>> _allIncidents = [
    {
      'title': 'Fall Hazard',
      'location': 'Tower A, Level 5',
      'time': '2 hours ago',
      'status': 'Open',
      'severity': 'High',
      'icon': Icons.cancel_outlined,
    },
    {
      'title': 'Equipment Malfunction',
      'location': 'North Perimeter',
      'time': 'Yesterday at 3:15 PM',
      'status': 'In Progress',
      'severity': 'Medium',
      'icon': Icons.settings_outlined,
    },
    {
      'title': 'Safety Violation',
      'location': 'Main Entrance',
      'time': '3 days ago',
      'status': 'Resolved',
      'severity': 'Low',
      'icon': Icons.accessibility_new,
    },
    {
      'title': 'Fire Hazard',
      'location': 'Storage Area B',
      'time': '4 days ago',
      'status': 'Resolved',
      'severity': 'Low',
      'icon': Icons.local_fire_department_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredIncidents() {
    return _allIncidents.where((incident) {
      final matchesSearch =
          incident['title'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          incident['location'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesSeverity =
          _selectedSeverity == 'All' ||
          incident['severity'] == _selectedSeverity;
      final matchesStatus =
          _selectedStatus == 'All' || incident['status'] == _selectedStatus;

      return matchesSearch && matchesSeverity && matchesStatus;
    }).toList();
  }

  void _showFilterDialog(
    String title,
    List<String> options,
    String currentValue,
    Function(String) onSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Select $title',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          children: options.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                onSelected(option);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  option,
                  style: GoogleFonts.inter(
                    color: option == currentValue
                        ? AppColors.primaryBlue
                        : AppColors.textLightPrimary,
                    fontWeight: option == currentValue
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredIncidents = _getFilteredIncidents();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLightPrimary),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(
          'Incidents',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textLightPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by type, site...',
                hintStyle: GoogleFonts.inter(
                  color: AppColors.textLightSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textLightSecondary,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    _selectedDateRange == 'All Time'
                        ? 'Date Range'
                        : _selectedDateRange,
                    _selectedDateRange != 'All Time',
                    _pickDateRange,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'Severity: $_selectedSeverity',
                    _selectedSeverity != 'All',
                    () {
                      _showFilterDialog(
                        'Severity',
                        ['All', 'High', 'Medium', 'Low'],
                        _selectedSeverity,
                        (val) {
                          setState(() => _selectedSeverity = val);
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'Status: $_selectedStatus',
                    _selectedStatus != 'All',
                    () {
                      _showFilterDialog(
                        'Status',
                        ['All', 'Open', 'In Progress', 'Resolved'],
                        _selectedStatus,
                        (val) {
                          setState(() => _selectedStatus = val);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Incidents List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredIncidents.length,
              itemBuilder: (context, index) {
                final incident = filteredIncidents[index];
                return _buildIncidentCard(
                  icon: incident['icon'],
                  iconBgColor: Colors.grey.shade200,
                  title: incident['title'],
                  time: incident['time'],
                  location: incident['location'],
                  status: incident['status'],
                  statusColor: _getStatusColor(incident['status']),
                  onStatusTap: () {
                    _showFilterDialog(
                      'Status',
                      ['Open', 'In Progress', 'Resolved'],
                      incident['status'],
                      (val) {
                        setState(() {
                          incident['status'] = val;
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/incidents/create'),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return AppColors.riskHigh;
      case 'In Progress':
        return AppColors.riskMedium;
      case 'Resolved':
        return AppColors.riskLow;
      default:
        return AppColors.textLightSecondary;
    }
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange =
            '${picked.start.day}/${picked.start.month} - ${picked.end.day}/${picked.end.month}';
      });
    }
  }

  Widget _buildFilterChip(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : AppColors.textLightPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: isActive ? Colors.white : AppColors.textLightPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentCard({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String time,
    required String location,
    required String status,
    required Color statusColor,
    VoidCallback? onStatusTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.textLightSecondary, size: 24),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textLightSecondary,
                  ),
                ),
                Text(
                  location,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onStatusTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
