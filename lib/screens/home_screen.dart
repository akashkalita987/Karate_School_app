import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = sampleStudent;
    final today = DateTime.now();
    final todayWeekday = today.weekday; // 1=Mon ... 7=Sun

    final todayClasses =
        sampleClasses.where((c) => c.weekdays.contains(todayWeekday)).toList()
          ..sort(
            (a, b) => (a.time.hour * 60 + a.time.minute).compareTo(
              b.time.hour * 60 + b.time.minute,
            ),
          );

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ─────────────────────────────────────
          SliverToBoxAdapter(
            child: GradientHeader(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SHOTOKAN PRO',
                                style: GoogleFonts.oswald(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                'MARTIAL ARTS ACADEMY',
                                style: GoogleFonts.barlow(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                student.initials,
                                style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome back,',
                        style: GoogleFonts.barlow(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        student.name.toUpperCase(),
                        style: GoogleFonts.oswald(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BeltBadge(belt: student.belt),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Stats Row ────────────────────────────────────────
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        value: '${student.totalClasses}',
                        label: 'CLASSES',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(
                        value: '${student.attendancePercent}%',
                        label: 'ATTENDANCE',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(value: '${student.wins}', label: 'WINS'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Today's Classes ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: "TODAY'S CLASSES",
                    actionLabel: 'See all',
                  ),
                  const SizedBox(height: 10),
                  if (todayClasses.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'No classes today. Rest well! 🏖️',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.barlow(color: AppColors.gray500),
                      ),
                    )
                  else
                    ...todayClasses
                        .take(3)
                        .map((c) => ClassListTile(karateClass: c)),
                ],
              ),
            ),
          ),

          // ── Quick Actions ─────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'QUICK ACTIONS'),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.6,
                    children: [
                      _QuickActionCard(
                        icon: '🥋',
                        label: 'Book a Class',
                        bgColor: AppColors.red,
                        textColor: Colors.white,
                      ),
                      _QuickActionCard(
                        icon: '📋',
                        label: 'My Progress',
                        bgColor: AppColors.blue,
                        textColor: Colors.white,
                      ),
                      _QuickActionCard(
                        icon: '🏆',
                        label: 'Tournaments',
                        bgColor: AppColors.redPale,
                        textColor: AppColors.redDark,
                      ),
                      _QuickActionCard(
                        icon: '📅',
                        label: 'Schedule',
                        bgColor: AppColors.bluePale,
                        textColor: AppColors.blueDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Announcement Banner ───────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.blueDark, AppColors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text('📣', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State Championship 2026',
                            style: GoogleFonts.oswald(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Registration open until March 31 · Guwahati Sports Complex',
                            style: GoogleFonts.barlow(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          Text(
            label,
            style: GoogleFonts.oswald(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
