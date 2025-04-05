import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:zippygo/common_code/colore_screen.dart';

class GradientProgressBar extends StatefulWidget {
  @override
  _GradientProgressBarState createState() => _GradientProgressBarState();
}

class _GradientProgressBarState extends State<GradientProgressBar> with SingleTickerProviderStateMixin{
  // double progress = 100; // Start at 100%
  // late Timer timer;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // Start the timer to decrease progress every second
  //   timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
  //     if (progress > 0) {
  //       setState(() {
  //         progress -= 5; // Decrease progress by 10% each second
  //       });
  //     } else {
  //       t.cancel(); // Stop the timer when progress reaches 0
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   timer.cancel(); // Cancel the timer when the widget is disposed
  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.green,
    ).animate(controller);

    controller.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   cancelRequestController.cancelRequestApi(
      //       context: context,
      //       requestId: widget.requestID.toString(),
      //       cID: requestDetailController.requestDetailModel!.requestData.cId
      //           .toString());
      //   notificationSoundPlayer.stopNotificationSound();
      // }
    });

    controller.repeat(reverse: false);
    super.initState();
  }


  void refreshAnimation() {
    // Reset the controller to start the animation again
    controller.reset();
    controller.repeat(reverse: false);
  }

  late AnimationController controller;
  late Animation<Color?> colorAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  refreshAnimation();
                });
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10,),
            AnimatedBuilder(
              animation: controller,
              builder:
                  (context, child) {
                return SizedBox(
                  height: 49,
                  width: double
                      .infinity,
                  child:
                  ElevatedButton(
                    style:
                    ButtonStyle(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets
                              .zero),
                      elevation:
                      const WidgetStatePropertyAll(
                          0),
                      overlayColor:
                      const WidgetStatePropertyAll(
                          Colors
                              .transparent),
                      backgroundColor: WidgetStatePropertyAll(Colors
                          .redAccent
                          .withOpacity(
                          0.8)),
                      shape:
                      WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // if (!acceptRequestController.isRequestAccepted) {
                      //   cancelRequestController.cancelRequestApi(context: context,
                      //       requestId: widget.requestID.toString(),
                      //       cID: requestDetailController.requestDetailModel!.requestData.cId.toString());
                      //   notificationSoundPlayer.stopNotificationSound();
                      // }
                    },
                    child: Stack(
                      alignment:
                      Alignment
                          .center,
                      clipBehavior:
                      Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                          child:
                          LinearProgressIndicator(
                            minHeight:
                            49,
                            value: 1.0 - controller.value,
                            backgroundColor: Colors
                                .redAccent
                                .withOpacity(0.1),
                            color: Colors
                                .red,
                          ),
                        ),
                        Text(
                          "Reject".tr,
                          style:
                          TextStyle(
                            fontSize:
                            14,
                            fontWeight:
                            FontWeight.w500,
                            color:
                            Colors.white,
                            letterSpacing:
                            0.4,
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       backgroundColor: Colors.black87, // Set background color
//       body: Center(
//         child: GradientProgressBar(), // Display the gradient progress bar
//       ),
//     ),
//   ));
// }
