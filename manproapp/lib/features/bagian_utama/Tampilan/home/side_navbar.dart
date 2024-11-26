import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/Tampilan/event_history/event_history.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/profile.dart';
import 'package:manpro/utils/constants/image_string.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian atas profil pengguna
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color:
                  Color.fromARGB(255, 246, 141, 252), // Change the color here
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, // Outline hitam
                  width: 1.0,
                ),
              ),
            ),
            accountName: Text(
              'Jehezkiel Louis',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            accountEmail: null, // Kosongkan jika tidak ada email
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  YPKImages.gbr_event1), // Ganti dengan path gambar profil
            ),
          ),
          // Tombol My Profile
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity, // Set width to fill the available space
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => const Profile()),
                icon: const Icon(
                  Icons.person,
                  size: 24,
                ),
                label: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ),
          ),
          // Tombol History Event
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity, // Set width to fill the available space
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => EventHistory()),
                icon: const Icon(
                  Icons.history,
                  size: 24,
                ),
                label: const Text(
                  'History Event',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Tombol Logout di bagian bawah
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: SizedBox(
              width: double.infinity, // Set width to fill the available space
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aksi ketika tombol logout ditekan
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 24,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
