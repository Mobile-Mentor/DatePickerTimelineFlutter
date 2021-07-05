import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Date Picker Timeline Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 21));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            _controller.animateToSelection();
          },
        ),
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.blueGrey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You Selected:"),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(_selectedValue.toString()),
              Padding(
                padding: EdgeInsets.all(20),
              ),
              Container(
                child: DatePicker(
                  DateTime.now().subtract(Duration(days: 21)),
                  width: 60,
                  height: 80,
                  daysCount: 22,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                  showPopUpDatePicker: () => _showPopUpDatePicker(),
                ),
              ),
            ],
          ),
        ));
  }

  Future<DateTime?> _showPopUpDatePicker() async {
    final selectedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).primaryColor,
              accentColor: Theme.of(context).accentColor,
              colorScheme: ColorScheme.light(primary: Theme.of(context).accentColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: _getInitialDate(_selectedValue),
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: startDate);

    if (selectedDate != null) {
      // New date selected
      setState(() {
        _selectedValue = selectedDate;
      });
    }

    return selectedDate;
  }

  DateTime _getInitialDate(DateTime? selectedDate) {
    if (selectedDate == null) {
      return startDate;
    } else if (selectedDate.isAfter(startDate)) {
      return startDate;
    } else {
      return selectedDate;
    }
  }
}
