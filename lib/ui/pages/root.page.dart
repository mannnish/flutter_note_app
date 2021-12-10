import 'package:flutter/material.dart';
import 'package:flutter_note_app/ui/pages/note.page.dart';
import 'package:flutter_note_app/ui/pages/task.page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController _controller = PageController(initialPage: 0);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          NotesPage(),
          TasksPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) {
          _controller.jumpToPage(i);
          setState(() {
            selectedIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            label: 'Todo',
            icon: Icon(Icons.toc_rounded),
          ),
        ],
      ),
    );
  }
}
