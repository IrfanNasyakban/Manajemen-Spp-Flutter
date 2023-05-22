import 'package:flutter/material.dart';
import 'package:manajemen_spp/formbayar.dart';
import 'package:flutter/services.dart';

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
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 420,
            width: 360,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.deepPurple, //color of border
                width: 2, //width of border
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'KARTU PEMBAYARAN SPP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'SMA NEGERI 1 WATES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Jl. Terbahsari Nomor 1, Terbah, Wates, Kulon Progo, D.I. Yogyakarta 55651',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Telp : (0274) 773067',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Email : smu1_wates@yahoo.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Silahkan bayar tagihan SPP melalui Virtual Account berikut',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 21),
                ),
                Container(
                  width: 90, // Lebar gambar
                  height: 90,
                  child: Image.asset('assets/bca.png'),
                ),
                Text(
                  'Nomor BCA Virtual Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '800080816742469',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'Total: Rp. 500.000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                MaterialButton(
                  onPressed: () {
                    Clipboard.setData(
                            const ClipboardData(text: "800080816742469"))
                        .then(
                      (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil Disalin!'),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Salin Nomor',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.deepPurple,
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormBayar();
                  },
                ),
              );
            },
            child: Container(
              padding:
                  EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Selanjutnya',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
