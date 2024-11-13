import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReportReviewPage(),
    );
  }
}

class ReportReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TombolBack(),
        title: Text(
          'Review',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Beras',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  sections: getSections(),
                  centerSpaceRadius: 60,
                  sectionsSpace: 4,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Profile Yayasan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.orangeAccent,
        value: 2,
        title: '21 August, 2 kg',
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.redAccent,
        value: 3,
        title: '1 September, 3 kg',
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.grey,
        value: 4,
        title: '22 November, 4 kg',
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.greenAccent,
        value: 9,
        title: '30 November, 9 kg',
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ];
  }
}
