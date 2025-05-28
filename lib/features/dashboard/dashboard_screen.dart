import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
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
                  'Welcome Back, Alex',
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
                        'Welcome Back,',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        'Alex',
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
                  _TodayMoodCard(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ).animate().fadeIn(duration: 400.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 500.ms,
                        curve: Curves.easeOutQuint,
                      ),

                  const SizedBox(height: 32),

                  // Mood Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _MoodStatCard(
                          icon: Icons.trending_up,
                          title: 'Weekly Streak',
                          value: '5 Days',
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _MoodStatCard(
                          icon: Icons.favorite,
                          title: 'Best Mood',
                          value: 'Happy',
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms).slideX(
                        begin: -0.2,
                        end: 0,
                        duration: 500.ms,
                        curve: Curves.easeOutQuint,
                      ),

                  const SizedBox(height: 32),

                  // Mood Trends Section
                  Text(
                    'Mood Trends',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _MoodTrendsCard(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ).animate().fadeIn(delay: 400.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 500.ms,
                        curve: Curves.easeOutQuint,
                      ),

                  const SizedBox(height: 32),

                  // Recent Journal Entries
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Journal Entries',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('New Entry'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _JournalEntries(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ).animate().fadeIn(delay: 600.ms).slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 500.ms,
                        curve: Curves.easeOutQuint,
                      ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
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
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.25),
                    blurRadius: 15,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Shimmering overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.2),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(),
                        )
                        .shimmer(
                          duration: 2000.ms,
                          color: Colors.white.withOpacity(0.1),
                        ),
                  ),
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
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Navigation Items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ModernNavItem(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        isSelected: _selectedIndex == 0,
                        onTap: () => setState(() => _selectedIndex = 0),
                      ),
                      _ModernNavItem(
                        icon: Icons.analytics_rounded,
                        label: 'Analytics',
                        isSelected: _selectedIndex == 1,
                        onTap: () => setState(() => _selectedIndex = 1),
                      ),
                      _ModernNavItem(
                        icon: Icons.person_rounded,
                        label: 'Profile',
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
                delay: 800.ms,
              )
              .slideY(
                begin: 1,
                end: 0,
                curve: Curves.easeOutExpo,
                duration: 800.ms,
              )
              .fadeIn(
                duration: 500.ms,
              )
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeOutBack,
                duration: 800.ms,
              ),
        ),
      ),
    );
  }
}

class _TodayMoodCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _TodayMoodCard({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withBlue(
              (colorScheme.primary.blue * 0.8).toInt(),
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Mood",
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '😊',
                          style: textTheme.headlineSmall,
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shake(
                            duration: 1.seconds,
                            delay: 2.seconds,
                          ),
                      const SizedBox(width: 12),
                      Text(
                        'Happy',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Feeling energized and motivated! Started the day with meditation and a healthy breakfast. Ready to tackle any challenge.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: colorScheme.onPrimary.withOpacity(0.7),
              ),
              const SizedBox(width: 4),
              Text(
                '9:30 AM',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _MoodStatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodTrendsCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _MoodTrendsCard({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'This Week',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today_outlined, size: 18),
                label: const Text('Change'),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: colorScheme.outline.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        if (value >= 0 && value < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              days[value.toInt()],
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 4),
                      FlSpot(2, 3.5),
                      FlSpot(3, 5),
                      FlSpot(4, 4),
                      FlSpot(5, 4.5),
                      FlSpot(6, 5),
                    ],
                    isCurved: true,
                    color: colorScheme.primary,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: colorScheme.surface,
                          strokeWidth: 3,
                          strokeColor: colorScheme.primary,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.primary.withOpacity(0.3),
                          colorScheme.primary.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (LineBarSpot touchedSpot) =>
                        colorScheme.primary,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'Mood: ${spot.y}',
                          TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _JournalEntries extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _JournalEntries({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final entries = [
      {
        'emoji': '🌟',
        'title': 'Achieved my daily goals',
        'preview':
            'Today was incredibly productive. I managed to complete all my tasks and even had time for a quick workout.',
        'time': '2h ago',
        'mood': 'Happy',
      },
      {
        'emoji': '🎨',
        'title': 'Creative breakthrough',
        'preview':
            'Finally found inspiration for my art project. The colors and composition just clicked together perfectly.',
        'time': 'Yesterday',
        'mood': 'Inspired',
      },
      {
        'emoji': '🌱',
        'title': 'New beginnings',
        'preview':
            'Started a new chapter in my life. Feeling optimistic about the future and all its possibilities.',
        'time': '2d ago',
        'mood': 'Hopeful',
      },
    ];

    return Column(
      children: entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      entry['emoji'] as String,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry['title'] as String,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry['time'] as String,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      entry['mood'] as String,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                entry['preview'] as String,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ModernNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 48) / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
