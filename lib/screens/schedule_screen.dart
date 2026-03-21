import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedWeekday = DateTime.now().weekday;
  ClassLevel? _filterLevel;

  static const List<String> _weekdayLabels = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  List<KarateClass> get _filteredClasses {
    return sampleClasses.where((c) {
      final dayMatch = c.weekdays.contains(_selectedWeekday);
      final levelMatch = _filterLevel == null || c.level == _filterLevel;
      return dayMatch && levelMatch;
    }).toList()..sort(
      (a, b) => (a.time.hour * 60 + a.time.minute).compareTo(
        b.time.hour * 60 + b.time.minute,
      ),
    );
  }

  void _showClassDetail(BuildContext context, KarateClass karateClass) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ClassDetailSheet(karateClass: karateClass),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build week dates around today
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final weekDates = List.generate(7, (i) => monday.add(Duration(days: i)));

    return Scaffold(
      body: Column(
        children: [
          // ── Header ───────────────────────────────────────────
          GradientHeader(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CLASS SCHEDULE',
                      style: GoogleFonts.oswald(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'March 2026',
                      style: GoogleFonts.barlow(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Week Strip ────────────────────────────────────────
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                final weekday = i + 1;
                final date = weekDates[i];
                final isSelected = _selectedWeekday == weekday;
                return GestureDetector(
                  onTap: () => setState(() => _selectedWeekday = weekday),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.red : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _weekdayLabels[i],
                          style: GoogleFonts.barlow(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white70
                                : AppColors.gray500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : AppColors.gray700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          Container(height: 1, color: AppColors.gray300),

          // ── Filter Tabs ───────────────────────────────────────
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterTab(
                    label: 'All Classes',
                    selected: _filterLevel == null,
                    onTap: () => setState(() => _filterLevel = null),
                  ),
                  const SizedBox(width: 6),
                  _FilterTab(
                    label: 'Beginner',
                    selected: _filterLevel == ClassLevel.beginner,
                    onTap: () =>
                        setState(() => _filterLevel = ClassLevel.beginner),
                  ),
                  const SizedBox(width: 6),
                  _FilterTab(
                    label: 'Intermediate',
                    selected: _filterLevel == ClassLevel.intermediate,
                    onTap: () =>
                        setState(() => _filterLevel = ClassLevel.intermediate),
                  ),
                  const SizedBox(width: 6),
                  _FilterTab(
                    label: 'Advanced',
                    selected: _filterLevel == ClassLevel.advanced,
                    onTap: () =>
                        setState(() => _filterLevel = ClassLevel.advanced),
                  ),
                  const SizedBox(width: 6),
                  _FilterTab(
                    label: 'Kids',
                    selected: _filterLevel == ClassLevel.kids,
                    onTap: () => setState(() => _filterLevel = ClassLevel.kids),
                  ),
                ],
              ),
            ),
          ),

          // ── Classes List ──────────────────────────────────────
          Expanded(
            child: _filteredClasses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🥋', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          'No classes on this day',
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    itemCount: _filteredClasses.length,
                    itemBuilder: (_, i) => ClassListTile(
                      karateClass: _filteredClasses[i],
                      showBookButton: true,
                      onTap: () =>
                          _showClassDetail(context, _filteredClasses[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.red : Colors.transparent,
          border: Border.all(
            color: selected ? AppColors.red : AppColors.gray300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.barlow(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.gray700,
          ),
        ),
      ),
    );
  }
}

class _ClassDetailSheet extends StatefulWidget {
  final KarateClass karateClass;

  const _ClassDetailSheet({required this.karateClass});

  @override
  State<_ClassDetailSheet> createState() => _ClassDetailSheetState();
}

class _ClassDetailSheetState extends State<_ClassDetailSheet> {
  bool _booked = false;

  @override
  void initState() {
    super.initState();
    _booked = widget.karateClass.isBooked;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.karateClass;
    final spotsLeft = c.maxStudents - c.enrolledStudents;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  c.name.toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray900,
                  ),
                ),
              ),
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: c.levelColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _detailRow('🕐', 'Time', c.timeString),
          _detailRow('📍', 'Dojo', c.dojo),
          _detailRow('👤', 'Instructor', c.instructor),
          _detailRow('⏱', 'Duration', '${c.durationMinutes} minutes'),
          _detailRow('👥', 'Spots Left', '$spotsLeft of ${c.maxStudents}'),
          const SizedBox(height: 8),
          // Progress bar for enrollment
          LinearProgressIndicator(
            value: c.enrolledStudents / c.maxStudents,
            backgroundColor: AppColors.gray200,
            color: spotsLeft <= 3 ? AppColors.red : AppColors.blue,
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() => _booked = !_booked);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _booked ? '✅ Class booked!' : '❌ Booking cancelled',
                    ),
                    backgroundColor: _booked
                        ? AppColors.success
                        : AppColors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _booked ? AppColors.gray300 : AppColors.red,
                foregroundColor: _booked ? AppColors.gray700 : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _booked ? 'Cancel Booking' : 'Book This Class',
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _detailRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.barlow(
              fontSize: 13,
              color: AppColors.gray500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.barlow(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
          ),
        ],
      ),
    );
  }
}
