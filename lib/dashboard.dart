import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:manajemen_spp/bayar.dart';
import 'package:manajemen_spp/profile.dart';
import 'package:manajemen_spp/transaksi.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    String userEmail = user.email!;
    String username;

    if (userEmail == 'irfan@gmail.com') {
      username = 'Irvan Nasyakban';
    } else {
      username = 'Guest';
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello ' + username,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
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
                  itemDashboard('Transaksi', CupertinoIcons.bag_fill_badge_plus,
                      Colors.purple, () {
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
                  itemDashboard('Log Out', CupertinoIcons.back, Colors.red, () {
                    // Add your onPressed logic here for 'Log Out'
                    FirebaseAuth.instance.signOut();
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
