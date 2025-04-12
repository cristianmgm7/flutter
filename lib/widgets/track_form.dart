import 'package:flutter/material.dart';
import '../models/song.dart';

class TrackForm extends StatefulWidget {
  final Function(Song) onSave;
  final Song? songToEdit;

  TrackForm({required this.onSave, this.songToEdit});

  @override
  _TrackFormState createState() => _TrackFormState();
}

class _TrackFormState extends State<TrackForm> {
  late String title;
  late String selectedKey;
  late String scaleType;
  late String degrees;

  final keyOptions = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  @override
  void initState() {
    super.initState();
    final song = widget.songToEdit;
    title = song?.title ?? '';
    selectedKey = song?.keyNote ?? 'C';
    scaleType = song?.scaleType ?? 'Major';
    degrees = song?.progression ?? '';
  }

  void saveForm() {
    if (title.isEmpty || degrees.isEmpty) return;

    final newSong = Song(
      title: title,
      keyNote: selectedKey,
      scaleType: scaleType,
      progression: degrees,
      tempo: null, // Tempo is not handled in this form
    );

    widget.onSave(newSong);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Song Name:', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: TextEditingController(text: title),
            onChanged: (value) => title = value,
          ),
          SizedBox(height: 10),
          Text('Key Note:', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: selectedKey,
            onChanged: (value) {
              setState(() {
                selectedKey = value!;
              });
            },
            items:
                keyOptions.map((key) {
                  return DropdownMenuItem(value: key, child: Text(key));
                }).toList(),
          ),
          SizedBox(height: 10),
          Text('Scale Type:', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Radio(
                value: 'Major',
                groupValue: scaleType,
                onChanged: (value) {
                  setState(() {
                    scaleType = value!;
                  });
                },
              ),
              Text('Major'),
              Radio(
                value: 'Minor',
                groupValue: scaleType,
                onChanged: (value) {
                  setState(() {
                    scaleType = value!;
                  });
                },
              ),
              Text('Minor'),
            ],
          ),
          SizedBox(height: 10),
          Text('Degrees:', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: TextEditingController(text: degrees),
            onChanged: (value) => degrees = value,
          ),
          SizedBox(height: 10),
          Text('Tempo:', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'BPM'),
            onChanged: (value) {
              // Handle tempo input
            },
          ),
          SizedBox(height: 10),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(onPressed: saveForm, child: Text('Save')),
          ),
        ],
      ),
    );
  }
}
