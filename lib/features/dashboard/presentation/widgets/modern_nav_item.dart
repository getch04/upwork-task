import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModernNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ModernNavItem({
    super.key,
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Icon and Label
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
                  size: isSelected ? 26 : 24,
                )
                    .animate(
                      target: isSelected ? 1 : 0,
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                )
                    .animate(
                      target: isSelected ? 1 : 0,
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.05, 1.05),
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 2),
                // Bottom Dot Indicator
                AnimatedContainer(
                  duration: 200.ms,
                  width: isSelected ? 4 : 0,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
