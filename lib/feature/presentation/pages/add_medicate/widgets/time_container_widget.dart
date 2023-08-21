import 'package:flutter/material.dart';
import 'package:medisync/config/constants/constants.dart';

class TimeContainerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final TimeOfDay timeOfDay;

  const TimeContainerWidget({
    super.key,
    required this.onTap,
    required this.timeOfDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 40,
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
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.schedule),
          const SizedBox(width: 10),
          Text("${parseTime(timeOfDay.hour)}:${parseTime(timeOfDay.minute)}"),
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

String parseTime(int time) {
  if (time > 9) {
    return "$time";
  } else {
    return "0$time";
  }
}
