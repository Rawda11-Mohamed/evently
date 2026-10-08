import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../screens/add_event_screen.dart';
import '../widgets/catigories_container.dart';
import '../widgets/events_container.dart';
import '../screens/event_details_screen.dart';

class SearchEventsScreen extends StatefulWidget {
  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  TextEditingController controller = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                fillColor: Theme.of(context).colorScheme.surface,
                hintText: 'search',
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
                      events.where((event) {
                        return event.description.contains(searchText);
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
