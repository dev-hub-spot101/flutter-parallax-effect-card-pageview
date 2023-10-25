import 'package:flutter/material.dart';
import 'package:parallaxeffect/widgets/SlidingCardView.dart';
import 'package:parallaxeffect/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Header(),
                SizedBox(height: 20),
                SlidingCardView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
