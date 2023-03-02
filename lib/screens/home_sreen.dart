import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Home icon
        leading: Icon(CupertinoIcons.home),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Chat App',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 19)),
        actions: [
          //Icons
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search), //Search icon
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert), //More icon
          ),
        ],
        backgroundColor: Colors.white,
      ),

      // floating button for chat
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.message), //Message icon (chat bubble)
        ),
      ),
    );
  }
}
