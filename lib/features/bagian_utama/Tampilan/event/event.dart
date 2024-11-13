import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/profile_yayasan/widgets/tombol_back.dart';

class EventsApp extends StatelessWidget {
  const EventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const EventsPage(),
    );
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: TombolBack(),
        title: const Text('Events', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            EventCard(
              imageUrl: 'https://via.placeholder.com/150', // Replace with actual image URLs
              title: 'Acara Bhaktiku Negri',
            ),
            const SizedBox(height: 16.0),
            EventCard(
              imageUrl: 'https://via.placeholder.com/150',
              title: 'Acara Bhaktiku Negri',
            ),
            const SizedBox(height: 16.0),
            EventCard(
              imageUrl: 'https://via.placeholder.com/150',
              title: 'Acara Bhaktiku Negri',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Forums'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Profile Yayasan'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: 'Gallery'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const EventCard({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
