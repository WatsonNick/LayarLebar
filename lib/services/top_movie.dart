import 'package:flutter/material.dart';
import 'package:layarlebar/screens/detail_movie_page.dart';
import 'package:layarlebar/apikey/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const popularmovieurl =
    'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';

class PopularMovie extends StatefulWidget {
  const PopularMovie({Key? key}) : super(key: key);

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  @override
  void initState() {
    super.initState();
    toptrendingthree();
  }

  Map<String, dynamic> popularmovie = {};

  Future<void> toptrendingthree() async {
    var response = await http.get(Uri.parse(popularmovieurl));

    if (response.statusCode == 200) {
      var jasonData = jsonDecode(response.body);
      var topthree = jasonData['results'];

      setState(() {
        popularmovie = {
          "title": topthree[0]["title"],
          "release_date": topthree[0]["release_date"],
          "overview": topthree[0]["overview"],
          "id": topthree[0]["id"],
          "poster_path":
              'https://image.tmdb.org/t/p/w500${topthree[0]["poster_path"]}',
          "backdrop_path":
              'https://image.tmdb.org/t/p/w500${topthree[0]["backdrop_path"]}',
        };
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMovie(movie: popularmovie),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.01),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    popularmovie['poster_path'],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          popularmovie['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          popularmovie['overview'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
