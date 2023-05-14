import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BayarSpp extends StatefulWidget {
  const BayarSpp({super.key});

  @override
  State<BayarSpp> createState() => _BayarSppState();
}

class _BayarSppState extends State<BayarSpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Bayar SPP'),
    );
  }
}