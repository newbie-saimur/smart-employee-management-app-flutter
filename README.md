# Smart Employee Management

> [!NOTE] > **📱 Android & iOS Only** - This application is designed for mobile devices.

A comprehensive employee management system built with Flutter for managing HR operations, attendance tracking, leave requests, payroll, and employee communications.

## 📱 About

Smart Employee Management is a full-featured mobile application that streamlines HR and employee management tasks. Built with Flutter and GetX for state management, it provides an intuitive interface for employees to manage their work-related activities including attendance tracking, leave applications, payroll viewing, staff directory access, and internal messaging.

## ✨ Features

### 🔐 Authentication

-   Employee ID/Email and password login
-   Biometric authentication (Fingerprint/Face ID)

### 🏠 Dashboard

-   Personalized greetings with employee name
-   Casual leave balance overview with visual indicators
-   Quick access shortcuts (Directory, Payslip, Attendance)
-   Upcoming events and tasks timeline
-   My tasks with priority indicators
-   System notifications and alerts
-   Pending approvals tracking

### 📅 Attendance Management

-   Daily attendance tracking
-   Monthly attendance overview
-   Real-time status indicators (Present, Late, Absent)
-   Historical attendance records
-   Location-based check-in visualization

### 🏖️ Leave Management

-   Multi-step leave application process
-   Three leave types: Casual, Sick, Emergency
-   Date range selection with calendar picker
-   Leave reason and description
-   Task handover to colleagues
-   Manager approval workflow
-   Leave balance tracking
-   Confirmation notifications

### 💰 Payroll System

-   Monthly salary slips
-   Detailed earnings breakdown:
    -   Basic Salary
    -   House Rent Allowance
    -   Medical Allowance
    -   Conveyance
-   Deductions display:
    -   Tax (TDS)
    -   Provident Fund
-   Net pay calculation
-   Month-wise navigation
-   PDF generation and sharing
-   Download payslip functionality

### 👥 Staff Directory

-   Complete employee directory
-   Department-wise filtering (Engineering, Design, Marketing, HR)
-   Search functionality
-   Employee contact details
-   Direct call, email, and chat options
-   Employee profile viewing
-   Organizational hierarchy

### 🔔 Notifications

-   Dual notification system:
    -   My Alerts (personal notifications)
    -   Notice Board (company-wide announcements)
-   Categorized notifications:
    -   Critical alerts (server maintenance, system updates)
    -   HR policy updates
    -   Event notifications with attachments
    -   Leave approvals/rejections
    -   Login attempt tracking
-   Real-time notification badges

### 🤖 AI Assistant

-   Smart HR policy assistant powered by Gemini AI
-   Natural language policy queries
-   Context-aware responses grounded in company policies
-   Real-time chat interface
-   Quick answers to HR-related questions
-   Google Search integration for comprehensive information

### 💬 Messaging

-   Chat inbox with conversation list
-   Unread message indicators
-   Individual chat details screen
-   Message timestamps and read status
-   File attachment display (PDF, documents)
-   User avatar and online status
-   Search and filter conversations

### 👤 Profile Management

-   Personal information display
-   Work information:
    -   Department
    -   Reporting manager
    -   Desk location
    -   Employee ID
-   Contact details (phone, email)
-   Profile photo and cover image
-   Edit profile functionality
-   Settings and preferences

### 📚 Resources & Learning

-   Training courses with detailed information
-   Course progress tracking
-   Video lectures and materials
-   Document library:
    -   Employee Handbook
    -   Insurance Policy
    -   Technical Documentation
-   Category-based organization
-   Course enrollment and completion
-   Certificate generation
-   Instructor information

## 🎨 UI Screenshots

### Authentication & Dashboard

<p align="center">
  <img src="screenshot_of_ui/login.png" alt="Login Screen" width="250"/>
  <img src="screenshot_of_ui/dashboard.png" alt="Dashboard" width="250"/>
  <img src="screenshot_of_ui/meeting_details.png" alt="Meeting Details" width="250"/>
</p>

### Attendance & Leave Management

<p align="center">
  <img src="screenshot_of_ui/attendance.png" alt="Attendance" width="250"/>
  <img src="screenshot_of_ui/leave_application_step_1.png" alt="Leave Request Step 1" width="250"/>
  <img src="screenshot_of_ui/leave_application_step_2.png" alt="Leave Request Step 2" width="250"/>
</p>

