import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/Options_user/screenChangePassword.dart';
import 'package:kp_manajemen_bengkel/screens/user/Options_user/screenChangeEmail.dart';
import 'package:kp_manajemen_bengkel/screens/user/Options_user/screenChangeNumber.dart';
import 'package:kp_manajemen_bengkel/screens/user/Options_user/screenChangeUsername.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({Key? key}) : super(key: key);

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  final UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(30, 70),
        child: AppBar(
          backgroundColor: Color.fromRGBO(231, 229, 93, 1),
          elevation: 1,
          automaticallyImplyLeading: false, //Menghilangkan Tombol Back
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          title: DefaultTextStyle(
            style: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: 190,
                  height: 29,
                  child: FutureBuilder<Map<dynamic, dynamic>?>(
                    future: userData.getUser(),
                    builder: (BuildContext,
                        AsyncSnapshot<Map<dynamic, dynamic>?> snapshot) {
                      return Text(
                        snapshot.data?['username'] ?? "",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 190,
                  height: 25,
                  child: FutureBuilder<Map<dynamic, dynamic>?>(
                    future: userData.getUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<dynamic, dynamic>?> snapshot) {
                      return Text(
                        snapshot.data?['number'] ?? "",
                        style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: Text(
              'Account Management',
              style: TextStyle(
                color: Color.fromARGB(223, 209, 209, 209),
                fontSize: 15,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Ganti Password',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => ChangePasswordScreen(),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Ganti Email',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ChangeEmailScreen());
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Ganti Nomor HP',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ChangeNumberScreen());
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Ganti Username',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ChangeUsernameScreen());
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),

          //Pengaturan Lainnya
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: Text(
              'Pengaturan Lainnya',
              style: TextStyle(
                color: Color.fromARGB(255, 209, 209, 209),
                fontSize: 15,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Notifikasi',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // changeUsername();
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'Dark Mode',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // changeUsername();
            },
          ),
        ],
      ),
    );
  }
}
