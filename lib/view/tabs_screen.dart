import 'package:flutter/material.dart';
import 'package:code_test/view/loan_form.dart';
import 'package:code_test/view/list_applications.dart';
class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages=[
    LoanForm(),
   ListApplications(),
  ];
  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loan Application"),
       ),
      body:  _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('Application')),
          BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Submitted')),
        ],
      ),
    );
  }
}
