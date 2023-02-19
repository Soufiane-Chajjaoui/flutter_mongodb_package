import 'package:faker/faker.dart';
import 'package:test_mongodb/modelmongodb.dart';

import 'package:flutter/material.dart';
import 'package:test_mongodb/show_all.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var controllername = TextEditingController();
  var controlleremail = TextEditingController();
  var controllerpassword = TextEditingController();
  bool insert = true;
  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      insert = false;
      controllername.text = data.name!;
      controlleremail.text = data.address!;
      controllerpassword.text = data.password!;
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 40, top: 28),
                          child: Column(children: []),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: TextFormField(
                                controller: controllername,
                                cursorHeight: 30,
                                decoration: InputDecoration(
                                    label: Text(
                                      'Full Name',
                                      style: TextStyle(
                                          fontFamily: 'PoppinsExtraLight',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: TextFormField(
                                controller: controlleremail,
                                cursorHeight: 30,
                                decoration: InputDecoration(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(
                                          fontFamily: 'PoppinsExtraLight',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: TextFormField(
                                controller: controllerpassword,
                                cursorHeight: 30,
                                decoration: InputDecoration(
                                    label: Text(
                                      'Password',
                                      style: TextStyle(
                                          fontFamily: 'PoppinsExtraLight',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF3279B6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                // background (button) color
                                // foreground (text) color
                              ),
                              onPressed: () => _fakeData(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Generate data",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            // ElevatedButton.icon(icon: Icon(Icons.save),label: Text('save'), onPressed: (){}, )

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF3279B6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                // background (button) color
                                // foreground (text) color
                              ),
                              onPressed: () {
                                if (insert) {
                                  userModel.insert(
                                      controllername.text,
                                      controlleremail.text,
                                      controllerpassword.text);
                                  _clearInput();
                                } else {
                                  userModel.updatedata(
                                      data.id,
                                      controllername.text,
                                      controlleremail.text,
                                      controllerpassword.text);
                                  // Navigator.pop(context, MaterialPageRoute(
                                  //   builder: (BuildContext context) {
                                  //     return const showData();
                                  //   },
                                  // ));
                                  //  Navigator.pushNamed(context, "showalldata");
                                  Navigator.pushNamed(context, "showalldata")
                                      .then((value) {
                                    setState(() {});
                                  });
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => showData()),
                                  //   (Route<dynamic> route) => false,
                                  // );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: insert
                                    ? Text(
                                        "Sign in",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Text(
                                        "Update",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearInput() {
    controllername.text = "";
    controlleremail.text = "";
    controllerpassword.text = "";
  }

  void _fakeData() {
    setState(() {
      controllername.text = faker.person.firstName() + faker.person.lastName();
      controlleremail.text = faker.lorem.toString();
      controllerpassword.text = "mongodb221";
    });
  }
}
