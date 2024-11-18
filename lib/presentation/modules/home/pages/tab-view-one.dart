import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/modules/home/widgest/card-events.dart';
import 'package:turismo_cartagena/presentation/modules/home/widgest/widget-category.dart';
import 'package:turismo_cartagena/presentation/modules/places/places.dart';


class TabViewOneHome extends StatelessWidget {
  const TabViewOneHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 4 - 40,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: [
                'https://media.istockphoto.com/id/466497932/es/foto/torre-del-reloj-de-puerta.jpg?s=612x612&w=0&k=20&c=iDG3eUSoQHWvWFwwDmGlWOK0o0KFZ_Xfnw7tR9UdinI=',
                'https://ca-times.brightspotcdn.com/dims4/default/b62e116/2147483647/strip/true/crop/1515x1000+0+0/resize/1200x792!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fec%2F48%2F75fb9d684e1b9673520e911a8a3c%2Fun-destino-para-gozar-958578.JPG',
                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Baluarte_de_Santiago_CTG_11_2019_9804.jpg/1200px-Baluarte_de_Santiago_CTG_11_2019_9804.jpg',
                'https://somosmotta.com/wp-content/uploads/2019/07/fotografia-foto-photo-aviso-letrero-turistico-bienvenida-cartagena-turismo-travel-colombia-fondos-wallpapers-somos-motta.jpg',
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
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
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(S.current.event,
                style:const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            EventCard(
              imageUrl: 'https://cccartagena.com/wp-content/uploads/2019/01/espaciosBannerMod.jpg',
              title: 'Feria de Arte y Cultura',
              date: '20 de octubre, 2024',
              description: 'Exhibiciones de arte local, talleres y espectáculos culturales.',
            ),
            EventCard(
              imageUrl: 'https://latiquetera.com/img/attach/Event/3610/52921/square_normal.f6f2c5adb11d623418e587687189d53d.webp',
              title: 'Concierto Andrés cepeda',
              date: '14 septiembre, 2024',
              description: 'Luego de viajar por el mundo con mi música, regreso a mi país a cantar las canciones que son la banda sonora de la vida de muchos, cuyas historias se parecen mucho a las mías. Cantarlas juntos es reconocer que se ha vivido y se sigue viviendo intensamente”, explica Cepeda',
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),

            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
