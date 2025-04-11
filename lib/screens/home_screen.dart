import 'package:flutter/material.dart';
import '../widgets/track_form.dart';
import '../models/song.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showForm = false;
  List<Song> songs = [];
  int? editingIndex;

  void addOrUpdateSong(Song song) {
    setState(() {
      if (editingIndex != null) {
        songs[editingIndex!] = song;
        editingIndex = null;
      } else {
        songs.add(song);
      }
      showForm = false;
    });
  }

  void editSong(int index) {
    setState(() {
      editingIndex = index;
      showForm = true;
    });
  }

  void deleteSong(int index) {
    setState(() {
      songs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final songToEdit = editingIndex != null ? songs[editingIndex!] : null;

    return Scaffold(
      appBar: AppBar(title: Text('My Tracks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (showForm && editingIndex != null) {
                    editingIndex = null;
                  }
                  showForm = !showForm;
                });
              },
              child: Text(showForm ? 'Cancel' : 'Add Track'),
            ),
            SizedBox(height: 20),
            if (showForm)
              TrackForm(onSave: addOrUpdateSong, songToEdit: songToEdit),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return Card(
                    child: ListTile(
                      title: Text('🎵 Song: ${song.title}'),
                      subtitle: Text(
                        'Tonality: ${song.keyNote} ${song.scaleType}\nProgression: ${song.progression}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => editSong(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteSong(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
