import 'package:flutter/material.dart';
import 'package:layarlebar/services/movie_description.dart';
import 'package:layarlebar/services/reviews.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String titles;
  const TopBar({Key? key, this.titles = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 30)),
      title: Text(titles,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DetailMovie extends StatelessWidget {
  final Map<String, dynamic> movie;
  const DetailMovie({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TopBar(titles: "Details"),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff262c35), Color(0xff6a7c95)],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    movie['backdrop_path'] ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 14),
                  MovieDescription(
                    movieID: movie['id'],
                  ),
                  const SizedBox(height: 10),
                  const TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'About Movie'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 400,
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            movie['overview'] ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: ReviewMovie(movieID: movie['id']),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
