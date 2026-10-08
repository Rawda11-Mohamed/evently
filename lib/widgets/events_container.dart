import 'package:flutter/material.dart';

class EventsContainer extends StatelessWidget {
  final String date;
  final String description;
  final String image;
  final bool isFavourite;
  VoidCallback onPressed;
  EventsContainer({
    super.key,
    required this.date,
    required this.description,
    required this.image,
    required this.isFavourite,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 193,

          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            width: 66,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(date),
          ),
        ),

        Positioned(
          bottom: 16,
          left: 8,
          right: 8,
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(description),
                Spacer(),
                GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
