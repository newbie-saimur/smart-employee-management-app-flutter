import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_employee_management/controllers/dashboard_task_tab_controller.dart';
import 'package:smart_employee_management/utils/colors.dart';
import 'package:smart_employee_management/views/AIAssistantScreen/ai_assistant_screen.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/casual_balance_card.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/dashboard_quick_access.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/grettings_and_notification.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/pending_approvals.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/tab_button.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/timeline_items_due_task.dart';
import 'package:smart_employee_management/views/HomeScreen/widgets/timeline_items_meeting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> timelineItems = [
      {
        "type": "meeting",
        "title": "New Hire Onboarding Session",
        "month": "Dec",
        "dateNumber": "17",
        "time": "9:30 AM",
        "meetingPlatform": "Office 301 (In-person)",
        "link": null,
        "description":
            "Welcome and introduction to company policies and culture for new employees.",
        "organizedBy": {"name": "HR Team", "designation": "HR Generalist"},
        "priority": "Low",
        "dueDateStatus": "Due Today",
        "priorityColor": "#673AB7",
        "priorityIcon": "Icons.schedule",
      },
      {
        "type": "dueTask",
        "title": "Expense Report Submission",
        "month": "Dec",
        "dateNumber": "17",
        "time": "6:00 PM",
        "description":
            "Submit all travel and operational expenses for the month of November.",
        "submitTo": {
          "name": "Jenna Miller",
          "designation": "Accounting Specialist",
        },
        "priority": "Low",
        "dueDateStatus": "2 Days left",
        "priorityColor": "#673AB7",
        "priorityIcon": "Icons.schedule",
      },
      {
        "type": "meeting",
        "title": "Project Alpha Retrospective",
        "month": "Dec",
        "dateNumber": "18",
        "time": "4:00 PM",
        "meetingPlatform": "Jitsi Meet",
        "link": "https://meet.jit.si/ProjectAlphaRetro",
        "description":
            "Review what went well and what could be improved on Project Alpha.",
        "organizedBy": {"name": "Robert Green", "designation": "Scrum Master"},
        "priority": "Medium",
        "dueDateStatus": "4 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "dueTask",
        "title": "Code Review: API Integration",
        "month": "Dec",
        "dateNumber": "21",
        "time": "10:00 AM",
        "description":
            "Review the pull request for the new third-party API integration code.",
        "submitTo": {"name": "Chen Wei", "designation": "Senior Developer"},
        "priority": "High",
        "dueDateStatus": "6 Days left",
        "priorityColor": "#E53935",
        "priorityIcon": "Icons.error",
      },
      {
        "type": "meeting",
        "title": "Budget Planning 2026 Kickoff",
        "month": "Dec",
        "dateNumber": "21",
        "time": "1:00 PM",
        "meetingPlatform": "Webex",
        "link": "https://company.webex.com/meetings/...",
        "description":
            "Initial meeting to allocate departmental budgets for the upcoming fiscal year.",
        "organizedBy": {"name": "Finance Dept.", "designation": "CFO"},
        "priority": "High",
        "dueDateStatus": "7 Days left",
        "priorityColor": "#E53935",
        "priorityIcon": "Icons.error",
      },
      {
        "type": "dueTask",
        "title": "Quarterly Goal Setting (Q1)",
        "month": "Dec",
        "dateNumber": "25",
        "time": "11:59 PM",
        "description":
            "Finalize and submit individual OKRs (Objectives and Key Results) for Q1.",
        "submitTo": {"name": "Saimur Rahman", "designation": "Team Lead"},
        "priority": "Medium",
        "dueDateStatus": "10 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "meeting",
        "title": "Client Demo: Feature X",
        "month": "Dec",
        "dateNumber": "26",
        "time": "1:30 PM",
        "meetingPlatform": "Google Meet",
        "link": "https://meet.google.com/client-demo-x",
        "description":
            "Live demonstration of the new Feature X to the primary client.",
        "organizedBy": {
          "name": "Karim Hassan",
          "designation": "Account Executive",
        },
        "priority": "Medium",
        "dueDateStatus": "11 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "dueTask",
        "title": "Performance Review Self-Assessment",
        "month": "Dec",
        "dateNumber": "27",
        "time": "5:00 PM",
        "description":
            "Complete and submit your annual self-assessment form for review.",
        "submitTo": {"name": "Jane Foster", "designation": "HR Manager"},
        "priority": "Medium",
        "dueDateStatus": "12 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "meeting",
        "title": "Holiday Party Planning Committee",
        "month": "Dec",
        "dateNumber": "28",
        "time": "10:30 AM",
        "meetingPlatform": "Lounge Area (In-person)",
        "link": null,
        "description":
            "Final discussion on venue, catering, and entertainment for the company holiday party.",
        "organizedBy": {"name": "Event Committee", "designation": "Various"},
        "priority": "Low",
        "dueDateStatus": "14 Days left",
        "priorityColor": "#673AB7",
        "priorityIcon": "Icons.schedule",
      },
      {
        "type": "dueTask",
        "title": "Database Migration Testing",
        "month": "Dec",
        "dateNumber": "31",
        "time": "9:00 AM",
        "description":
            "Complete the full regression test suite following the staging database migration.",
        "submitTo": {"name": "Rajesh Kumar", "designation": "DevOps Engineer"},
        "priority": "High",
        "dueDateStatus": "16 Days left",
        "priorityColor": "#E53935",
        "priorityIcon": "Icons.error",
      },
      {
        "type": "meeting",
        "title": "Department Head Sync",
        "month": "Dec",
        "dateNumber": "31",
        "time": "3:00 PM",
        "meetingPlatform": "Zoom",
        "link": "https://zoom.us/j/1122334455",
        "description":
            "Monthly sync-up for department heads to review inter-departmental initiatives.",
        "organizedBy": {
          "name": "COO",
          "designation": "Chief Operating Officer",
        },
        "priority": "High",
        "dueDateStatus": "19 Days left",
        "priorityColor": "#E53935",
        "priorityIcon": "Icons.error",
      },
      {
        "type": "dueTask",
        "title": "Training Module Completion: Security",
        "month": "Dec",
        "dateNumber": "31",
        "time": "11:59 PM",
        "description":
            "Mandatory annual IT Security and Data Privacy training must be completed.",
        "submitTo": {"name": "System", "designation": "IT Department"},
        "priority": "Medium",
        "dueDateStatus": "16 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "meeting",
        "title": "New Year Kickoff Strategy Session",
        "month": "Jan",
        "dateNumber": "03",
        "time": "10:00 AM",
        "meetingPlatform": "Company Auditorium",
        "link": null,
        "description":
            "Annual session to launch company-wide strategy for the new year.",
        "organizedBy": {
          "name": "CEO",
          "designation": "Chief Executive Officer",
        },
        "priority": "Medium",
        "dueDateStatus": "26 Days left",
        "priorityColor": "#FFB300",
        "priorityIcon": "Icons.info",
      },
      {
        "type": "dueTask",
        "title": "Invoice Processing Batch 1",
        "month": "Jan",
        "dateNumber": "05",
        "time": "4:00 PM",
        "description":
            "Process the first batch of vendor invoices for January payment cycle.",
        "submitTo": {"name": "Finance Team", "designation": "Accounts Payable"},
        "priority": "Low",
        "dueDateStatus": "21 Days left",
        "priorityColor": "#673AB7",
        "priorityIcon": "Icons.schedule",
      },
    ];

    final List<Map> pendingApprovals = [
      {
        "requestID": "LVE-0042",
        "requestType": "Leave Approval",
        "department": "Engineering",
        "status": "Pending",
        "requestedBy": {
          "name": "Saimur Rahman",
          "designation": "Software Engineer",
        },
        "details": {
          "leaveType": "Casual Leave",
          "durationDays": 4,
          "startDate": "2025-12-15",
          "endDate": "2025-12-18",
          "balanceBefore": 7,
          "reason":
              "I am planning a mandatory family trip to attend my cousin's wedding in another city, followed by a short two-day vacation. I have coordinated all my sprints with David Lee to ensure no disruption to project Alpha.",
          "handoverTo": {
            "name": "David Lee",
            "designation": "Senior Developer",
          },
        },
        "submissionDate": "2025-12-05 09:30 AM",
      },
      {
        "requestID": "SAL-9011",
        "requestType": "Pay Slip Access",
        "department": "Project Management",
        "status": "Pending",
        "requestedBy": {"name": "Sarah Khan", "designation": "Project Manager"},
        "details": {
          "accessType": "Previous Year Slip",
          "reason":
              "I require a copy of my December 2024 payslip. My bank needs this specific document as supporting evidence to finalize the paperwork for my home equity loan application, which is due next week.",
          "affectedMonth": "2024-12",
        },
        "submissionDate": "2025-12-04 04:15 PM",
      },
      {
        "requestID": "LVE-0043",
        "requestType": "Leave Approval",
        "department": "Human Resources",
        "status": "Pending",
        "requestedBy": {"name": "Michael Chen", "designation": "HR Director"},
        "details": {
          "leaveType": "Sick Leave",
          "durationDays": 2,
          "startDate": "2025-12-09",
          "endDate": "2025-12-10",
          "balanceBefore": 14,
          "reason":
              "I woke up with a persistent, high fever and severe headache this morning. I visited the doctor and have been advised to rest for at least two days to recover and avoid infecting colleagues.",
          "handoverTo": {
            "name": "Jenna Miller",
            "designation": "Accounting Specialist",
          },
        },
        "submissionDate": "2025-12-08 10:00 AM",
      },
      {
        "requestID": "GEN-3001",
        "requestType": "General Request",
        "department": "Engineering",
        "status": "Pending",
        "requestedBy": {"name": "Robert Green", "designation": "Scrum Master"},
        "details": {
          "item": "New Monitor",
          "reason":
              "My current primary monitor (Asset ID #345) has developed a permanent dark band running vertically down the center. This significantly hinders my ability to manage the Kanban board and conduct effective code reviews, requiring urgent replacement.",
          "costEstimate": 350,
        },
        "submissionDate": "2025-12-03 11:20 AM",
      },
      {
        "requestID": "LVE-0044",
        "requestType": "Leave Approval",
        "department": "Sales",
        "status": "Pending",
        "requestedBy": {
          "name": "Karim Hassan",
          "designation": "Account Executive",
        },
        "details": {
          "leaveType": "Emergency Leave",
          "durationDays": 1,
          "startDate": "2025-12-12",
          "endDate": "2025-12-12",
          "balanceBefore": 3,
          "reason":
              "I have a sudden and unavoidable court appearance related to a past traffic incident. The notice was only delivered this morning, and it conflicts directly with my client meeting schedule.",
          "handoverTo": {
            "name": "Alex Johnson",
            "designation": "Department Head",
          },
        },
        "submissionDate": "2025-12-08 12:45 PM",
      },
      {
        "requestID": "SAL-9012",
        "requestType": "Pay Slip Access",
        "department": "Engineering",
        "status": "Pending",
        "requestedBy": {"name": "Chen Wei", "designation": "Senior Developer"},
        "details": {
          "accessType": "Current Month Slip",
          "reason":
              "I need immediate access to my November payslip to verify the accuracy of the new retirement fund contribution rate implemented last month. I want to confirm the correct percentage was applied.",
          "affectedMonth": "2025-11",
        },
        "submissionDate": "2025-12-02 09:00 AM",
      },
      {
        "requestID": "LVE-0045",
        "requestType": "Leave Approval",
        "department": "Human Resources",
        "status": "Pending",
        "requestedBy": {"name": "Jane Foster", "designation": "HR Manager"},
        "details": {
          "leaveType": "Casual Leave",
          "durationDays": 7,
          "startDate": "2026-01-01",
          "endDate": "2026-01-07",
          "balanceBefore": 10,
          "reason":
              "This is my annual overseas trip planned with my family. This leave period falls during a standard low-activity week for HR, and all year-end duties will be completed by December 20th.",
          "handoverTo": {"name": "Saima A.", "designation": "Lead Designer"},
        },
        "submissionDate": "2025-12-01 03:00 PM",
      },
      {
        "requestID": "GEN-3002",
        "requestType": "General Request",
        "department": "DevOps",
        "status": "Pending",
        "requestedBy": {
          "name": "Rajesh Kumar",
          "designation": "DevOps Engineer",
        },
        "details": {
          "item": "VPN Access Level Upgrade",
          "reason":
              "The current Level 1 VPN access is insufficient. I require Level 3 access to securely connect to the primary client's environment to deploy the latest database migration scripts, which is scheduled for execution on December 15th.",
          "requiredLevel": "Level 3",
        },
        "submissionDate": "2025-12-04 09:10 AM",
      },
      {
        "requestID": "LVE-0046",
        "requestType": "Leave Approval",
        "department": "Marketing",
        "status": "Pending",
        "requestedBy": {
          "name": "David Lee",
          "designation": "Marketing Manager",
        },
        "details": {
          "leaveType": "Casual Leave",
          "durationDays": 1,
          "startDate": "2025-12-25",
          "endDate": "2025-12-25",
          "balanceBefore": 5,
          "reason":
              "I am requesting the day off for Christmas Day to spend time with my extended family. All critical marketing campaigns will be scheduled and automated by December 24th, requiring no in-office attention.",
          "handoverTo": {
            "name": "Saimur Rahman",
            "designation": "Software Engineer",
          },
        },
        "submissionDate": "2025-12-03 10:40 AM",
      },
      {
        "requestID": "GEN-3003",
        "requestType": "General Request",
        "department": "Finance",
        "status": "Pending",
        "requestedBy": {
          "name": "Jenna Miller",
          "designation": "Accounting Specialist",
        },
        "details": {
          "item": "New Accounting Software License",
          "reason":
              "The current QuickBooks Basic license is insufficient for upcoming international reporting requirements starting Q1 2026. I need the Pro version license to handle multi-currency transactions and generate compliance reports.",
          "softwareName": "QuickBooks Pro",
        },
        "submissionDate": "2025-12-08 08:00 AM",
      },
    ];
    final tabController = Get.put(DashboardTaskTabController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gretting & Notification Section
            GrettingsAndNotification(),
            SizedBox(height: 20),

            // Casual Leave Section
            CasualBalanceCard(),
            SizedBox(height: 24),

            // Quick Access Section
            Text(
              "QUICK ACCESS",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            DashboardQuickAccess(),
            SizedBox(height: 24),

            // Timeline & Task Section
            Row(
              children: [
                TabButton(title: "UP NEXT", tabController: tabController),
                SizedBox(width: 24),
                TabButton(
                  title: "PENDING APPROVAL",
                  tabController: tabController,
                ),
              ],
            ),

            // Timeline Content
            Obx(
              () => tabController.isActiveUpNext.value
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        itemCount: timelineItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = timelineItems[index];
                          return data['type'] == "meeting"
                              ? TimelineItemsMeeting(data: data)
                              : TimelineItemsDueTask(data: data);
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        itemCount: pendingApprovals.length,
                        itemBuilder: (context, index) {
                          final data = pendingApprovals[index];
                          return PendingApprovals(data: data);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AiAssistantScreen());
        },
        child: Icon(Icons.auto_awesome_outlined, size: 30),
      ),
    );
  }
}
