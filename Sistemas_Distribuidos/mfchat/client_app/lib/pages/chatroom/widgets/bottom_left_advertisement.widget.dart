import 'dart:math';

import 'package:client_app/application/ui/app_dialogs.dart';
import 'package:flutter/material.dart';

class BottomLeftAdvertisementWidget extends StatefulWidget {
  const BottomLeftAdvertisementWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomLeftAdvertisementWidget> createState() =>
      _BottomLeftAdvertisementWidgetState();
}

class _BottomLeftAdvertisementWidgetState
    extends State<BottomLeftAdvertisementWidget> {
  AdModel currentAd = _allAds.first;

  @override
  void initState() {
    super.initState();
    _changeAd();
  }

  void _changeAd() {
    final delay = Duration(milliseconds: 10000 + Random().nextInt(12000));
    Future.delayed(delay).then((_) {
      setState(() {
        currentAd = _allAds.elementAt(Random().nextInt(_allAds.length));
      });
      _changeAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.green[100],
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            AppDialogs.information(context, message: 'Thanks for the support!');
          },
          child: Column(
            children: [
              Text(
                currentAd.title,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                currentAd.description,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdModel {
  final String title;
  final String url;
  final String description;

  const AdModel(
    this.title, {
    required this.url,
    required this.description,
  });
}

const List<AdModel> _allAds = [
  AdModel(
    'Lojas Americanas',
    description: 'Tudo. A toda hora. Em qualquer lugar. Americanas!',
    url: 'https://www.americanas.com.br',
  ),
  AdModel(
    'Óticas Diniz',
    description: 'Óticas Diniz, lugar de ser feliz!!',
    url: 'https://www.oticasdiniz.com.br',
  ),
  AdModel(
    'Casa do Código',
    description: 'Feitos por programadores para programadores.',
    url: 'https://www.casadocodigo.com.br',
  ),
  AdModel(
    'Tumelero',
    description: 'Tumelero, ninguém facilita tanto!',
    url: 'https://www.tumelero.com.br',
  ),
  AdModel(
    'Amazon',
    description: 'Work Hard, Have Fun, Make History',
    url: 'https://www.amazon.com.br/',
  ),
  AdModel(
    'Polar',
    description: 'A melhor é daqui! No Export.',
    url: 'https://www.cervejapolar.com.br/',
  ),
  AdModel(
    'Heineken',
    description: 'A melhor cerveja do mundo!',
    url: 'https://www.heineken.com.br/',
  ),
  AdModel(
    'Coca-Cola',
    description: 'Coca-Cola, a melhor bebida do mundo!',
    url: 'https://www.coca-cola.com.br/',
  ),
];
