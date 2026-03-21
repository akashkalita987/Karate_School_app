import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = sampleStudent;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GradientHeader(
              colors: const [
                AppColors.blue,
                AppColors.blueDark,
                AppColors.redDark,
              ],
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MY PROGRESS',
                        style: GoogleFonts.oswald(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'Track your journey to black belt',
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
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Overall Score ──────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.redDark, AppColors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OVERALL SCORE',
                                style: GoogleFonts.barlow(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white60,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '78/100',
                                style: GoogleFonts.oswald(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Good standing · Keep pushing!',
                                style: GoogleFonts.barlow(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 0.78,
                                strokeWidth: 8,
                                backgroundColor: Colors.white24,
                                color: AppColors.gold,
                              ),
                              Text(
                                '78%',
                                style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const SectionHeader(title: 'SKILL BREAKDOWN'),
                  const SizedBox(height: 12),

                  // ── Skill Bars ─────────────────────────────────
                  ...[
                    _SkillBar(skill: 'Kata', value: 0.85, color: AppColors.red),
                    _SkillBar(
                      skill: 'Kihon',
                      value: 0.70,
                      color: AppColors.blue,
                    ),
                    _SkillBar(
                      skill: 'Kumite',
                      value: 0.60,
                      color: AppColors.redLight,
                    ),
                    _SkillBar(
                      skill: 'Flexibility',
                      value: 0.75,
                      color: AppColors.blueLight,
                    ),
                    _SkillBar(
                      skill: 'Strength',
                      value: 0.80,
                      color: AppColors.red,
                    ),
                    _SkillBar(
                      skill: 'Speed',
                      value: 0.65,
                      color: AppColors.blue,
                    ),
                  ],

                  const SizedBox(height: 20),
                  const SectionHeader(title: 'MONTHLY ATTENDANCE'),
                  const SizedBox(height: 12),

                  // ── Monthly Attendance Chart ────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _BarColumn(
                              label: 'Sep',
                              value: 0.7,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Oct',
                              value: 0.85,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Nov',
                              value: 0.9,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Dec',
                              value: 0.6,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Jan',
                              value: 0.88,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Feb',
                              value: 0.92,
                              color: AppColors.gray300,
                            ),
                            _BarColumn(
                              label: 'Mar',
                              value: 0.87,
                              color: AppColors.red,
                              current: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Current month',
                              style: GoogleFonts.barlow(
                                fontSize: 11,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const SectionHeader(title: 'WIN / LOSS RECORD'),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: student.wins,
                              child: Container(
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: student.losses,
                              child: Container(
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _WinLossStat(
                              label: 'Wins',
                              value: '${student.wins}',
                              color: AppColors.success,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.gray300,
                            ),
                            _WinLossStat(
                              label: 'Total',
                              value: '${student.wins + student.losses}',
                              color: AppColors.blue,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.gray300,
                            ),
                            _WinLossStat(
                              label: 'Losses',
                              value: '${student.losses}',
                              color: AppColors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String skill;
  final double value;
  final Color color;

  const _SkillBar({
    required this.skill,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: GoogleFonts.barlow(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray700,
                ),
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: GoogleFonts.barlow(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.gray100,
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _BarColumn extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool current;

  const _BarColumn({
    required this.label,
    required this.value,
    required this.color,
    this.current = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (current)
          Text(
            '${(value * 100).toInt()}%',
            style: GoogleFonts.barlow(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
        Container(
          width: 28,
          height: 80 * value,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.barlow(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: current ? AppColors.red : AppColors.gray500,
          ),
        ),
      ],
    );
  }
}

class _WinLossStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _WinLossStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.oswald(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.barlow(fontSize: 12, color: AppColors.gray500),
        ),
      ],
    );
  }
}
