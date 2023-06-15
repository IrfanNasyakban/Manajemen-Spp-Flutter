import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manajemen_spp/bayar.dart';
import 'package:manajemen_spp/profile.dart';
import 'package:manajemen_spp/transaksi.dart';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';

import 'loginpage.dart';
import 'main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;

  List<Siswa> listSiswa = [];
  Repository repository = Repository();

  getDataSiswa() async {
    try {
      listSiswa = await repository.getDataSiswa();
      setState(() {});
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        listSiswa = []; // Set listSiswa ke daftar kosong
      });
    }
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              // channel!.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notif cliked!!');
    });

    super.initState();
    getDataSiswa();
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = user.email!;
    String username;
    String url = 'http://192.168.154.32:5000/images/';

    if (userEmail == 'irfan@gmail.com') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == 'ari@gmail.com') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == 'widia@gmail.com') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadira';
    }

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 34, 31, 38),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 53, 17, 110),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  for (var siswaImage in listSiswa)
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Text(username,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white)),
                      subtitle: Text('SMAN 1 WATES',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white54)),
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(url + siswaImage.image),
                      ),
                    ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
            Container(
              color: Color.fromARGB(255, 53, 17, 110),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 31, 38),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200)),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard(
                        'Profile', CupertinoIcons.person_2, Colors.deepOrange,
                        () {
                      // Add your onPressed logic here for 'Profile'
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyProfile();
                          },
                        ),
                      );
                    }),
                    itemDashboard(
                        'Bayar SPP', CupertinoIcons.money_dollar, Colors.green,
                        () {
                      // Add your onPressed logic here for 'Bayar SPP'
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BayarSpp();
                          },
                        ),
                      );
                    }),
                    itemDashboard('Transaksi',
                        CupertinoIcons.bag_fill_badge_plus, Colors.purple, () {
                      // Add your onPressed logic here for 'Transaction'
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Transaksi();
                          },
                        ),
                      );
                    }),
                    itemDashboard('Keluar', CupertinoIcons.back, Colors.red,
                        () {
                      // Add your onPressed logic here for 'Log Out'
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      }).catchError((error) {
                        print('Logout Error: $error');
                      });
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 84, 28, 173),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
