import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'SMS DEMO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Telephony telephony = Telephony.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = '9542732466, 1234567890'; // Example numbers
    _msgController.text = 'Hello :)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Numbers';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone Numbers (comma-separated)',
                        labelText: 'Numbers',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _msgController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a message';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Text message',
                        labelText: 'Message',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _sendSMS(),
                    child: const Text('SEND SMS'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _sendSMS() async {
    List<String> phoneNumbers =
    _phoneController.text.split(',').map((e) => e.trim()).toList();
    String message = _msgController.text;

    for (String phoneNumber in phoneNumbers) {
      await telephony.sendSms(to: phoneNumber, message: message);
    }
  }
}
