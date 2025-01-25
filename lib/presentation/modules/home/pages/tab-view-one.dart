import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/event/event_bloc.dart';

import 'package:turismo_cartagena/presentation/modules/events/widgets/card-events.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as UTILS;
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as GLOBAL;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class TabViewOneHome extends StatefulWidget {
  const TabViewOneHome({super.key});

  @override
  State<TabViewOneHome> createState() => _TabViewOneHomeState();
}

class _TabViewOneHomeState extends State<TabViewOneHome> {
  late final WebViewController _webViewController;
  void _reloadEvents(BuildContext context) {
    context.read<EventBloc>().add(GetEventEvent());
  }

  Future navigationWed(String link) async {
    if (Platform.isIOS) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GLOBAL.WebPageViewer(
            url: link,
            title: S.current.advertising,
          ),
        ),
      );
    } else {
      UTILS.Utils.launchURL(context, Uri.parse(link), true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 4 - 40,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: [
              {
                "image": 'https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/carrusel/slider-two.jpeg',
                "isAd": true,
                "link": "https://carnavaldebarranquilla.org/",
                "navigationInternal" : false,
              },
              {
                "image": 'https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/carrusel/slider-one.webp',
                "isAd": true,
                "link": "https://convocatorias.ipcc.gov.co/convocatoria-festival-del-frito-2025",
                "navigationInternal" : false,
              },
              {
                "image": 'https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/carrusel/slider-three.webp',
                "isAd": false,
                "link": "https://www.hayfestival.com/cartagena/inicio",
                "navigationInternal" : false,
              },
              {
                "image": 'https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/carrusel/slider-for.webp',
                "isAd": false,
                "link": "https://www.hayfestival.com/cartagena/inicio",
                "navigationInternal" : true,
              }
            ].map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: (){
                      item["navigationInternal"] == false
                      ? navigationWed(item["link"].toString())
                      : Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Layout(currentItemPages: 2)), (route) => false
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: item["image"].toString()!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                              const Center(child:   GLOBAL.Skeleton(height: 160, width: double.infinity),),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/no-photo.jpg",
                                fit: BoxFit.cover, // Asegura que la imagen de respaldo cubra el área
                              ),
                            ),
                          ),
                        ),
                        if (item["isAd"] == true)
                          Positioned(
                            left: 10,
                            bottom: 10.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Publicidad",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.current.event,
              style:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          BlocProvider(
            create: (context) => EventBloc(sl())..add(GetEventEvent()),
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is LoadingGetEvent) {
                  return const Center(child: GLOBAL.SkeletonCardBuys());
                }
                if (state is SuccessGetEvent) {
                  final List<EventModel> listModel = state.events;
                  if (listModel.isEmpty) {
                    return Center(child: Text(S.current.noFoundEvent));
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listModel.length,
                    itemBuilder: (context, index) {
                      final EventModel event = listModel[index];
                      return EventCard(event: event);
                    },
                  );
                }
                if (state is ErrorGetEvent) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/menu-icon-04.svg",
                            width: 80.0,
                            height: 80.0,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S.current.noFoundEvent,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 16),
                          GLOBAL.RegistrationButton(
                            color: Colors.green,
                            width: 190,
                            text: S.current.retry,
                            onPressed: () => _reloadEvents(context),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                    child: Text("Error al cargar los eventos."));
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
