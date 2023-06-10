import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BuktiBayar extends StatefulWidget {
  const BuktiBayar({super.key});

  @override
  State<BuktiBayar> createState() => _BuktiBayarState();
}

class _BuktiBayarState extends State<BuktiBayar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Bukti'),
    );
  }
}