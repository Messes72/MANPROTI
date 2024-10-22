import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile/profile.dart';
import 'services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserProfile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: FutureBuilder<UserProfile>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final profile = snapshot.data!;
              return Column(
                children: [
                  Text('First Name: ${profile.firstName}'),
                  Text('Last Name: ${profile.lastName}'),
                  Text('Address: ${profile.address}'),
                  Text('Email: ${profile.email}'),
                  Text('Phone: ${profile.phone}'),
                  Text('DOB: ${profile.dob}'),
                  profile.profilePicture != null
                      ? Image.network(profile.profilePicture!)
                      : SizedBox.shrink(),
                ],
              );
            } else {
              return Text('No profile found');
            }
          },
        ),
      ),
    );
  }
}