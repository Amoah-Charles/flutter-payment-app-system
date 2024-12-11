import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'login_screen.dart';
import 'make_payment_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthenticationWrapper(), // Single home parameter
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen(); // If user is not logged in, show login screen
          }
          return const MyPaymentApp(); // If logged in, show payment app
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(
            child: Text('Something went wrong. Please try again.'));
      },
    );
  }
}

class MyPaymentApp extends StatefulWidget {
  const MyPaymentApp({super.key});

  @override
  _MyPaymentAppState createState() => _MyPaymentAppState();
}

class _MyPaymentAppState extends State<MyPaymentApp> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/Black_and_Blue_Initials_Creative_Logo.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SnapPay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings icon clicked')),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'Logout') {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('\$value selected')),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Home',
                  child: Row(
                    children: [
                      Icon(Icons.home, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Home'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/Black and Blue Initials Creative Logo 2.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Experience fast, secure, and seamless transactions—wherever life takes you. With SnapPay, your payment is just a tap away.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MakePaymentScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.yellow[800],
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            "Make Payment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
