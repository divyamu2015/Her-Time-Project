import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:circle_nav_bar/circle_nav_bar.dart';

class CyclePieChartPage extends StatefulWidget {
  const CyclePieChartPage({
    super.key,
    required this.periodLength,
    required this.fertileLength,
    required this.ovulationLength,
  });
  final int periodLength;
  final int fertileLength;
  final int ovulationLength;

  @override
  State<CyclePieChartPage> createState() => _CyclePieChartPageState();
}

class _CyclePieChartPageState extends State<CyclePieChartPage> {
  late PageController pageController;

  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cycle Overview"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  borderData: FlBorderData(show: false),
                  sections: [
                    PieChartSectionData(
                      color: Colors.redAccent,
                      value: widget.periodLength.toDouble(),
                      title: 'Period',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: widget.fertileLength.toDouble(),
                      color: Colors.greenAccent,
                      title: "Fertile",
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: widget.ovulationLength.toDouble(),
                      color: const Color.fromARGB(255, 112, 33, 8),
                      title: "Ovulation",
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // PieChartSectionData(
                    //   value: 10,
                    //   color: Colors.blueGrey,
                    //   title: "Other",
                    //   radius: 60,
                    //   titleStyle: const TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildLegend(Colors.redAccent, "Period Days"),
            _buildLegend(Colors.greenAccent, "Fertile Window"),
            _buildLegend(
              const Color.fromARGB(255, 112, 33, 8),
              "Ovulation Day",
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.history_outlined, color: Colors.deepPurple),
          Icon(Icons.book_rounded, color: Colors.deepPurple),
          Icon(Icons.home, color: Colors.deepPurple),
          Icon(Icons.production_quantity_limits, color: Colors.deepPurple),
          Icon(Icons.logout, color: Colors.deepPurple),
        ],
        inactiveIcons: const [
          Text("Cycle History"),
          Text("Books"),
          Text("Home"),
          Text("buy Products"),
          Text("Logout"),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
          if (index == 2) {
            // Navigate to My Booking page
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ,
            //   ),
            // );
          } else if (index == 0) {
            // Navigate to Logout page OR perform logout then navigate
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) =>),
            // );
            // Or perform logout logic here then navigate
          } else if (index == 1) {
            // Navigate to Logout page OR perform logout then navigate
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) =>),
            // );
            // Or perform logout logic here then navigate
          } else if (index == 3) {
            // Navigate to Logout page OR perform logout then navigate
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) =>),
            // );
            // Or perform logout logic here then navigate
          }
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: const Color.fromARGB(255, 248, 219, 175),
        elevation: 10,
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
