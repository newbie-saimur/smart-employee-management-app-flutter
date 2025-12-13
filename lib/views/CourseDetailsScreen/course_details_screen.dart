import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

const Color _kPrimaryBlue = Color(0xFF2563EB);
const Color _kDarkSlate = Color(0xFF1E293B);
const Color _kMutedText = Color(0xFF64748B);
const Color _kCompletedGreen = Color(0xFF0F766E);
const Color _kWarningOrange = Color(0xFFF97316);

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late TabController _tabController;

  final Map courseDetails = {
    "courseName": "Flutter Advanced Patterns",
    "author": "Saimur Rahman",
    "ratings": 4.9,
    "durationTotalHours": 32,
    "priceUSD": 49,
    "modules": [
      {
        "moduleName": "State Management with GetX",
        "moduleDuration": "45 Min",
        "completed": true,
      },
      {
        "moduleName": "Advanced Routing and Deep Linking",
        "moduleDuration": "30 Min",
        "completed": false,
      },
      {
        "moduleName": "Streams and RxDart Patterns",
        "moduleDuration": "55 Min",
        "completed": false,
      },
      {
        "moduleName": "Custom Painters and Animations",
        "moduleDuration": "40 Min",
        "completed": false,
      },
      {
        "moduleName": "Testing and CI/CD Setup",
        "moduleDuration": "60 Min",
        "completed": false,
      },
      {
        "moduleName": "Flutter Web and Desktop Integration",
        "moduleDuration": "45 Min",
        "completed": false,
      },
      {
        "moduleName": "Final Project Implementation",
        "moduleDuration": "120 Min",
        "completed": false,
      },
      {
        "moduleName": "Reactive Programming with Bloc/Cubit",
        "moduleDuration": "70 Min",
        "completed": false,
      },
      {
        "moduleName": "Dependency Injection (DI) with GetIt",
        "moduleDuration": "50 Min",
        "completed": false,
      },
      {
        "moduleName": "Native Platform Integration (Method Channels)",
        "moduleDuration": "65 Min",
        "completed": false,
      },
      {
        "moduleName": "Performance Optimization (Profiling)",
        "moduleDuration": "40 Min",
        "completed": false,
      },
      {
        "moduleName": "Server-Driven UI (SDUI) Concepts",
        "moduleDuration": "35 Min",
        "completed": false,
      },
      {
        "moduleName": "Accessibility and Internationalization",
        "moduleDuration": "50 Min",
        "completed": false,
      },
      {
        "moduleName": "Security Best Practices in Flutter",
        "moduleDuration": "30 Min",
        "completed": false,
      },
    ],
    "playlistCount": 14,
    "progressPercentage": 0.07,
  };

  final String _flutterDescription = '''
This advanced course is designed for experienced Flutter developers aiming to master professional patterns, large-scale application architecture, and performance optimization techniques. You will move beyond basic state management and delve into robust, reactive, and scalable solutions required for production-ready corporate applications.\n

Course Focus Areas:
• State Management Mastery: Deep dive into GetX and contrasting patterns like Bloc/Cubit for highly reactive and predictable application states.\n
• Architecture & Scaling: Implementing Clean Architecture principles, effective Dependency Injection using GetIt, and understanding Server-Driven UI (SDUI) concepts for dynamic content delivery.\n
• Performance & Quality: Comprehensive training on profiling for performance optimization, establishing strong testing practices, and setting up Continuous Integration/Continuous Deployment (CI/CD) pipelines.\n
• Platform Integration: Mastering advanced routing, deep linking, and crucial Native Platform Integration using Method Channels for utilizing device-specific features.\n
• Modern Standards: Implementing best practices for Security, and ensuring application quality through Accessibility and Internationalization.
''';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF64748B),
              size: 28,
            ),
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 8),
          Text(
            courseDetails['courseName'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _kDarkSlate,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withValues(alpha: .1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: _controller.value.isInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        // Play/Pause Button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          color: _kPrimaryBlue,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: _kPrimaryBlue),
                    ),
            ),

            const SizedBox(height: 16),

            Text(
              courseDetails['courseName'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _kDarkSlate,
              ),
            ),
            const SizedBox(height: 5),

            // Author Row
            Row(
              children: [
                const Text(
                  'Created by ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: _kMutedText,
                  ),
                ),
                Text(
                  courseDetails['author'],
                  style: const TextStyle(
                    color: _kPrimaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Ratings, Duration, Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Ratings
                    const Icon(Icons.star_border_rounded, color: _kMutedText),
                    const SizedBox(width: 4),
                    Text(
                      "${courseDetails['ratings']}",
                      style: const TextStyle(
                        color: _kMutedText,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Duration
                    const Icon(Icons.watch_later_outlined, color: _kMutedText),
                    const SizedBox(width: 4),
                    Text(
                      "${courseDetails['durationTotalHours']} Hours",
                      style: const TextStyle(
                        color: _kMutedText,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Price
                Text(
                  "\$${courseDetails['priceUSD']}",
                  style: const TextStyle(
                    color: _kPrimaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(4),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: _kMutedText,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: _kDarkSlate,
                  borderRadius: BorderRadius.circular(12),
                ),
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(text: "Playlist (${courseDetails['playlistCount']})"),
                  const Tab(text: "Description"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Playlist View
                  ListView.builder(
                    padding: const EdgeInsets.only(top: 16),
                    itemCount: courseDetails['playlistCount'],
                    itemBuilder: (context, index) {
                      final data = courseDetails['modules'][index];
                      final isCompleted = data['completed'] == true;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? _kCompletedGreen
                                : _kPrimaryBlue.withValues(alpha: .1),
                          ),
                          child: Icon(
                            isCompleted
                                ? Icons.check_rounded
                                : Icons.play_arrow_rounded,
                            size: 24,
                            color: isCompleted ? Colors.white : _kPrimaryBlue,
                          ),
                        ),
                        title: Text(
                          data['moduleName'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _kDarkSlate,
                          ),
                        ),
                        subtitle: Text(
                          data['moduleDuration'],
                          style: const TextStyle(
                            color: _kMutedText,
                            fontSize: 13,
                          ),
                        ),
                        trailing: isCompleted
                            ? const Icon(
                                Icons.check_circle,
                                color: _kCompletedGreen,
                                size: 24,
                              )
                            : Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _kWarningOrange.withValues(alpha: .1),
                                ),
                                child: const Icon(
                                  Icons.lock_outline,
                                  size: 18,
                                  color: _kWarningOrange,
                                ),
                              ),
                      );
                    },
                  ),

                  // Description View
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _flutterDescription,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: _kDarkSlate.withValues(alpha: .8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 20,
          top: 10,
        ),
        child: Row(
          children: [
            // Calendar Button
            SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kWarningOrange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                child: const Icon(Icons.calendar_month_outlined, size: 24),
              ),
            ),
            const SizedBox(width: 12),
            // Enroll Button
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Enroll Now",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
