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
        backgroundColor: Color.fromARGB(255, 53, 17, 110),
      ),
      body: Container(
        color: Color.fromARGB(255, 34, 31, 38),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 420,
              width: 360,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 26, 63),
                border: Border.all(
                  color: Colors.white, //color of border
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
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'SMA NEGERI 1 WATES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
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
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Telp : (0274) 773067',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Email : smu1_wates@yahoo.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Silahkan bayar tagihan SPP melalui Virtual Account berikut / Langsung di Sekolah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 90, // Lebar gambar
                    height: 60,
                    child: Image.asset('assets/bca.png'),
                  ),
                  Text(
                    'Nomor BCA Virtual Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '800080816742469',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Total: Rp. 500.000',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
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
              'Apabila Sudah Bayar Silahkan tekan Selanjutnya',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
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
                padding: EdgeInsets.all(20),
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
      ),
    );
  }
}
