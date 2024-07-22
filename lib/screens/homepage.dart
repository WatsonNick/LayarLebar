import 'package:flutter/material.dart';
import 'package:layarlebar/screens/searchbox_page.dart';
import 'package:layarlebar/services/threetrending.dart';
import 'package:layarlebar/services/top_movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset('assets/image/noun-cinema-screen.png',
                    width: double.infinity),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Top Trending',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PopularMovie(),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'What do you want to watch?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SearchBox(),
                const SizedBox(height: 40),
                const Text(
                  'Weekly Top Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const ThreeTopMovies(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
