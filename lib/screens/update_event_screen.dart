import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/event_model.dart';
import '../widgets/catigories_container.dart';
import '../widgets/custom_elevated_button.dart';

class UpdateEventScreen extends StatefulWidget {
  final String description;
  final Timestamp date;
  final Timestamp time;
  final String image;
  final String title;
  final String id;
  final bool isFavourite;

  const UpdateEventScreen({
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
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String selectedCategory = '';
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

  Future<void> updateEvent() async {
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
      date: eventTimestamp,
      time: eventTimestamp,
      image: image,
    );
    await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.id)
        .update(event.toFireStore());
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Event')),

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
                      image: AssetImage(image == '' ? widget.image : image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                const SizedBox(height: 16),

                // Categories
                SizedBox(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CatigoriesContainer(
                        text: 'Book club',
                        icon: 'assets/icons/book_club_icon.svg',
                        isSelected: selectedCategory == 'Book Club',
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Book Club';
                            image = 'assets/images/book_club.png';
                          });
                        },
                      ),

                      const SizedBox(width: 8),

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

                      const SizedBox(width: 8),

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

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

                // Event Time
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar-add_icon.svg'),

                    Spacer(),

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
                    text: 'Update',
                    onPressed: updateEvent,
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