<p align="center">
  <img src="screenshot_of_ui/leave_application_step_3.png" alt="Leave Request Step 3" width="250"/>
  <img src="screenshot_of_ui/leave_application_date_picker.png" alt="Date Picker" width="250"/>
  <img src="screenshot_of_ui/leave_application_confirmation_snackbar.png" alt="Confirmation" width="250"/>
</p>

<p align="center">
  <img src="screenshot_of_ui/leave_request_details.png" alt="Leave Request Details" width="250"/>
</p>

### Communication & Notifications

<p align="center">
  <img src="screenshot_of_ui/chat_inbox.png" alt="Chat Inbox" width="250"/>
  <img src="screenshot_of_ui/chat_details.png" alt="Chat Details" width="250"/>
  <img src="screenshot_of_ui/notification_alert.png" alt="My Alerts" width="250"/>
</p>

<p align="center">
  <img src="screenshot_of_ui/notification_notice.png" alt="Notice Board" width="250"/>
  <img src="screenshot_of_ui/notice_details.png" alt="Notice Details" width="250"/>
  <img src="screenshot_of_ui/ai_assistant.png" alt="AI Assistant" width="250"/>
</p>

### Employee Directory & Payroll

<p align="center">
  <img src="screenshot_of_ui/staff_directory.png" alt="Staff Directory" width="250"/>
  <img src="screenshot_of_ui/staff_profile.png" alt="Staff Profile" width="250"/>
  <img src="screenshot_of_ui/payslip.png" alt="Payslip" width="250"/>
</p>

<p align="center">
  <img src="screenshot_of_ui/payslip_access_request_review.png" alt="Access Request Review" width="250"/>
</p>

### Profile & Resources

<p align="center">
  <img src="screenshot_of_ui/profile.png" alt="My Profile" width="250"/>
  <img src="screenshot_of_ui/resources.png" alt="Learning Resources" width="250"/>
  <img src="screenshot_of_ui/course_details.png" alt="Course Details" width="250"/>
</p>

## 🛠️ Technologies & Architecture

### Core Technologies

-   **Framework:** Flutter 3.x
-   **Language:** Dart
-   **State Management:** GetX
-   **Platform:** Android & iOS

### Key Dependencies

```yaml
dependencies:
    get: ^4.6.6 # State management & routing
    flutter_svg: ^2.0.10+1 # SVG rendering
    pdf: ^3.11.1 # PDF generation
    printing: ^5.13.2 # PDF sharing
    path_provider: ^2.1.4 # File system access
```

### Architecture

-   **Pattern:** MVC with GetX
-   **State Management:** Reactive GetX controllers
-   **Navigation:** GetX routing
-   **UI Components:** Modular and reusable widgets

## 📂 Project Structure

