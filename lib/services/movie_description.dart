import 'package:flutter/material.dart';
import 'package:layarlebar/apikey/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const moviedetailurl = 'https://api.themoviedb.org/3/movie/';

class MovieDescription extends StatefulWidget {
  final int movieID;

  const MovieDescription({Key? key, required this.movieID}) : super(key: key);

  @override
  _MovieDescriptionState createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  Map<String, dynamic> movie = {};

  @override
  void initState() {
    super.initState();
    moviedesc();
  }

  Future<void> moviedesc() async {
    var response = await http
        .get(Uri.parse('$moviedetailurl${widget.movieID}?api_key=$apikey'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        movie = {
          "title": data["title"],
          "release_date": data["release_date"],
          "overview": data["overview"],
          "genres": data["genres"][0]["name"],
          "poster_path":
              'https://image.tmdb.org/t/p/w500${data["poster_path"]}',
          "backdrop_path":
              'https://image.tmdb.org/t/p/w500${data["backdrop_path"]}',
          "runtime": data["runtime"],
        };
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return movie.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  movie['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon/CalendarBlank.png", width: 20),
                    const SizedBox(width: 5),
                    Text(
                      movie['release_date'] != null
                          ? movie['release_date'].substring(0, 4)
                          : '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      '  |  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset("assets/icon/Clock.png", width: 20),
                    Text(
                      movie['runtime'].toString() + ' mins',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      '  |  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset("assets/icon/Ticket.png", width: 20),
                    const SizedBox(width: 5),
                    Text(
                      movie['genres'] ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
