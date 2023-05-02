// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqlite/service/dbm_helper.dart';
import 'package:login_sqlite/service/usermodel.dart';
import 'package:login_sqlite/service/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBMHelper.instanse.getRecord();
  }

  @override
  Widget build(BuildContext context) {
    int? selectid;
    final emailcontroller = TextEditingController();
    final addresscontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Expanded(
              child: FutureBuilder(
                  future: DBMHelper.instanse.getRecord(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            children: snapshot.data!.map((user) {
                              return Center(
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        emailcontroller.text = user.email;
                                        addresscontroller.text = user.address;
                                        selectid = user.id;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Update Data in Locally'),
                                              content: Center(
                                                  child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: emailcontroller,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter Email"),
                                                  ).py16(),
                                                  TextFormField(
                                                    controller:
                                                        addresscontroller,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter Address"),
                                                  )
                                                ],
                                              )).px20().centered(),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('cencle')),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await DBMHelper.instanse.updateRecord(UserModel(
                                                                id: selectid,
                                                                email:emailcontroller.text,
                                                                  address:addresscontroller.text))
                                                              .then((value) {
                                                              setState(() {
                                                                Get.back();
                                                              });
                                                              Utils().ToastMassage('Data are successfully Update');                                                            
                                                            }).onError((error,
                                                                  stackTrace) {       
                                                              Utils().ToastMassage('Data are Failed'+error.toString());                                                         
                                                            });
                                                    },
                                                    child: Text('Update'))
                                              ],
                                            );
                                          });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        DBMHelper.instanse
                                            .deleteRecord(user.id!);
                                      });
                                    },
                                    title: Text(user.email),
                                    subtitle: Text(user.address),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                  }))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Insert Data in Locally'),
                  content: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(hintText: "Enter Email"),
                      ).py16(),
                      TextFormField(
                        controller: addresscontroller,
                        decoration: InputDecoration(hintText: "Enter Address"),
                      )
                    ],
                  ).px20().centered(),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('cencle')),
                    ElevatedButton(
                        onPressed: () {
                          DBMHelper.instanse
                              .InsertRecord(UserModel(
                                  email: emailcontroller.text,
                                  address: addresscontroller.text))
                              .then((value) {
                            setState(() {
                              Get.back();
                            });
                            Utils().ToastMassage('Data are successfully Insert');
                          }).onError((error, stackTrace) {
                            Utils().ToastMassage("Error"+error.toString());
                          });
                        },
                        child: Text('Insert'))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
