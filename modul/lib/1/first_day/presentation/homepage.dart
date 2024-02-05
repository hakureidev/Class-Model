import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modul/1/first_day/model/model_test.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<UserModel> userModels = []; // disini kita membuat model sebelumnya yang kita buat menjadi sebuah list
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController hobbyEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();

  bool _validate = false;

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  void _deleteUser(int index) {
    setState(() {
      userModels.removeAt(index);
    });
  }

  void _addUser() {
    UserModel userModel = UserModel(
      index: userModels.length + 1,
      name: nameEditingController.text,
      lastName: lastNameEditingController.text,
      kegiatan: hobbyEditingController.text,
    );
    setState(() {
      userModels.add(userModel);
      nameEditingController.clear();
      lastNameEditingController.clear();
      hobbyEditingController.clear();
    });
    Navigator.pop(context);
  }

  void _editUser(int index, BuildContext context) {
    UserModel editedUser = UserModel(
      index: index + 1,
      name: nameEditingController.text,
      lastName: lastNameEditingController.text,
      kegiatan: hobbyEditingController.text,
    );

    setState(() {
      userModels[index] = editedUser;
      nameEditingController.clear();
      lastNameEditingController.clear();
      hobbyEditingController.clear();
    });
    Navigator.pop(context);
  }

  void _showEditDialog(BuildContext context, UserModel user) {
    nameEditingController.text = user.name;
    lastNameEditingController.text = user.lastName;
    hobbyEditingController.text = user.kegiatan;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: width(context),
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .add(const EdgeInsets.only(bottom: 10)),
                        child: TextField(
                          controller: nameEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                            hintText: 'masukan nama',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: width(context),
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .add(const EdgeInsets.only(bottom: 10)),
                        child: TextField(
                          controller: lastNameEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                            hintText: 'masukan nama belakang',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: width(context),
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .add(const EdgeInsets.only(bottom: 10)),
                        child: TextField(
                          controller: hobbyEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                            hintText: 'masukan kegiatan',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameEditingController.text.isNotEmpty &&
                        lastNameEditingController.text.isNotEmpty &&
                        hobbyEditingController.text.isNotEmpty) {
                      _editUser(userModels.indexOf(user), context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _addUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'To-do List App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Colors.white,
        //   statusBarBrightness: Brightness.dark,
        // ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: userModels.map((element) {
            return Card(
              elevation: 0,
              borderOnForeground: true,
              color: Colors.grey[200],
              margin: const EdgeInsets.symmetric(horizontal: 10)
                  .add(const EdgeInsets.only(bottom: 10)),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: width(context),
                        height: height(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${element.name} ${element.lastName}'),
                                  Text(element.kegiatan),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () => _deleteUser(
                                          userModels.indexOf(element)),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1),
                                            color: Colors.black87,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () =>
                                          _showEditDialog(context, element),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1),
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(
                                          Icons.create,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  width: width(context) / 3,
                                  height: height(context) / 4,
                                  padding: const EdgeInsets.all(10),
                                  child: Text(element.cetakInfo()),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Cek info'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (ctx) {
                return Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: height(context) / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Flexible(flex: 1, child: Text('Add Task')),
                          Flexible(
                            flex: 4,
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: width(context),
                                    height: 60,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: TextField(
                                      controller: nameEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                        hintText: 'masukan nama',
                                        errorText: _validate
                                            ? 'mohon masukan nama'
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: width(context),
                                    height: 60,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: TextField(
                                      controller: lastNameEditingController,
                                      decoration: InputDecoration(
                                        errorText: _validate
                                            ? 'mohon masukan nama belakang'
                                            : null,
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                        hintText: 'masukan nama belakang',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: width(context),
                                    height: 60,
                                    margin: const EdgeInsets.only(bottom: 0),
                                    child: TextField(
                                      controller: hobbyEditingController,
                                      decoration: InputDecoration(
                                        errorText: _validate
                                            ? 'mohon masukan kegiatan'
                                            : null,
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                        hintText: 'masukan kegiatan',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                                height: 50,
                                width: width(context),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shadowColor: Colors.transparent,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    onPressed: () {
                                      if (nameEditingController
                                              .text.isNotEmpty &&
                                          lastNameEditingController
                                              .text.isNotEmpty &&
                                          hobbyEditingController
                                              .text.isNotEmpty) {
                                        _addUser();
                                      } else {
                                        _validate = true;
                                      }
                                    },
                                    child: Text('Submit'))),
                          ),
                        ],
                      ),
                    ));
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
