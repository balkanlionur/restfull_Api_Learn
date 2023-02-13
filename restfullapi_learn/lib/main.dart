import 'package:flutter/material.dart';
import 'package:restfullapi_learn/model/user_model.dart';
import 'package:restfullapi_learn/service/user_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;

  List<UserModelData?> users = [];

  @override
  void initState() {
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('data'),
          ),
          body: isLoading == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : isLoading == true
                  ? ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${users[index]!.firstName! + users[index]!.lastName!}'),
                          subtitle: Text(users[index]!.email!),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index]!.avatar!),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Bir sorun oluştu...'),
                    )),
    );
  }
}
