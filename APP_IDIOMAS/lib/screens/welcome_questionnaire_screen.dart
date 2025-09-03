import 'package:flutter/material.dart';
import '../main.dart';

class WelcomeQuestionnaireScreen extends StatefulWidget {
  final String userName;
  
  const WelcomeQuestionnaireScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _WelcomeQuestionnaireScreenState createState() => _WelcomeQuestionnaireScreenState();
}

class _WelcomeQuestionnaireScreenState extends State<WelcomeQuestionnaireScreen> {
  int currentStep = 0;
  String selectedLanguage = '';
  String selectedLevel = '';
  String selectedTime = '';
  bool showVideo = false;

  final List<String> languages = ['Inglês', 'Espanhol', 'Francês'];
  final List<String> levels = ['Iniciante', 'Básico', 'Intermediário', 'Avançado'];
  final List<String> studyTimes = ['15 min/dia', '30 min/dia', '1 hora/dia', '2+ horas/dia'];

  void _nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      setState(() {
        showVideo = true;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(userName: widget.userName),
      ),
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedLanguage.isNotEmpty;
      case 1:
        return selectedLevel.isNotEmpty;
      case 2:
        return selectedTime.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: showVideo ? _buildVideoSection() : _buildQuestionnaire(),
      ),
    );
  }

  Widget _buildVideoSection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  'Como funciona o App Idiomas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Assista ao vídeo e descubra todas as funcionalidades',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reproduzindo vídeo explicativo...'),
                        backgroundColor: Colors.blue[600],
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'O que você vai encontrar:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.style,
                  'Flashcards Inteligentes',
                  'Sistema de repetição espaçada para memorização eficaz',
                  Colors.purple[400]!,
                ),
                SizedBox(height: 12),
                _buildFeatureItem(
                  Icons.music_note,
                  'Aprendizado com Músicas',
                  'Aprenda vocabulário com suas músicas favoritas',
                  Colors.green[400]!,
                ),
                SizedBox(height: 12),
                _buildFeatureItem(
                  Icons.people,
                  'Conversação Real',
                  'Pratique com outros usuários em chamadas aleatórias',
                  Colors.blue[400]!,
                ),
              ],
            ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seu plano personalizado:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.language, color: Colors.blue[600], size: 20),
                    SizedBox(width: 8),
                    Text('Idioma: $selectedLanguage', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.blue[600], size: 20),
                    SizedBox(width: 8),
                    Text('Nível: $selectedLevel', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.blue[600], size: 20),
                    SizedBox(width: 8),
                    Text('Tempo de estudo: $selectedTime', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _finishOnboarding,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'Começar Jornada',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionnaire() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  'Bem-vindo ao App Idiomas!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Vamos personalizar sua experiência',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= currentStep ? Colors.blue[600] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _buildCurrentStep(),
          ),
          
          Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: _previousStep,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              if (currentStep > 0) SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _canProceed() ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentStep == 2 ? 'Ver Como Funciona' : 'Próximo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildLanguageSelection();
      case 1:
        return _buildLevelSelection();
      case 2:
        return _buildTimeSelection();
      default:
        return Container();
    }
  }

  Widget _buildLanguageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qual idioma você quer aprender?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Escolha o idioma principal para seus estudos',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 32),
        Expanded(
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              final isSelected = selectedLanguage == language;
              
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedLanguage = language;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[50] : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: isSelected ? Colors.blue[600] : Colors.grey[500],
                        ),
                        SizedBox(width: 16),
                        Text(
                          language,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.blue[600] : Colors.grey[800],
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue[600],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLevelSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qual seu nível atual em $selectedLanguage?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Isso nos ajuda a personalizar o conteúdo',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 32),
        Expanded(
          child: ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              final isSelected = selectedLevel == level;
              
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedLevel = level;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[50] : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.green[600]! : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: isSelected ? Colors.green[600] : Colors.grey[500],
                        ),
                        SizedBox(width: 16),
                        Text(
                          level,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.green[600] : Colors.grey[800],
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quanto tempo você tem para estudar?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Vamos criar um plano de estudos personalizado',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 32),
        Expanded(
          child: ListView.builder(
            itemCount: studyTimes.length,
            itemBuilder: (context, index) {
              final time = studyTimes[index];
              final isSelected = selectedTime == time;
              
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange[50] : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.orange[600]! : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: isSelected ? Colors.orange[600] : Colors.grey[500],
                        ),
                        SizedBox(width: 16),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.orange[600] : Colors.grey[800],
                          ),
                        ),
                        Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: Colors.orange[600],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}