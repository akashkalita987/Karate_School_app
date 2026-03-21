import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ── Belt Model ──────────────────────────────────────────────
class Belt {
  final String name;
  final Color color;
  final int kyu;

  const Belt({required this.name, required this.color, required this.kyu});
}

const List<Belt> beltLevels = [
  Belt(name: 'White', color: Colors.white, kyu: 10),
  Belt(name: 'Yellow', color: Color(0xFFFDD835), kyu: 9),
  Belt(name: 'Orange', color: Color(0xFFFF6D00), kyu: 8),
  Belt(name: 'Green', color: Color(0xFF2E7D32), kyu: 7),
  Belt(name: 'Blue', color: Color(0xFF1565C0), kyu: 6),
  Belt(name: 'Brown', color: Color(0xFF6D4C41), kyu: 5),
  Belt(name: 'Black', color: Color(0xFF212121), kyu: 1),
];

// ── Student Model ────────────────────────────────────────────
class Student {
  final String name;
  final String id;
  final Belt belt;
  final int totalClasses;
  final int attendancePercent;
  final int wins;
  final int losses;
  final DateTime joinDate;
  final List<Achievement> achievements;

  const Student({
    required this.name,
    required this.id,
    required this.belt,
    required this.totalClasses,
    required this.attendancePercent,
    required this.wins,
    required this.losses,
    required this.joinDate,
    required this.achievements,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join();
}

// ── Achievement Model ────────────────────────────────────────
class Achievement {
  final String name;
  final String icon;
  final String description;
  final bool unlocked;

  const Achievement({
    required this.name,
    required this.icon,
    required this.description,
    this.unlocked = true,
  });
}

// ── KarateClass Model ────────────────────────────────────────
enum ClassLevel { beginner, intermediate, advanced, kids }

class KarateClass {
  final String id;
  final String name;
  final String instructor;
  final String dojo;
  final TimeOfDay time;
  final int durationMinutes;
  final ClassLevel level;
  final int enrolledStudents;
  final int maxStudents;
  final List<int> weekdays; // 1=Mon, 7=Sun
  final bool isBooked;

  const KarateClass({
    required this.id,
    required this.name,
    required this.instructor,
    required this.dojo,
    required this.time,
    required this.durationMinutes,
    required this.level,
    required this.enrolledStudents,
    required this.maxStudents,
    required this.weekdays,
    this.isBooked = false,
  });

  String get levelLabel {
    switch (level) {
      case ClassLevel.beginner:
        return 'BEG';
      case ClassLevel.intermediate:
        return 'INT';
      case ClassLevel.advanced:
        return 'ADV';
      case ClassLevel.kids:
        return 'KIDS';
    }
  }

  Color get levelColor {
    switch (level) {
      case ClassLevel.beginner:
        return AppColors.red;
      case ClassLevel.intermediate:
        return AppColors.blue;
      case ClassLevel.advanced:
        return AppColors.redDark;
      case ClassLevel.kids:
        return AppColors.success;
    }
  }

  Color get levelBgColor {
    switch (level) {
      case ClassLevel.beginner:
        return AppColors.redPale;
      case ClassLevel.intermediate:
        return AppColors.bluePale;
      case ClassLevel.advanced:
        return AppColors.redPale;
      case ClassLevel.kids:
        return AppColors.successLight;
    }
  }

  String get timeString {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final min = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$min $period';
  }
}

// ── Instructor Model ─────────────────────────────────────────
class Instructor {
  final String name;
  final String rank;
  final double rating;
  final String specialty;
  final int yearsExperience;

  const Instructor({
    required this.name,
    required this.rank,
    required this.rating,
    required this.specialty,
    required this.yearsExperience,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join();
}

// ── Tournament Model ─────────────────────────────────────────
class Tournament {
  final String name;
  final DateTime date;
  final String location;
  final String result;
  final Color resultColor;

  const Tournament({
    required this.name,
    required this.date,
    required this.location,
    required this.result,
    required this.resultColor,
  });
}

// ── Sample Data ───────────────────────────────────────────────
final sampleStudent = Student(
  name: 'Rajan Kumar',
  id: 'SKA-2024-0047',
  belt: beltLevels[1], // Yellow
  totalClasses: 42,
  attendancePercent: 87,
  wins: 6,
  losses: 2,
  joinDate: DateTime(2024, 1, 15),
  achievements: const [
    Achievement(
      name: 'First Kata',
      icon: '🥋',
      description: 'Completed your first kata',
      unlocked: true,
    ),
    Achievement(
      name: 'Tournament Win',
      icon: '🏆',
      description: 'Won your first tournament',
      unlocked: true,
    ),
    Achievement(
      name: '30-Day Streak',
      icon: '🔥',
      description: '30 consecutive training days',
      unlocked: true,
    ),
    Achievement(
      name: 'Top Student',
      icon: '⭐',
      description: 'Ranked #1 in your batch',
      unlocked: true,
    ),
    Achievement(
      name: 'Perfect Form',
      icon: '🎯',
      description: 'Perfect score on form evaluation',
      unlocked: true,
    ),
    Achievement(
      name: 'Black Belt',
      icon: '🖤',
      description: 'Achieve black belt rank',
      unlocked: false,
    ),
    Achievement(
      name: '100 Classes',
      icon: '💯',
      description: 'Attend 100 training classes',
      unlocked: false,
    ),
  ],
);

final sampleClasses = [
  const KarateClass(
    id: '1',
    name: 'Morning Kata',
    instructor: 'Sensei Mohan',
    dojo: 'Dojo A',
    time: TimeOfDay(hour: 7, minute: 0),
    durationMinutes: 45,
    level: ClassLevel.beginner,
    enrolledStudents: 12,
    maxStudents: 20,
    weekdays: [1, 3, 5],
    isBooked: true,
  ),
  const KarateClass(
    id: '2',
    name: 'Kihon Training',
    instructor: 'Sensei Priya',
    dojo: 'Dojo B',
    time: TimeOfDay(hour: 10, minute: 0),
    durationMinutes: 60,
    level: ClassLevel.intermediate,
    enrolledStudents: 9,
    maxStudents: 15,
    weekdays: [2, 4],
  ),
  const KarateClass(
    id: '3',
    name: 'Kids Karate',
    instructor: 'Sensei Amit',
    dojo: 'Dojo C',
    time: TimeOfDay(hour: 14, minute: 0),
    durationMinutes: 45,
    level: ClassLevel.kids,
    enrolledStudents: 16,
    maxStudents: 20,
    weekdays: [1, 2, 3, 4, 5],
  ),
  const KarateClass(
    id: '4',
    name: 'Sparring Session',
    instructor: 'Sensei Mohan',
    dojo: 'Dojo A',
    time: TimeOfDay(hour: 17, minute: 30),
    durationMinutes: 60,
    level: ClassLevel.advanced,
    enrolledStudents: 8,
    maxStudents: 12,
    weekdays: [2, 4, 6],
  ),
  const KarateClass(
    id: '5',
    name: 'Evening Kumite',
    instructor: 'Sensei Priya',
    dojo: 'Dojo B',
    time: TimeOfDay(hour: 19, minute: 30),
    durationMinutes: 90,
    level: ClassLevel.advanced,
    enrolledStudents: 10,
    maxStudents: 14,
    weekdays: [1, 3, 5],
  ),
  const KarateClass(
    id: '6',
    name: 'Weekend Warriors',
    instructor: 'Sensei Amit',
    dojo: 'Dojo A',
    time: TimeOfDay(hour: 9, minute: 0),
    durationMinutes: 90,
    level: ClassLevel.intermediate,
    enrolledStudents: 14,
    maxStudents: 18,
    weekdays: [6, 7],
  ),
];

final sampleInstructors = [
  const Instructor(
    name: 'Sensei Mohan',
    rank: '5th Dan',
    rating: 5.0,
    specialty: 'Head Instructor · Kumite',
    yearsExperience: 20,
  ),
  const Instructor(
    name: 'Sensei Priya',
    rank: '3rd Dan',
    rating: 4.8,
    specialty: 'Kata Specialist',
    yearsExperience: 12,
  ),
  const Instructor(
    name: 'Sensei Amit',
    rank: '2nd Dan',
    rating: 4.5,
    specialty: 'Kids & Beginners',
    yearsExperience: 8,
  ),
];

final sampleTournaments = [
  Tournament(
    name: 'State Karate Championship',
    date: DateTime(2025, 11, 15),
    location: 'Guwahati Sports Complex',
    result: '1st Place',
    resultColor: AppColors.gold,
  ),
  Tournament(
    name: 'District Open Tournament',
    date: DateTime(2025, 8, 20),
    location: 'Dispur Arena',
    result: '2nd Place',
    resultColor: AppColors.gray500,
  ),
  Tournament(
    name: 'Club Inter-Dojo Meet',
    date: DateTime(2025, 5, 10),
    location: 'Shotokan Dojo',
    result: '1st Place',
    resultColor: AppColors.gold,
  ),
];
