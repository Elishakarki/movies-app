// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/main.dart';
import 'model/movies.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movielist =
      Movie.getMovies(); //here the getmovies method is
//here get method movies method is static so no need to add
//new or .to someobject but by directly classname is Movie
  final List movies = [
    "titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I am Legend",
    "300",
    "The wolf of wall Street",
    "interstellar",
    "Game of Thrones",
    "Vikings"
  ];

  MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        backgroundColor: Colors.blueGrey.shade900,
        body: ListView.builder(
            itemCount: movielist.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(children: [
                movieCard(movielist[index], context),
                Positioned(
                    top: 10,
                    left: 10,
                    child: movieImage(movielist[index].images[1])),
              ]);
              // return Card(
              //   elevation: 4.5,
              //   color: Colors.white,
              //   child: ListTile(
              //     leading: CircleAvatar(
              //       child: Container(
              //         height: 200,
              //         width: 200,
              //         decoration: BoxDecoration(
              //             image: DecorationImage(
              //                 image: NetworkImage(movielist[index].images[0]),
              //                 fit: BoxFit.cover),
              //             borderRadius: BorderRadius.circular(18)),
              //       ),
              //     ),
              //     trailing: Text("..."),
              //     title: Text(
              //       movielist[index].title,
              //     ),
              //     subtitle: Text("${movielist[index].title}"),
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (Context) => MovieListViewDetails(
              //                     movieName: movielist.elementAt(index).title,
              //                     movie: movielist[index],
              //                   )));
              //     },
              //     // onTap: () =>
              //     //  debugPrint("Movie name:${movies.elementAt(index)}"),
              //   ),
              // );
            }));
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.only(left: 60),
          width: MediaQuery.of(context).size.width,
          height: 120.0,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 54,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movie.title,
                          style: maintextstyle(),
                        ),
                        Text(
                          "${movie.imdbRating} /10",
                          style: maintextstyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "{ released:${movie.released}",
                          style: maintextstyle(),
                        ),
                        Text(
                          movie.runtime,
                          style: maintextstyle(),
                        ),
                        Text(
                          movie.rated,
                          style: maintextstyle(),
                        ),
                      ],
                    )
                  ]),
            ),
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (Context) => MovieListViewDetails(
                    movieName: movie.title, movie: movie)));
      },
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(imageUrl ??
                "https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyOTYyMzUxNl5BMl5BanBnXkFtZTcwNTg0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg"),
            fit: BoxFit.cover),
      ),
    );
  }

  TextStyle maintextstyle() {
    return const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies "),
        backgroundColor: Colors.blueGrey.shade900,
      ),

      body: ListView(
        children: [
          MovieDetailsThumbnail(
            thumbnail: movie.images[0],
          ),
          MovieDetailsHeadeerwithPoster(movie: movie),
          MovieDetailsCast(movie: movie),
          const HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images,)
        ],
      ),
      // body: Container(
      //   color: Colors.blueGrey.shade900,
      //   child: Center(
      //     child: ElevatedButton(

      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: Text("Go back  ${this.movie.title}"),
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;
  const MovieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail), fit: BoxFit.cover),
              ),
            ),
            const Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          height: 80,
        ),
      ],
    );
  }
}

class MovieDetailsHeadeerwithPoster extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeadeerwithPoster({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0]),
          const SizedBox(width: 16),
          Expanded(
            child: MovieDetailsHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year}.${movie.genre}".toUpperCase(),
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Text(
          movie.title,
          style: const TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        // ignore: prefer_const_constructors
        Text.rich(
          TextSpan(
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              children: <TextSpan>[
                TextSpan(text: movie.plot),
                const TextSpan(
                  text: "More...",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ]),
        ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRect(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;
  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Moviefield(field: "cast", Value: movie.actors),
          Moviefield(field: "directors", Value: movie.director),
          Moviefield(field: "language", Value: movie.language),
        ],
      ),
    );
  }
}

class Moviefield extends StatelessWidget {
  final String field;
  final String Value;
  const Moviefield({Key? key, required this.field, required this.Value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field:"),
        Text(Value),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          height: 0.5,
          color: Colors.black,
        ));
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;
  const MovieDetailsExtraPosters({Key? key, required this.posters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text("More Movie Posters".toUpperCase(),style: TextStyle(fontSize: 14,color:Colors.black26),),
      Container(
        height:200 ,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
           itemCount: posters.length,
          separatorBuilder: (context, index) => SizedBox(width: 8,),
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.all( Radius.circular(10),),
            child: Container(
              width: MediaQuery.of(context).size.width/4,
              height: 160,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(posters[index]),fit: BoxFit.cover)))),
            ),
          ), 
        
         
         
      
      ],
    );
  }
}
