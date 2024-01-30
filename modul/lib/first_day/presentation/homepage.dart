import 'package:flutter/material.dart';
import 'package:modul/first_day/model/model_test.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<UserModel> userModels = [];
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController hobbyEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
          children: userModels.map((element) {
        return ListTile(
          title: Text(element.name),
          subtitle: Text(element.lastName),
          leading: Text(element.hobby),
          trailing: Text(element.index.toString()),
        );
      }).toList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    height: MediaQuery.sizeOf(context).height / 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: nameEditingController,
                          decoration: InputDecoration(
                            hintText: 'masukan nama',
                          ),
                        ),
                        TextField(
                          controller: lastNameEditingController,
                          decoration: InputDecoration(
                            hintText: 'masukan nama terakhir',
                          ),
                        ),
                        TextField(
                          controller: hobbyEditingController,
                          decoration: InputDecoration(
                            hintText: 'masukan hobby',
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              UserModel userModel = UserModel(
                                  index: 1,
                                  name: nameEditingController.text,
                                  lastName: lastNameEditingController.text,
                                  hobby: hobbyEditingController.text);
                              setState(() {
                                userModels.add(userModel);
                              });
                            },
                            child: Text('submit'))
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.add)),
          
    );
  }
}
