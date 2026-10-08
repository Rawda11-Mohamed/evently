import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/event_model.dart';
import '../widgets/catigories_container.dart';
import '../screens/update_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final String description;
  final Timestamp date;
  final Timestamp time;
  final String image;
  final String title;
  final String id;
  final bool isFavourite;
  const EventDetailsScreen({
    super.key,
    required this.date,
    required this.description,
    required this.image,
    required this.time,
    required this.title,
    required this.id,
    required this.isFavourite,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Future<void> deleteEvent() async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .delete();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
          actions: [
            IconButton(
              onPressed: deleteEvent,
              icon: Icon(Icons.delete_outline_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => UpdateEventScreen(
                          date: widget.date,
                          description: widget.description,
                          image: widget.image,
                          time: widget.time,
                          title: widget.title,
                          id: widget.id,
                          isFavourite: widget.isFavourite,
                        ),
                  ),
                );
              },
              icon: Icon(Icons.mode_edit_outline_outlined),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Event Image
              Container(
                width: double.infinity,
                height: 193,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              ListTile(
                tileColor: Theme.of(context).colorScheme.surface,
                leading: SvgPicture.asset('assets/icons/calendar-add_icon.svg'),
                title: Text(widget.date.toDate().day.toString()),
                subtitle: Text(
                  widget.time.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 179,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Text(widget.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
