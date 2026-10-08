import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const ProfileScreen({super.key, required this.onThemeChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String name = '';
  String email = '';
  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      name = userDoc['name'];
      email = userDoc['email'];
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),

          child: Column(
            spacing: 10,

            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/route_circle_avatar.png',
                ),
              ),
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      'Dark mode',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    ),
                    Spacer(),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          isDark = value;
                        });
                        widget.onThemeChanged(value);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      'Language',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: logout,
                      icon: Icon(Icons.logout, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