```
smart_employee_management/
├── lib/
│   ├── main.dart                           # App entry point
│   │
│   ├── controllers/                        # GetX Controllers
│   │   ├── login_controller.dart           # Login state management
│   │   ├── bottom_navigation_bar_controller.dart
│   │   ├── dashboard_task_tab_controller.dart
│   │   ├── leave_application_controller.dart
│   │   ├── payslip_controller.dart
│   │   ├── attendance_controller.dart
│   │   ├── gemini_controller.dart          # AI Assistant controller
│   │   ├── chat_inbox_controller.dart      # Messaging controller
│   │   ├── notification_controller.dart    # Notifications controller
│   │   ├── staff_directory_controller.dart # Staff directory controller
│   │   ├── my_profile_controller.dart      # Profile controller
│   │   └── resources_controller.dart       # Learning resources controller
│   │
│   ├── views/                              # UI Screens
│   │   ├── LoginScreen/
│   │   │   └── login_screen.dart
│   │   ├── HomeScreen/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── casual_balance_card.dart
│   │   │       ├── dashboard_quick_access.dart
│   │   │       ├── grettings_and_notification.dart
│   │   │       ├── pending_approvals.dart
│   │   │       ├── tab_button.dart
│   │   │       ├── timeline_items_due_task.dart
│   │   │       └── timeline_items_meeting.dart
│   │   ├── AttendanceScreen/
│   │   │   └── attendance_screen.dart
│   │   ├── LeaveApplication/
│   │   │   ├── leave_application_step_one.dart
│   │   │   ├── leave_application_step_two.dart
│   │   │   └── leave_application_step_three.dart
│   │   ├── PayslipScreen/
│   │   │   └── payslip_screen.dart
│   │   ├── StaffDirectory/
│   │   │   └── staff_directory_screen.dart
│   │   ├── SingleStaffProfile/
│   │   │   └── single_staff_profile_screen.dart
│   │   ├── ChatInboxScreen/                # Messaging
│   │   │   └── chat_inbox_screen.dart
│   │   ├── ChatDetailsScreen/
│   │   │   └── chat_details_screen.dart
│   │   ├── NotificationScreen/
│   │   │   └── notification_screen.dart
│   │   ├── NotificationDetailScreen/
│   │   │   └── notification_detail_screen.dart
│   │   ├── MyProfile/
│   │   │   └── my_profile_screen.dart
│   │   ├── Resources/                      # Learning & Training
│   │   │   └── resources_screen.dart
│   │   ├── CourseDetailsScreen/
│   │   │   └── course_details_screen.dart
│   │   ├── AIAssistantScreen/              # AI Assistant
│   │   │   ├── ai_assistant_screen.dart
│   │   │   └── widgets/
│   │   │       ├── chat_bubble.dart
│   │   │       └── gemini_services.dart    # Gemini API integration
│   │   └── NavBarView/
│   │       └── nav_bar_view.dart           # Bottom navigation
│   │
│   ├── widgets/                            # Global Widgets
│   │   └── custom_button.dart
│   │
│   └── utils/                              # Utilities
│       ├── colors.dart                     # App color scheme
│       └── pdf_generator.dart              # PDF generation utility
│
├── assets/
│   └── svg/                                # SVG assets
│
├── screenshot_of_ui/                       # App screenshots
│
├── .env                                    # Environment variables (not tracked)
├── .env.example                            # Environment template
│
├── android/                                # Android configuration
├── ios/                                    # iOS configuration
│
├── pubspec.yaml                            # Dependencies
└── README.md
```

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK 3.0 or higher
-   Dart SDK 3.0 or higher
-   Android Studio / VS Code
-   Android SDK (for Android development)
-   Xcode (for iOS development - macOS only)

### Installation

1. **Clone the repository**

    ```bash
    git clone https://github.com/newbie-saimur/smart-employee-management-app-flutter.git
    cd smart-employee-management-app-flutter
    ```

2. **Install dependencies**

    ```bash
    flutter pub get
    ```

3. **Set up environment variables**

    Create a `.env` file in the root directory and add your Gemini API key:

    ```bash
    # Copy the example file
    cp .env.example .env
    ```

    Edit `.env` and add your actual API key:

    ```env
    GEMINI_API_KEY=your_actual_gemini_api_key_here
    ```

    > **🔑 Get Gemini API Key:** Visit [Google AI Studio](https://makersuite.google.com/app/apikey) to get your free API key

4. **Run the app**

    ```bash
    flutter run
    ```

### Build APK/IPA

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release
```

## 🎯 Implementation Status

### ✅ Completed Features

-   [x] Login screen with validation
-   [x] Biometric authentication UI
-   [x] Bottom navigation with 4 tabs
-   [x] Dashboard with leave balance card
-   [x] Quick access shortcuts
-   [x] Timeline/Task tabs with dynamic switching
-   [x] Attendance screen UI
-   [x] 3-step leave application flow
-   [x] Date picker integration
-   [x] Payslip screen with month navigation
-   [x] PDF generation and sharing for payslips
-   [x] Staff directory with filtering
-   [x] Notification center (Alerts & Notice Board)
-   [x] Chat screens UI
-   [x] Profile screen
-   [x] Knowledge base UI
-   [x] Biometric authentication functionality
-   [x] Responsive design for multiple screen sizes
-   [x] GetX state management integration
-   [x] Custom reusable widgets

### 🚧 Pending Features

-   [ ] Backend API integration
-   [ ] Real authentication system
-   [ ] Database integration
-   [ ] Push notifications
-   [ ] Real-time messaging
-   [ ] File upload functionality
-   [ ] Location-based attendance tracking
-   [ ] Search functionality implementation

## 🎓 Academic Project

This project was developed as part of a Mobile Application Design course lab project to demonstrate:

-   Modern Flutter development practices
-   State management with GetX
-   Responsive UI/UX design
-   PDF generation and file handling
-   Navigation and routing
-   Custom widget creation
-   Clean code architecture

<!-- ## 👤 Author -->

<!-- **Saimur Rahman** -->

<!-- -   GitHub: [@newbie-saimur](https://github.com/newbie-saimur) -->
<!-- -   Project: [smart-employee-management-app-flutter](https://github.com/newbie-saimur/smart-employee-management-app-flutter) -->

---

_Last Updated: December 2025_
