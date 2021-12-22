import 'package:api_practice_demo_albums/domain/albums.dart';
import 'package:api_practice_demo_albums/repository/album_api_client/album_api_client.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Album> futureAlbum;
  AlbumApiClient albumApiClient = AlbumApiClient();

  @override
  void initState() {
    super.initState();
    futureAlbum = albumApiClient.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            else if(snapshot.connectionState == ConnectionState.done) {
              return Text('${snapshot.connectionState}');
            }
            else if(snapshot.connectionState == ConnectionState.active) {
              return Text('${snapshot.connectionState}');
            }
            else if(snapshot.connectionState == ConnectionState.none) {
              return Text('${snapshot.connectionState}');
            }
            else if(snapshot.connectionState == ConnectionState.waiting) {
              return Text('${snapshot.connectionState}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
