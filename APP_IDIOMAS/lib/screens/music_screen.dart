import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool isPlaying = false;
  bool showTranslation = false;
  
  final Map<String, dynamic> currentSong = {
    'title': 'Imagine',
    'artist': 'John Lennon',
    'language': 'Inglês',
    'lyrics': [
      {'en': 'Imagine there\'s no heaven', 'pt': 'Imagine que não há paraíso'},
      {'en': 'It\'s easy if you try', 'pt': 'É fácil se você tentar'},
      {'en': 'No hell below us', 'pt': 'Nenhum inferno abaixo de nós'},
      {'en': 'Above us only sky', 'pt': 'Acima de nós apenas o céu'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprender com Músicas'),
        backgroundColor: Colors.green[600],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.music_note,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    currentSong['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentSong['artist'],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                        iconSize: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.green[600],
                            size: 32,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next, color: Colors.white),
                        iconSize: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Letra da Música',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: showTranslation,
                  onChanged: (value) {
                    setState(() {
                      showTranslation = value;
                    });
                  },
                  activeColor: Colors.green[600],
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            Text(
              showTranslation ? 'Tradução ativada' : 'Apenas em inglês',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            
            SizedBox(height: 16),
            
          
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: currentSong['lyrics'].length,
                  itemBuilder: (context, index) {
                    final lyric = currentSong['lyrics'][index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lyric['en'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          if (showTranslation) ...[
                            SizedBox(height: 4),
                            Text(
                              lyric['pt'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          SizedBox(height: 8),
                          Divider(color: Colors.grey[200]),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                  
                  },
                  icon: Icon(Icons.favorite_border),
                  label: Text('Favoritar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Praticar vocabulário
                  },
                  icon: Icon(Icons.quiz),
                  label: Text('Praticar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}