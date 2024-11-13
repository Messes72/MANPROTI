import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_awal/tampilan/login/login.dart';
import 'package:manpro/features/bagian_utama/Tampilan/donation/donation.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/profile.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/profile_yayasan.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event/event.dart';
import 'package:manpro/features/bagian_utama/Tampilan/report/report.dart';
import 'package:manpro/utils/constants/image_string.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(  // Changed from drawer to endDrawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,  // Customize header background
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with real image
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Jehezkiel Louis", // User's name
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Get.to(() => Profile());  // Navigate to profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);  // Close drawer and stay on home
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Attending Event'),
              onTap: () {
                Get.to(() => Login());  // Example navigation to Login or other page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Get.to(() => ProfileYayasan());
                // Navigate to About Us page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Perform logout logic here
                Get.to(() => Login());
              },
            ),
          ],
        ),
      ),
      body: Container(
        // Background app
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 7.0, 12.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gambar logo yayasan
                  Container(
                    padding: const EdgeInsets.only(left: 13.0),
                    width: 120,
                    height: 120,
                    child: Transform.scale(
                      scale: 1.8,
                      child: Image.asset(
                        'assets/logos/logo yayasan.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Pencetan garis tiga (Hamburger icon)
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();  // This opens the drawer from the right
                      },
                      icon: Icon(Icons.menu),  // Use the hamburger menu icon
                    ),
                  ),
                ],
              ),
              // Tulisan halo
              const Text(
                'Halo, Jehezkiel Louis !',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 27.0),

              // Tulisan event information
              const Text(
                'Event Information',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 15.0),

              // Box gambar event
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://via.placeholder.com/350x150',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                                (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 62.5),

              //Menu di home screen
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Container(
                  height: 275.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22.5, 15.0, 22.5, 15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Bagian UI Events
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () => Get.to(() => EventsApp()),
                                    icon: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 7.0),
                                      child: Transform.scale(
                                        scale: 1.55,
                                        child: Image.asset(
                                          'assets/icons/icon event.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Events',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Bagian UI Article
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 3.0),
                                      child: Transform.scale(
                                        scale: 1.18,
                                        child: Image.asset(
                                          'assets/icons/icon article.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Article',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Bagian UI Profile Yayasan
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () => Get.to(() => ProfileYayasan()),
                                    icon: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          3.0, 0.0, 0.0, 0.0),
                                      child: Transform.scale(
                                        scale: 1.28,
                                        child: Image.asset(
                                          YPKImages.icon_profile_yayasan,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Profile\nYayasan',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Bagian UI Donation
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () => Get.to(() => DonationApp()),
                                    icon: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 2.0, 0.0, 1.0),
                                      child: Transform.scale(
                                        scale: 1.28,
                                        child: Image.asset(
                                          'assets/icons/icon donation.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Donation',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Bagian UI Agenda
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(13.0, 2.0, 0.0, 0.0),
                                      child: Transform.scale(
                                        scale: 1.18,
                                        child: Image.asset(
                                          'assets/icons/icon agenda.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Agenda',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Bagian UI Report
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: IconButton(
                                    onPressed: () => Get.to(() => ReportApp()),
                                    icon: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 3.0, 0.0),
                                      child: Transform.scale(
                                        scale: 1.1,
                                        child: Image.asset(
                                          'assets/icons/icon report.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Report',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
