import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/bottomnav_user.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home(news).dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;
  bool showPassword1 = true;
  bool showPassword2 = true;
  bool showPassword3 = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: showPassword1,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword1 = !showPassword1;
                      });
                    },
                    icon: Icon(
                      showPassword1 ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                obscureText: showPassword2,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword2 = !showPassword2;
                      });
                    },
                    icon: Icon(
                      showPassword2 ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: showPassword3,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword3 = !showPassword3;
                      });
                    },
                    icon: Icon(
                      showPassword3 ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your new password';
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
                  String oldPassword = _oldPasswordController.text;
                  String newPassword = _newPasswordController.text;
                  String confirmNewPassword =
                      _confirmNewPasswordController.text;

                  if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please enter and confirm your new password'),
                      ),
                    );
                    return;
                  }

                  bool passwordMatch =
                      await UserData().checkPassword(oldPassword);
                  if (passwordMatch) {
                    if (newPassword == confirmNewPassword) {
                      await UserData().changePassword(newPassword);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Password Anda telah berhasil diubah!',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 20),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NavbarUser(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Konfirmasi password baru tidak sesuai'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password lama tidak sesuai'),
                      ),
                    );
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
    );
  }
}
