import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = sampleStudent;
    final instructors = sampleInstructors;
    final avatarColors = [AppColors.red, AppColors.blue, AppColors.blueDark];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Profile Header ────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.blueDark, AppColors.red],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                      child: Column(
                        children: [
                          // Avatar
                          Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: Center(
                              child: Text(
                                student.initials,
                                style: GoogleFonts.oswald(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            student.name.toUpperCase(),
                            style: GoogleFonts.oswald(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Student ID: ${student.id}',
                            style: GoogleFonts.barlow(
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 10),
                          BeltBadge(belt: student.belt),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Stats Row (overlapping) ───────────────────────────
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        value: '${student.totalClasses}',
                        label: 'SESSIONS',
                        accentColor: AppColors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(
                        value: '${beltLevels.indexOf(student.belt) + 1}',
                        label: 'BELTS EARNED',
                        accentColor: AppColors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(
                        value: '${student.attendancePercent}%',
                        label: 'ATTEND.',
                        accentColor: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Belt Progress ─────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'BELT PROGRESSION'),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: beltLevels.map((belt) {
                            final currentIdx = beltLevels.indexOf(student.belt);
                            final beltIdx = beltLevels.indexOf(belt);
                            final achieved = beltIdx <= currentIdx;
                            return Column(
                              children: [
                                Container(
                                  width: 30,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: achieved
                                        ? belt.color
                                        : AppColors.gray200,
                                    borderRadius: BorderRadius.circular(3),
                                    border: achieved
                                        ? Border.all(
                                            color: Colors.black26,
                                            width: 0.5,
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  belt.name[0],
                                  style: GoogleFonts.barlow(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: achieved
                                        ? AppColors.gray700
                                        : AppColors.gray300,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value:
                                    (beltLevels.indexOf(student.belt) + 1) /
                                    beltLevels.length,
                                backgroundColor: AppColors.gray200,
                                color: AppColors.gold,
                                borderRadius: BorderRadius.circular(4),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${beltLevels.indexOf(student.belt) + 1}/${beltLevels.length}',
                              style: GoogleFonts.barlow(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gray700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Achievements ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'ACHIEVEMENTS'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: student.achievements.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (_, i) => AchievementBadge(
                        achievement: student.achievements[i],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Tournament History ─────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'TOURNAMENT HISTORY'),
                  const SizedBox(height: 12),
                  ...sampleTournaments.map(
                    (t) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
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
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: t.resultColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                t.result.contains('1st') ? '🥇' : '🥈',
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.name,
                                  style: GoogleFonts.oswald(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.gray900,
                                  ),
                                ),
                                Text(
                                  '${t.location} · ${t.date.year}',
                                  style: GoogleFonts.barlow(
                                    fontSize: 11,
                                    color: AppColors.gray500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: t.resultColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              t.result,
                              style: GoogleFonts.barlow(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: t.resultColor == AppColors.gold
                                    ? const Color(0xFF9E6C00)
                                    : AppColors.gray700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Instructors ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'MY INSTRUCTORS'),
                  const SizedBox(height: 12),
                  ...List.generate(
                    instructors.length,
                    (i) => InstructorCard(
                      instructor: instructors[i],
                      avatarColor: avatarColors[i % avatarColors.length],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
