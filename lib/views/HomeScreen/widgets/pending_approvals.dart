import 'package:flutter/material.dart';
import 'package:smart_employee_management/utils/colors.dart';

class PendingApprovals extends StatelessWidget {
  final Map data;
  const PendingApprovals({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Color color = data['requestType'] == "General Request"
        ? Color(0xFFFBC02D)
        : data['requestType'] == "Pay Slip Access"
        ? Color(0xFF4CAF50)
        : Color(0xFF2979FF);
    final IconData icon = data['requestType'] == "General Request"
        ? Icons.flight_takeoff
        : data['requestType'] == "Pay Slip Access"
        ? Icons.attach_money
        : Icons.construction;

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
                        data['requestType'],
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
                            Icons.person,
                            color: AppColors.secondaryTextColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${data['requestedBy']['name']}  •  ${data['department']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondaryTextColor,
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
