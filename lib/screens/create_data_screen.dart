
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model_class.dart';

class CreateDataScreen extends StatefulWidget {
  const CreateDataScreen({super.key});

  @override
  State<CreateDataScreen> createState() => _CreateDataScreenState();
}

class _CreateDataScreenState extends State<CreateDataScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _roll_nocontroller = TextEditingController();
  final TextEditingController _gradecontroller = TextEditingController();
  @override
  void dispose() {
    _namecontroller.dispose();
    _roll_nocontroller.dispose();
    _gradecontroller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Data Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _namecontroller,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: _roll_nocontroller,
                decoration: InputDecoration(labelText: 'Roll_No'),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: _gradecontroller,
                decoration: InputDecoration(labelText: 'Grade'),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                final value = StudentData(name: _namecontroller.text,
                    roll_no: int.parse(_roll_nocontroller.text),
                    grade: _gradecontroller.text);
                Hive.box("PersonBox").add(value);
                print("Create Data");
              },
                  child: const Text("Create Data")),


            ],
          ),
        ),
      ),

    );
  }
}