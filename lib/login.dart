import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqlite/home_screen.dart';
import 'package:login_sqlite/service/db_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                ),
                ).py20(),
                    TextFormField(
                  controller: passwordcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                ),
                ).py20(),
                  
                InkWell(
                  onTap: ()async{
                    
                    await DBhelper.instance.insetRecord({
                      DBhelper.columnEmail:'email kamlesh',
                      DBhelper.columnPassword:'passworj newaejhk'
                    });
                    print('Store Successfully');
                    // Get.snackbar('Login', 'Login Successfully');
                   
                    // Get.to(()=>Home_Screen());
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Vx.purple700
                    ),
                    child: Text('Register').text.size(15).white.bold.make().centered(),
                  ),
                )
              ],
            ).px12().centered(),
          ),
        ),
      ),
    );
  }
}