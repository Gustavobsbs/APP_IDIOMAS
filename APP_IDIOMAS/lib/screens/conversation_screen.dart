import 'package:flutter/material.dart';
import 'dart:math';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  bool isSearching = false;
  bool isConnected = false;
  bool isMuted = false;
  bool isSpeakerOn = false;
  String currentPartner = '';
  String partnerLevel = '';
  String partnerCountry = '';
  int callDuration = 0;
  

  final List<Map<String, String>> mockUsers = [
    {'name': 'Maria Santos', 'level': 'Intermediário', 'country': 'Brasil', 'avatar': 'M'},
    {'name': 'John Smith', 'level': 'Avançado', 'country': 'EUA', 'avatar': 'J'},
    {'name': 'Pierre Dubois', 'level': 'Básico', 'country': 'França', 'avatar': 'P'},
    {'name': 'Ana García', 'level': 'Intermediário', 'country': 'Espanha', 'avatar': 'A'},
    {'name': 'Carlos Lima', 'level': 'Básico', 'country': 'Brasil', 'avatar': 'C'},
  ];

  void _startSearching() async {
    setState(() {
      isSearching = true;
    });


    await Future.delayed(Duration(seconds: 3));
    
  
    final random = Random();
    final selectedUser = mockUsers[random.nextInt(mockUsers.length)];
    
    setState(() {
      isSearching = false;
      isConnected = true;
      currentPartner = selectedUser['name']!;
      partnerLevel = selectedUser['level']!;
      partnerCountry = selectedUser['country']!;
    });

    _startCallTimer();
  }

  void _startCallTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (isConnected) {
        setState(() {
          callDuration++;
        });
        _startCallTimer();
      }
    });
  }

  void _endCall() {
    setState(() {
      isConnected = false;
      isSearching = false;
      callDuration = 0;
      currentPartner = '';
      partnerLevel = '';
      partnerCountry = '';
      isMuted = false;
      isSpeakerOn = false;
    });
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversação'),
        backgroundColor: Colors.green[600],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (!isSearching && !isConnected) _buildWelcomeSection(),
            if (isSearching) _buildSearchingSection(),
            if (isConnected) _buildCallSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícone principal
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.green[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people,
              size: 60,
              color: Colors.green[600],
            ),
          ),
          
          SizedBox(height: 32),
          
          Text(
            'Pratique Conversação',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 16),
          
          Text(
            'Conecte-se com outros usuários ao redor do mundo para praticar conversação em tempo real',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 32),
          
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              children: [
                Icon(Icons.lightbulb, color: Colors.blue[600], size: 32),
                SizedBox(height: 12),
                Text(
                  'Dicas para uma boa conversa:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '• Seja respeitoso e paciente\n• Fale devagar e claramente\n• Ajude seu parceiro quando necessário\n• Divirta-se aprendendo!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _startSearching,
              icon: Icon(Icons.search, size: 24),
              label: Text(
                'Encontrar Parceiro',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchingSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
  
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange[100],
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]!),
                  strokeWidth: 3,
                ),
                Icon(
                  Icons.search,
                  size: 40,
                  color: Colors.orange[600],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
          Text(
            'Procurando parceiro...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          Text(
            'Conectando você com alguém do seu nível',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 40),
          
  
          OutlinedButton(
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              side: BorderSide(color: Colors.grey[400]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallSection() {
    return Expanded(
      child: Column(
        children: [
    
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
              
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green[600],
                  child: Text(
                    currentPartner.isNotEmpty ? currentPartner[0] : 'U',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
            

                Text(
                  currentPartner,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                
                SizedBox(height: 4),
                

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.trending_up, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      partnerLevel,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      partnerCountry,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
              
  
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _formatDuration(callDuration),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
 
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tópicos sugeridos:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildTopicChip('Hobbies'),
                    _buildTopicChip('Viagens'),
                    _buildTopicChip('Comida'),
                    _buildTopicChip('Trabalho'),
                    _buildTopicChip('Cultura'),
                  ],
                ),
              ],
            ),
          ),
          
          Spacer(),
          
 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMuted = !isMuted;
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isMuted ? Colors.red[100] : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isMuted ? Icons.mic_off : Icons.mic,
                    size: 28,
                    color: isMuted ? Colors.red[600] : Colors.grey[700],
                  ),
                ),
              ),
              

              GestureDetector(
                onTap: _endCall,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.call_end,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              
        
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSpeakerOn = !isSpeakerOn;
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSpeakerOn ? Colors.blue[100] : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                    size: 28,
                    color: isSpeakerOn ? Colors.blue[600] : Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        topic,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}