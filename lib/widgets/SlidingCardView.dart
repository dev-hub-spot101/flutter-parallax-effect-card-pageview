import 'package:flutter/material.dart';
import 'package:parallaxeffect/models/carddata.dart';
import 'dart:math' as math;

import 'package:parallaxeffect/screens/detail.dart';

class SlidingCardView extends StatefulWidget {
  const SlidingCardView({super.key});

  @override
  State<SlidingCardView> createState() => _SlidingCardViewState();
}

class _SlidingCardViewState extends State<SlidingCardView> {
  late PageController pageController;

  late List<CardData> card = [
    CardData("Water pic", "assets/images/0.jpeg"),
    CardData("Color pic", "assets/images/1.jpeg"),
    CardData("Space pic", "assets/images/2.jpeg"),
    CardData("Wave pic", "assets/images/3.jpeg"),
    CardData("light pic", "assets/images/4.jpeg"),
    CardData("zoom pic", "assets/images/5.jpeg")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: card.length, //dynamic list show
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
              return Transform.translate(
                offset: Offset(-32 * gauss * pageOffset.sign, 0),
                child: Container(
                  clipBehavior: Clip.none,
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(8, 20),
                            blurRadius: 24)
                      ]),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32)),
                        child: Image.asset(
                          card[index].url,
                          height: MediaQuery.of(context).size.height * 0.4,
                          alignment: Alignment(-pageOffset.abs(), 0),
                          fit: BoxFit.none,
                        ),
                      ),
                      Expanded(child: child!)
                    ],
                  ),
                ),
              );
            },
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(card[index].title,
                              style: TextStyle(fontSize: 20)),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => DetaiScreen()));
                              },
                              child: Text(
                                "Detail",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  textStyle: TextStyle(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32))),
                            ),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
