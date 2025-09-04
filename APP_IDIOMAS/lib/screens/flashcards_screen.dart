import 'package:flutter/material.dart';

class FlashcardsScreen extends StatefulWidget {
  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int currentCardIndex = 0;
  bool isFlipped = false;
  
  final List<Map<String, String>> flashcards = [
    {'front': 'Hello', 'back': 'Olá', 'language': 'Inglês'},
    {'front': 'Thank you', 'back': 'Obrigado', 'language': 'Inglês'},
    {'front': 'Good morning', 'back': 'Bom dia', 'language': 'Inglês'},
    {'front': 'How are you?', 'back': 'Como você está?', 'language': 'Inglês'},
    {'front': 'Goodbye', 'back': 'Tchau', 'language': 'Inglês'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
        backgroundColor: Colors.purple[600],
        elevation: 0,
      ), 
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
        
            Container(
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progresso'),
                      Text('${currentCardIndex + 1}/${flashcards.length}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (currentCardIndex + 1) / flashcards.length,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[600]!),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
        
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFlipped = !isFlipped;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isFlipped ? Colors.purple[50] : Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isFlipped ? Colors.purple[200]! : Colors.blue[200]!,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isFlipped ? Icons.translate : Icons.language,
                        size: 48,
                        color: isFlipped ? Colors.purple[400] : Colors.blue[400],
                      ),
                      SizedBox(height: 24),
                      Text(
                        isFlipped 
                          ? flashcards[currentCardIndex]['back']!
                          : flashcards[currentCardIndex]['front']!,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        isFlipped ? 'Português' : flashcards[currentCardIndex]['language']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Toque para virar',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 32),
            
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: currentCardIndex > 0 ? () {
                    setState(() {
                      currentCardIndex--;
                      isFlipped = false;
                    });
                  } : null,
                  icon: Icon(Icons.arrow_back),
                  label: Text('Anterior'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: currentCardIndex < flashcards.length - 1 ? () {
                    setState(() {
                      currentCardIndex++;
                      isFlipped = false;
                    });
                  } : null,
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Próximo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[600],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDifficultyButton('Difícil', Colors.red[400]!, Icons.close),
                _buildDifficultyButton('Médio', Colors.orange[400]!, Icons.remove),
                _buildDifficultyButton('Fácil', Colors.green[400]!, Icons.check),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDifficultyButton(String label, Color color, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Marcado como: $label')),
        );
      },
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}