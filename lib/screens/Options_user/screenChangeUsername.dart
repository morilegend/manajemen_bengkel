import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/services/userServices.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({Key? key}) : super(key: key);

  @override
  _ChangeUsernameScreenState createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final TextEditingController _newUsernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _newUsernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Username Baru',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username Tidak Valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String newUsername = _newUsernameController.text;
                      try {
                        await username().changeUsername(newUsername);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Berhasil Update"),
                              content: Text('Username Berhasil Di Update'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        print(e);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Gagal Update'),
                              content: Text('Username Gagal Diupdate'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
