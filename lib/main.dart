import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Circular Reveal Animation",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 15),),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'This is demo of "Circular Reveal Animation" Flutter library',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  onPressed: () => showRevealImageDialog(context),
                  color: Colors.green,
                  child: const Text("show reveal image dialog",style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  onPressed: () => showRevealTextDialog(context),
                  color: Colors.amber,
                  child: const Text("show reveal text dialog",style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  onPressed: () {
                    if (animationController.status == AnimationStatus.forward ||
                    animationController.status ==
                    AnimationStatus.completed) {
                      animationController.reverse();
                    } 
                    else 
                    {
                      animationController.forward();
                    }
                  },
                  color: Colors.red,
                  child: const Text("show / hide image",style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 12),
                CircularRevealAnimation(
                  animation: animation,
                  centerOffset: const Offset(130, 100),
                  child: Image.asset(
                    'assets/images/hotel.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showRevealImageDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Label",
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset('assets/images/1.png'),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          animation: anim1,
          centerAlignment: Alignment.bottomCenter,
          child: child,
        );
      },
    );
  }

  void showRevealTextDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Label",
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
          title: const Text("Title of the dialog"),
          content: const Text(
              "Content of the dialog. Content of the dialog. Content of the dialog. Content of the dialog."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          animation: anim1,
          centerAlignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}