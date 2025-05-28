import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upwork_task/features/dashboard/animated_on_visibility.dart';
import 'package:upwork_task/features/dashboard/presentation/widgets/journal_entries.dart';
import 'package:upwork_task/features/dashboard/presentation/widgets/modern_nav_item.dart';
import 'package:upwork_task/features/dashboard/presentation/widgets/mood_stat_card.dart';
import 'package:upwork_task/features/dashboard/presentation/widgets/mood_trends_card.dart';
import 'package:upwork_task/features/dashboard/presentation/widgets/today_mood_card.dart';
import 'package:upwork_task/l10n/app_localizations.dart';

import '../../../analytics/analytics_screen.dart';
import '../../../settings/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 140 && !_showAppBarTitle) {
      setState(() => _showAppBarTitle = true);
    } else if (_scrollController.offset <= 140 && _showAppBarTitle) {
      setState(() => _showAppBarTitle = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: AnimatedSwitcher(
        duration: 300.ms,
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              // Home Screen
              CustomScrollView(
                key: const ValueKey<String>('home_screen'),
                controller: _scrollController,
                slivers: [
                  // Modern App Bar
                  SliverAppBar.medium(
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    backgroundColor: colorScheme.surface,
                    surfaceTintColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: _showAppBarTitle ? 1.0 : 0.0,
                        duration: 200.ms,
                        child: Text(
                          l10n.welcomeBack,
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      background: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.welcomeBack,
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                l10n.annette,
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Dashboard Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),

                          // Today's Mood Card - Modern Design
                          AnimatedOnVisibility(
                            key: const Key('today-mood'),
                            delay: 0.ms,
                            child: TodayMoodCard(
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              l10n: l10n,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Mood Stats Row
                          AnimatedOnVisibility(
                            key: const Key('mood-stats'),
                            delay: 120.ms,
                            slideOffset: const Offset(-0.12, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MoodStatCard(
                                    icon: Icons.trending_up,
                                    title: l10n.weeklyStreak,
                                    value: l10n.streak5Days,
                                    colorScheme: colorScheme,
                                    textTheme: textTheme,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MoodStatCard(
                                    icon: Icons.favorite,
                                    title: l10n.bestMood,
                                    value: l10n.happy,
                                    colorScheme: colorScheme,
                                    textTheme: textTheme,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Mood Trends Section
                          AnimatedOnVisibility(
                            key: const Key('mood-trends-title'),
                            delay: 240.ms,
                            slideOffset: const Offset(0, 0.10),
                            duration: 500.ms,
                            child: Text(
                              l10n.moodTrends,
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          AnimatedOnVisibility(
                            key: const Key('mood-trends-card'),
                            delay: 320.ms,
                            child: MoodTrendsCard(
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              l10n: l10n,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Recent Journal Entries
                          AnimatedOnVisibility(
                            key: const Key('journal-title'),
                            delay: 400.ms,
                            slideOffset: const Offset(0, 0.10),
                            duration: 500.ms,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.journalEntries,
                                  style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add, size: 20),
                                  label: Text(l10n.newEntry),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          AnimatedOnVisibility(
                            key: const Key('journal-entries'),
                            delay: 480.ms,
                            child: JournalEntries(
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              l10n: l10n,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Analytics Screen
              const AnalyticsScreen(
                key: ValueKey<String>('analytics_screen'),
              ),
              // Settings Screen
              const SettingsScreen(
                key: ValueKey<String>('settings_screen'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withOpacity(0.95),
                  colorScheme.secondary.withOpacity(0.9),
                  colorScheme.secondary.withOpacity(0.95),
                ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 18,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 32,
                  spreadRadius: 0,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Animated Selection Indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: _selectedIndex *
                      (MediaQuery.of(context).size.width - 48) /
                      3,
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 48) / 3,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.10),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                // Navigation Items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ModernNavItem(
                      icon: Icons.home_rounded,
                      label: l10n.home,
                      isSelected: _selectedIndex == 0,
                      onTap: () => setState(() => _selectedIndex = 0),
                    ),
                    ModernNavItem(
                      icon: Icons.analytics_rounded,
                      label: l10n.analytics,
                      isSelected: _selectedIndex == 1,
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                    ModernNavItem(
                      icon: Icons.settings_rounded,
                      label: l10n.settings,
                      isSelected: _selectedIndex == 2,
                      onTap: () => setState(() => _selectedIndex = 2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            .animate(
              delay: 600.ms,
            )
            .slideY(
              begin: 1.2,
              end: 0,
              curve: Curves.easeOutExpo,
              duration: 900.ms,
            )
            .fadeIn(
              duration: 600.ms,
            )
            .scale(
              begin: const Offset(0.7, 0.7),
              end: const Offset(1.0, 1.0),
              curve: Curves.easeOutBack,
              duration: 900.ms,
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
