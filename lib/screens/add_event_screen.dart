import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/event_model.dart';
import '../widgets/catigories_container.dart';
import '../widgets/custom_elevated_button.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String selectedCategory = 'Birthday';
  String image = 'assets/images/birthday.png';

  Future<void> chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: selectedDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> chooseTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> addEvent() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose date and time')),
      );
      return;
    }

    final DateTime eventDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final Timestamp eventTimestamp = Timestamp.fromDate(eventDateTime);

    final EventModel event = EventModel(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      category: selectedCategory,
      date: eventTimestamp,
      image: image,
      time: eventTimestamp,
    );

    try {
      DocumentReference doc = await FirebaseFirestore.instance
          .collection('events')
          .add(event.toFireStore());

      print('EVENT ID: ${doc.id}');

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Event')),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: SingleChildScrollView(
            child: Column(
              children: [
                // Event Image
                Container(
                  width: double.infinity,
                  height: 193,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                const SizedBox(height: 16),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CatigoriesContainer(
                        text: 'Book',
                        icon: 'assets/icons/book_club_icon.svg',
                        isSelected: selectedCategory == 'Book club',
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Book club';
                            image = 'assets/images/book_club.png';
                          });
                        },
                      ),

                      CatigoriesContainer(
                        text: 'Sport',
                        icon: 'assets/icons/sport_icon.svg',
                        isSelected: selectedCategory == 'Sport',
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Sport';
                            image = 'assets/images/add_event_sport.png';
                          });
                        },
                      ),

                      CatigoriesContainer(
                        text: 'Birthday',
                        icon: 'assets/icons/birthday_icon.svg',
                        isSelected: selectedCategory == 'Birthday',
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Birthday';
                            image = 'assets/images/birthday.png';
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Event Title
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Event title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Event Description
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Event description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Event Date
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar-add_icon.svg'),

                    const SizedBox(width: 4),

                    Text(
                      'Event Date',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: chooseDate,
                      child: Text(
                        selectedDate == null
                            ? 'choose date'
                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Event Time
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar-add_icon.svg'),

                    const SizedBox(width: 4),

                    Text(
                      'Event Time',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: chooseTime,
                      child: Text(
                        selectedTime == null
                            ? 'choose time'
                            : selectedTime!.format(context),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Add Event Button
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: addEvent,
                    text: 'Add Event',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
