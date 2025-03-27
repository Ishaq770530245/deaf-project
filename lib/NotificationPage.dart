import 'package:deafproject/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // For demonstration, we assume the logged-in user has id = 1.
  final int currentUserId = 1;
  List<Map<String, dynamic>> timers = [];
  bool _isLoading = false;

  // Setting variable to control whether to show date & time fields.
  // When false, no date/time is shown and the timer defaults to now + 10 minutes.
  bool _showTimerFields = false;

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  Future<void> _loadTimers() async {
    final data = await DBHelper().getTimersByUser(currentUserId);
    setState(() {
      timers = data;
    });
  }

  Future<void> _deleteTimer(int timerId) async {
    await DBHelper().deleteTimer(timerId);
    Get.snackbar("Deleted".tr, "Timer deleted successfully".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 6,
        icon: const Icon(Icons.delete, color: Colors.white));
    _loadTimers();
  }

  // Settings dialog to toggle the timer input fields.
  Future<void> _showSettingsDialog() async {
    // Create a local variable for the switch value.
    bool localSetting = _showTimerFields;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF002244),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: Text("Timer Settings".tr,
                  style: const TextStyle(color: Colors.white)),
              content: SwitchListTile(
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                title: Text("Enable timer day and hour input".tr,
                    style: const TextStyle(color: Colors.white)),
                value: localSetting,
                onChanged: (value) {
                  // Update the local state inside the dialog.
                  setState(() {
                    localSetting = value;
                  });
                  // Also update the parent state.
                  this.setState(() {
                    _showTimerFields = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close".tr,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showAddTimerDialog() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    final descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF002244),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title:
              Text("Add Timer".tr, style: const TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Only show date and time pickers if the setting is enabled.
                if (_showTimerFields) ...[
                  // Date Picker Field
                  _buildInputField(
                    icon: Icons.date_range,
                    label: selectedDate == null
                        ? "Select Date".tr
                        : "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
                    onTap: () async {
                      DateTime now = DateTime.now();
                      final date = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now,
                        lastDate: DateTime(now.year + 5),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child!,
                          );
                        },
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  // Time Picker Field
                  _buildInputField(
                    icon: Icons.access_time,
                    label: selectedTime == null
                        ? "Select Time".tr
                        : "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child!,
                          );
                        },
                      );
                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                // Description Field (always visible)
                TextField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Description".tr,
                    labelStyle: const TextStyle(color: Colors.white),
                    hintText: "Optional".tr,
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel".tr,
                  style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                // Determine the timer DateTime:
                // If _showTimerFields is true and both date and time are provided,
                // then use them. Otherwise, default to now + 10 minutes.
                final DateTime timerDateTime = (_showTimerFields &&
                        selectedDate != null &&
                        selectedTime != null)
                    ? DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      )
                    : DateTime.now().add(const Duration(minutes: 10));

                // Format the DateTime as a string.
                final formattedDateTime =
                    "${timerDateTime.year}-${timerDateTime.month.toString().padLeft(2, '0')}-${timerDateTime.day.toString().padLeft(2, '0')} ${timerDateTime.hour.toString().padLeft(2, '0')}:${timerDateTime.minute.toString().padLeft(2, '0')}";

                // Create timer map.
                Map<String, dynamic> newTimer = {
                  'user_id': currentUserId,
                  'timer_time': formattedDateTime,
                  'description': descriptionController.text.trim(),
                  'video_url': '', // Optionally add a video URL.
                };

                await DBHelper().insertTimer(newTimer);
                Get.snackbar("Success".tr, "Timer added successfully".tr,
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.green,
                    borderRadius: 6,
                    icon: const Icon(Icons.check_circle, color: Colors.green));
                Navigator.pop(context);
                _loadTimers();
              },
              child: Text("Add Timer".tr,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  /// Helper widget for input-like fields inside the dialog.
  Widget _buildInputField(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerTile(Map<String, dynamic> timer) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(color: Colors.white, width: 1.0),
      ),
      color: Colors.blueGrey[900],
      child: ListTile(
        leading: const Icon(Icons.alarm, color: Colors.white),
        title: Text(
          timer['timer_time'],
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          timer['description'] ?? '',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteTimer(timer['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DBHelper().getTimersByUser(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white)));
          } else {
            final timersData = snapshot.data ?? [];
            if (timersData.isEmpty) {
              return Center(
                  child: Text("No timers found".tr,
                      style: const TextStyle(color: Colors.white)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: timersData.length,
              itemBuilder: (context, index) {
                return _buildTimerTile(timersData[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTimerDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.timer_sharp),
      ),
    );
  }
}
