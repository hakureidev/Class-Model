import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modul/1/second_day/models/user.dart';
import 'package:modul/1/second_day/presentation/constant/constant.dart';
import 'package:modul/1/second_day/presentation/constant/widgets/shimmer.dart';
import 'package:modul/1/second_day/presentation/constant/widgets/widgets.dart';
import 'package:modul/1/second_day/presentation/view/data.dart';
import 'package:modul/1/second_day/repository/user_repository.dart';

class MyCompany extends StatefulWidget {
  const MyCompany({Key? key}) : super(key: key);

  @override
  State<MyCompany> createState() => _MyCompanyState();
}

class _MyCompanyState extends State<MyCompany> {
  final UserRepository userRepository = UserRepository();
  List<User> allUsers = [];
  List<User> filtered = [];

  Future<void> _refresh() async {
    List<User> users = await userRepository.getData();
    setState(() {
      allUsers = users;
      filtered = allUsers;
    });
    return await Future.delayed(const Duration(seconds: 2));
  }

  Future<int> jumlah() async {
    await Future.delayed(const Duration(seconds: 1));
    return allUsers.length;
  }

  Future<List<User>> search(String name) async {
    if (name.isEmpty) {
      return allUsers;
    }
    List<User> result = allUsers
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    change(result.isNotEmpty);
    return result;
  }

  Future<List<User>> _user() async {
    await Future.delayed(const Duration(seconds: 2));
    return await userRepository.getData();
  }

  bool y = false;
  void change(bool value) {
    setState(() {
      y = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    _user();
  }

  @override
  void dispose() {
    jumlah();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.primary,
        toolbarHeight: 60.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Constant.primary,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: Constant.width(context),
              height: Constant.height(context) / 8,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Constant.width(context),
                    height: Constant.height(context) / 5,
                    decoration: const BoxDecoration(color: Constant.primary),
                    child: Center(
                      child: FutureBuilder<int>(
                        future: jumlah(),
                        builder: (context, snapshot) {
                          final int? data = snapshot.data;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Jumlah Semua karyawan saat ini',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? 'Loading...'
                                    : data.toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: MyContainer(
                      width: Constant.width(context),
                      height: 60.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.16),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        maxLength: 15,
                        maxLines: 1,
                        onChanged: (name) async {
                          if (name.isNotEmpty && name.length >= 3) {
                            print('index : ${name.length}');
                            print("di if block");
                            List<User> filter = await search(name);
                            setState(() {
                              filtered = filter;
                              change(false);
                              print('nilai y $y');
                            });
                          } else if (name.trim().isEmpty) {
                            print('index : ${name.length}');
                            print("di else if block");
                            setState(() {
                              filtered = allUsers;
                              change(false);
                              print('nilai y $y');
                            });
                          } else {
                            print('index : ${name.length}');
                            print("di else block");
                            setState(() {
                              change(true);
                              filtered = [];
                              print('nilai y $y');
                            });
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Cari data karyawan',
                            hintStyle: TextStyle(fontSize: 14),
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 17, 0, 0),
                            counterText: ''),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: MyContainer(
              width: Constant.width(context),
              height: Constant.height(context) / 1.5,
              decoration: const BoxDecoration(),
              child: SafeArea(
                top: true,
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: SizedBox(
                              child: FutureBuilder(
                                  future: _user(),
                                  builder: (ctx, snapshot) {
                                    List<int> err =
                                        List.generate(10, (index) => index);
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: filtered
                                            .map((_) => ShimmerPage(
                                                width: Constant.width(context),
                                                height: 120.0))
                                            .toList(),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return y
                                          ? FutureBuilder(
                                              future: Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500)),
                                              builder: (ctx, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  return const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Oopps'),
                                                      Text(
                                                          'data tidak di temukan')
                                                    ],
                                                  );
                                                }
                                              })
                                          : Column(
                                              children: filtered
                                                  .map((element) => Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Text(element
                                                                .id
                                                                .toString()),
                                                            title: Text(
                                                                element.name),
                                                            subtitle: Text(
                                                                element
                                                                    .username),
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                PageRouteBuilder(
                                                                  pageBuilder: (context,
                                                                      animation,
                                                                      secondaryAnimation) {
                                                                    return MyInfo(
                                                                      user: [
                                                                        element
                                                                      ],
                                                                      userRepository:
                                                                          userRepository,
                                                                    );
                                                                  },
                                                                  transitionsBuilder: (context,
                                                                      animation,
                                                                      secondaryAnimation,
                                                                      child) {
                                                                    const begin =
                                                                        0.0;
                                                                    const end =
                                                                        1.0;
                                                                    const curve =
                                                                        Curves
                                                                            .easeInOut;

                                                                    var tween = Tween(
                                                                            begin:
                                                                                begin,
                                                                            end:
                                                                                end)
                                                                        .chain(CurveTween(
                                                                            curve:
                                                                                curve));

                                                                    var opacityAnimation =
                                                                        animation
                                                                            .drive(tween);

                                                                    return FadeTransition(
                                                                      opacity:
                                                                          opacityAnimation,
                                                                      child:
                                                                          child,
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          Divider(), // Tambahkan divider di sini
                                                        ],
                                                      ))
                                                  .toList(),
                                            );
                                    } else {
                                      return Column(
                                        children: err
                                            .map((e) => ShimmerPage(
                                                width: Constant.width(context),
                                                height: 120.0))
                                            .toList(),
                                      );
                                    }
                                  })),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyContainer(
          width: Constant.width(context),
          height: 60.0,
          decoration: const BoxDecoration(
            color: Constant.body,
            border: Border(top: BorderSide(color: Colors.black12, width: 1)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 4; i++)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1)),
                  )
              ],
            ),
          )),
    );
  }
}
