import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80); // Altura del AppBar personalizado
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 400,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
                'Copenhagen',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "¿A dónde quieres ir hoy?",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),

            TabBar(
              isScrollable: true,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'All homes'),
                Tab(icon: Icon(Icons.landscape), text: 'Countryside'),
                Tab(icon: Icon(Icons.design_services), text: 'Design'),
                Tab(icon: Icon(Icons.park), text: 'National parks'),
              ],
            ),
          ],
      ),
    );
  }
}