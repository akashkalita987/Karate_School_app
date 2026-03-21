import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _classReminders = true;
  bool _tournamentAlerts = true;
  bool _progressUpdates = false;
  bool _newsletter = false;
  String _selectedLanguage = 'English';
  String _selectedDojo = 'Dojo A';

  @override
  Widget build(BuildContext context) {
    final student = sampleStudent;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GradientHeader(
              colors: const [AppColors.gray900, AppColors.redDark],
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SETTINGS',
                              style: GoogleFonts.oswald(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'Manage your preferences',
                              style: GoogleFonts.barlow(
                                fontSize: 12,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
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
                  // ── Account Section ────────────────────────────
                  _SectionLabel(label: 'ACCOUNT'),
                  _SettingsTile(
                    icon: Icons.person_outline,
                    iconColor: AppColors.blue,
                    title: 'Edit Profile',
                    subtitle: student.name,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.card_membership_outlined,
                    iconColor: AppColors.red,
                    title: 'Membership',
                    subtitle: 'Active · Monthly Plan',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: GoogleFonts.barlow(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.lock_outline,
                    iconColor: AppColors.gray700,
                    title: 'Change Password',
                    onTap: () {},
                  ),

                  const SizedBox(height: 8),
                  _SectionLabel(label: 'PREFERENCES'),
                  _SettingsTile(
                    icon: Icons.language_outlined,
                    iconColor: AppColors.blue,
                    title: 'Language',
                    subtitle: _selectedLanguage,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => SimpleDialog(
                          title: Text(
                            'Select Language',
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: ['English', 'Hindi', 'Assamese']
                              .map(
                                (lang) => SimpleDialogOption(
                                  onPressed: () {
                                    setState(() => _selectedLanguage = lang);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    lang,
                                    style: GoogleFonts.barlow(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                  _SettingsTile(
                    icon: Icons.location_on_outlined,
                    iconColor: AppColors.red,
                    title: 'Home Dojo',
                    subtitle: _selectedDojo,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => SimpleDialog(
                          title: Text(
                            'Select Dojo',
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: ['Dojo A', 'Dojo B', 'Dojo C']
                              .map(
                                (dojo) => SimpleDialogOption(
                                  onPressed: () {
                                    setState(() => _selectedDojo = dojo);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    dojo,
                                    style: GoogleFonts.barlow(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  _SectionLabel(label: 'NOTIFICATIONS'),
                  _ToggleTile(
                    icon: Icons.notifications_outlined,
                    iconColor: AppColors.red,
                    title: 'Class Reminders',
                    subtitle: '1 hour before class starts',
                    value: _classReminders,
                    onChanged: (v) => setState(() => _classReminders = v),
                  ),
                  _ToggleTile(
                    icon: Icons.emoji_events_outlined,
                    iconColor: AppColors.gold,
                    title: 'Tournament Alerts',
                    subtitle: 'New events & registrations',
                    value: _tournamentAlerts,
                    onChanged: (v) => setState(() => _tournamentAlerts = v),
                  ),
                  _ToggleTile(
                    icon: Icons.bar_chart_outlined,
                    iconColor: AppColors.blue,
                    title: 'Progress Updates',
                    subtitle: 'Weekly summary reports',
                    value: _progressUpdates,
                    onChanged: (v) => setState(() => _progressUpdates = v),
                  ),
                  _ToggleTile(
                    icon: Icons.mail_outline,
                    iconColor: AppColors.gray500,
                    title: 'Newsletter',
                    subtitle: 'Tips, techniques & events',
                    value: _newsletter,
                    onChanged: (v) => setState(() => _newsletter = v),
                  ),

                  const SizedBox(height: 8),
                  _SectionLabel(label: 'SUPPORT'),
                  _SettingsTile(
                    icon: Icons.help_outline,
                    iconColor: AppColors.blue,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.star_outline,
                    iconColor: AppColors.gold,
                    title: 'Rate the App',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.info_outline,
                    iconColor: AppColors.gray500,
                    title: 'About',
                    subtitle: 'Version 1.0.0',
                    onTap: () {},
                  ),

                  const SizedBox(height: 16),

                  // ── Logout Button ──────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: AppColors.red),
                      label: Text(
                        'Log Out',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(
                          color: AppColors.red,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        label,
        style: GoogleFonts.barlow(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.gray500,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.barlow(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: GoogleFonts.barlow(
                  fontSize: 12,
                  color: AppColors.gray500,
                ),
              )
            : null,
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.gray500,
            ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.barlow(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: GoogleFonts.barlow(
                  fontSize: 12,
                  color: AppColors.gray500,
                ),
              )
            : null,
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.red,
        ),
      ),
    );
  }
}
