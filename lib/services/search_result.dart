import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layarlebar/screens/detail_movie_page.dart';
import 'package:http/http.dart' as http;
import 'package:layarlebar/apikey/apikey.dart';

class SearchResult extends StatefulWidget {
  final String query;

  const SearchResult({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

const searchUrl =
    'https://api.themoviedb.org/3/search/movie?api_key=$apikey&query=';

class _SearchResultState extends State<SearchResult> {
  List<Map<String, dynamic>> searchResult = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchMovie(widget.query);
  }

  Future<void> searchMovie(String query) async {
    var response = await http.get(Uri.parse('$searchUrl$query'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var results = jsonData['results'];

      setState(() {
        searchResult = List<Map<String, dynamic>>.generate(results.length, (i) {
          return {
            "title": results[i]["title"],
            "release_date": results[i]["release_date"],
            "poster_path": results[i]["poster_path"] != null
                ? 'https://image.tmdb.org/t/p/w500${results[i]["poster_path"]}'
                : null,
            "id": results[i]["id"],
            "overview": results[i]["overview"],
            "backdrop_path": results[i]["backdrop_path"] != null
                ? 'https://image.tmdb.org/t/p/w500${results[i]["backdrop_path"]}'
                : null,
          };
        });
        isLoading = false;
      });
    } else {
      print(response.statusCode);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              var movie = searchResult[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMovie(movie: movie),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      movie['poster_path'] != null
                          ? Image.network(
                              movie['poster_path'],
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 100,
                              height: 150,
                              color: Colors.grey,
                              child: Icon(Icons.movie,
                                  color: Colors.white, size: 50),
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              movie['release_date'] ?? 'N/A',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              movie['overview'],
                              style: TextStyle(
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
              );
            },
          );
  }
}
