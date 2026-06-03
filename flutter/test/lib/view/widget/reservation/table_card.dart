import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class TableCard extends StatelessWidget {
  final int tableNumber;
  final bool isOccupied;
  final VoidCallback onTap;

  const TableCard({
    required this.tableNumber,
    required this.isOccupied,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isOccupied ? Colors.red : Appcolor.scondary;

    final Color statusBg = isOccupied
        ? Colors.red.withValues(alpha: 0.12)
        : Appcolor.scondary.withValues(alpha: 0.12);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isOccupied ? Colors.red.withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: mainColor.withValues(alpha: 0.35),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: mainColor.withValues(alpha: 0.16),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      isOccupied ? "Occupied" : "Available",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  //  const SizedBox(height: 10),
                  Container(
                    width: 42,
                    height: 30,
                    decoration: BoxDecoration(
                      color: mainColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      Icons.table_restaurant_rounded,
                      size: 30,
                      color: mainColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Table",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    "$tableNumber",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

            if (isOccupied)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}