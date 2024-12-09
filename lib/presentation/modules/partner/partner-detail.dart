import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/rate.model.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/modules/partner/widgets/spaces-header-appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;

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
  Position? originLatLng;

  Future<Position?> _getCurrentLocation() async {
    Position? currentLocation = await SHARED.Utils.getPositionCurrent();
    if (currentLocation != null) {
      originLatLng = Position(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }
    return originLatLng;
  }


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
  void initState()  {
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void _launchURL(Uri uri, bool inApp) async {
    try {
      if (inApp) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position?>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error al obtener la ubicación"),
              );
            } else {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SpacesHeaderAppBar(imagenes: partners.imagesUrl,),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderSliver(
                        partner: partners, originLatLng: snapshot.data),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          Text(
                            partners.address,
                            style: const TextStyle(
                                color: Colors.black87
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Text(S.current.description,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          Text(partners.description,
                            style: const TextStyle(
                              fontSize: 16,

                            ),

                          ),
                          const SizedBox(height: 16,),
                          /*const Text("Reseñas",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          const SizedBox(height: 16,),
                          const ReviewCard(
                              userName: "Frainer Simarra",
                              userRole: "Cartagena, Colombia",
                              reviewText: "Eclente lugar cuenta con un luhar muy hermoso estoy segura que volveria a visitarlo",
                              userImageUrl: "https://fotografias.antena3.com/clipping/cmsimages01/2021/05/02/26E03450-C5FB-4D16-BC9B-B282AE784352/57.jpg",
                              rating: 2

                          )
                          const SizedBox(height: 16,),
                          const Text("Servicios",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          const SizedBox(height: 16,),*/
                        ],
                      ),
                    ),
                  ),
                  /*SliverToBoxAdapter(
                    child: SizedBox(
                      height: 370, // Altura fija para la lista horizontal
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // Dirección horizontal
                        itemCount: 6,
                        itemBuilder: (context, index) =>
                            CardServicesPartner(
                              services: fakeService,
                              isDollar: isDollar,
                              exchangeRate: tasaDeCambio,
                            ),
                      ),
                    ),
                  ),*/
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                           Text(S.current.contact,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          const SizedBox(height: 8,),
                           Text(S.current.sendLinkContact,
                            style: const TextStyle(
                              fontSize: 15,
                            ),

                          ),
                          const SizedBox(height: 16,),
                          Container(
                            child: Row(
                              children: [
                                partners!.phone != 0 ? Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: Colors.blueAccent,

                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        _makePhoneCall(partners.phone.toString());
                                      },
                                      icon: const Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),

                                    ),
                                  ),
                                ) : const SizedBox.shrink(),
                                const SizedBox(width: 16,),
                                partners!.whatsapp != 0 ? Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: Colors.blueAccent,

                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        _launchURL(Uri.parse('whatsapp://send?phone=+${partners.whatsapp}&text=hola como estas'), false);
                                      },
                                      icon: const  FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color:  Colors.white

                                      ),

                                    ),
                                  ),
                                ) : SizedBox.shrink(),
                                const SizedBox(width: 16,),

                                /*Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: Colors.blueAccent,

                                  ),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {

                                      },
                                      icon: const Icon(
                                        Icons.language,
                                        color: Colors.white,
                                      ),

                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                ],
              );

            }

        }
      ),
    );
  }
}

const maxHeaderExtent = 100.0;

class _HeaderSliver extends SliverPersistentHeaderDelegate {

  final PartnersModel partner;
  final Position? originLatLng;
  _HeaderSliver({required this.partner, required this.originLatLng});

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
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 300),
                          offset: Offset(percent < 0.1 ? -0.10 : 0.1, 0),
                          curve: Curves.easeIn,
                          child:  Text(partner.name,
                            style: const TextStyle(
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
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Row(
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
                            const SizedBox(width: 28),
                            const Icon(Icons.location_on, color: Colors.white, size: 16),
                            const SizedBox(width: 8),
                            Text(SHARED.Utils.haversineDistanceString(
                                originLatLng?.latitude ?? 0.0,
                                originLatLng?.longitude ?? 0.0,
                                partner.latitud,
                                partner.longitud),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
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