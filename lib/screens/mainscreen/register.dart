import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/mainscreen/login.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Show Hide Password Var
  bool _showPassword1 = true;
  bool _showPassword2 = true;

  //Save
  final _formKey = GlobalKey<FormState>();
  late String saveusername = "";
  late String savepassword = "";
  late String saveemail = "";
  late String savenumber = "";

  //Controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //Initializaze
  userRegister newUser = userRegister();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Username
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    saveusername = value!;
                  },
                ),

                //Email
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Email Tidak Valid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    saveemail = value!;
                  },
                ),

                //Number
                const SizedBox(height: 15),
                TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    labelText: 'Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor tidak boleh kosong';
                    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Nomor hanya boleh berisi angka';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    savenumber = value!;
                  },
                ),

                //Password
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: _showPassword1,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    //Logika Password Hide And Show
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword1
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword1 = !_showPassword1;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    } else if (value.length < 6) {
                      return 'Password Harus Memiliki Panjang Diatas 6 Huruf';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    savepassword = value!;
                  },
                ),

                //Confirm Password
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: _showPassword2,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    //Logika Password Hide And Show
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword2 = !_showPassword2;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi Password tidak boleh kosong';
                    } else if (value != passwordController.text) {
                      null;
                      return 'Konfirmasi Password tidak sesuai';
                    }
                    return null;
                  },
                ),

                //Button
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //Path To auth.dart --> Save To Firebase

                      bool success = await newUser.newUserRegis(saveemail,
                          savepassword, saveusername, savenumber, context);

                      if (success == success) {
                        _formKey.currentState!.save();
                        newUser.newUserRegis(saveemail, savepassword,
                            saveusername, savenumber, context);
                        // Tampilkan popup notifikasi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Pendaftaran berhasil. Silakan login.'),
                            duration: Duration(seconds: 4),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                        _formKey.currentState!.save();
                      } else {
                        print("Tidak Berhasil Register");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    fixedSize: const Size(300, 20),
                    backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
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
