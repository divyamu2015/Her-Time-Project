import 'package:flutter/material.dart';


class PeriodTipsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dos = [
    {
      "icon": Icons.local_drink,
      "title": "Stay hydrated",
      "desc": "Drink plenty of water to reduce bloating and cramps.",
    },
    {
      "icon": Icons.restaurant,
      "title": "Eat balanced meals",
      "desc": "Focus on iron-rich foods (spinach, beans, fish, lean meat) and magnesium-rich foods (nuts, bananas, dark chocolate).",
    },
    {
      "icon": Icons.fitness_center,
      "title": "Light exercise or yoga",
      "desc": "Walking, stretching, or gentle yoga can relieve cramps.",
    },
    {
      "icon": Icons.clean_hands,
      "title": "Maintain hygiene",
      "desc": "Change pads/tampons/menstrual cups every 4–6 hours.",
    },
    {
      "icon": Icons.local_fire_department,
      "title": "Use heat therapy",
      "desc": "A heating pad or warm shower eases cramps.",
    },
    {
      "icon": Icons.bedtime,
      "title": "Get enough rest",
      "desc": "Sleep well to balance mood and energy.",
    },
    {
      "icon": Icons.track_changes,
      "title": "Track your cycle",
      "desc": "Helps predict periods, ovulation, and fertile window.",
    },
    {
      "icon": Icons.checkroom,
      "title": "Wear comfortable clothes",
      "desc": "Loose cotton clothes reduce irritation.",
    },
    {
      "icon": Icons.spa,
      "title": "Practice relaxation",
      "desc": "Deep breathing or meditation helps with mood swings.",
    },
  ];

  final List<Map<String, dynamic>> donts = [
    {
      "icon": Icons.clear,
      "title": "Don’t skip meals",
      "desc": "Skipping food can worsen fatigue and dizziness.",
    },
    {
      "icon": Icons.local_cafe,
      "title": "Avoid excess caffeine/alcohol",
      "desc": "Can increase bloating, irritability, and cramps.",
    },
    {
      "icon": Icons.smoking_rooms,
      "title": "Don’t smoke",
      "desc": "Smoking may make cramps worse.",
    },
    {
      "icon": Icons.fitness_center,
      "title": "Avoid very heavy workouts",
      "desc": "Intense exercise may increase fatigue; prefer light activity.",
    },
    {
      "icon": Icons.warning,
      "title": "Don’t ignore severe symptoms",
      "desc": "Heavy bleeding, unbearable pain, or irregular cycles should be checked by a doctor.",
    },
    {
      "icon": Icons.fastfood,
      "title": "Avoid junk & salty food",
      "desc": "Can cause bloating and water retention.",
    },
    {
      "icon": Icons.accessibility_new,
      "title": "Don’t stay in one position too long",
      "desc": "Move around to improve blood circulation.",
    },
    {
      "icon": Icons.sanitizer,
      "title": "Don’t use scented products",
      "desc": "May cause irritation or infections.",
    },
    {
      "icon": Icons.block,
      "title": "Don’t wear tight or synthetic clothes",
      "desc": "Can trap heat and moisture.",
    },
  ];

   PeriodTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Period Do’s & Don’ts", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.pink],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                sectionTitle("✔ Do’s", Colors.pink),
                ...dos.map((item) => tipCard(item, true)),
                SizedBox(height: 20),
                sectionTitle("❌ Don’ts", Colors.purple),
                ...donts.map((item) => tipCard(item, false)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget tipCard(Map<String, dynamic> item, bool isDos) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: isDos ? Colors.white : Colors.purple,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isDos ? Colors.pink : Colors.purple,
          child: Icon(item["icon"], color: Colors.white),
        ),
        title: Text(
          item["title"],
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: isDos ? Colors.pink : Colors.purple),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item["desc"],
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
