import 'package:flutter/material.dart';
import 'package:manajemen_spp/formbayar.dart';

class BayarSpp extends StatefulWidget {
  const BayarSpp({super.key});

  @override
  State<BayarSpp> createState() => _BayarSppState();
}

class _BayarSppState extends State<BayarSpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran SPP'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 420,
            width: 360,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, //color of border
                width: 2, //width of border
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Apabila Sudah Transfer Silahkan tekan Selanjutnya',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormBayar();
                  },
                ),
              );
            },
            child: Text('Selanjutnya'),
            color: Colors.deepPurple[200],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
