import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String title;
  final String description;
  final String? category;
  final Timestamp date;
  final Timestamp time;
  final String image;
  final String? id;
  bool? isFavourite;

  EventModel({
    required this.title,
    required this.description,
    this.category,
    required this.date,
    required this.time,
    required this.image,
    this.isFavourite,
    this.id,
  });

  factory EventModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      time: data['time'] ?? Timestamp.now(),
      image: data['image'] ?? '',
      isFavourite: data['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'image': image,
      'isFavourite': isFavourite,
    };
  }
}
