import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/rate.model.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-services.dart';
import 'package:turismo_cartagena/presentation/modules/partner/widgets/spaces-header-appbar.dart';

import '../../../domain/models/partner.model.dart';

class PartnerDetailScreen extends StatefulWidget {
  final PartnersModel partners;

  const PartnerDetailScreen({super.key, required this.partners});

  @override
  _PartnerDetailScreenState createState() =>
      _PartnerDetailScreenState(partners: this.partners);
  }

class _PartnerDetailScreenState extends State<PartnerDetailScreen> {
  final PartnersModel partners;
  final ScrollController _scrollController = ScrollController();

  _PartnerDetailScreenState({required this.partners});
  bool isDollar = false;
  double tasaDeCambio = 1.0;

  final Servicio fakeService = Servicio(
    id: 1,
    tipo: "",
    direccion: "Esta es una direccion",
    name: "Tour en el centro histórico",
    descripcion: "Explora los lugares más emblemáticos de Cartagena con guías expertos. Disfruta de la arquitectura colonial y aprende sobre su historia.",
    imagenes: [
      {"url": "https://fortificacionescartagena.com.co/wp-content/uploads/2017/06/planee-su-visita-castillo-san-felipe.jpg"},
      {"url": "https://fortificacionescartagena.com.co/wp-content/uploads/2017/06/planee-su-visita-castillo-san-felipe.jpg"},
    ],
    tarifa: Tarifa(
      precio: 80000,
      id: 1,
      moneda: "COP",
      temporada: '',
    ),
  );

  Future<void> fetchExchangeRate() async {
    String apiUrl = "https://www.datos.gov.co/resource/32sa-8pi3.json";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final body = jsonDecode(response.body);

      setState(() {
        tasaDeCambio = double.parse(body[0]['valor']);
        isDollar = !isDollar;
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  double convertToDollar(double priceInCop) {
    return priceInCop / tasaDeCambio;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    const threshold = 100.0;
    if (_scrollController.offset > threshold) {
      print("Umbral de desplazamiento superado.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SpacesHeaderAppBar(imagenes: partners.imagesUrl,),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderSliver(partner : partners ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Text(partners.description),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => CardServicesPartner(
                services: fakeService,
                isDollar: isDollar,
                exchangeRate: tasaDeCambio,
              ),
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}

const maxHeaderExtent = 100.0;

class _HeaderSliver extends SliverPersistentHeaderDelegate {

  final PartnersModel partner;

  _HeaderSliver({required this.partner});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxHeaderExtent;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            width: maxHeaderExtent,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: percent > 0.1 ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 300),
                          offset: Offset(percent < 0.1 ? -0.10 : 0.1, 0),
                          curve: Curves.easeIn,
                          child:  Text(partner.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 8),
                            Text(
                              '4.5 Rating',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text(
                              '1 Km de distancia',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$120/night',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
