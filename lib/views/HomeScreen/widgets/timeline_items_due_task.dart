import 'package:flutter/material.dart';
import 'package:smart_employee_management/utils/colors.dart';

class TimelineItemsDueTask extends StatelessWidget {
  final Map data;
  const TimelineItemsDueTask({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Color color = data['priority'] == "Low"
        ? Color(0xFF673AB7)
        : data['priority'] == "Medium"
        ? Color(0xFFFFB300)
        : Color(0xFFE53935);

    final IconData icon = data['priority'] == "Low"
        ? Icons.error_outline
        : data['priority'] == "Medium"
        ? Icons.warning_amber_rounded
        : Icons.schedule;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(width: 4, color: color)),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0.5,
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.deepOrange,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${data['time']}  •  ${data['month']} ${data['dateNumber']}  •  ${data['dueDateStatus']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: AppColors.borderColor,
          ),
        ],
      ),
    );
  }
}
