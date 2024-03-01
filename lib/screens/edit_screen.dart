
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model_class.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    Key? key,
    required this.name,
    required this.roll_no,
    required  this.grade,
    required this.index,
  }): super(key:key);
  final String name;
  final int roll_no;
  final String grade;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController  _namecontroller = TextEditingController();
  final TextEditingController  _roll_nocontroller = TextEditingController();
  final TextEditingController  _gradecontroller = TextEditingController();
  @override
  void initState() {
    _namecontroller.text = widget.name;
    _roll_nocontroller.text = widget.roll_no.toString();
    _gradecontroller.text = widget.grade;
    super.initState();
  }
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
        title: const Text("Update Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _namecontroller,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: widget.name,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _roll_nocontroller,
                decoration: InputDecoration(
                  labelText: 'Roll_No',
                  hintText: widget.roll_no.toString(),
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _gradecontroller,
                decoration: InputDecoration(
                  labelText: 'Grade',
                  hintText: widget.grade,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  final value = StudentData(
                      name: _namecontroller.text,
                      roll_no: int.parse(_roll_nocontroller.text),
                      grade: _gradecontroller.text);
                  Hive.box('PersonBox').putAt(widget.index, value);
                  print('Update Values');
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}