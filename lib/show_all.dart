// ignore_for_file: camel_case_types
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:test_mongodb/modelmongodb.dart';
import 'package:flutter/material.dart';
import 'package:test_mongodb/register.dart';
import 'package:lottie/lottie.dart';

class showData extends StatefulWidget {
  const showData({super.key});

  @override
  State<showData> createState() => _showDataState();
}

class _showDataState extends State<showData> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  dynamic datas;

  @override
  void initState() {
    // TODO: implement initState
    datas = userModel.display();
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    // disposing states
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('show all data'),
        ),
        body: FutureBuilder(
          future: datas,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var lengthData = snapshot.data.length;
                return LiquidPullToRefresh(
                  height: 100,
                  showChildOpacityTransition: true,
                  onRefresh: () =>
                      Future.delayed(const Duration(seconds: 1), () {
                    /// adding elements in list after [1 seconds] delay
                    /// to mimic network call
                    ///
                    /// Remember: [setState] is necessary so that
                    /// build method will run again otherwise
                    /// list will not show all elements
                    setState(() {
                      datas = userModel.display();
                    });

                    // showing snackbar
                  }),
                  child: ListView.builder(
                      itemCount: lengthData,
                      itemBuilder: (context, index) {
                        return showElemets(
                            userModel.fromJson(snapshot.data[index]));
                      }),
                );
              } else {
                return Center(child: Text('data not available'));
              }
            }
          },
        ),
      ),
    );
  }

  Widget showElemets(userModel data) {
    return ListTile(
      leading: IconButton(
          onPressed: () async {
            await userModel.delete(data);
            setState(() async {
              await datas.removeAt(data.id);
              dispose();
            });
          },
          icon: Icon(Icons.delete_forever_outlined)),
      title: Text("${data.id?.$oid}"),
      subtitle: Text("${data.name}"),
      trailing: ElevatedButton.icon(
        icon: Icon(Icons.settings),
        label: Text("modifie"),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SingUp();
                      },
                      settings: RouteSettings(arguments: data)))
              .then((value) {
            setState(() {});
          });
          ;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
