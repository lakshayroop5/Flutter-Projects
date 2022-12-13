import 'package:flutter/material.dart';
import 'package:gameon_tech/screens/phone_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  void _sheet() {
    showModalBottomSheet(
        barrierColor: Theme.of(context).primaryColor.withOpacity(0.24),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const PhoneScreen(),
            ));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sheet();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    BlendMode.dstATop),
                image: Image.asset('assets/images/wankhede1.png').image,
              ),
            ),
          ),
          Positioned(
            top: height * 0.1,
            left: width * 0.38,
            child: Image.asset(
              'assets/images/logo.png',
              scale: 0.1,
              width: 100,
              height: 100,
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
