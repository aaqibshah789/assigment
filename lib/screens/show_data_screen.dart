
import 'dart:js_interop_unsafe';

import 'package:assigment/screens/create_data_screen.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../model_class.dart';
import 'edit_screen.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({super.key});

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  void dispose() {
    Hive.box('PersonBox').close();
    //or
    //close all box
    // Hive.close();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show data"),
        actions: [
          IconButton(onPressed: (){
            Hive.box('PersonBox').clear();
          },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>const CreateDataScreen(),
        ),
        );
      },
        child: const Icon(Icons.add) ,),
      body: FutureBuilder(future: Hive.openBox('PersonBox'),
          builder: (context,snapshot) {
            if(snapshot.connectionState== ConnectionState.done){
              final hiveBox = Hive.box('PersonBox');
              return ValueListenableBuilder(
                valueListenable:hiveBox.listenable(),
                builder: (context,Box box,child){
                  if(box.isEmpty){
                    return const Center(child: Text('Empty'),
                    );
                  }
                  else {
                    return ListView.builder(
                        itemCount: hiveBox.length,
                        itemBuilder:(context, index) {
                          final helper = hiveBox.getAt(index) as StudentData;
                          return ListTile(
                            trailing: IconButton(onPressed: (){
                              showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: const Text('Delete'),
                                  content: const Text('Do you want to delete this file'),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: (){
                                        hiveBox.deleteAt(index);
                                        print('Delete Data');
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete it',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    },
                                      child: const Text('return'),
                                    ),

                                  ],

                                ),
                              );
                            },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            leading: IconButton(onPressed:(){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => EditScreen(
                                  index: index,
                                  name: helper.name,
                                  roll_no: helper.roll_no,
                                  grade: helper.grade,
                                ),
                                ),
                              );
                            },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            title: Text(helper.name,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Roll_No${helper.roll_no}'),
                                Text('Grade${helper.grade}'),
                              ],
                            ),

                          );
                        }
                    );
                  }

                },
              );

            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }
}