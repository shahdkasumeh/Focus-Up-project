import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class BottomNavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: 54,
          decoration: BoxDecoration(
            color: isSelected
                ? Appcolor.primaryColor.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: isSelected
                        ? Appcolor.primaryColor
                        : Appcolor.inactiveColor,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isSelected ? 9 : 0,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isSelected
                        ? Text(
                            title,
                            key: ValueKey(title),
                            style: const TextStyle(
                              color: Appcolor.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              if (isSelected)
                Positioned(
                  bottom: 5,
                  child: Container(
                    width: 21,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: Appcolor.accentColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
