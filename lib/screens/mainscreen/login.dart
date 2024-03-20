import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/mainscreen/register.dart';
import 'package:kp_manajemen_bengkel/screens/manager/manager_home.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home.dart';
import 'package:kp_manajemen_bengkel/screens/admin/admin_home.dart';
import 'package:kp_manajemen_bengkel/services/loginuser.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = true;
  final _formKey = GlobalKey<FormState>();
  late String saveemail = "";
  late String savepassword = "";

  //Initilizaze
  userLogin newUserLogin = userLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  // Logic Pengecekan
                  onSaved: (value) {
                    saveemail = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                  }),

              const SizedBox(height: 20),
              TextFormField(
                obscureText: _showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                // Logic Pengecekan
                onSaved: (value) {
                  savepassword = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password Tidak Boleh Kosong";
                  }
                  return null;
                },
              ),

              // Login Button
              SizedBox(height: 30),
              ElevatedButton(
                //Logic Untuk Login
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    newUserLogin.newUserLogin(saveemail, savepassword, context);
                  } else {
                    null;
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  fixedSize: Size(300, 20),
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              // Register Button
              SizedBox(height: 5),
              ElevatedButton(
                // Ganti Ke Halaman Register
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  fixedSize: Size(300, 20),
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
