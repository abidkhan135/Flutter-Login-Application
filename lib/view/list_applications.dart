import 'package:code_test/models/application.dart';
import 'package:code_test/view/list_item.dart';
import 'package:code_test/view/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_test/viewmodel/loanform_viewmodel.dart';

class ListApplications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: LoanViewModel().getApplication(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Application> data = snapshot.data;
          return _loansListView(data);
        } else if (snapshot.hasError) {
          var exceptionType=snapshot.error.toString().split(':');
          return Center(
              child: AlertDialog(
            title: new Text(exceptionType[0]),
            content: new Text(exceptionType[1]),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) {
                          return TabsScreen();
                        },
                      ),
                    );
                  },
                  child: new Text('OK'))
            ],
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _loansListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListItem(
              data[index].firstName, data[index].lastName, Icons.person);
        });
  }
}
