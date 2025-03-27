import 'package:deafproject/auth/profile.dart';
import 'package:deafproject/db_helper.dart';
import 'package:deafproject/detect_sign_language.dart';
import 'package:deafproject/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Learn extends StatefulWidget {
  const Learn({Key? key}) : super(key: key);

  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  int index = 1;
  List<VideoPlayerController> _controllers = [];
  Future<void> checkAndShowReminderDialog(BuildContext context) async {
    // Assume the current logged-in user has id = 1.
    final int currentUserId = 1;

    final timers = await DBHelper().getTimersByUser(currentUserId);
    if (timers.isNotEmpty) {
      // For demo, we take the first timer. In a real app, you might iterate or select the most urgent.
      final timer = timers.first;
      bool? result = await showGeneralDialog<bool>(
        context: context,
        barrierDismissible: false,
        barrierLabel: "Reminder",
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SizedBox.shrink(),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: FadeTransition(
              opacity: animation,
              child: AlertDialog(
                backgroundColor: const Color(0xFF002244),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    const Icon(Icons.sentiment_dissatisfied,
                        color: Colors.white),
                    const SizedBox(width: 8),
                    Text("Reminder".tr,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
                content: Text(
                  "You have a reminder scheduled for ${timer['timer_time']}.\n\nWould you like to mark with description ( ${timer['description']} )it as done or be reminded later?"
                      .tr,
                  style: const TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("OK".tr,
                        style: const TextStyle(color: Colors.green)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Remind me later".tr,
                        style: const TextStyle(color: Colors.orange)),
                  ),
                ],
              ),
            ),
          );
        },
      );
      if (result == true) {
        // User tapped OK: remove the timer.
        await DBHelper().deleteTimer(timer['id']);
        // Optionally cancel any scheduled local notification.
      } else if (result == false) {
        // User tapped "Remind me later": Reschedule the timer (e.g., 10 minutes later).
        DateTime newTime = DateTime.now().add(const Duration(minutes: 10));
        String formattedTime =
            "${newTime.year}-${newTime.month.toString().padLeft(2, '0')}-${newTime.day.toString().padLeft(2, '0')} ${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}";
        await DBHelper()
            .updateTimer(timer['id'], {'timer_time': formattedTime});
        // Optionally, schedule a local notification using flutter_local_notifications.
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkAndShowReminderDialog(context);
    _initializeVideos();
  }

  void _initializeVideos() {
    List<String> videoPaths = [
      "assets/new/video1.mp4",
      "assets/new/video2.mp4",
      "assets/new/video3.mp4",
      "assets/new/video4.mp4"
    ];

    for (String path in videoPaths) {
      VideoPlayerController controller = VideoPlayerController.asset(path);

      controller.initialize().then((_) {
        setState(() {}); // Refresh UI after initialization
      }).catchError((error) {
        print("Error initializing video: $error"); // Debugging log
      });

      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _selectedLanguage = 'en';
  Future<void> showAppExitConfirmationDialog(BuildContext context) async {
    bool? exitConfirmed = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Exit App",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              backgroundColor: const Color(0xFF002244),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  const Icon(Icons.sentiment_dissatisfied, color: Colors.white),
                  const SizedBox(width: 8),
                  Text("Exit App".tr,
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.sentiment_dissatisfied,
                      color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Are you sure you want to exit the application?".tr,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel".tr,
                      style: const TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sentiment_dissatisfied,
                          color: Colors.redAccent),
                      const SizedBox(width: 4),
                      Text("Exit".tr,
                          style: const TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (exitConfirmed == true) {
      // Exit the entire application
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) async {
          setState(() {
            index = value;
          });
          if (index == 0) {
            await showAppExitConfirmationDialog(context);
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetectSignLanguagePage()),
            );
          }
          if (index == 2) {
            Get.to(() => FAQPage());
          }
        },
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.green),
        selectedIconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Color(0xFF002244),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back), label: "Back".tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new), label: "Detect sign".tr),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Save".tr),
        ],
        showUnselectedLabels: true,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await showAppExitConfirmationDialog(context);
          },
        ),
        title: Text("Deaf_App".tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  250.0,
                  100.0,
                  _selectedLanguage == 'en' ? 0.0 : 250.0,
                  0.0,
                ),
                items: [
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                  PopupMenuItem<String>(
                    value: 'ar',
                    child: Text('Arabic'),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value == 'en' ? 'English' : 'Arabic';
                    Get.updateLocale(Locale(value));
                  });
                }
              });
            },
            icon: Icon(Icons.change_circle),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => FAQPage());
            },
            icon: Icon(Icons.question_mark),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Explore Video Lessons".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.separated(
                /*  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),*/
                separatorBuilder: (context, index) => SizedBox(
                  height: 25,
                ),
                itemCount: 6, // 4 videos + 2 images
                itemBuilder: (context, index) {
                  if (index < 4) {
                    return _buildVideoPlayer(_controllers[index]);
                  } else {
                    return _buildImage(index == 4
                        ? "assets/new/photo1.jpg"
                        : "assets/new/photo2.jpg");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(VideoPlayerController controller) {
    return controller.value.isInitialized
        ? Container(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(controller),
                  Positioned(
                    bottom: 100,
                    child: IconButton(
                      icon: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          controller.value.isPlaying
                              ? controller.pause()
                              : controller.play();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            width: Get.width * 8 / 10,
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildImage(String assetPath) {
    return Image.asset(assetPath, fit: BoxFit.cover);
  }
}
