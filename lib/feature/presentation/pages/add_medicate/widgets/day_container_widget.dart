import 'package:flutter/material.dart';

class DayContainerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String titleDay;

  const DayContainerWidget({
    super.key,
    required this.onTap,
    required this.titleDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            color: Colors.grey[300]!,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 10),
          Text(
            titleDay,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
