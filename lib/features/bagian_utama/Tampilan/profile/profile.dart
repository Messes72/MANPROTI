import 'package:flutter/material.dart';
import '../profile_yayasan/widgets/tombol_back.dart';

// Read-only Profile page
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TombolBack(),
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ), // Replace with your image URL
                      ),
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                        // Handle profile picture edit (optional)
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(height: 20),
                    buildReadOnlyField("Jehezkiel"),
                    buildReadOnlyField("Louis"),
                    buildReadOnlyField("JL. Ir Soekarno 20"),
                    buildReadOnlyField("jehezkiel@gmail.com"),
                    buildReadOnlyField("08178787878"),
                    buildReadOnlyField("9 November 1992"),
                    buildReadOnlyField("**********", isPassword: true),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          // Edit button at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileEdit(
                          firstName: "Jehezkiel",
                          lastName: "Louis",
                          address: "JL. Ir Soekarno 20",
                          email: "jehezkiel@gmail.com",
                          phone: "08178787878",
                          dob: "9 November 1992",
                        ),
                      ),
                    );
                  },
                  child: Text("Edit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReadOnlyField(String value, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: value,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ProfileEdit page where the fields are editable
class ProfileEdit extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String phone;
  final String dob;

  const ProfileEdit({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.phone,
    required this.dob,
  });

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late String firstName;
  late String lastName;
  late String address;
  late String email;
  late String phone;
  late String dob;

  @override
  void initState() {
    super.initState();
    firstName = widget.firstName;
    lastName = widget.lastName;
    address = widget.address;
    email = widget.email;
    phone = widget.phone;
    dob = widget.dob;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TombolBack(),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                        // Handle profile picture edit
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(height: 20),
                    buildEditableField(firstName, onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    }),
                    buildEditableField(lastName, onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    }),
                    buildEditableField(address, onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    }),
                    buildEditableField(email, onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                    buildEditableField(phone, onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    }),
                    buildEditableField(dob, onChanged: (value) {
                      setState(() {
                        dob = value;
                      });
                    }),
                    buildEditableField("**********", isPassword: true, onChanged: (String ) {  }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'firstName': firstName,
                  'lastName': lastName,
                  'address': address,
                  'email': email,
                  'phone': phone,
                  'dob': dob,
                });
              },
              child: Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableField(String value, {bool isPassword = false, required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: value,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
