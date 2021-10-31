import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TextFormField(
          maxLength: 5,
          decoration: const InputDecoration(
            labelText: 'Label text',
            hintText: 'Hint text',
            border: OutlineInputBorder()
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 90,
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: 'messages'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pregnant_woman), label: 'pragnant'),
            ],
            selectedItemColor: Colors.blueAccent,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
        shape: const CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
