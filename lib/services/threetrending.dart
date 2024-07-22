import 'package:flutter/material.dart';
import 'package:layarlebar/screens/detail_movie_page.dart';
import 'dart:convert';
import 'package:layarlebar/apikey/apikey.dart';
import 'package:http/http.dart' as http;

const threemoviesurl =
    'https://api.themoviedb.org/3/trending/movie/day?api_key=$apikey';

class ThreeTopMovies extends StatefulWidget {
  const ThreeTopMovies({Key? key}) : super(key: key);

  @override
  _ThreeTopMoviesState createState() => _ThreeTopMoviesState();
}

class _ThreeTopMoviesState extends State<ThreeTopMovies> {
  @override
  void initState() {
    super.initState();
    toptrendingthree();
  }

  List<Map<String, dynamic>> threemovies = [];

  Future<void> toptrendingthree() async {
    var response = await http.get(Uri.parse(threemoviesurl));

    if (response.statusCode == 200) {
      var jasonData = jsonDecode(response.body);
      var topthree = jasonData['results'];

      setState(() {
        threemovies = List<Map<String, dynamic>>.generate(3, (i) {
          return {
            "title": topthree[i]["title"],
            "release_date": topthree[i]["release_date"],
            "overview": topthree[i]["overview"],
            "poster_path":
                'https://image.tmdb.org/t/p/w500${topthree[i]["poster_path"]}',
            "backdrop_path":
                'https://image.tmdb.org/t/p/w500${topthree[i]["backdrop_path"]}',
            "id": topthree[i]["id"],
          };
        });
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: threemovies.map((movie) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMovie(movie: movie),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.01),
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.network(
                    movie['poster_path'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie['release_date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie['overview'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
