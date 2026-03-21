import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

// ── Gradient Header ──────────────────────────────────────────
class GradientHeader extends StatelessWidget {
  final Widget child;
  final double height;
  final List<Color>? colors;

  const GradientHeader({
    super.key,
    required this.child,
    this.height = 200,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              colors ?? [AppColors.redDark, AppColors.red, AppColors.blueDark],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: 60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: accentColor != null
            ? Border(top: BorderSide(color: accentColor!, width: 3))
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.oswald(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.barlow(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Belt Badge ────────────────────────────────────────────────
class BeltBadge extends StatelessWidget {
  final Belt belt;

  const BeltBadge({super.key, required this.belt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: belt.color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${belt.name} Belt · ${belt.kyu}th Kyu',
            style: GoogleFonts.barlow(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Class List Tile ────────────────────────────────────────────
class ClassListTile extends StatelessWidget {
  final KarateClass karateClass;
  final bool showBookButton;
  final VoidCallback? onTap;

  const ClassListTile({
    super.key,
    required this.karateClass,
    this.showBookButton = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBlue =
        karateClass.level == ClassLevel.intermediate ||
        karateClass.level == ClassLevel.advanced && karateClass.id == '4';
    final accentColor = isBlue ? AppColors.blue : AppColors.red;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: accentColor, width: 4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 56,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              decoration: BoxDecoration(
                color: isBlue ? AppColors.bluePale : AppColors.redPale,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    karateClass.time.hourOfPeriod == 0
                        ? '12'
                        : '${karateClass.time.hourOfPeriod}:${karateClass.time.minute.toString().padLeft(2, '0')}',
                    style: GoogleFonts.oswald(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                  Text(
                    karateClass.time.period == DayPeriod.am ? 'AM' : 'PM',
                    style: GoogleFonts.barlow(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: accentColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    karateClass.name,
                    style: GoogleFonts.oswald(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${karateClass.instructor} · ${karateClass.dojo} · ${karateClass.durationMinutes} min',
                    style: GoogleFonts.barlow(
                      fontSize: 11,
                      color: AppColors.gray500,
                    ),
                  ),
                  if (showBookButton) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${karateClass.enrolledStudents}/${karateClass.maxStudents} students',
                      style: GoogleFonts.barlow(
                        fontSize: 11,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (karateClass.isBooked)
              _buildBadge('Booked', AppColors.success, AppColors.successLight)
            else
              _buildBadge(
                karateClass.levelLabel,
                karateClass.levelColor,
                karateClass.levelBgColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.barlow(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

// ── Section Header ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.oswald(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
            letterSpacing: 0.5,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.barlow(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Custom App Bar ─────────────────────────────────────────────
class DojoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const DojoAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.redDark, AppColors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ── Instructor Card ────────────────────────────────────────────
class InstructorCard extends StatelessWidget {
  final Instructor instructor;
  final Color avatarColor;

  const InstructorCard({
    super.key,
    required this.instructor,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  avatarColor,
                  avatarColor.withRed(avatarColor.red - 30),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                instructor.initials,
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor.name,
                  style: GoogleFonts.oswald(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                ),
                Text(
                  '${instructor.rank} · ${instructor.specialty}',
                  style: GoogleFonts.barlow(
                    fontSize: 11,
                    color: AppColors.gray500,
                  ),
                ),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < instructor.rating.floor()
                          ? Icons.star_rounded
                          : i < instructor.rating
                          ? Icons.star_half_rounded
                          : Icons.star_outline_rounded,
                      size: 14,
                      color: AppColors.gold,
                    );
                  }),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${instructor.yearsExperience}y exp',
              style: GoogleFonts.barlow(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.gray700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Achievement Badge ──────────────────────────────────────────
class AchievementBadge extends StatelessWidget {
  final Achievement achievement;

  const AchievementBadge({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: achievement.unlocked ? AppColors.white : AppColors.gray100,
        borderRadius: BorderRadius.circular(14),
        boxShadow: achievement.unlocked
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: achievement.unlocked ? 1.0 : 0.35,
            child: Text(achievement.icon, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 6),
          Text(
            achievement.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.barlow(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: achievement.unlocked
                  ? AppColors.gray700
                  : AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
