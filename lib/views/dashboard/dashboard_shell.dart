import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import '../../services/profile_store.dart';
import '../../theme/app_colors.dart';
import '../profile/student_profile_page.dart';
import '../profile/teacher_profile_page.dart';
import '../sign_in_page.dart';
import 'tab_placeholder.dart';

/// One tab of the bottom navigation bar.
class _Tab {
  const _Tab(this.label, this.icon, this.activeIcon);

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

// Student tabs follow the Figma bottom bar.
const _studentTabs = [
  _Tab('Home', Icons.home_outlined, Icons.home),
  _Tab('Discover', Icons.person_search_outlined, Icons.person_search),
  _Tab('My Classes', Icons.school_outlined, Icons.school),
  _Tab('Messages', Icons.chat_bubble_outline, Icons.chat_bubble),
  _Tab('Profile', Icons.person_outline, Icons.person),
];

// Teacher tabs follow the Figma bottom bar.
const _teacherTabs = [
  _Tab('Home', Icons.grid_view_outlined, Icons.grid_view),
  _Tab('Classes', Icons.school_outlined, Icons.school),
  _Tab('Create', Icons.add_box_outlined, Icons.add_box),
  _Tab('Messages', Icons.chat_bubble_outline, Icons.chat_bubble),
  _Tab('Profile', Icons.person_outline, Icons.person),
];

/// The screen shown after login. It reads the signed-in user's role and shows
/// the student or the teacher bottom navigation (story 2.4).
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _index = 0;

  void _goTo(int index) => setState(() => _index = index);

  /// One page per tab, in the same order as the tabs above.
  List<Widget> _pages(UserProfile profile) {
    if (profile.isTeacher) {
      return [
        const TabPlaceholder('Teacher home'),
        const TabPlaceholder('Classes & notes'),
        const TabPlaceholder('Create class'),
        const TabPlaceholder('Messages'),
        const TeacherProfilePage(),
      ];
    }
    return [
      const TabPlaceholder('Student home'),
      const TabPlaceholder('Discover'),
      const TabPlaceholder('My classes'),
      const TabPlaceholder('Messages'),
      const StudentProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileStore.instance.current;
    // Nobody is signed in, so send them to the sign-in page.
    if (profile == null) return const SignInPage();

    final tabs = profile.isTeacher ? _teacherTabs : _studentTabs;

    return Scaffold(
      backgroundColor: AppColors.pale,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopBar(),
            // IndexedStack keeps every tab alive, so a half-filled form is not lost.
            Expanded(
              child: IndexedStack(index: _index, children: _pages(profile)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _goTo,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.tint,
        destinations: [
          for (final tab in tabs)
            NavigationDestination(
              icon: Icon(tab.icon, color: AppColors.label),
              selectedIcon: Icon(tab.activeIcon, color: AppColors.navy),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          const Icon(Icons.school, color: AppColors.navy, size: 28),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              tooltip: 'Dark mode (later sprint)',
              onPressed: () {},
              icon: const Icon(Icons.dark_mode_outlined,
                  color: AppColors.navy, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}