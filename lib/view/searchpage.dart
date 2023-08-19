import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _generatedUrl = "";

  void _navigateToWebsite(String songName) {
    String url = "http://mp3quack.app/mp3/Tiny-Dancer";
    String capitalizedSongName =
        songName.substring(0, 1).toUpperCase() + songName.substring(1);
    String updatedUrl =
        url.replaceAll("Tiny-Dancer", capitalizedSongName.replaceAll(" ", "-"));

    setState(() {
      _generatedUrl = updatedUrl;
    });

    // Open the generated URL in the user's browser
    _launchURL(updatedUrl);
  }

  // Function to launch URL using url_launcher package
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error if the URL cannot be launched
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 127, 15),
        title: Text(
          'Song Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // Add the decoration here
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 16, 4, 4).withOpacity(1.0),
              Color.fromARGB(175, 247, 107, 0).withOpacity(1.0),
              Color.fromARGB(246, 16, 13, 2).withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    _navigateToWebsite(value);
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter the song name',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _navigateToWebsite(_searchController.text);
                  },
                  child: Text(
                    'Search',
                  ),
                ),
                SizedBox(height: 16),
                // Display the generated URL
                Text(
                  _generatedUrl,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
