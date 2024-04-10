import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/mainscreen/register.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

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

  //Initilizaze From userLogin --> UserLogin
  userLogin UserLogin = userLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170),
        child: AppBar(
          backgroundColor: Color.fromRGBO(231, 229, 93, 1),
          elevation: 3,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.asset(
                'assets/img/LogoGAC.png',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ),

      //Body
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                width: 270,
                height: 309,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 236, 234, 1),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                      )
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 10,
                      right: 10,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 75,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                  )),
                              // Logic Pengecekan
                              onSaved: (value) {
                                saveemail = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 10),
                          SizedBox(
                            height: 75,
                            child: TextFormField(
                              obscureText: _showPassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.indigo),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
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
                          ),

                          // Login Button
                          SizedBox(height: 8),
                          ElevatedButton(
                            //Logic Untuk Login
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                UserLogin.LoginUser(
                                    saveemail, savepassword, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              minimumSize: Size(300, 40),
                              backgroundColor: Colors.indigo,
                            ),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Text(
                              'Belum punya akun? Daftar sekarang!',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
