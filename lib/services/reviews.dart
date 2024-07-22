import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:layarlebar/apikey/apikey.dart';
import 'package:http/http.dart' as http;

class ReviewMovie extends StatefulWidget {
  final int movieID;

  const ReviewMovie({Key? key, required this.movieID}) : super(key: key);

  @override
  _ReviewMovieState createState() => _ReviewMovieState();
}

const reviewUrl = 'https://api.themoviedb.org/3/movie/';

class _ReviewMovieState extends State<ReviewMovie> {
  List<Map<String, dynamic>> review = [];

  @override
  void initState() {
    super.initState();
    reviewMovie();
  }

  Future<void> reviewMovie() async {
    var response = await http
        .get(Uri.parse('$reviewUrl${widget.movieID}/reviews?api_key=$apikey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        review =
            List<Map<String, dynamic>>.generate(data["results"].length, (i) {
          return {
            "author": data["results"][i]["author"],
            "content": data["results"][i]["content"],
            "updated_at": data["results"][i]["updated_at"],
            "avatar_path": data["results"][i]["author_details"]
                        ["avatar_path"] !=
                    null
                ? 'https://image.tmdb.org/t/p/w500${data["results"][0]["author_details"]["avatar_path"]}'
                : null,
          };
        });
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return review.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: review.map((review) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: review["avatar_path"] != null
                        ? NetworkImage(review["avatar_path"])
                        : null,
                  ),
                  title: Text(
                    review["author"],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review["content"],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white)),
                      Text(
                          review["updated_at"] != null
                              ? review["updated_at"].substring(0, 10)
                              : '',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.75))),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
  }
}
