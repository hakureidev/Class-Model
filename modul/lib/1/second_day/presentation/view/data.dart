import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modul/1/second_day/models/user.dart';
import 'package:modul/1/second_day/presentation/constant/constant.dart';
import 'package:modul/1/second_day/repository/user_repository.dart';

class MyInfo extends StatefulWidget {
  final List<User> user;
  final UserRepository userRepository;
  const MyInfo({super.key, required this.user, required this.userRepository});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  Future<List<User>> _user() async {
    await Future.delayed(const Duration(seconds: 2));
    return await widget.userRepository.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Constant.body ,
          statusBarBrightness: Brightness.dark
        ),
        backgroundColor: Constant.body,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data karyawan',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
      ),
      body: SafeArea(
          top: true,
          child: FutureBuilder(
              future: _user(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                      height: Constant.height(context),
                      width: Constant.width(context),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 20, 5),
                        child: Column(
                          children: widget.user
                              .map((e) => ListTile(
                                    title: Text(e.name),
                                    
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider() ,
                                        Text('Name : ${e.name}'),
                                        Text('Username: ${e.username}'),
                                        Text('Email: ${e.email}'),
                                        Text(
                                            'Andress : ${e.address.street}, ${e.address.suite}, ${e.address.city}, ${e.address.zipcode.toString()}, ${e.address.geo.lat.toString()}, ${e.address.geo.lng.toString()}'),
                                        Text('Phone : ${e.phone}'),
                                        Text('Website : ${e.website}'),
                                        const Divider(),
                                        const Text('Company' , style: TextStyle(color: Colors.black)),
                                        const SizedBox(height: 5,) ,
                                        Text('Name : ${e.company.name}' ,),
                                        Text(
                                            'CatchPhrase : ${e.company.catchPhrase}'),
                                        Text('Bs : ${e.company.bs}') ,
                                        const Divider()
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ));
                }
              })),
    );
  }
}
