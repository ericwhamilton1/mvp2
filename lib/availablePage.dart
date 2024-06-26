import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';

class Availablepage extends StatefulWidget{
  const Availablepage({super.key});

  @override
  State<Availablepage> createState() => _AvailablepageState();
}
class _AvailablepageState extends State<Availablepage> {
  List<List<dynamic>> data = [];


  @override
  void initState(){
    super.initState();
    loadCSV();

  }
  void loadCSV() async{
    final rawData = await rootBundle.loadString("assets/users.csv");
    List<List<dynamic>> listdata = const CsvToListConverter().convert(rawData);
    setState(() {
      data = listdata;
    });
  }

  void smsText(int number) async {
    List<String> recipients  = [number.toString()];
    try{
    await sendSMS(
      message: "Hey! I want to go on a walk with you!",
      recipients: recipients);
    }
    on PlatformException{print("Text Sent!");}
  }
  void showNumber(BuildContext context, String firstname, String lastname, int number) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Message?'),
        content: Text('Do you want to text $firstname $lastname at $number?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDefaultAction: true,
            onPressed: () {
              smsText(number);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Walkers")
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index){
          return Container(
            padding: const EdgeInsets.all(10.0),
            height: 75,
            child: ElevatedButton(
              onPressed: (){
                showNumber(context, data[index][0], data[index][1], data[index][2]);
                },
              child:Text("${data[index][0]} ${data[index][1]}"),
              ),
          );
        },
      )
    );
  }
}