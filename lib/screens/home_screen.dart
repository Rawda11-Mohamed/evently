import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../screens/add_event_screen.dart';
import '../widgets/catigories_container.dart';
import '../widgets/events_container.dart';
import '../screens/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final String? name;

  const HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String name = '';
  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      name = userDoc['name'];
    });
  }

  int selectedCategory = 0;

  final List<String> categories = ['All', 'Sport', 'Birthday', 'Book club'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back ✨',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),

      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CatigoriesContainer(
                  text: 'All',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 0;
                    });
                  },
                  icon: 'assets/icons/all_icon.svg',
                  isSelected: selectedCategory == 0,
                ),

                CatigoriesContainer(
                  text: 'Sport',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 1;
                    });
                  },
                  icon: 'assets/icons/sport_icon.svg',
                  isSelected: selectedCategory == 1,
                ),

                CatigoriesContainer(
                  text: 'Birthday',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 2;
                    });
                  },
                  icon: 'assets/icons/birthday_icon.svg',
                  isSelected: selectedCategory == 2,
                ),

                CatigoriesContainer(
                  text: 'Book',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 3;
                    });
                  },
                  icon: 'assets/icons/book_club_icon.svg',
                  isSelected: selectedCategory == 3,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('events').snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No events found'));
                }

                final List<EventModel> events =
                    snapshot.data!.docs
                        .map((doc) => EventModel.fromFireStore(doc))
                        .toList();

                final filteredEvents =
                    selectedCategory == 0
                        ? events
                        : events.where((event) {
                          return event.category == categories[selectedCategory];
                        }).toList();

                if (filteredEvents.isEmpty) {
                  return const Center(child: Text('No events found'));
                }

                return ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EventDetailsScreen(
                                  date: event.date,
                                  description: event.description,
                                  image: event.image,
                                  time: event.time,
                                  title: event.title,
                                  id: event.id!,
                                  isFavourite: event.isFavourite!,
                                ),
                          ),
                        );
                      },
                      child: EventsContainer(
                        date: (event.date).toDate().day.toString(),
                        description: event.description,
                        image: event.image,
                        isFavourite: event.isFavourite!,
                        onPressed: () async {
                          final newValue = !event.isFavourite!;

                          await FirebaseFirestore.instance
                              .collection('events')
                              .doc(event.id)
                              .update({'isFavourite': newValue});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEventScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
