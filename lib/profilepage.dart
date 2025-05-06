import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Profile Picture Section
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    "assets/image.png"), // ✅ Replace with actual asset path
              ),
            ),

            // const SizedBox(height: 10),

            // 🔹 User Name & Details
            const Text(
              "Parth", // ✅ Replace with actual user name
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            const Text(
              "Level 10", // ✅ Level indicator
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            // 🔹 Progress Bar with Level Indicator
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.75, // ✅ Progress level (75% completion)
                  minHeight: 10,
                  backgroundColor: Colors.grey[300], // ✅ Subtle background
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //now gimme a row of icons like badges in duolingo pls
// 🔹 Achievement Badges (Duolingo Style)
            Wrap(
              spacing: 12, // ✅ Horizontal spacing between badges
              runSpacing: 10, // ✅ Vertical spacing when wrapping
              alignment: WrapAlignment.center,
              children: [
                _buildBadge(
                    "Consistency King", Icons.verified, Colors.blue, true),
                _buildBadge("Task Master", Icons.task_alt, Colors.green, true),
                _buildBadge(
                    "Goal Achiever", Icons.emoji_events, Colors.orange, true),
                _buildBadge(
                    "Time Guru", Icons.access_time, Colors.purple, true),
                _buildBadge("Habit Builder", Icons.loop, Colors.teal, true),
                _buildBadge("Focus Legend", Icons.center_focus_strong,
                    Colors.red, true),
                _buildBadge(
                    "Learning Champion", Icons.school, Colors.indigo, false),
                _buildBadge("Health Enthusiast", Icons.fitness_center,
                    Colors.pink, false),
                _buildBadge("Ultimate Planner", Icons.calendar_today,
                    Colors.deepOrange, false),
              ],
            ),
            const SizedBox(height: 40),

            // 🔹 User Progress & Stats
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 🔹 Title with Info Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Your Balance Breakdown",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // ✅ Space between text and icon
                        GestureDetector(
                          onTap: () {
                            _showInfoDialog(context, "Balance Breakdown",
                                "This section shows how your daily activities are distributed across Social, Physical, Academic, and Goals to ensure a balanced routine.");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.info_outline,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _buildParameterStat(
                        "Social", "20%", Icons.people, Colors.blueAccent),
                    const Divider(),
                    _buildParameterStat(
                        "Physical", "10%", Icons.fitness_center, Colors.green),
                    const Divider(),
                    _buildParameterStat(
                        "Academics", "90%", Icons.school, Colors.red),
                    const Divider(),
                    _buildParameterStat(
                        "Goals", "10%", Icons.flag, Colors.purple),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterStat(
      String title, String value, IconData icon, Color color) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8), // ✅ Adds uniform spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // ✅ Aligns items neatly
        children: [
          Icon(icon,
              color: color, size: 25), // 🔥 Clean Icon for Each Parameter
          const SizedBox(width: 12), // ✅ Spacing between icon and text
          SizedBox(
            width: 90, // ✅ Fixed width for text to keep alignment uniform
            child: Text(title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12), // ✅ Spacing between text and progress bar

          // ✅ Progress Bar (Properly aligned)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: double.parse(value.replaceAll('%', '')) /
                    100, // ✅ Convert % to double
                minHeight: 8,
                backgroundColor: Colors.grey[300], // ✅ Subtle background
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Info Dialog Function
  void _showInfoDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ✅ Close dialog
              },
              child: Text("Got it"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge(String title, IconData icon, Color color, bool mastered) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color:
                mastered ? color : Colors.grey, // ✅ Gray color if not mastered
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white, // ✅ Muted text if locked
            ),
          ),
        ],
      ),
    );
  }
}
