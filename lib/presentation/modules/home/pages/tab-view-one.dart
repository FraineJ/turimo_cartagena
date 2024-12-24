import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/event/event_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/button-outlined.dart';
import 'package:turismo_cartagena/presentation/global/widgets/skeleton-card-buys.dart';
import 'package:turismo_cartagena/presentation/modules/events/widgets/card-events.dart';

class TabViewOneHome extends StatefulWidget {
  const TabViewOneHome({super.key});

  @override
  State<TabViewOneHome> createState() => _TabViewOneHomeState();
}

class _TabViewOneHomeState extends State<TabViewOneHome> {
  void _reloadEvents(BuildContext context) {
    context.read<EventBloc>().add(GetEventEvent());
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
              'https://media.istockphoto.com/id/466497932/es/foto/torre-del-reloj-de-puerta.jpg?s=612x612&w=0&k=20&c=iDG3eUSoQHWvWFwwDmGlWOK0o0KFZ_Xfnw7tR9UdinI=',
              'https://ca-times.brightspotcdn.com/dims4/default/b62e116/2147483647/strip/true/crop/1515x1000+0+0/resize/1200x792!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fec%2F48%2F75fb9d684e1b9673520e911a8a3c%2Fun-destino-para-gozar-958578.JPG',
              'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Baluarte_de_Santiago_CTG_11_2019_9804.jpg/1200px-Baluarte_de_Santiago_CTG_11_2019_9804.jpg',
              'https://somosmotta.com/wp-content/uploads/2019/07/fotografia-foto-photo-aviso-letrero-turistico-bienvenida-cartagena-turismo-travel-colombia-fondos-wallpapers-somos-motta.jpg',
            ].map((imagePath) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.current.event,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          BlocProvider(
            create: (context) => EventBloc(sl())..add(GetEventEvent()),
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is LoadingGetEvent) {
                  return const Center(child: SkeletonCardBuys());
                }
                if (state is SuccessGetEvent) {
                  final List<EventModel> listModel = state.events;
                  if (listModel.isEmpty) {
                    return  Center(child: Text(S.current.noFoundEvent));
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
                      padding: const EdgeInsets.symmetric(horizontal:  16.0, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/menu-icon-04.svg",
                            width: 80.0, // Ajusta según tus necesidades
                            height: 80.0,
                          ),
                          const SizedBox(height: 16),
                           Text(S.current.noFoundEvent,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 16),
                          RegistrationButton(
                            color: Colors.green,
                            width: 190,
                            text: S.current.retry,
                            onPressed: () => _reloadEvents(context)
                          ),

                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: Text("Error al cargar los eventos."));
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
